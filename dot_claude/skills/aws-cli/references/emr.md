# EMR workflows

Use these instructions for cluster discovery, configuration, steps, logs, and lifecycle operations. Examples use EMR on EC2 (`aws emr`). EMR Serverless uses `aws emr-serverless`; EMR on EKS uses `aws emr-containers`. Identify the deployment type first; cluster IDs, application IDs, virtual cluster IDs, and job-run IDs are not interchangeable.

Replace uppercase placeholders and append the established `--profile PROFILE --region REGION` consistently. A cluster name is not a unique identifier; resolve it to a `j-...` cluster ID before acting.

## Find the cluster and explain its state

```bash
aws emr list-clusters --active --output json
aws emr list-clusters --created-after START_TIMESTAMP --created-before END_TIMESTAMP --output json
aws emr describe-cluster --cluster-id CLUSTER_ID --output json
aws emr list-instances --cluster-id CLUSTER_ID --output json
```

Use a bounded creation-time window for historical investigation. `--active` also includes clusters starting, bootstrapping, or terminating; it does not mean all results can accept work. Keep pagination enabled and inspect IDs, names, timestamps, tags, and state before selecting a cluster.

In `describe-cluster`, inspect `Status.State`, its reason and timeline, `ReleaseLabel`, installed applications, `Configurations`, `LogUri`, `ServiceRole`, `Ec2InstanceAttributes`, and `StepConcurrencyLevel`. `WAITING` generally means the cluster is available without an executing EMR step; it is not a step failure. Cluster state does not prove a particular Spark application succeeded.

The service role lets EMR manage AWS resources; the EC2 instance profile supplies permissions to software on cluster nodes. An execution role can further affect step access. Distinguish these from the local CLI caller when diagnosing S3 or KMS failures inside a job.

Inspect the configured instance collection type before choosing:

```bash
aws emr list-instance-groups --cluster-id CLUSTER_ID --output json
aws emr list-instance-fleets --cluster-id CLUSTER_ID --output json
aws emr get-managed-scaling-policy --cluster-id CLUSTER_ID
aws emr get-auto-termination-policy --cluster-id CLUSTER_ID
```

Use the matching groups/fleets command, not both as an assumed universal inventory. Compare requested and provisioned capacity, lifecycle reasons, and EC2 instance IDs when investigating stuck startup or insufficient capacity. Scaling policies and auto-termination policies describe configuration, not proof of a current action.

## Inspect steps before logs

A step is a command submitted to the cluster, often `spark-submit`; that command can launch a separate YARN application, which schedules work across nodes.

```bash
aws emr list-steps --cluster-id CLUSTER_ID --output json
aws emr list-steps --cluster-id CLUSTER_ID --step-states FAILED CANCELLED INTERRUPTED --output json
aws emr describe-step --cluster-id CLUSTER_ID --step-id STEP_ID --output json
```

Inspect the step's command/JAR and argument array, status, timeline, state-change reason, and `FailureDetails`. List ordering has exceptions when filtering or selecting IDs; sort explicit timestamps when finding the latest step. Save both cluster and `s-...` step IDs. `FailureDetails.LogFile` can identify a useful log but may be absent.

Trace input/output S3 paths and relevant Spark configuration from actual arguments and referenced configuration. Distinguish configured paths from observed writes. A successful submission only establishes that EMR accepted the step; `COMPLETED` establishes step completion, and task-specific output checks establish the requested result.

## Locate and read logs

Read `Cluster.LogUri` from `describe-cluster` instead of assuming a company bucket. A common layout under that prefix is `CLUSTER_ID/steps/STEP_ID/`, with controller, stdout, and stderr files, often gzip-compressed. List the actual prefix before downloading; do not assume exact filenames or duplicate a cluster ID already present in the URI.

```bash
aws s3 ls s3://LOG_BUCKET/LOG_PREFIX/CLUSTER_ID/steps/STEP_ID/
aws s3 cp s3://LOG_BUCKET/EXACT_LOG_KEY ./step-stderr.gz --no-progress
gzip -dc ./step-stderr.gz | tail -n 200
```

Adapt the final command to the observed compression. Start with status/failure details and targeted step logs, then search for the YARN application ID and driver error. In Spark cluster deploy mode, driver logs may be in YARN container logs rather than the step's stderr. Inspect available application/container logs, Spark event logs, or the existing cluster access mechanism as needed; an EMR step ID is not a YARN application ID.

Logs can arrive asynchronously, have retention limits, or be unavailable if logging was not configured. Missing S3 logs do not prove no work ran. Separate the original failure from subsequent cleanup errors and retries. Do not enable logging, create SSH keys, or change security groups merely to inspect a cluster. Use an established authorized SSH/SSM path if required and available.

## Submit and monitor requested work

Prefer the project's existing launch configuration and exact Spark arguments. For an authorized step submission, use a JSON array to preserve argument boundaries. Example `steps.json`:

```json
[
  {
    "Name": "requested-spark-job",
    "Type": "CUSTOM_JAR",
    "ActionOnFailure": "CONTINUE",
    "Jar": "command-runner.jar",
    "Args": [
      "spark-submit", "--deploy-mode", "cluster",
      "--class", "com.example.Main",
      "s3://ARTIFACT_BUCKET/job.jar",
      "--input", "s3://INPUT_BUCKET/PREFIX/",
      "--output", "s3://OUTPUT_BUCKET/PREFIX/"
    ]
  }
]
```

```bash
aws emr add-steps --cluster-id CLUSTER_ID --steps file://steps.json --output json
aws emr describe-step --cluster-id CLUSTER_ID --step-id STEP_ID --output json
aws emr wait step-complete --cluster-id CLUSTER_ID --step-id STEP_ID
```

This is the high-level CLI `--steps` shape; do not substitute a raw API `HadoopJarStep` body without checking the accepted schema. Set each flag and value as separate `Args` entries. Select `ActionOnFailure` deliberately from the job's requirements and cluster concurrency; check help for supported combinations. Do not terminate a shared cluster as an incidental failure policy.

Save returned `StepIds` immediately. For interactive work, prefer periodic `describe-step` calls so long waits do not block updates. The installed waiter's help specifies its polling and timeout; on any nonzero result, describe the step to distinguish failure from timeout. A timed-out local waiter does not cancel remote work. Before resubmitting after an ambiguous response, inspect recent steps and arguments to avoid duplicate jobs and writes.

## Lifecycle changes

Create, resize, cancel, and terminate only within the requested scope. For cluster creation, reuse the established release, applications, subnet/security groups, roles, bootstrap actions, logging, capacity, and shutdown policy from maintained launch configuration. Do not run `create-default-roles` or copy every field of a describe response into a create request. Inspect `create-cluster help` and build the supported request explicitly.

For cancellation, inspect `cancel-steps help`, select the intended step IDs and cancellation mode, then poll each step: cancellation is asynchronous and acceptance does not guarantee cancellation. Cluster termination affects all workloads; cancelling one step and terminating its cluster are separate actions. Verify final cluster state after an authorized termination or capacity/state after an authorized resize.

For Serverless, discover `list-applications`, `list-job-runs`, `get-job-run`, and relevant start/cancel commands through help. For EKS, discover the corresponding virtual-cluster and job-run commands under `emr-containers`. Read their actual monitoring configuration to locate logs; do not reuse EC2 cluster log assumptions.

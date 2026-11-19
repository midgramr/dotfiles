---
name: aws-cli
description: Use the AWS CLI to inspect, manage, or troubleshoot AWS resources, especially S3 files and EMR clusters and jobs. Apply when running or composing aws commands; not for general AWS architecture or SDK coding without CLI work.
---

# AWS CLI

Use the installed CLI help as the authority for syntax and supported options. Discover commands as needed instead of guessing flags or copying syntax from another version.

## Discover commands

Start with `aws --version`, then narrow help to the relevant service and operation:

```bash
aws help
aws <command> help
aws <command> <subcommand> help
# Example:
aws s3 help
aws s3api list-objects-v2 help
```

For noninteractive help, use `AWS_PAGER='' MANPAGER=cat PAGER=cat aws ... help`. For CLI v2 requests, disable the output pager and interactive prompting with `--no-cli-pager --no-cli-auto-prompt` when needed. These settings affect the current invocation; do not rewrite global configuration for one task.

Read operation help for required parameters, examples, pagination, and return values. If syntax fails, inspect parent help and the installed version before retrying. If local help is unavailable or insufficient, consult the [official AWS CLI reference](https://docs.aws.amazon.com/cli/latest/reference/) for the appropriate version. Do not install or upgrade the CLI just to match an example.

## Resolve the destination

Reuse the requested or established profile, region, and endpoint. When context is missing, discover profile names with `aws configure list-profiles`; inspect effective settings with `aws configure list --profile PROFILE`. Do not dump credential files or secret environment variables.

Before changing resources, resolve the intended account and region. When identity needs verification, use:

```bash
aws sts get-caller-identity --profile PROFILE --output json
```

Keep selected `--profile PROFILE` and `--region REGION` consistent across related calls. Do not assume a profile name proves account identity. Preserve intentional custom endpoints. Ask only when the destination remains ambiguous and affects the task.

For expired IAM Identity Center credentials, inspect `aws sso login help` and use the established profile when authentication is needed for the task; let the user complete interactive login. Do not change grants, create access keys, or replace credential configuration as an incidental repair. If configuration changes are requested and tracked in chezmoi, sync the source and edit templates directly, avoiding machine-specific paths.

## Requests and complete results

Prefer `--output json` for structured API results. Inspect the response shape before applying `--query` (a JMESPath expression for selecting output fields) or `jq`. Prefer supported service-side filters to reduce requests and data transfer; `--query` filters the response locally.

For complex inputs, use a JSON file with `--cli-input-json file://request.json` where supported. Generate JSON with a serializer or quoted heredoc. Consult operation help or `--generate-cli-skeleton input` for the schema; skeletons are version-dependent examples, not complete requests. Check `file://`, `fileb://`, and `--cli-binary-format` semantics for binary inputs rather than treating them interchangeably.

Leave automatic pagination enabled for complete inventories. `--no-paginate` can return only the first service page; `--page-size` changes request size, while `--max-items` caps CLI output. When deliberately limiting results, report the limit and use documented `--starting-token` continuation where supported. Do not interchange CLI continuation tokens with service-specific tokens. With `--output text`, queries can run per page; prefer JSON for global sorting, counts, or selecting an overall first result.

## Frequent workflows: S3 and EMR

- For S3 work, read [references/s3.md](references/s3.md): prefix discovery, metadata, bounded reads, copy/sync filters, versions, deletion, and access diagnosis.
- For EMR work, read [references/emr.md](references/emr.md): cluster selection and configuration, step inspection, Spark/YARN logs, submission, monitoring, and lifecycle changes. It also distinguishes EMR on EC2 from Serverless and EKS.
- For EMR logs or artifacts stored in S3, use both references as needed.

## Execute and verify

Carry out changes within the user's authorized scope without adding unrelated resource or permission changes. For asynchronous operations, save the returned resource/job ID and inspect status or use a documented `wait` command. An accepted request is not proof of completion, and a local timeout does not mean the remote operation stopped.

After a mutation, read back the affected state or check the terminal operation result. Before repeating an uncertain create or launch after a network failure, look for the original operation and use a supported idempotency token when applicable. Stop repeated retries when the same authentication, permissions, or invalid-request error persists; diagnose the cause instead of broadening permissions.

Report the account/profile and region when relevant, the resource IDs or S3 paths, observed outcome, and any incomplete pagination or polling. Distinguish verified state from assumptions. Avoid exposing secrets in output or debug logs.

---
name: databricks-cli
description: Use the Databricks CLI to inspect or manage workspaces, jobs, compute, Unity Catalog, files, bundles, and REST API operations. Apply when running or troubleshooting databricks commands; not for generic Spark or SQL explanations without CLI work.
---

# Databricks CLI

Use the installed CLI and its help as the authority for command syntax. These examples were checked against v1.9.0; discover capabilities again when the installed version differs.

## Discover the command and destination

Start with `databricks --version`, then narrow help to the operation:

```bash
databricks --help
databricks jobs --help
databricks jobs run-now --help
```

Read command-specific help before using unfamiliar flags. Required IDs are often positional; do not substitute older CLI syntax such as `--job-id` for a positional `JOB_ID`. If a command is unavailable, inspect its parent help before choosing a fallback. Do not install or upgrade the CLI just to match these examples.

Resolve the intended workspace and identity using existing configuration:

```bash
databricks auth profiles --skip-validate
databricks auth describe -p PROFILE
databricks current-user me -p PROFILE -o json
```

`--skip-validate` inventories profiles without testing their credentials. `auth describe` explains the credential source; `current-user me` verifies workspace access. Use an explicit `-p PROFILE` consistently after selecting the intended profile. If the destination is ambiguous, ask before a remote operation. Workspace profiles and account profiles are distinct: inspect `databricks account --help` for account administration.

When login is needed and within the task, use `databricks auth login --host HOST --profile PROFILE`; it uses browser OAuth and writes the profile. Let the user complete interactive authentication. Do not print configuration secrets, use `auth describe --sensitive`, or fetch tokens merely to diagnose authentication. Avoid changing the default profile to perform one task. If editing a configuration tracked by chezmoi, sync its source and edit templates directly without embedding machine-specific paths.

## Requests and results

Prefer the named command group. Use `-o json` for structured inspection; inspect the actual response before writing a `jq` filter. Output shapes differ across commands and versions.

For commands supporting `--json`, pass complex bodies through a file as `--json @request.json`. Consult help for whether required values belong in positional arguments or the body; do not guess how duplicate values are resolved. Construct JSON with a serializer or a quoted heredoc rather than interpolating user text into shell commands.

Pagination is command-specific. Help may describe REST fields that are not CLI flags. For example, v1.9.0 `tables list` exposes `--limit`, while its prose mentions `max_results`. Do not invent `--max-results` or assume a limit is a page size. Inspect returned continuation fields and supported flags before claiming a complete inventory. With raw API pagination, continue until the continuation token is absent, even when a page is empty. Describe permission-filtered results as what the current identity can see.

## Common workflows

Substitute real profile names, IDs, and paths in these examples.

### Catalog and compute inspection

```bash
databricks catalogs list -p PROFILE -o json
databricks schemas list CATALOG -p PROFILE -o json
databricks tables list CATALOG SCHEMA -p PROFILE -o json
databricks tables get CATALOG.SCHEMA.TABLE -p PROFILE -o json
databricks clusters list -p PROFILE -o json
databricks warehouses list -p PROFILE -o json
```

Catalog commands return metadata, not table rows. Saved-query management is not SQL execution. For SQL execution, discover an available command or use the documented Statement Execution REST API through `api`; verify the warehouse, request schema, statement status, and result pagination in the current API reference.

### Jobs and run diagnosis

```bash
databricks jobs list --name JOB_NAME -p PROFILE -o json
databricks jobs get JOB_ID -p PROFILE -o json
databricks jobs run-now JOB_ID --no-wait -p PROFILE -o json
databricks jobs get-run RUN_ID -p PROFILE -o json
databricks jobs get-run-output TASK_RUN_ID -p PROFILE -o json
```

Launching a run is a remote action; use it when requested. In v1.9.0, `run-now` waits by default, with a 20-minute timeout. For long work, `--no-wait` returns control so the run ID can be saved and polled. Submission does not establish success: inspect terminal state and result. A local timeout does not prove that the remote run stopped. Before retrying an uncertain submission, look for the original run; where appropriate use the supported idempotency token to prevent duplicate launches.

For multi-task jobs, inspect `get-run` for each task's run ID and request that task's output. `get-run` can paginate large arrays using `--page-token`. Output is limited and is not necessarily the complete driver log; notebook return values come from `dbutils.notebook.exit()`.

### Workspace objects versus data files

Workspace notebooks/files use workspace paths. DBFS and Unity Catalog volume files use `fs`; remote paths require the `dbfs:` scheme, including volumes.

```bash
databricks workspace list /Workspace/PATH -p PROFILE -o json
databricks workspace export /Workspace/PATH/notebook --format SOURCE --file notebook.py -p PROFILE
databricks workspace import /Workspace/PATH/notebook --format SOURCE --language PYTHON --file notebook.py -p PROFILE
databricks fs ls dbfs:/Volumes/CATALOG/SCHEMA/VOLUME/ -p PROFILE
databricks fs cp dbfs:/Volumes/CATALOG/SCHEMA/VOLUME/data.csv ./data.csv -p PROFILE
```

A single-file SOURCE notebook import requires a language. Use `--overwrite` or recursive options only when replacing existing content or acting on a directory is intended. Do not confuse local files, workspace objects, and volume paths.

### Bundles

A bundle defines deployable resources in project configuration. Inspect the existing `databricks.yml` and target definitions before running bundle commands from the project directory.

```bash
databricks bundle validate -t TARGET -p PROFILE
databricks bundle plan -t TARGET -p PROFILE
```

Check subcommand help for version support. Validate and inspect the plan before an authorized deployment. `bundle deploy`, `bundle run`, `bundle sync`, and `bundle destroy` affect the remote workspace; validation alone does not deploy or execute anything. Respect the project's existing resource ownership rather than making ad hoc changes to bundle-managed resources.

## REST fallback and verification

When the CLI lacks a named operation, inspect `databricks api METHOD --help` and the current [official REST API reference](https://docs.databricks.com/api/workspace/). The generic API command supplies authentication, but its help does not define endpoint schemas.

```bash
databricks api get /api/2.0/clusters/list -p PROFILE -o json
# For an authorized POST, after verifying its endpoint and body:
databricks api post /api/VERSION/RESOURCE --json @request.json -p PROFILE -o json
```

Use the correct workspace/account routing; consult help for `--account` and `--workspace-id` rather than assuming they are interchangeable. Prefer named commands when available, as recommended by the [API command reference](https://docs.databricks.com/aws/en/dev-tools/cli/reference/api-commands).

After a change, read the affected resource back or inspect its run status. Report the selected workspace/profile, relevant resource or run IDs, observed outcome, and any incomplete polling or truncated results. On authentication or permission errors, diagnose identity and destination before retrying; do not alter grants or credentials as an incidental fix. Do not blindly repeat mutations after network errors.

For syntax gaps beyond local help, consult the [official command reference](https://docs.databricks.com/aws/en/dev-tools/cli/commands).

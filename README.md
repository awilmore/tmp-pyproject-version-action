# pyproject-version-action

## Overview

This Github Action is intended for use in conjunction with the [mx51/merge-tag-action](https://github.com/mx51/merge-tag-action) project.

The `merge-tag-action` project will automatically create a new Git tag once a Pull-Request is merged. It relies on labels set in the Pull-Request title to determine what component of the version will be incremented. This table shows an example of how a version will be updated based on the label used:

| Label     | Current Tag | New Tag  |
|-----------|-------------|----------|
| `[patch]` | `v1.2.3`    | `v1.2.4` |
| `[minor]` | `v1.2.3`    | `v1.3.0` |
| `[major]` | `v1.2.3`    | `v2.0.0` |
| `[notag]` | `v1.2.3`    | N/A      |

See the [merge-tag-action README.md](https://github.com/mx51/merge-tag-action/blob/master/README.md) for more details.

This project runs before a Pull-Request is merged, and checks that the version value set in `pyproject.toml` matches what the PR author intends to set based on the label used in their PR title.

## Usage

### Repository Settings

**IMPORTANT**: This action requires repository read permission on any project it is used with. Ensure this permission is enabled by going to your project's **Settings** -> **Actions** -> **General** and under **Workflow permissions** select **Read and write permissions**.

### Github Action Config

Below is an example of how Github Action can be enabled on a Github project:

```
# When a pull request is opened, updated or merged, run the tag check
on:
  pull_request:
    types: [ opened, synchronize, reopened, edited ]
    branches-ignore:
      - 'dependabot/**'

jobs:
  tag_check:
    runs-on: ubuntu-latest
    name: "PyProject Version Check"

    steps:
    - uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - uses: mx51/pyproject-version-action@master
      with:
        repo-token: ${{ secrets.GITHUB_TOKEN }}
```

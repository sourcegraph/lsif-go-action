# Sourcegraph Go LSIF Indexer GitHub Action

This action generate LSIF data from Go source code. See the [LSIF Go Indexer](https://github.com/sourcegraph/lsif-go) for more details. This will also run the `lsif-gomod` binary in order to output monikers for external dependencies.

## Usage

The following input scan be set.

| name         | default   | description |
| ------------ | --------- | ----------- |
| file         | data.lsif | The output file. |
| project_root | `.`       | The root of the project (where go.mod is located). |
| verbose      | false     | Print indexer progress to stdout. |

The following is a complete example that uses the [upload action](https://github.com/sourcegraph/lsif-upload-action) to upload the generated data to [sourcegraph.com](https://sourcegraph.com).

```
name: LSIF
on:
  - push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Generate LSIF Data
        uses: sourcegraph/lsif-go-action@0.1.0-alpha
        with:
          file: data.lsif
          verbose: 'true'
      - name: Upload LSIF data
        uses: sourcegraph/lsif-upload-action@0.1.0-alpha
        with:
          file: data.lsif
          upload_token: abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijkl
```

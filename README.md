# Sourcegraph Go LSIF Indexer GitHub Action

This action generate LSIF data from Go source code. See the [LSIF go indexer](https://github.com/sourcegraph/lsif-go) for more details.

## Usage

The following inputs can be set.

| name         | default   | description |
| ------------ | --------- | ----------- |
| file         | dump.lsif | The output file. |
| project_root | `.`       | The root of the project (where go.mod is located). |

The following is a complete example that uses the [upload action](https://github.com/sourcegraph/lsif-upload-action) to upload the generated data to [sourcegraph.com](https://sourcegraph.com). Put this in `.github/workflows/lsif.yaml`.

```
name: LSIF
on:
  - push
jobs:
  index:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Generate LSIF data
        uses: sourcegraph/lsif-go-action@master
      - name: Upload LSIF data
        uses: sourcegraph/lsif-upload-action@master
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

# Run mmCEsim Action
GitHub Action for Running mmCEsim CLI and Generating Report

> **Note** This version only supports command `exp` (code export).

- mmCEsim CLI Repo: https://github.com/mmcesim/mmcesim
- mmCEsim Homepage: https://mmcesim.org

## Basic Usage

To use this action, you can simply use:
```yml
- uses: mmcesim/run-mmcesim-action
  with:
    source: input.sim # the mmCEsim configuration file
```
Alternatively you can fix the version of this action by using
`mmcesim/run-mmcesim-action@v0.0.1`.

## Inputs

| Input | Description | Default |
| :-: | :-: | :-: |
| `version` | mmCEsim Version (SHA/Tag/Branch) | `master` |
| `command` | mmCEsim Command (Only Support `exp` Now) | `exp` |
| `source` | mmCEsim Configuration Source File (`*.sim`) | (**required**) |
| `output` | Output (Generated) File name | `exported.cpp` |
| `options` | mmCEsim Options | (Optional) |

### `version`
Set the mmCEsim CLI version. It can be either **SHA**, **Tag** or **Branch**.
- SHA: The commit SHA of [mmCEsim CLI](https://github.com/mmcesim/mmcesim), for example `eadfe28d8c0cbd115cfa87d78c994dedb9ca0eb5`.
- Tag: The tag name of mmCEsim CLI, for example `v0.1.0`. (The prefix `v` can not be omitted!)
- Branch: The branch name of mmCEsim CLI, for example `master`.

The default value is `master`.

### `command`
The mmCEsim execution command.
So far, only `exp` (to export code) is support.

The default value is `exp`.

### `source`
The source file of mmCEsim configuration (`*.sim`).
The suffix `.sim` can be omitted as in mmCEsim CLI.

This value is **required**.

### `output`
The output (generated) file name.
So far, since only C++ with Armadillo library is supported, it is the C++ source file.

### `options`
Additional command line option for mmCEsim.
It is worth noting that the `output` input uses the `-o` option.

This value is optional.

## Outputs

| Output | Description |
| :-: | :-: |
| `src` | Generated Source File |

### `src`
The generated source file name.
This is the same as the input `source`.

## Example

Here is a basic example with all options configured.

In this example, a mmCEsim configuration file `path/to/file_name.sim` is set as the `source`,
and the output file name is set to `export_file_name.cpp`.
The version of [mmCEsim](https://github.com/mmcesim/mmcesim) is set to the `master` branch.
Additional CLI option `--no-error-compile` is passed on.

The 
```yml
on: [push]

jobs:
  run_mmcesim:
    runs-on: ubuntu-latest
    name: Test Tag
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Run mmCEsim Action
        uses: mmcesim/run-mmcesim-action@v0.0.1
        id: run
        with:
          version: master
          command: exp
          source: path/to/file_name
          output: export_file_name.cpp
          options: --no-error-compile
      - name: Check Contents
        run: cat "${{ steps.run.outputs.src }}"
      - name: Upload
        uses: actions/upload-artifact@v3
        with:
          name: "mmCEsim Result"
          path: "${{ steps.run.outputs.src }}"
```

## License
This action is licensed by an [MIT License](LICENSE).
Copyright (c) 2023 Wuqiong Zhao (Teddy van Jerry)

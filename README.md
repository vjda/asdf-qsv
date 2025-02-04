<div align="center">

# asdf-qsv [![Build](https://github.com/vjda/asdf-qsv/actions/workflows/build.yml/badge.svg)](https://github.com/vjda/asdf-qsv/actions/workflows/build.yml) [![Lint](https://github.com/vjda/asdf-qsv/actions/workflows/lint.yml/badge.svg)](https://github.com/vjda/asdf-qsv/actions/workflows/lint.yml)

[qsv](https://qsv.dathere.com/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add qsv
# or
asdf plugin add qsv https://github.com/vjda/asdf-qsv.git
```

qsv:

```shell
# Show all installable versions
asdf list-all qsv

# Install specific version
asdf install qsv latest

# Set a version globally (on your ~/.tool-versions file)
asdf global qsv latest

# Now qsv commands are available
qsv --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/vjda/asdf-qsv/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Victor J. Diaz Ayuste](https://github.com/vjda/)

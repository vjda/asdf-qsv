# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test qsv https://github.com/vjda/asdf-qsv.git "qsv --list"
```

Tests are automatically run in GitHub Actions on push and PR.

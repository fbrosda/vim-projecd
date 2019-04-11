# ProjeCD

A small plugin, which stores a list of projects (aka git root directories) and
lets you choose one of them with `:Cd` for fast context switching.

If fzf is installed this will be used to narrow down the list of available
projects.

## TODOs

- [ ] Basic implementation
- [ ] Support other options then git rev-parse
- [ ] Enable default vim autocompletion if fzf is not available
- [ ] Some more configuration options

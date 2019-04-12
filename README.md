# ProjeCD

A small plugin, which stores a list of projects (aka git root directories) and
lets you choose one of them with `:Cd` for fast context switching.

If fzf is installed this will be used to narrow down the list of available
projects.

## TODOs

- [X] Basic implementation
- [X] Support other options then git rev-parse( basic support via command variable )
- [X] Enable default vim autocompletion if fzf is not available
- [ ] Write some documentation
- [ ] Maybe move some stuff to autoload

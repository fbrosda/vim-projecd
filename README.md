# ProjeCD

A small plugin, which stores a list of projects (aka git root directories) and
lets you choose one of them with `:C` for fast context switching.

If fzf is installed this will be used to narrow down the list of available
projects.

The plugin is heavily inspired by projectile for emacs, but offers only
functionality for a small and specific use case.

## Motivation

Have an fast and simple mechanism to switch between different project context.
With commands like `:e`, `:find` and `:grep` starting from the current directory
by default, setting this to the project root, seems to be an unobtrusive way
for achieving this.

## Installation

Use whatever plugin manager you prefer.


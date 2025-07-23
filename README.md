# dotfiles

## Install

Ensure Homebrew is installed e.g.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
. utils.sh
df_hydrate_brew

./install.sh

hash -r
PATH="/opt/homebrew/bin:$PATH"

cat << EOF >> ~/.bash_profile
export BASH_SILENCE_DEPRECATION_WARNING=1

[[ -r ~/.bashlc ]]  && . ~/.bashlc
[[ -r ~/.bashrc ]]  && . ~/.bashrc

PATH="/opt/homebrew/bin:$PATH"
SHELL=$(which bash)
EOF
```

### Shell

Ensure all terminal emulators are updated to run a bash login with homebrew
installed version of bash. This is required for completions and other dotfile
functionality specific to bash 5. i.e.

```bash
/opt/homebrew/bin/bash -l
```

### Toolchains

Install the toolchains you want from a new bash 5 shell
```bash
. utils.sh
df_node_hydrate
df_java_hydrate
df_python_hydrate
df_rust_hydrate
```

## Skipfile - skipping dotfile loading

Dotfiles may be skipped by creating a file `$HOME/.dotfiles-skip` and adding a line per file to skip.

For example to skip `.bashrc.d/10_pipenv` just add it to the file.

Dotfiles to skip must only be preceded by the containing load folder i.e. `.bashrc.d/` or `.bashlc.d` - additional
leading slashes folders or full paths will not work.

You can also disabled specific "triggers" within files for more granular control. For example adding `pipenv-completion`
to the skipfile will cause the pipenv shell completion setup to be skipped (anecdotally this takes ~1.5s).

Granular triggers may be added by wrapping with the `dotfiles_skip` function e.g. the below creates a "trigger"
`fnm-completion` which may be specified in the skipfile.
```bash
if ! dotfiles_skip fnm-completion
then
    eval "$(fnm env --use-on-cd)"
fi
```

#### Neovim

The below should all be done *before* running `nvim` for the first time.

Ensure the below tools are installed
- gcc (or equivalent)
- cmake
- unzip
- ripgrep

Ensure that the below integrations are installed
- node neovim e.g. `npm install --global neovim`
- python neovim e.g. `pip install neovim`

Various language servers installed through Mason also require
- npm/node
- java
- golang
- cargo/rust
- marksman

Manual commands to be run after first initialisation:
- `:MasonInstall codelldb shellcheck sonarlint-language-server`

### Adding existing files to this repo

The simplest thing is just move the file into `src` then run `./install.sh` to create a symlink e.g.
```bash
mv ~/.npmrc src
./install.sh
```

### Adding loader files

Create a new file in `~/.bashlc.d` or `~/.bashrc.d` prefixed with at least one number (this indicates the order
the files are loaded). Add any commands you want then open a new bash shell.

### Notes

- .bashlc should be sourced **before** .bashrc
- bash config which can be loaded once by an initial shell and exports its configuration should be added to
  `~/.bashlc.d`
- bash config which must be loaded by every shell and does not export its configuration should be added to
  `~/.bashrc.d`

### Issues

#### Neovim with JDTLS

There is currently an incompatibility with JDTLS and lombok as a result of changes to the internal JDT AST classes.

This can be resolved by
- downloading an [older version](https://download.eclipse.org/jdtls/milestones/1.30.1/jdt-language-server-1.30.1-202402151717.tar.gz) or JDTLS
- replacing all jars in `~/.local/share/nvim/mason/packages/jdtls/plugins` with those from the download
- removing and re-linking all jars in `~/.local/share/nvim/mason/share/jdtls/plugins`

Without these changes the lombok agent will fail to process any `@EqualsAndHashCode` annotations.

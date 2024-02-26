# dotfiles

Loader for `bash`.

### What you get

- Big old brewfile
- A bunch of standard tool config (`vim`, `tmux`, `git`, etc.).
- A bunch of standard environment configuration and helpful functions - see `~/.bash_load.d` and `~/.bashrc.d`.
- A `udf` (user defined functions) which gives you a list of the functions defined by the above.
- A useful `PS1/PROMPT_COMMAND` and a corresponding `envinfo` function for more detail.
- Terminal colours in the form `_fmt_<id>`, see `00_colours` and the `what_colours` function.

### Install

```bash
brew bundle install

# Run as many times as you want - see "Adding existing files to this repo"
./install.sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
jenv enable-plugin export

cat << EOF >> ~/.bash_profile
[[ -r ~/.bashlc ]]  && . ~/.bashlc
[[ -r ~/.bashrc ]]  && . ~/.bashrc
EOF
```

Remove or comment out any sourcing of `~/.bashrc` from `/etc/bashrc`.

#### Neovim

Ensure the below tools are installed
- gcc (or equivalent)
- cmake
- unzip
- ripgrep

Various language servers installed through Mason also require
- npm/node
- java
- golang
- cargo/rust

Manual commands to be run after first initialisation:
- `MasonInstall codelldb`

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
  `~/.bashlc.d` e.g. `10_nvm`
- bash config which must be loaded by every shell and does not export its configuration should be added to
- `~/.bashrc.d`.
- The loader mechanisms should be sourced into `~/.bash_profile` (which itself appears to be remote managed). This
  will ensure make things a little easier if the system overwrites the file (just add the two `.` source lines back).

### Issues

#### Neovim with JDTLS

There is currently an incompatibility with JDTLS and lombok as a result of changes to the internal JDT AST classes.

This can be resolved by
- downloading an [older version](https://download.eclipse.org/jdtls/milestones/1.30.1/jdt-language-server-1.30.1-202402151717.tar.gz) or JDTLS
- replacing all jars in `~/.local/share/nvim/mason/packages/jdtls/plugins` with those from the download
- removing and re-linking all jars in `~/.local/share/nvim/mason/share/jdtls/plugins`

Without these changes the lombok agent will fail to process any `@EqualsAndHashCode` annotations.

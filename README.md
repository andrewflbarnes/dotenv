# dotenv

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
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
jenv enable-plugin export

cat << EOF >> ~/.bash_profile
[[ -r ~/.bash_load ]]  && . ~/.bash_load
[[ -r ~/.bashrc ]]  && . ~/.bashrc
EOF
```

Remove or comment out any sourcing of `~/.bashrc` from `/etc/bashrc`.

### Adding existing files to this repo

The simplest thing is just move the file into `src` then run `./install.sh` to create a symlink e.g.
```bash
mv ~/.npmrc src
./install.sh
```

### Adding loader files

Create a new file in `~/.bash_load.d` or `~/.bashrc.d` prefixed with at least one number (this indicates the order
the files are loaded). Add any commands you want then open a new bash shell.

### Notes

- `.bash_load` should be sourced **before** .bashrc
- bash config which can be loaded once by an initial shell and exports its configuration should be added to `~/.bash_load.d` e.g. `10_nvm`.
- bash config which must be loaded by every shell and does not export its configuration should be added to `~/.bashrc.d`.
- The loader mechanisms should be sourced into `~/.bash_profile`. If it is is overwritten for any reason, say
because it is a remotely managed file, all that needs to be done is to add the source commands back.

[Screenshot]: ./screenshot.png
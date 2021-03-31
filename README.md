# dotenv

Loader for `bash`.

### Install

```bash
./install.sh

cat << EOF >> ~/.bash_profile
[[ -r ~/.bash_load ]]  && . ~/.bash_load
[[ -r ~/.bashrc ]]  && . ~/.bashrc
EOF
```

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

- .bash_load should be sourced **before** .bashrc
- bash config which can be loaded once by an initial shell and exports its configuration should be added to
  `~/.bash_load.d` e.g. `10_nvm`
- bash config which must be loaded by every shell and does not export its configuration should be added to
- `~/.bashrc.d`.
- The loader mechanisms should be sourced into `~/.bash_profile`. If it is is overwritten for any reason, say
  because it is a remotely managed file, all that needs to be done is to add the source commands back.

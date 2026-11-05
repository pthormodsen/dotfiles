# dotfiles

Ghostty, zsh, Starship, Zellij and Atuin, managed with GNU Stow.

## New machine

```sh
brew bundle
stow --target="$HOME" ghostty zsh starship zellij atuin
atuin import zsh
```

Stow refuses to overwrite existing files, so move any existing configs out of
the way first.

Ghostty also reads `~/Library/Application Support/com.mitchellh.ghostty/config`
and it wins over `~/.config/ghostty/config`, so that file must not exist.

Reload Ghostty's config with `Cmd+Shift+,`.

Never commit secrets here. Put machine-specific settings outside this repo.

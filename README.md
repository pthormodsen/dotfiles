# dotfiles

Ghostty, zsh, Starship, Zellij, Atuin, glow and Yazi, managed with GNU Stow.

## New machine

```sh
brew bundle
stow --target="$HOME" ghostty zsh starship zellij atuin glow yazi
atuin import zsh
ya pkg install
```

If your username isn't `patrik`, update the absolute `style` path in
`glow/Library/Preferences/glow/glow.yml`. glow doesn't expand `~` or `$HOME`
there.

Stow refuses to overwrite existing files, so move any existing configs out of
the way first.

Ghostty also reads `~/Library/Application Support/com.mitchellh.ghostty/config`
and it wins over `~/.config/ghostty/config`, so that file must not exist.

Reload Ghostty's config with `Cmd+Shift+,`.

Never commit secrets here. Put machine-specific settings outside this repo.

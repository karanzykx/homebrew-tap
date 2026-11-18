# Karan's Homebrew Tap

Homebrew casks for the macOS apps and tools I build.

```bash
brew tap karanzykx/tap
brew install --cask <name>
```

or in one step: `brew install --cask karanzykx/tap/<name>`.

## Apps

| App | What it is | Install |
|---|---|---|
| [**Wisp**](https://github.com/karanzykx/wisp) | Safe, one-click deep clean for developer Macs | `brew install --cask karanzykx/tap/wisp` |

## Update and remove

| Task | Command |
|---|---|
| Update everything from this tap | `brew update && brew upgrade --cask` |
| Remove an app | `brew uninstall --cask <name>` |
| Remove an app including its settings and logs | `brew uninstall --zap --cask <name>` |

## About these installs

- Homebrew verifies every download against the SHA-256 pinned in the app's file under [`Casks/`](Casks).
- For apps that are not notarised by Apple, the cask clears the download's quarantine flag after the checksum is verified,
  so macOS does not show its first-launch warning. That is the only thing its `postflight_steps` block does. If you would
  rather approve the app yourself, download it from the app's releases page instead.
- Each app's own documentation, safety notes and issue tracker live in its repository.

## Maintaining

Each app is one file, `Casks/<name>.rb`. Use an existing cask as the template.

After an app publishes a new release, point its cask at it and push:

```bash
./bump.sh wisp 0.1.1
git commit -am "wisp 0.1.1" && git push
```

CI runs `brew style` on every push.

## License

[MIT](LICENSE)

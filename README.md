### Debugging

```
nix repl --expr "builtins.getFlake \"$PWD\""
```

### fish

```
echo /Users/alexandre.schoenwitz/.nix-profile/bin/fish | sudo tee -a /etc/shells
chsh -s /Users/alexandre.schoenwitz/.nix-profile/bin/fish
```

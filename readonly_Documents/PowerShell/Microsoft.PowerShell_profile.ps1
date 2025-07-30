Invoke-Expression (&starship init powershell)
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

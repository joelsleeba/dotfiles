# SSH and GPG key agent
eval "$(ssh-agent -s)"
eval `keychain --noask --quiet --eval joelsleeba@github.com jsleeba@math.uh.edu wegut@github.com`

# Hermes Agent command
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac

This repository is the backup of my major configurations. I added a deployment
script in order to facilitate the process on my computers but feel free to
send me your personal adjustments.

## Deployment

Those are guidelines to install my Git, Tmux, Vim, ZSH and Pentadactyl
configurations but you probably want to modify several steps such as the
variables at the beginning of the deploy.sh script.

Basically, all the configurations are inside a directory separate from your
HOME. They are then symbolically linked in your HOME.

```
git clone https://github.com/aseure/configs .configs
cd .configs
./deploy.sh
```

Then, follow the instructions and don't forget to `source` your newly created
`.zshrc` file.

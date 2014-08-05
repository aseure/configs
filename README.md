This repository is the backup of my major configurations. I added a deployment
script in order to facilitate the process on my computers but feel free to
send me your personal adjustments.

It perfectly works on both my Mac and my Linux systems.

## Deployment

Those are guidelines to install my Jogsoul, Tmux, Vim and ZSH configurations
but you probably want to modify several steps.

Basically, all the configurations are inside a directory separate from your
HOME. They are then symbolically linked in your HOME.

```
git clone https://github.com/aseure/configs
mv configs .configs
cd .configs
./deploy.sh
```

Then, follow the instructions and don't forget to `source` your newly created
`.zshrc` file.

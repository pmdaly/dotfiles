Dotfiles
---
Noted changes
1. Vimrc
    - jj -> Esc
    - ; -> :
    - leader ll -> compile latex
    - leader p -> split pane with screen opening ipython
    - highlight text + leader v -> send code to ipython shell
2. Bashrc
    - git branch in prompt
    - better history
    - some aliases
3. Inputrc
    - vim commands in terminal
4. Tmux conf
    - color resolution

TODO:
---
1. Script to install and update vim
2. Dotfiles work with OSX/Linux but might need some customizing based on OS
3. General software installation script
    1. Vim update if needed (mac usually)
    2. Tmux? - terminal mutliplexing
    3. Autojump - auto aliasing
    4. Tldr/Bro-pages - examples instead of manual
    5. Jq - json pretty print
    6. CCat - syntax highlighted cat
    7. Ranger - quick file browsing
    8. VSCode? - have never really used IDEs but it's a nice light weight one that I can customize to be really similar to my tmux'd vim/ipython setup... not sure if this improves my workflow yet but it's fun at the moment, might need a config file for this
gic.sh
======
_Relay Chat over Git_

### Tutorial
1. Fork this repo to your own account or group
1. Add your friends as collaborators
1. Have them set up their chat like so:

```bash
export CHAT_GROUP="<your github account or group>"
git clone git@github.com:$CHAT_GROUP/GIC.git
```

Once chat is set up, you can launch a chat session like so:
```bash
cd GIC
./gic.sh
```
#### Chat commands

* `/join` joins an existing room
* `/create` creates a new room
* `/help` shows the above two commands

### How it works
* Chat logs are git commit messages
* Typing in chat creates and pushes and empty commit with your message
* Tmux splits into chat log and prompt screens
* GNU Watch pulls and updates the chat log every 2 seconds

## Acknowledgements
* @ephigabay for the [original GIC](https://github.com/ephigabay/GIC)
* @motemen for [git-log-relay-chat](https://github.com/motemen/git-log-relay-chat)
* Andy Balaam's blog post on [associative arrays in bash](http://www.artificialworlds.net/blog/2012/10/17/bash-associative-array-examples/)
* [This StackOverflow Answer](https://askubuntu.com/a/832453) by [Harshit](https://askubuntu.com/users/529894/harshit) and [Kevin Bowen](https://askubuntu.com/users/106495/kevin-bowen)

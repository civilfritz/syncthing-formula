# README #

WARNING:
Items in this repository are under heavy development and my change from time to time. I suggest forking if you are going to use it in a production environment.

### What does this repository contain? ###

* Custom Saltstack grain for Syncthing
* Saltstack SLS for Syncthing

### Features ##
TODO

### How do I get set up? ###

* Place syncthing.py in _grains into /srv/salt/_grains. The _grains folder should be under your file_roots
* Adjust `syncthing_api` in syncthing.py to change the API url if necessary
* Do a `salt '*' saltutil.sync_grains` to sync your grains with your minions
* Do a `salt '*' grains.items` to see if syncthing shows up
* Use pillar.example as an example as to how to configure the SLS.
* After configuring the pillar, do a state.highstate on all the minions hosting syncthing nodes
* Go for a walk or something while the Salt Mines sync. This might take a while. To check if its done, do a state.highstate every once in a while and see if the syncthing config updates with the nodes.
* You can use salt.modules.mine.get from http://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mine.html to make sure data is being received.
* If you still have issues, use grains.items to see if syncthing shows up as a grain.

### Known Issues ###

* No API password support , see issue #1
* SLS does not automatically download latest syncthing version, see issue #2
* No various architecture support, see issue #3

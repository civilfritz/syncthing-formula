# README #

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

### Settings in pillar ###

## installdir ##
Installation directory for syncthing. Syncthing will be installed in $installdir$/bin
Directory must exist before running, and must be owned by the user/group


## folders ##
Enter folders in dict form here (see example in example.pillar) while specifying the hostnames of nodes used (Hostnames must either be defined in $additional_nodes$ or be a minion id.
Folders will be synced to $installdir$/Sync/$FOLDERNAME$

## additional_nodes ##
Add additional nodes that are not managed by salt here.

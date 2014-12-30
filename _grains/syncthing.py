#!/usr/bin/env python

import sys
import json
import os.path
import urllib2
import salt.log
import salt.utils
import salt.utils.network

syncthing_api = "http://localhost:8080"

def syncthing_data ():
	#Check if syncthing service is online
	if os.path.isfile("/etc/init/syncthing.conf"):
		stdata = {}

		#Syncthing system data
		syncthing_api_sys = urllib2.urlopen(syncthing_api + '/rest/system')
		syncthing_api_sys_resp = syncthing_api_sys.read()
		syncthing_api_sys_resp_json = json.loads(syncthing_api_sys_resp)
		stdata['key'] =  syncthing_api_sys_resp_json["myID"]

		#Syncthing version data
		syncthing_api_version = urllib2.urlopen(syncthing_api + '/rest/version')
		syncthing_api_version_resp = syncthing_api_version.read()
		syncthing_api_version_resp_json = json.loads(syncthing_api_version_resp)
		stdata['ver'] = syncthing_api_version_resp_json["version"]

		return {'syncthing': stdata}

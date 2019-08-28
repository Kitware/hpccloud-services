#!/bin/sh
cd /ansible
ansible-playbook -i inventory/localhost dev.yml

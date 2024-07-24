#!/bin/sh
ansible-galaxy install -r requirements.yml
ansible-playbook ./playbook.yml --ask-become-pass

echo " "
echo "================================"
echo "Done! Please reboot your system."
echo "================================"
echo " "

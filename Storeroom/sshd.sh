#!/bin/bash
echo            >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
service sshd restart
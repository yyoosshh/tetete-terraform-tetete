#!/bin/bash

yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service

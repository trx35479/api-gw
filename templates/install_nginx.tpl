#!/bin/bash
deb http://nginx.org/packages/ubuntu/ xenial nginx
deb-src http://nginx.org/packages/ubuntu/ xenial nginx

apt-get update
apt-get install nginx -y

========================
django-buildout-template
========================

Features
========

* supervisor - for start & monitoring django processes
* logrotate - for clear/rotate applications logs
* auto cron install - supervisor on machine reboot and daily logrotate
* configurable by **'local.cfg'**
   * optional pin egg versions
   * start prod or dev env with supervisor
* build for production (with cron install) or for developmen machine (no cron install)


Install
=======

Get it
------

* wget https://github.com/onjin/django-buildout-template/archives/master
* unpack && cd in


Use virtualenv for better isolation
-----------------------------------

* virtualenv --no-site-packages ./env
* source ./env/bin/activate
* easy_install -U setuptools


customize
---------
* cp local.cfg-dist to local.cfg and edit

build it
--------
* 'make'' - for help or 'make dev' , 'make prod'

you got
-------
* ./bin/django-prod syncdb

single run
----------
* ./bin/django-(prod/dev) runserver

run fcgi processes(es)
----------------------
* ./bin/supervisord (-n for no background & debug)
* ./bin/supervisorctl

add to own project
------------------
* rm -rf .git   # remove .git for django-buildout-template
* git init
* git add .gitignore buildout.cfg dev.cfg local.cfg-dist Makefile prod.cfg versions.cfg templates REDAME README.html project
* git commit -m '@init'

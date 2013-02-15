.DEFAULT_GOAL = usage
.PHONY = prod dev clean dist configure

usage:
	@echo 
	@echo "  .: powered by https://github.com/onjin/django-buildout-template :."
	@echo 
	@echo "  .: Project builder usage :."
	@echo 
	@echo "  dev            - build development version, no crontabs"
	@echo "  prod           - build production version with crontabs"
	@echo
	@echo "  clean          - rm py[co] files"
	@echo "  dist           - !!! rm eggs, parts, downloads, bootstrap.py"
	@echo "  compile        - compile .py files"
	@echo

system:
	@mkdir -p ~/logs
	@mkdir -p var/log
	@mkdir -p downloads
	@mkdir -p eggs
	@mkdir -p parts
	@mkdir -p develop-eggs
	if [ ! -f local.cfg ]; then echo "\n\tYOU MUST cp local.cfg-dist local.cfg && vim local.cfg\n";return 1; fi


bootstrap.py :
	wget http://downloads.buildout.org/2/bootstrap.py
	python -S bootstrap.py

bin/buildout : bootstrap.py
	@mkdir -p etc
	@mkdir -p var/log

dev: system bin/buildout compile 
	bin/buildout -c dev.cfg
	@echo
	@echo " .: DEVELOPMENT configuration was built, so NO CRON here"
	@echo
	@echo " run 'make configure' to create default config files"
	@echo

prod: system bin/buildout compile
	bin/buildout -c prod.cfg
	@echo
	@echo " .: PRODUCTION configuration was built, with CRON installed"
	@echo 
	@echo " run 'make configure' to create default config files"
	@echo


clean:
	find . -name '*.py[oc~]'| xargs rm -f

dist: clean
	rm -rf bin develop-eggs eggs parts .installed.cfg downloads bootstrap.py

compile:
	python -c 'import compileall;  compileall.compile_dir("./project/", force=True, quiet=True);'
	@echo
	@echo

configure:
	@if [ ! -f project/development.py ]; then cp -i templates/development.py project/; echo " .: created project/development.py"; fi
	@if [ ! -f project/production.py ]; then cp -i templates/production.py project/; echo " .: created project/production.py";  fi


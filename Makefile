.PHONY: $(MAKECMDGOALS)

# `make setup` will be used after cloning or downloading to fulfill
# dependencies, and setup the the project in an initial state.
# This is where you might download rubygems, node_modules, packages,
# compile code, build container images, initialize a database,
# anything else that needs to happen before your server is started
# for the first time
setup:
	cd front/
	npm install axios react
	cd ..
	docker build -t url_shortener_front ./front/
	docker build -t url_shortener .


# `make server` will be used after `make setup` in order to start
# an http server process that listens on any unreserved port
#	of your choice (e.g. 8080).
server:
	docker-compose up

# `make test` will be used after `make setup` in order to run
# your test suite.
test:
	mix test --trace

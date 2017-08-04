
GIT_COMMIT_REV = $(shell git log -n1 --format='%h')
GIT_COMMIT_SHA = $(shell git log -n1 --format='%H')
GIT_REMOTE_ORIGIN_URL = $(shell git config --get remote.origin.url)

DATE_MONTH = $(shell date "+%e %h" | tr "[:lower:]" "[:upper:]")
DATE_VERSION = $(shell date "+%Y.%m.%d")

LOCAL_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
BRANCH = $(shell echo $(shell whoami)-$(shell git rev-parse --abbrev-ref HEAD))


all: init test docs package
init:
    # - Install your dependencies via gem, maven, etc.
    # - Download sql dumps or copy configuration templates
    #   that a dev needs to get up and running.
    # - Install git hooks (more below)
test:
    # Run unit tests, code coverage, and linters
docs:
    # Generate your API documentation (you do have some, don't you?)
package:
    # Build a release tarball or jar or executable
clean:
    # Remove everything built
	rm -rf vendor/
dev:
    # Start up a development server or process e.g. `vagrant up` or `node server.js`
    # Bonus: open that page in the user's browser automatically
install:
    # If your project builds an executable, place it in the `$PATH`.
    # E.g. copy or symlink it into `/usr/local/bin`
deploy:
    # If you have a simple deployment mechanism, like `rsync` or `s3cmd`, let
    # the Makefile take care of it.
.PHONY: test docs



## GIT STUFF
git:
	@echo "GIT_COMMIT_REV: \t \t ${GIT_COMMIT_REV}"
	@echo "GIT_COMMIT_SHA: \t \t ${GIT_COMMIT_SHA}" 
	@echo "GIT_REMOTE_ORIGIN_URL: \t \t ${GIT_REMOTE_ORIGIN_URL}" 
	@echo "GIT_COMMIT_REV: \t \t ${GIT_COMMIT_REV}" 
	@echo "GIT_COMMIT_REV: \t \t ${GIT_COMMIT_REV}" 
	


# make git m="My comment".
git-commit:
	git add -A .
	git commit -m "$m"

git-push:
	git push origin -f LOCAL_BRANCH

git-pull:



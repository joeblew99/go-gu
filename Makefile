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
# make git m="My comment".
git-comment:
	git add -A .
	git commit -m "$m"



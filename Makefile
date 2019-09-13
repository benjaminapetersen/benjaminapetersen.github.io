# Old-skool build tools.
#
# this mostly exists because I don't work in ruby regularly, and
# I forget what commands to call to get jekyll to do its job.
# So..... Makefile :) 
# and to make it more exciting, call bask scripts, woot.
#
#
# Example:
# make build
# make build WHAT=foo
build:
	hack/build.sh
.PHONY: build 

serve:
	hack/serve.sh
.PHONY: serve
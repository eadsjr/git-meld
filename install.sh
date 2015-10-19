#!/bin/bash
# Install script for the git-meld project.

# Copyright 2015 by Jason Randolph Eads <jeads442@gmail.com>
# Licensed under the Apache License, Version 2.0 (the "License");
#     http://www.apache.org/licenses/LICENSE-2.0


# TODO: Safety checks
# TODO: check write permission
# TODO: more verbose feedback

# TODO: Check to see if /usr/local/bin is on the path

# Install the scripts to /usr/local/bin
cp bin/git-* /usr/local/bin/

# TODO: else add bin dir to path?

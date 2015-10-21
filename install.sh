#!/bin/bash
# Installs scripts for the git-meld project to a location accesible to git.

# Copyright 2015 by Jason Randolph Eads <jeads442@gmail.com>
# Licensed under the Apache License, Version 2.0 (the "License");
#     http://www.apache.org/licenses/LICENSE-2.0

# Exit codes
declare -a errorcodes
errorcodes["permission_denied"]=13
errorcodes["not_on_path"]=14
errorcodes["preventing_overwrite"]=15
errorcodes["unknown_arguments"]=16
errorcodes["copy_failed"]=17
errorcodes["binaries_missing"]=18


install_target_path='/usr/local/bin/' # must end with '/'

force_overwrite=false
verbosity=1

while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
		# prepare to consume flag argument in next iteration
		-f|--force)
		force_overwrite=true
		;;
		-q|--quiet)
		verbosity=0
		;;
		-v|--verbose)
		verbosity=2
		;;
		*)
		echo "ERROR: unknown argument \""$key"\""
		exit ${errorcodes["unknown_arguments"]}
		;;
	esac
	shift
done


# echo 'preparing to install git-meld scripts to '$install_target_path

# echo 'asserting that '$install_target_path' is on the system path'

path=$(echo $PATH | sed 's/:/\'$'\n/g')
is_install_target_on_path=false
for p in $path ; do
	if [ $p == $install_target_path ] || [ $p == ${install_target_path%?} ] ; then
		is_install_target_on_path=true
		break
	fi
done

if ! $is_install_target_on_path ; then
	>&2 echo "ERROR: "$install_target_path" is not on the path."
	>&2 echo "hint: To resolve, add 'PATH=$PATH:"$install_target_path"' to to your ~/.bashrc or ~/.profile file and rerun"
	>&2 echo "hint: To install manually, copy the contents of the bin directory to somewhere on the PATH"
	exit ${errorcodes["not_on_path"]}
fi

# echo 'asserting that '$install_target_path' is writable'

if [ ! -w $install_target_path ] ; then
	>&2 echo "ERROR: permission to write to " $install_target_path " was denied. "
	>&2 echo "hint: To resolve, rerun with admin priviliges. 'sudo ./install.sh'"
	>&2 echo "hint: To install manually, copy the contents of the bin directory to somewhere on the PATH"
	exit ${errorcodes["permission_denied"]}
fi

if ! $force_overwrite ; then
	echo 'asserting that git-meld is not already installed at ' $install_target_path
fi

for path in bin/git-* ; do
	if [ $? -ne 0 ] ; then
		>&2 echo 'ERROR: unable to find binaries. Are you in the base project directory?'
		exit ${errorcodes["binaries_missing"]}
	fi
	if [ -e $install_target_path$(basename $path) ] ; then
		if $force_overwrite ; then
			:
			# >&2 echo "WARNING: overwriting file $(basename $path) at "$install_target_path
		else
			>&2 echo "ERROR: file $(basename $path) already exists at "$install_target_path
			>&2 echo "hint: To overwrite existing installation, rerun with --force or -f option."
			>&2 echo "hint: To install manually, copy the contents of the bin directory to somewhere on the PATH"
			exit ${errorcodes["preventing_overwrite"]}
		fi
	fi
done

# echo 'checks complete.'
# echo 'installing git-meld to '$install_target_path' ...'

# Install the scripts
cp bin/git-* $install_target_path
if [ $? -ne 0 ] ; then
	>&2 echo 'ERROR: failed to copy files to installation directory.'
	exit ${errorcodes["copy_failed"]}
fi

# echo 'installation complete!'
# echo

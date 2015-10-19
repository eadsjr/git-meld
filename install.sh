#!/bin/bash
# Installs scripts for the git-meld project to a location accesible to git.

# Copyright 2015 by Jason Randolph Eads <jeads442@gmail.com>
# Licensed under the Apache License, Version 2.0 (the "License");
#     http://www.apache.org/licenses/LICENSE-2.0

# Exit codes
EX_PERMISSION_DENIED=13
EX_NOT_ON_PATH=14
EX_PREVENTING_OVERWRITE=15
EX_UNKNOWN_ARGUMENT=16
EX_COPY_FAILED=17

INSTALL_TARGET_PATH='/usr/local/bin/'

force_overwrite=false

echo 'preparing to install git-meld scripts to ' $INSTALL_TARGET_PATH

for arg in $@:
do
	case $arg in
		# prepare to consume flag argument in next iteration
		--force)
		force_overwrite=true
		;;
		sudo|*install.sh)
		;;
		*)
		echo "ERROR: unknown argument \"" $arg "\"" 
		exit(EX_UNKNOWN_ARGUMENT)
		;;
	esac
done

echo 'asserting that ' INSTALL_TARGET_PATH ' is on the system path'

path=$(echo $PATH | sed 's/:/\'$'\n/g')
is_install_target_on_path=false
for p in $path ; do
	if [ p -eq $INSTALL_TARGET_PATH ] ; then
		is_install_target_on_path=true
	fi
done

if [ ! is_install_target_on_path ] ; then
	>&2 echo "ERROR: " $INSTALL_TARGET_PATH " is not on the path."
	>&2 echo "To resolve, add 'PATH=$PATH:" $INSTALL_TARGET_PATH "' to to your ~/.bashrc or ~/.profile file and rerun"
	>&2 echo "To install manually, copy the contents of the bin directory to somewhere on the PATH"
	exit(EX_NOT_ON_PATH)
fi

echo 'asserting that ' $INSTALL_TARGET_PATH ' is writable'

# Source: chepner, AlexVogel
# http://stackoverflow.com/questions/14103806/bash-test-if-a-directory-is-writable-by-a-given-uid
check_write_permissions(path) {
	USER=johndoe
	DIR=$path

	# Use -L to get information about the target of a symlink,
	# not the link itself, as pointed out in the comments
	INFO=( $(stat -cL "%a %G %U" $DIR) )
	PERM=${INFO[0]}
	GROUP=${INFO[1]}
	OWNER=${INFO[2]}

	ACCESS=no
	if [[ $PERM & 0002 != 0 ]]; then
	    # Everyone has write access
	    ACCESS=yes
	elif [[ $PERM & 0020 != 0 ]]; then
	    # Some group has write access.
	    # Is user in that group?
	    gs=( $(groups $USER) )
	    for g in "${gs[@]}"; do
	        if [[ $GROUP == $g ]]; then
	            ACCESS=yes
	            break
	        fi
	    done
	elif [[ $PERM & 0200 != 0 ]]; then 
	    # The owner has write access.
	    # Does the user own the file?
	    [[ $USER == $OWNER ]] && ACCESS=yes
	fi

	return $ACCESS
}
perm = check_write_permissions($INSTALL_TARGET_PATH)
if [ ! perm ] ; then
	>&2 echo "ERROR: permission to write to " $INSTALL_TARGET_PATH " was denied. "
	>&2 echo "To resolve, rerun with admin priviliges. 'sudo ./install.sh'"
	>&2 echo "To install manually, copy the contents of the bin directory to somewhere on the PATH"
	exit(EX_PERMISSION_DENIED)
fi

echo 'asserting that git-meld is not already installed at ' $INSTALL_TARGET_PATH

for path in bin/git-* ; do
	if [ test -e $INSTALL_TARGET_PATH$(basename $path) ] ; then
		if 
		>&2 echo "ERROR: file " $(basename $path) " already exists at " $INSTALL_TARGET_PATH
		>&2 echo "To overwrite existing installation, rerun with --force option."
		>&2 echo "To install manually, copy the contents of the bin directory to somewhere on the PATH"
		exit(EX_PREVENTING_OVERWRITE)
	fi
done

echo 'checks complete.'
echo 'installing git-meld to ' $INSTALL_TARGET_PATH ' ...'

# Install the scripts
cp bin/git-* $INSTALL_TARGET_PATH
if [ $? -ne 0 ] ; then
	>&2 echo 'ERROR: failed to copy files to installation directory.'
	exit(EX_COPY_FAILED)
fi

echo 'installation complete!'
echo

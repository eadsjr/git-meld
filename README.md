## WARNING: This project hasn't been tested extensively yet.




# git-meld
A simple extension to git that enables cleaner branching workflow without losing history.

Version 0.8.0


# The 'big idea' of git-meld
The purpose of git-meld is to allow easy merging of branches, without polluting the log with a bunch of extraneous commits. For instance, you may create a 'feature branch' and make several commits relating to a single feature. Then you `meld` it back into the parent branch. The entire child branch will become a single commit on the parent branch. As a result the logs remain sensible and clean, but all the history is still recoverable.


# Installing git-meld
Run `sudo install.sh`


# Using git-meld
When you are using git, an additional set of commands are available.

Instead of merging branches, meld them. This is equivalent to running `git merge --squash <branch>` but it also hides the branch afterwards.
> `git meld <branch>`

You can manually hide branches that you don't want to delete or meld. This archives changes that you may want to analyze later.
> `git hide <branch>`

To retrieve a branch that has been hidden, use this command.
> `git unhide <branch>`

To see all of the branches that have been hidden, use this command.
> `git hidden`


# Contributing to git-meld

If you find a bug please report it in [the 'Issues' page on github](https://github.com/eadsjr/git-meld)

If you write a fix for a bug, please submit it as a pull request, comment on an issue or by email.

If you like git-meld, or use it regularly, or have other constructive feedback please contact me at [jeads442@gmail.com](mailto:jeads442@gmail.com)

Don't forget to star it if it helps you! This helps others find useful tools like this one.

For more neat git extensions, check out [the git-commands collection!](https://github.com/git-commands)

# TODO:
* Solve: Syncronize with server to preserve history non-locally.
* More documentation!
* Test more!
* Add man pages that install and come up in `git help`
* Add pictures to README to make it more sensible
* add workflow documentation - testing proc / walkthrough
* add developer documentation - migrate ERROR CODES
* CONSIDER:
  * git-push override that makes sure hidden brances sync to remote system
  * add a flag to prevent empty ref folder cleanup

# CHANGELOG:
1. Oct 21, 2015 - 930760 - Added significant safety checks, features and feedback.
  * fully working basic case for each command
  * lots of error checking and failsafes added to git-*
  * git-meld now passes most arguments through to merge, and uses git-hide
  * git-hide will delete the hidden branch as cleanup if it fails to delete the original
  * git-hidden now displays the branch names correctly, even with extra folders
  * install.sh recieved a major upgrade
  * added CHANGELOG
  * added error codes
2. Sep 3,  2015 - f6f2d8 - Core functionality implemented. Mostly works, no safety checks.
  * git-meld added
  * git-hide added
  * git-unhide added
  * git-hidden added
  * install.sh added

# ERROR CODES:
```bash
# Error codes thrown on exit
ec_usage=3
ec_missing_target=4
ec_duplicate_hidden=5
ec_update_ref_failed_with_ec=6
ec_update_ref_failed_no_ec=7
ec_delete_failed=8
ec_delete_and_cleanup_failed=9
ec_none_hidden=10
ec_duplicate_branch=11
ec_merge_failed=12
ec_permission_denied=13
ec_not_on_path=14
ec_preventing_overwrite=15
ec_unknown_arguments=16
ec_copy_failed=17
ec_binaries_missing=18
```

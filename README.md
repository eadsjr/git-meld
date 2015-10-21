## WARNING: This does not have all the safety features implemented just yet. Use with appropriate caution.




# git-meld
A simple extension to git that enables cleaner branching workflow without losing history.


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

If you like git-meld, or use it regularly, or have other constructive feedback please contact me at [jeads442@gmail.com](mailto:jeads442@gmail.com)

Don't forget to star it if it helps you! This helps others find useful tools like this one.

# TODO:
* implement the new error code style
* finish debugging and updating the scripts
* Add pictures to README to make it more sensible
* More documentation!
* Make installer more robust
* Test for bugs!
* more feedback on errors / usage from git commands
* add workflow documentation - testing proc / walkthrough
* add developer documentation - migrate ERROR CODES
* CONSIDER:
  * git-push override that makes sure hidden brances sync to remote system
  * make git-hide and git-unhide error case behavior more symmetric to avoid confusion

# CHANGELOG:
1. Oct 18, 2015 - ? - Added significant safety checks, features and feedback.
  * lots of error checking and failsafes added to git-*
  * git-meld now passes most arguments through to merge
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

# ERROR CODES:
```bash
declare -a errorcodes
errorcodes["usage_error"]=3
errorcodes["missing_target"]=4
errorcodes["duplicate_hidden"]=5
errorcodes["update_ref_failed_EC"]=6
errorcodes["update_ref_failed_no_EC"]=7
errorcodes["delete_failed"]=8
errorcodes["delete_and_cleanup_failed"]=9
errorcodes["none_hidden"]=10
errorcodes["duplicate_branch"]=11
errorcodes["merge_failed"]=12
errorcodes["permission_denied"]=13
errorcodes["not_on_path"]=14
errorcodes["preventing_overwrite"]=15
errorcodes["unknown_arguments"]=16
errorcodes["copy_failed"]=17
errorcodes["binaries_missing"]=18
```

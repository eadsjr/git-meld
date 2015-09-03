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


# TODO:
* Add pictures to README to make it more sensible
* Finish TODOs in scripts
* Make installer more robust
* Test for bugs!
* more feedback onn errors / usage from git commands

# Permissions and more - Exercises

1. Another way you'll see to represent permissions is an octal (base 8) representation, where each permission set is represented by a number 0-7:

  | number | represents |
  |---|---|
  | 4 | read |
  | 2 | write |
  | 1 | execute |

  Then you can just add the numbers together to get the full representation, for each set of permissions.
  For example, `6` (4 + 2) represents `rw`, `7` (4 + 2 + 1) represents `rwx`, and `5` (4 + 1) represents `rx`.

  So for the permissions `755` (common for directories), the owner has `rwx` permissions, and the group and others have `r-x` permissions.
  And for the permissions `644` (common for files), the owner has `rw-` permissions, and the group and others have `r--` permissions.

  Check out a few files and directories using `ls -l`, and identify what numeric value you'd use to set these permissions.

  Then create some sample files or directories (using `touch` or `mkdir`), and set the permissions using `chmod` and the octal system.

1. In the manual pages for both `chmod` and `chown`, find the `-R` options.
   __Be extremely careful with these.__
   If you're not careful, you can overwrite lots of important permissions.
   Check and double-check before running `chmod -R` or `chown -R`, because unfortunately, there's no "undo" (unless you restore from version control or backups).

1. Let's get ourselves into a bad situation, on purpose, with `chmod -R`, and get ourselves *out* of trouble too.
   From the root directory of this repository (using `cd` as needed), run the following:

   ```shell
   $ chmod -R a-x example_app
   $ git status
   ```

   You should see a lot of angry-looking "Permission denied" error messages, but don't panic!
   With `a-x`, we've removed the "execute" permission recursively, which means we can't descend into any of these directories (and `git` needs to do that to do its job).
   We can [kind of] fix it up with `a+x`:

   ```shell
   $ chmod -R a+x example_app
   $ git status
   ```

   No scary error messages anymore, which is great, but there are now *lots* of modified files in our `git status` output.
   Remember - we didn't really __undo__ - we've gone from marking all our files and directories as executable, to marking them all as *non-*executable.
   But if (as is the case here), they didn't all *start out* as non-executable, we've ended up with a different state than we started with.
   Luckily, `git` has our backs and we can just `git checkout example_app` to restore to our original state.

1. Experiment a bit with changing files in the `playground` directory you created (you can always `mkdir -p playground`) if you didn't do it earlier.
   Use `mv` to move (or rename) files, `rm` to remove them, and `cp` to copy them.

   Be especially careful with `mv` and `rm`: remember, __there is no undo at the command line__.

1. Check out `sudo` and `su`, two commands that let you assume the identity of other users.
   These can be useful, but depending on you're doing, they can also be the *cause* of problems with permissions.
   For example, if you use `sudo` to "become" the `root` user and run a command that creates things (e.g. `sudo rails new example_2`, those files and directories will be owned by the root user.

   It's possible (depending on your machine setup) that you don't have the ability to run `sudo`, and using `su` , but it's still worth knowing about.
   There's a [great XKCD cartoon about sudo][xkcd_sudo].


[xkcd_sudo]: https://www.xkcd.com/149/

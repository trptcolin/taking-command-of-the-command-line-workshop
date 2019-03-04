# Permissions and more

Like lots of other things in Unix, the permissions system is powerful but also kind of arcane.
Luckily, we can skip the more annoying parts for now.

Let's start by making a new directory and putting some things in it:

```shell
$ mkdir -p playground/great_stuff
$ touch playground/nothing.txt
```

`mkdir` creates a directory, and `touch` creates a file.
As always, look at the manual pages for these commands if you want to know more.

Here's what permissions and ownership might look like.
You might remember this format, from trying `ls -l` earlier:

```shell
$ ls -l playground
drwxr-xr-x  2 colin  staff  64 Feb 26 14:39 great_stuff
-rw-r--r--  1 colin  staff   0 Feb 26 14:48 nothing.txt
```

There are three columns we'll want to look at above.
First, the permissions colum:

```shell
drwxr-xr-x
-rw-r--r--
```

As you might remember, that very first character is a special slot that tells you whether a given "file" is a normal file (`-`), a directory (`d`), or something else.
No need to worry about that "something else" for today!
You can always check your manual pages (and DuckDuckGo it) if you get curious.

After that, there are three sets of three characters.
Let's break them down:

```shell
rwx   r-x   r-x
rw-   r--   r--
```

Looking at a single set at a time, the slots available are `r` (read), `w` (write), and `x` (execute).
These mean slightly different things for files and directories:

| type | meaning for files | meaning for directories |
|---|---|---|
| `r` | __r__ead | list files in this directory |
| `w` | __w__rite | add files to / remove files from this directory |
| `x` | e__x__ecute | traverse into this directory (may also be required to write, depending on your OS) - "it's complicated" |

Now, why are there three sets of these?
The three sets represent, in order:

```shell
user     group      others
rwx       r-x        r-x
rw-       r--        r--
```

*Which* user and *which* group, you might ask?
Aha!
Now we're ready to look at the other two important columns from our `ls -l` output.

```shell
$ ls -l playground
drwxr-xr-x  2 colin  staff  64 Feb 26 14:39 great_stuff
-rw-r--r--  1 colin  staff   0 Feb 26 14:48 nothing.txt
```

In the above two entries, the "user" (or "owner") for both files is `colin`, and the "group" is `staff`.
There are lots of ways to configure a multi-user system with groups, but most often all you care about on your own personal machine is the "user" / "owner".

Now here's the payoff: when those permissions and owners/groups don't match what you expect, you have the power to change it!

- `chmod`: There are a few primary ways to change permissions.
  The easy way, which I almost always use, is to say what you want to change explicitly.
  For example, if I want to add the `x` permission to a directory, for only the user, I can do this

  ```shell
  $ ls -ld playground
  drw-rw-rw-  4 colin  staff  128 Feb 27 09:11 playground
  $ chmod u+x playground
  $ ls -ld playground
  drw-rw-rw-  4 colin  staff  128 Feb 27 09:11 playground
  ```

  Notice the `u+x`: I'm saying *for the user*, add the `x` permission.
  I can remove it again just as easily:

  ```shell
  $ chmod u-x playground
  $ ls -ld playground
  drw-rw-rw-  4 colin  staff  128 Feb 27 09:11 playground
  ```

  Here are the options for that spot where we put the `u` above:

  | character | meaning |
  |---|---|
  | u | __u__ser (aka owner) |
  | g | __g__roup |
  | o | __o__ther |
  | a | __a__ll (apply to all three sets of permissions) |

  I find myself using `u` and `a` the most often, by far.

  One caveat: to change permissions, if you don't have __write__ permission for a given file or directory, then you also won't be able to change permissions.


- `chown`: You can change the owner and group either independently, or at the same time.
  Check out the manual page for the details, but the syntax would look like this if I wanted to change the owner to `root` and the group to `wheel` for the `Gemfile`:

   ```shell
   $ chown root:wheel Gemfile
   ```

   There's another big caveat here, because you'll need to be the __super-user__ (aka __`root`__) to change a file's owner.
   In the exercises, you'll see how to use `sudo` to make this happen!



## Exercises

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


## Wrap-up

We've learned:

- how to interpret and change Unix permissions and ownership
- how to use `mkdir` and `touch` to create files and directories
- how permissions and ownership impact our ability to do various operations on files and folders

Next, we'll learn to search our directories, using one tool we've seen already and one we haven't!

[xkcd_sudo]: https://www.xkcd.com/149/

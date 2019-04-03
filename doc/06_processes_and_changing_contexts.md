# Processes and changing contexts

Sometimes you might need to run a long-running command, but you don't want it to block other commands you need to run.
Let's try that with a useless Bash command that `find`s all of our files but __redirects__ all output to `/dev/null`:

```shell
$ find / >/dev/null 2>&1 && echo done
```

Remember, `>/dev/null 2>&1` just means "send *everything*, including errors, to `/dev/null`."
The `&&` is a new bit of syntax, but it means basically the same thing in Bash that it means in any other language, which is: "short-circuiting __and__".
And in the command line context, it's used to run the second thing if the first thing succeeds.

So if the `find` command succeeds, the above command line will print "done" at the end.
If we hit `<Ctrl-C>` to cancel the command while running it, we don't get our "done" message printed.

Now try it again, but this time hit `<Ctrl-Z>` to __suspend__ the running process.
This is just like hitting pause on a game.
And similarly to in a multiplayer online game, if your process is talking to other processes (players) across a network, those other processes might be kind of confused and decide not to play with you anymore.
But for a single process, this works great.

OK, so we've paused the process - now let's see how we can un-pause it:

```shell
$ find / >/dev/null 2>&1 && echo done
^Z
[1]+  Stopped                 find / > /dev/null 2>&1
$ jobs
[1]+  Stopped                 find / > /dev/null 2>&1
$ fg
find / > /dev/null 2>&1
[... you can wait this out or <Ctrl-C> to cancel it...]
$
```

So after we suspend a process, we can inspect it with the `jobs` command, and bring it back into the foreground with `fg`.
We could also send it to be run in the background with `bg`, but if we don't take any action, the job will remain paused.


## What processes are running?

If you're anything like me, you'll sometimes end up having processes running that you don't want to be running.
Even if it's not through the job control mechanism above, your web application server (e.g. Unicorn or Puma for Rails), or a scripting layer above it, might leave some orphaned processes laying around.

Luckily, we can see what processes we're running with `ps`:

```shell
$ ps -axf | grep puma
  501 97409 97079   0 11:15AM ttys001    0:03.12 puma 3.12.0 (tcp://0.0.0.0:3000) [example_app]
  501 97578 84297   0 11:49AM ttys010    0:00.00 grep puma
```

There are lots and lots of flags available for `ps`, and there are different versions on different operating systems.
My typical `ps` usage is just like the above: passing the `-axf` flags and piping that to `grep` to search for specific terms I'm interested in.

Notice that `grep puma` shows up here too!
It turns out that when you use pipes as above, you're actually starting multiple commands in parallel that stream data from one to the next.
Fancy, huh?!

At any rate, `ps` gives us, among other things, the all-important process ID, or __PID__.
With a PID, we can send signals to the process, using the `kill` command.
In my case above, the PID is in the second column (run `ps -axf | less` if you want to see the column headers).
So to tell the `puma` process to terminate, I can run:

```shell
$ kill 97409
```

And it's done!
Occasionally a process won't terminate nicely, so you need to `kill -9` to forcefully terminate it.
There are other signals you can send (see `man kill`), but `kill PID_HERE` and `kill -9 PID_HERE` are by far the most common.

There are some related commands, `killall` or `pkill`, so check those out if you're interested, but I personally like to be really careful and explicit, copying the PID directly into my commands most of the time.


## Command substitution

Remember in the last module when we used `find` + `-exec` to run a command on each filename?
Here's the more general way I promised to put the output of one command into the *text* of a command.

It's called command substitution, and there are at least a couple of ways to do it.
Let's say we want to see the attributes for whatever command runs `ruby`:

```shell
$ which ruby
/Users/colin/.rbenv/shims/ruby
$ ls -l $(which ruby)
-rwxr-xr-x  1 colin  staff  409 Apr 24  2017 /Users/colin/.rbenv/shims/ruby
$ ls -l `which ruby`
-rwxr-xr-x  1 colin  staff  409 Apr 24  2017 /Users/colin/.rbenv/shims/ruby
```

There are two syntaxes above, `$(...)` and `` `...` ``.
Either one works fine - I like parentheses!


## Shelling out

Most programming languages have capabilities for "shelling out", or running Unix commands as separate processes.
In Ruby, for example, you have a bunch of options:

```ruby
def directory_contents_1(directory)
  `ls -l #{directory}`
end

def directory_contents_2(directory)
  system("ls -l #{directory}")
end

def directory_contents_3(directory)
  system("ls", "-l", directory)
end
```

But you'll definitely need to keep in mind the potential for __command injection__.
It's similar to SQL injection, in that *you can't trust user input*.
Try running the examples above with a `directory` value like this: ``"/tmp`touch /tmp/hi.txt; echo /`"``.
Of the above, only `directory_contents_3` is safe to use with user input - the others will all execute whatever code the user sends in!

## Exercises

- [Processes and changing contexts - Exercises](./exercises/06_processes_and_changing_contexts_exercises.md)


## Wrap-up

We've learned:

- how to run multiple commands with `&&`, `;`, and `bash -c`
- how to use `<Ctrl-C>`, `<Ctrl-Z>`, `fg`, `bg`, and `jobs` to control jobs running in your command line
- how to view running processes with `ps`, using `grep` to filter to only the processes you care about
- how to use `kill` to send signals to running processes
- how to use command substitution to use one command's output to build another command
- how to use your programming language of choice to "shell out"

## Meta-wrap-up

This has been a whirlwind tour through the Unix command line.
We've seen a lot of features today, but nowhere near all of them, and haven't gone super-deep into many of them.
But hopefully you've seen that the command line is a powerful tool, and also one that you have the power to use well.

Remember that the manual pages are there for you, and you'll be well on your way to Unix command line proficiency!


[command_injection]: http://cwe.mitre.org/data/definitions/77.html
[julia_evans_blog]: https://jvns.ca/

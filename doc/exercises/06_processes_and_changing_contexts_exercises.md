# Processes and changing contexts - Exercises

1. If you waited until the long-running job was completed in our job control example above, you may have noticed that "done" never got printed.
   That's because when we hit `<Ctrl-Z>`, *from the shell's perspective*, the `&&` short-circuits, saying that the first command didn't succeed.

   We can see the difference by using `;` to connect commands instead.
   The difference there is that we're running both commands, regardless of whether the first one succeeds or not:

   ```shell
   $ find / >/dev/null 2>&1; echo done
   ^Z
   [1]+  Stopped                 find / > /dev/null 2>&1
   done
   $ jobs
   [1]+  Stopped                 find / > /dev/null 2>&1
   $ fg
   find / > /dev/null 2>&1
   ^C
   ```

   Notice the `done` printed after hitting `<Ctrl-Z>`?
   If we needed to batch these actions up together so that "done" always gets printed after the long-running command, we can do that too, by running them together in a single `bash -c` invocation:

   ```shell
   $ bash -c "find / >/dev/null 2>&1; echo done"
   ```

1. Run 3-4 long-running Bash commands, suspending each one with `<Ctrl-Z>`.
   Use `sleep` with several different number-of-seconds arguments if you don't want to come up with anything fancy.

   Practice `kill`ing these long-running commands with the Bash job control facilities (`jobs`, `kill`, `%1`, `%2`, etc.),
   You'll probably want to read the sections of `man bash` that describe "JOB CONTROL" and `bg`, `fg`, and `jobs` to find out what things like `%1` and `%2` represent.

1. Find out how to use `lsof` or `netstat` (installing them if necessary) to search for process that are bound to a given port.
   This is super-helpful when you find that some server process is already running on a given port, and you wanted to start a new server process bound to that port.

1. Read up on the right way(s) to run system commands from your programming language of choice.
   Make sure when you do this (as with the Ruby example above), you don't leave your application vulnerable to [command injection][command_injection].
   Try the example text above and read the documentation carefully to make sure you're being safe.
   Ask around if you're not sure!

1. Visit [Julia Evans' blog][julia_evans_blog], bookmark it, and browse through a few articles or zines that look interesting.
   Julia has written a bunch of really insightful and useful material on Linux command line tools and other topics, and I highly recommend her work to anyone who will listen!


[command_injection]: http://cwe.mitre.org/data/definitions/77.html
[julia_evans_blog]: https://jvns.ca/

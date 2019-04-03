# Searching

Say we're looking for all the Ruby files in the `example_app` directory.
How can we do it?

```shell
$ find example_app -name "*.rb"
[...lots of paths to .rb files...]
```

The `find` command is great for this kind of thing.
I used quotes here because I'm used to needing them in Zsh (my preferred Unix shell), but you might not need them in Bash.

You can use the `-exec` flag to run a command for every match:

```shell
$ find example_app -name "*.rb" -exec grep -H "::Base" {} \;
example_app/app/mailers/application_mailer.rb:class ApplicationMailer < ActionMailer::Base
example_app/app/models/application_record.rb:class ApplicationRecord < ActiveRecord::Base
example_app/app/jobs/application_job.rb:class ApplicationJob < ActiveJob::Base
example_app/app/controllers/application_controller.rb:class ApplicationController < ActionController::Base
example_app/app/channels/application_cable/connection.rb:  class Connection < ActionCable::Connection::Base
example_app/app/channels/application_cable/channel.rb:  class Channel < ActionCable::Channel::Base
example_app/config/environments/test.rb:  # ActionMailer::Base.deliveries array.
```

I literally learned about `grep`'s `-H` flag just now, by searching through the `grep` manual page, when creating the above command.
You don't need to memorize these things: you just need to know where to look.

As you can see, there are a couple of strange pieces of syntax in the `-exec` argument (which you can find described in the `find` manual page too).
The `{}` is a placeholder for the file path that `find` found, and the escaped semicolon (`\;`) means "We're all done with this command!"

`find` is a powerful utility, but if all we want to do is search a directory for some text, there's an easier way!
`grep -r` is what I'd usually use to "google" my filesystem:

```shell
$ grep -r -H "::Base" example_app
example_app/app/mailers/application_mailer.rb:class ApplicationMailer < ActionMailer::Base
example_app/app/models/application_record.rb:class ApplicationRecord < ActiveRecord::Base
example_app/app/jobs/application_job.rb:class ApplicationJob < ActiveJob::Base
example_app/app/controllers/application_controller.rb:class ApplicationController < ActionController::Base
example_app/app/channels/application_cable/connection.rb:  class Connection < ActionCable::Connection::Base
example_app/app/channels/application_cable/channel.rb:  class Channel < ActionCable::Channel::Base
example_app/config/environments/test.rb:  # ActionMailer::Base.deliveries array.
```

You might see some folks using `xargs` for similar use cases to `find` + `-exec`, in particular where you could really pass *all* of the paths to the same command, on one command.
Our use of `-exec` is a little different, since it executes the command in the `-exec` option *once for each path*.
`xargs` is cool too, but I've also run into [some gotchas][xargs_gotchas], and since I've mostly used it with `find`'s output anyway, `find` + `-exec` seems to fit my use cases a bit better.

We saw earlier that you can connect commands with the pipe operator (`|`).
`find` + `-exec` is another way to connect commands.
This time, though, instead of connecting standard output to standard input, we're connecting each of a list of files to be part of a __command__.

We can do this in a more general way too, and we'll see that in the next module.
But first, let's look at how we can find out what we're doing.


## What am I running?

Often we might get curious about exactly *what file* is running when I type a given command.
This is usually because something is going wrong, so let's make something go wrong!

```shell
$ alias ls=garbage
$ ls
bash: garbage: command not found
```

We've told Bash that when we type the `ls` command, it should use the `garbage` command (which doesn't exist) instead.

But if something's going wrong and we don't *know* that `ls` has been aliased in this garbage way, we might need to check on it:

```shell
$ alias ls
alias ls='garbage'
$ # AHA! [command lines starting with # are comments]
$ unalias ls
```

And now `ls` works again.

But there's another important way we can be surprised by a command not running the code we thought it would.
Let's mess things up in a different way:

```shell
$ touch playground/ls
$ chmod a+x playground/ls
$ PATH=playground:$PATH
```

Ok, bear with me.
We've just done some weird stuff.
We created an empty file, made it executable, and then set an __environment variable__, named `PATH`, to be "playground" and then the __previous value of the `PATH` environment variable__.


```shell
$ ls
$ # nothing's in this directory?!??!
$ which ls
playground/ls
$ # ahahaha!!!! got me!
$ echo $PATH
playground:[...additional, more legitimate paths, separated by the : character...]
```

You can reset `PATH` manually if you want, or you could just quit your current shell session and start a new one.
Environment variables can be send to __child processes__, but they can't be changed and sent back to the *parent* process (for example, the terminal or parent shell that launched `bash`).
If you find that a child process (created by commands you run) isn't getting the environment variables you meant for it to have, you'll want to use the `export` command.


## Exercises

- [Searching - Exercises](./exercises/05_searching_exercises.md)


## Wrap-up

We've learned:

- how to use `find` and `grep -r` to search for files
- how to run a command for each file/directory found, using `find`'s `-exec` flag
- how to determine what command will run when we type it, using `alias` and `which`
- how to inspect and set environment variables


[xargs_gotchas]: http://offbytwo.com/2011/06/26/things-you-didnt-know-about-xargs.html

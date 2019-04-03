# Stitching commands together

It might seem awkward to start talking about stitching commands together this early, when we haven't talked about running many commands alone.
But for me, this ability to combine small programs is the core reason that the command line is so powerful and useful.
And there's no time like the present to get started!

Let's make sure we start in the directory where this repository lives, and use the example files to try some new techniques:

```shell
$ cd ~/presentations/command-line/taking-command-of-the-command-line
$ cat example_app/Gemfile.lock | head -n 8
GEM
  remote: https://rubygems.org/
  specs:
    actioncable (5.2.2)
      actionpack (= 5.2.2)
      nio4r (~> 2.0)
      websocket-driver (>= 0.6.1)
    actionmailer (5.2.2)
```

We've got two new commands above, `cat` and `head`, as well as a pipe character (`|`) joining them together.
`cat` is short for "concatenate" (because it can concatenate multiple files together), but it's often useful to just quickly see what's in a single file.
And `head` will let you see just the start of the given input.
The right way to think about the pipe operator is that the `cat` command runs, and streams each of its output lines into the `head` command.
Many Unix commands work on __standard input__ and __standard output__.
We don't use these often in building Rails apps, but in Ruby these are represented by `STDIN`/`$stdin` and `STDOUT`/`$stdout`.

Some folks might [frown on using `cat`][unnecessary_cat] the way we've used it above, because you can just pass a file's path directly to `head` as an argument, like this:

```shell
$ head -n3 example_app/Gemfile.lock
GEM
  remote: https://rubygems.org/
  specs:
```

But honestly, both are usually just fine.
I tend to use `cat` just because it makes the pipeline (the sequence of commands, combined with pipes) easier to edit and extend as I change my mind about commands I want to add to it.
If and when you start writing Bash scripts, and particularly ones that need to eke out performance, then I'd advise going way beyond the advice I'm giving here.

Next up: `tail` is very similar to `head`, but it starts from the end of its input instead of the beginning.
So we could get lines 21-25 of `Gemfile.lock` by composing a new pipeline:

```shell
$ cat example_app/Gemfile.lock | head -n25 | tail -n5
    actionview (5.2.2)
      activesupport (= 5.2.2)
      builder (~> 3.1)
      erubi (~> 1.4)
      rails-dom-testing (~> 2.0)
```

You can connect as many pipes together as you want!
And I find the `less` command (whose interface you'll probably recognize from the manual pages) to be super useful for quickly scrolling through a file at the command line.
Remember, `f` to page "forwards" and `b` to page "backwards".

```shell
$ cat example_app/Gemfile.lock | less
```

Once you quit `less` (by hitting `q`), you might notice that all the output goes away.
That's because `less` is an interactive program - it'll normally go at the end of a pipeline, just like above.

Remember, you can check the manual pages if you want more info on any of these commands.
And you can see more details on how pipes work too, using `man bash` and searching for "Pipe" on that page!


## Redirecting output

Similarly to "piping" output from one command to another with the `|` operator, you might want to just put the output of a given command into a file.
This saves off the output, and you could use `cat` or something else later on to do further processing or analysis.

There are a couple of redirect operators that you'll want to know:

| character | example | meaning |
|---|---|---|
| `>` | `echo hello > /tmp/redirect_test` | redirect standard output to the given file, creating it if it doesn't exist, and clearing (aka __truncating__) the file if it exists |
| `>>` | `echo hello >> /tmp/redirect_test` | *append* standard output to the given file |

There are ways to redirect input as well, but you usually don't need them.
And we'll get some practice with a couple of variants on these in just a moment.


## Exercises

- [Stitching Commands Together - Exercises](./exercises/03_stitching_commands_together_exercises.md)


## Wrap-up

We've learned:

- how to use `cat`, `head`, `tail` to examine the given input
- how to use the `less` program to use any input just like the manual pages (including search and everything!)
- how to combine small programs by connecting them with pipes (`|`)
- how to redirect output from a command into a file with `>` and `>>`
- how to use `grep` to search input

Next, we'll get some practice with permissions (one of the most common command line problem areas), while also learning to change files.


[unnecessary_cat]: http://porkmail.org/era/unix/award.html

# Readline and looking around

## What do we have here?

Find the directory where you downloaded this project repository.
You probably did this with `git clone`.
Look at the files in that directory (that's the Unix name for "folder").
For me, this looks like the following:

```shell
$ ls ~/presentations/command-line/taking-command-of-the-command-line
LICENSE.txt     README.md       TODO.md         doc             images
```

The argument you pass to `ls` will look different than mine, but the directory contents should look similar.

Check out `man ls` and see what options are available.
The `-l` flag for `ls` is one of my most common flags.
It adds a bunch of extra information for each entry, including whether it's a normal file or a directory, along permissions information which we'll get into later.

Try running the same command again, but this time with the `-l` flag.
Depending on your OS, you may be able to use the manual page for `ls` to figure out exactly what each column is trying to communicate.

```shell
$ ls -l ~/presentations/command-line/taking-command-of-the-command-line
-rw-r--r--@ 1 colin  staff  18652 Feb 19 15:20 LICENSE.txt
-rw-r--r--  1 colin  staff   1579 Feb 19 15:27 README.md
-rw-r--r--  1 colin  staff   1020 Feb 21 12:37 TODO.md
drwxr-xr-x  7 colin  staff    224 Feb 25 13:05 doc
drwxr-xr-x  3 colin  staff     96 Feb 20 11:59 images
```

If your manual pages don't show what the `-l` format columns mean, or you just don't see it yet, no worries!
We don't need to dig deep here.
The only important thing to look at for now is that very first column of output, with a bunch of letters, and in fact only the first character in each column.
A column starting with a `-` means that entry is a normal file, and a `d` means it's a directory.
You can worry about the rest another time.


## Where am I?

The command line has a concept of a current directory - it basically represents where you are in the directory structure.
You can find out where with the `pwd` command ("present working directory"):

```shell
$ pwd
/Users/colin
```

Your output will depend on what you've done in that terminal session (it probably won't say "colin" but it might!).

The `pwd` command's output will change when you use the `cd` command to "change directory":

```shell
$ pwd
/Users/colin
$ cd ~/presentations/command-line/taking-command-of-the-command-line
$ pwd
/Users/colin/presentations/command-line/taking-command-of-the-command-line
```

You might have noticed that the `~` character, when I enter it into the command line, ends up *meaning* my user's home directory, or `/Users/colin` in my case.
That's also available as an environment variable, `HOME`, which we'll cover later.

In any case, once you know your current directory, you no longer need to provide the whole path to look at directory contents.
We can provide __relative paths__ now, instead of __absolute paths__.
If we stay in the directory where we left off above:

```shell
$ ls
LICENSE.txt     README.md       TODO.md         doc             images
$ ls ./TODO.md
TODO.md
$ ls LICENSE.txt
LICENSE.txt
$ ls R*
README.md
```

That `*` character is a __wildcard__, which means that it'll __expand__ to any 0 or more matching characters.
It's kind of like a regular expression, but it's standalone (not related to the preceding "R" character above, for example), and much less powerful.
There are other wildcards, but that's the most important one to know.

OK, we're getting somewhere, but at this point we've typed the path to the workshop repository a bunch of times - or *might have*.
Let's see how we can be more efficient.


## Creatures of habit

If you're anything like me, you'll tend to run very similar handfuls of commands over time.
This means that if we want to be efficient at the command line (and I do!) we want to optimize, not for raw typing speed, but for recall and *editing* speed.
Thankfully, you don't actually have to re-type these commands every time.

A few keystrokes you should know in order to get the most out of the "Readline" editing facilities at the command line:

| command | description |
|---|---|
| `<ctrl-e>` | Go to the end of the line. |
| `<ctrl-a>` | Go to the beginning of the line. |
| `<ctrl-u>` | Delete starting from the cursor position, backwards to the beginning of the line. |
| `<ctrl-k>` | Delete starting from the cursor position, forwards to the end of the line. |
| `<esc><b>` | Go backwards one word. |
| `<esc><f>` | Go forwards one word. |
| `<esc><d>` | Delete starting from the cursor position, forwards one word. |
| `<esc><backspace>` | Delete starting from the cursor position, backwards one word. |
| Left and right arrows, or `<ctrl-b>` ("back") and `<ctrl-f>` ("forward") | Move by one character at a time. |
| `<backspace>` and `<ctrl-d>` | Delete backwards and forwards by one character at a time. |

As you can see, the chart above starts with the keystrokes that do the *most* (moving or deleting as much as a whole line), and moves towards keystrokes that do *less*.
I'd recommend starting with the top ones, so you can spend less time hitting the same keys!

And here are some keystrokes to help you get the right text into the command line:

| command | description |
|---|---|
| `<tab>` | Try to complete a directory or file name. Some commands can be set up to autocomplete fancier options, but I usually just use the file/directory completion. If you hit tab doesn't trigger completion for you, you might be in a different directory than you think. This is a big help for me in preventing typos! |
| Up and down arrows, or `<ctrl-p>` and `<ctrl-n>` ("previous" and "next" are my mnemonics here) | Change the current input line to an entry backwards or forwards in your command history. |
| `<ctrl-r>` and `<ctrl-s>` | Enter search mode! `<ctrl-r>`, or "reverse", is the norm. Once you're in this mode, you can type the start of a command in your history, hit `<ctrl-r>` again to find more hits backwards (older), or `<ctrl-s>` to search forwards (newer). And then I usually hit `<ctrl-e>` to get out of the mode and go to the end of the line, but there are lots of other ways - the best for a given situation will depend on what you want to do next! |
| `<esc>>` (using shift to get that greater-than sign) | Use the very last command in your search history. This is super useful if you've been browsing backwards in time with `<ctrl-r>` and you lose yourself a bit. This brings you back to the present time. |

There are lots of other commands and keystrokes you can look up, and configurations you can make to the way you interact with the actual text on the command line.
Feel free to check out the [Readline User Manual][readline_user_manual] as you get more confident with the commands and keystrokes above.
But for now, I recommend sticking with the above.

If you've used Emacs, you may recognize that these commands are the same as Emacs uses.
No need to be an Emacs expert though - the above commands are really the main ones you care about.
There's a way to [configure your shell to use vi bindings][vi_mode], but I won't recommend it.
I've been a Vim user for a long time, but I find the vi keybindings to be awkward on the command line, where you're only editing a single line and often switching between what would be "insert mode" or "command mode".
Plus, Emacs bindings are the default, and I can generally expect that any Unix shell I walk up to, will be using those bindings.


## Exercises

OK, that was a lot.
Don't worry about trying to memorize everything right now.
That would be impossible.

Instead, let's practice using some of these commands and keystrokes.

1. Use `<ctrl-r>` to search your command line history for a nice long command that'll be fun to edit.
   - Go to the start of the line.
   - Go forward two words.
   - Go to the end of the line.
   - Go back two words.
   - Play around going forwards and backwards, and editing the pieces of the command that seem like they might change the next time you run it.

1. Typing `<esc>` multiple times can get pretty annoying, particularly if you've got a certain manufacturer's fancy new laptop without a tactile Escape key.
   You should be able to remap this to a more convenient keystroke.
   The mechanism will depend on your terminal program.

   I use iTerm2, and I [remap my Option key to send `<esc>`][option_key].
   Your terminal program may already have an Alt or Command key standing in as this "Meta" character.
   Try it out and see.
   If not, do a search to find out what it is.

   Set this up for your terminal program of choice!
   If the internet isn't working, no worries - just make a note and come back to this one later.

1. Scroll one entry at a time through your command history and find a command with a file or directory name.
   Delete that filename or directory, and replace it with another one, *using `<tab>` to ensure you haven't got any typos*.

1. Using the manual page for `ls`, find and use the command to show the most recently modified files and directories *last*. Hint: you'll need to use three flags for this in order to do this sorting *and* check those timestamps.


## Wrap-up

We've learned:

- how to tell where we are in the directory structure (`pwd`), how to move somewhere else (`cd`), and how to see what files and subdirectories are in a given directory (`ls`)
- how to use wildcards (`*`) to expand to file paths
- the most important Readline keystrokes and how to use them to be efficient at the command line
- how to recall previously-entered commands, both one by one and by searching

Next, we'll start using the pipe operator, one of the most important and powerful features of the Unix command line.


## More resources

- [Readline User Manual][readline_user_manual]

[option_key]: https://stackoverflow.com/questions/196357/making-iterm-to-translate-meta-key-in-the-same-way-as-in-other-oses
[readline_user_manual]: https://tiswww.cwru.edu/php/chet/readline/rluserman.html
[vi_mode]: https://sanctum.geek.nz/arabesque/vi-mode-in-bash/

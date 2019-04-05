# Getting Help - Exercises

1. Bash is the shell that we're running, but it's also a program that we can run directly.
   We can absolutely run `bash` inside of an existing Bash session (and exit each one with `exit` or `<Ctrl-D>`).

   Run `man bash`.
   You're going to see a *lot* of information, including some things we'll cover today, but this also goes far beyond a single day's learning.
   But scroll through it (again: `f` for forwards, and `b` for backwards), and notice each different top-level section, __looking more closely at any parts that seem interesting to you__.

1. Inside the manual page for `man` (to be clear: running `man man`), search for the `-k` option.
   You'll probably want to use the `h` keystroke to learn how to __search__ the manual page.

   Once you've found the `-k` option, notice that there's a command that this option is "equivalent to".
   Open the manual page for this "equivalent" command, and run it with a few different inputs to get ideas on how you might *search* for a manual page whose name you don't know.

1. Check out the manual page for the `ruby` command and see if you can find any new-to-you options or other insights about the `ruby` program.
   Run `apropos ruby` to see what other manual pages are related to Ruby on your machine.

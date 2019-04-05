# Bonus Exercises

1. Write a Bash function that takes all of its input and echoes it back, followed by two exclamation points.
   Use `man bash` as a reference.

   To complete this, you will need to know:
   - how to write a function
   - how to get ahold of a function's parameters (*all* of them)
   - how to escape exclamation points (which are a special "history expansion" character in Bash)

   This is a bit tricky, so don't get discouraged when things don't work on the first try!
   I recommend taking these requirements one step at a time, starting by writing a function that just echoes "hello", and adding capabilities step by step.

1. Try out the [Zsh][zsh] and/or [Fish][fish] shell.
   Most of your Bash skills will carry right over to these fancier shells, but there will be some differences.
   I use Zsh day-to-day, and started with the excellent [Oh My Zsh][oh_my_zsh] framework, and moved to a more minimal Zsh setup a few years ago.

1. Run `vimtutor` and go through this short tutorial to Vim.
   You can quit `vim` with `:qa!`.
   You may need to install Vim through your package manager for this.
   I use Vim as my day-to-day editor (when I'm not in Google Docs or Evernote).
   Don't feel like you need to adopt Vim as your editor, but it's useful to be able to get around a bit.

1. Run `emacs --eval '(help-with-tutorial)'` to start the Emacs tutorial.
   You can quit `emacs` with `<ctrl-x><ctrl-c>`.
   You may need to install Emacs through your package manager for this.
   Don't feel like you need to adopt Emacs as your editor, but it's useful to be able to get around a bit.

1. Read [A tmux Crash Course][tmux_crash_course] and try it out.
   tmux can be very useful for viewing multiple terminal sessions on one screen, and for keeping sessions running on a remote machine even after you disconnect (perhaps to commute, or just to step away from your desk for a few minutes).


[fish]: https://fishshell.com/
[oh_my_zsh]: https://github.com/robbyrussell/oh-my-zsh
[tmux_crash_course]: https://thoughtbot.com/blog/a-tmux-crash-course
[zsh]: https://www.zsh.org/

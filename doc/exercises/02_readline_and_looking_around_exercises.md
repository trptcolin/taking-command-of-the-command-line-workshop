# Readline and looking around - Exercises

1. Use `<ctrl-r>` to search your command line history for a nice long command that'll be fun to edit.
   If you don't have one, use this:

   ```shell
   $ echo Skit skat skoodle doot. Flip flop flee. Everybody running to the coconut tree.
   ```

   - Go to the start of the line.
   - Go forward two words.
   - Go to the end of the line.
   - Go back two words.
   - Play around going forwards and backwards, and editing the pieces of the command that seem like they might change the next time you run it.

   You can stop for now, but consider practicing this until you don't need to look up the commands anymore.

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
   If you don't have one, use this:

   ```shell
   $ cat /etc/hosts
   ```

   Delete that filename or directory, and replace it with another one, *using `<tab>` to ensure you haven't got any typos*.

1. Using the manual page for `ls`, find and use the command to show the most recently modified files and directories *last*. Hint: you'll need to use three flags for this in order to do this sorting *and* check those timestamps.




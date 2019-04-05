# Taking Command of the Command Line

## Topic Outline

- Getting help! - the manual pages (`man`, options)
- Readline (beginning/end of line, clear line, forward/back by word, search command history)
- Navigating and looking around (e.g. `cd`, `ls`)
- Looking at files and filtering (`cat`, `less`, `head`, `tail`, `grep`)
- Combining programs (pipes & redirection)
- Permissions (e.g. `chmod`, `chown`, `sudo`, `su`)
- Changing things (e.g. `mkdir`, `touch`, `mv`, `cp`, `rm`)
- Googling your filesystem (`find`, `grep -r`)
- Configuration (e.g. environment variables [especially `PATH`], dotfiles, `export`, `alias`, `which`)
- Process control - aka why the heck do I have 20 orphaned Spring processes running? (e.g. `jobs`, `ps`, `kill`)
- Shelling out from Ruby (`system` and backticks - watch out for command injection!)


## Prerequisites / Setup

You'll want to be running one of MacOS, Linux, or Windows with the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) installed, and know how to start up your terminal and start up Bash.
No assumed knowledge beyond that.
If you're on Windows, please make sure you [install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) - Git Bash has some similarities, and your skills from this workshop will transfer to it, but it's missing many of the utilities you'll need.

You won't need to `bundle install` anything - just cloning the repository is sufficient!


## Background

This workshop was originally prepared for RailsConf 2019, and was open-sourced
to help out folks who aren't able to attend the workshop in person, but who
still want to get started with the Unix command line.

Please feel free to open an issue if you have any questions! It doesn't have to
be a mistake in the materials, though I'd like to hear about any of those you
find as well!

Get in touch with me ([@trptcolin](https://github.com/trptcolin)) if you have
any questions or would like me to facilitate this workshop at your conference
or user group.


## License

Copyright © 2019 Colin Jones

[Creative Commons Attribution 4.0 International License](LICENSE.txt) - [HTML summary](https://creativecommons.org/licenses/by/4.0/)

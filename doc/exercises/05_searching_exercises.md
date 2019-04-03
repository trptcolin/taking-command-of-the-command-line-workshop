# Searching - Exercises

1. Use `man bash` to locate the documentation for the shell builtin commands.
   I've often tried something like `man alias` or `man export`, only to find that the documentation for these built-in commands lives elsewhere.

1. Environment variables are a common mechanism for configuring application frameworks.
   They're mentioned specifically as one of the twelve "factors" in [the 12-factor app][12_factor_config].

   Run `printenv` to see what environment variables you currently have set.

1. Change the value of `PATH` to change the commands that are available to you.
   Open a new shell session in order to reset `PATH` to its original value.

   Read the "INVOCATION" section of `man bash` to find out how to change the starting value of `PATH`.
   If your manual page doesn't have this section, search for `bashrc` or `bash_profile`.

1. Search Github for ["dotfiles"][github_dotfiles], and look for inspiration for your own startup configurations.
   You don't need to understand everything!
   The goal here is just to get some ideas on how to configure your own setup.
   One specific thing that might be interesting is the value of `PROMPT` or `PS1` to make your prompt (the text before you start typing) look nicer.

   Caution: if you create and post your own dotfiles repository, *please* make sure not to include secrets (e.g. API credentials).
   I have known folks who accidentally posted AWS credentials, and had thousands of dollars racked up in bills within hours, even after taking them down very quickly.
   You don't want to be in that situation.

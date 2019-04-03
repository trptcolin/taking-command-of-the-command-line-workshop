# Stitching commands together - Exercises

1. Use `grep` to search for "GET" request URLs in `example_app/log/development.log` and find the one request that looks different.
   You might want to check out `man grep` - in particular the "EXAMPLES" section - to see how it works.

   Now create a command that just the request lines that *don't* have a URL of `"/"`.
   Hint: you will need `grep`'s `-v' flag, and you'll probably want to be careful with your quoting.
   Similarly to Ruby, double-quotes will need to be escaped to put them inside double-quoted strings.
   Or, also like Ruby, you can switch your quoting characters up!

1. Don't you hate it when a command gives you an error?
   Let's learn to shut up those error messages.

   You can redirect normal output to `/dev/null` (aka the "black hole" - although there's no gravity, things do really just disappear when you send them there) like this:

   ```shell
   $ echo hi
   hi
   $ echo hi > /dev/null
   $ echo hi
   hi
   ```

   So that's how you redirect standard output.
   But error messages don't get sent to standard output (usually):

   ```shell
   $ ls example_app/nothing-here
   ls: example_app/nothing-here: No such file or directory
   $ bash-3.2$ ls example_app/nothing-here > /dev/null
   ls: example_app/nothing-here: No such file or directory
   ```

   You'll need to use a variant of `>` to redirect standard *error*: `2>`.
   The 2 there is referring to the __file descriptor__ for standard error.
   Standard *output*'s file descriptor is 1, and you could say `1>` instead of `>`, but you don't have to.
   Try using `2>` with a few commands that normally give you those pesky error messages!

   You can also shut *everything* up, including non-error-message output, by using this incantation which redirects standard error to standard input and *also* sends standard input to `/dev/null`:

   ```shell
   $ echo hi > /dev/null 2>&1
   ```

   I read `2>&1` as "redirect file descriptor 2 [aka standard error] to the same place as file descriptor 1".
   But if you want, you can just copy-paste it.
   Don't feel like you have to memorize everything.
   Search `man bash` for "REDIRECTION" for more fun!

   The required counterpoint to the above silliness: Error messages are good actually, because they help us to understand what's going wrong!

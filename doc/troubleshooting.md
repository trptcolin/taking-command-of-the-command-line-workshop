# Troubleshooting

This workshop has been tested for out-of-the-box installations of:
- MacOS
- Windows 10: Ubuntu Linux, via the "Windows Subsystem for Linux"
- Ubuntu Linux

Please file a bug report against this repository for things that do not work.
There will be several places where commands will have different flags or output for different versions of Unix, but I'll try to point those out.

I do *not* suggest trying to use:
- any Linux distribution via Docker

The Docker versions of Linux often work great in production, but they will be missing common command-line utilities we'll use.
If you really want to subject yourself to it, go for it, but expect some troubleshooting!

## man: command not found

If you're running a minimal install of Linux (via Docker or other means), you might not have some of the expected commands.
Docker image creators like to keep images as small as possible, both for security and [deployment] performance reasons, but it comes at the cost of developer-friendliness.

Again, I strongly recommend just not using Docker for today, but in case you want to go for it anyway, here's what you'll need to run to get ahold of the packages we'll be using today.
These packages are normally baked into the full distributions.

### Debian / Ubuntu

```shell
$ apt-get update && apt-get -y install man less
```

### CentOS / RedHat

```shell
$ sed -i.bak -e 's/tsflags=nodocs/# tsflags=nodocs/'
$ yum -y update && yum -y install man man-pages less
```

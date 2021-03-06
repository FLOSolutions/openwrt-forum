# OPENWRT FORUM

A tiny, self-contained communication tool that doesn't require any internets

## Purpose

This was originally created to support the [Occupy Wall Street][ows] protest
in New York City. The motivation behind ows.offline is that the web offers a
fantastic array of communication tools, but often the conversation suffers from
certain trade-offs as the number of participants rises. Proximity could be a
useful filter for those with the greatest need for better communication tools.
The forum is an attempt to complement the existing deliberative process of the
NYC General Assembly and offer its constituents a text-based forum to hash out
their ideas with greater subtlety.

## How to install

This forum software was designed for the [Linksys WRT54GL][wrt54g] router
running [OpenWRT][owrt] Linux and [uhttpd]. But I've also successfully run it
on Mac OS X and Debian/Ubuntu with [thttpd].

## Installing dependencies on Debian/Ubuntu

1. Get a root shell: `sudo -i`
2. Install [Lua][lua] and [Luarocks][lrock]: `apt-get install lua luarocks`
3. Install [LuaFileSystem][lfs]: `luarocks install lfs`

## Installing on any platform

1. Install dependencies: [Lua][lua] + [LuaFileSystem][lfs]
2. Unpack the zip file in a public web folder
3. Copy `forum.cgi.example` to `forum.cgi` (or plain `forum`, if your webserver
   doen't enforce extensions for CGIs)
5. Move `forum.cgi` to your webserver's CGI directory (e.g. `/www/cgi-bin`)
6. Modify the configuration settings in `forum.cgi`:
    * Set your location name and coordinates (for future p2p functionality)
    * Point `forum_base` to the forum's directory in the filesystem
    * Point `public_root` to the forum's URL as seen from the "web"
7. Adjust file permissions if necessary:
    * Base and subdirectories accessible (executable) and readable by
      the httpd user
    * `data` directory writable by the httpd user
    * Some webservers don't like executable static files (css, javascript)
7. Try it out in a browser by calling the CGI script!

## Installing on OpenWRT

*These instructions assume that you're experienced with basic Unix tools like ssh,
scp and vi.*

1. If you're running the default Linksys-provided OS, you'll first need to [flash
   your router][flash] with the [OpenWRT system image][squashfs]
2. Download and scp the [LuaFileSystem package][lfsipk] to the router
   (place the file in `/tmp`)
3. Install the package using: `opkg install /tmp/luafilesystem_1.5.0-1_brcm-2.4.ipk`
4. Use scp to put all the forum's files in `/www` on the router
5. Copy `forum.cgi.example` to `forum.cgi` (you can also rename it to plain
   `forum`, since uhttpd doesn't require a special file extension to execute CGIs)
5. Move `forum.cgi` to `/www/cgi-bin`
6. Modify the configuration settings in `forum.cgi`:
    * Set your location name and coordinates (for future p2p functionality)
    * Set the `forum_title`
    * Update `forum_base` to `'/www/'`
    * Update `public_root` to `'/'`
7. Try it out in a browser! (something like `http://192.168.1.1/cgi-bin/forum.cgi`)

## Tuning OpenWRT

There are a couple things you can do to modify your router to make it to help
guide users to the right place.

### Change the base redirect

  * Edit `/www/index.html` to redirect to the forum URL (with the wildcard DNS
    below, you can choose a non-standard URL like `http://ows.offline/cgi-bin/forum.cgi`)

### Set up a wildcard DNS entry

It's a good idea to resolve all domains to `192.168.1.1`. This will make the router
behave as a kind of captive portal.

  * Edit`/etc/dnsmasq.conf` and add the line `address=/#/192.168.1.1`
  * Restart the DNS daemon with `/etc/init.d/dnsmasq restart`

[ows]: http://occupywallst.org/
[hm]: http://www.thenation.com/blog/163767/we-are-all-human-microphones-now
[wrt54g]: http://en.wikipedia.org/wiki/Linksys_WRT54G_series
[owrt]: https://openwrt.org/
[hb]: http://en.wikipedia.org/wiki/Shebang_%28Unix%29
[lua]: http://lua.org/
[lfs]: http://keplerproject.github.com/luafilesystem/
[lrock]: http://luarocks.org/
[flash]: http://wiki.openwrt.org/doc/howto/generic.flashing
[squashfs]: http://downloads.openwrt.org/backfire/10.03/brcm-2.4/openwrt-wrt54g-squashfs.bin
[lfsipk]: http://downloads.openwrt.org/backfire/10.03/brcm-2.4/packages/luafilesystem_1.5.0-1_brcm-2.4.ipk
[uhttpd]: http://code.google.com/p/uhttpd/
[thttpd]: http://acme.com/software/thhtpd/

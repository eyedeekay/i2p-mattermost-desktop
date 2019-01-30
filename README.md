# i2p-mattermost-desktop

Notes about configuring a desktop client for Mattermost to reliably work with an
i2p client tunnel.

## What is Mattermost Desktop

 * An electron app
 * A browser app

## Where can you run it over i2p

### HTTP Proxy Based

You can run it in a browser over the HTTP proxy by visiting it's web interface.

  * This is the easiest way
  * But there are some reports of unreliability.

You can run it in the desktop application, which honors the http\_proxy,
https\_proxy, no\_proxy environment variables. This is also pretty easy, you
just use the .b32.i2p address in place of the domain name and run it with a
command like this:

         http_proxy="http://127.0.0.1:4444" \
         https_proxy="http://127.0.0.1:4444" \
         /opt/Mattermost/mattermost-desktop

### Client Tunnel Based

You can give it it's own client tunnel, then connect your browser to it on the
local host.

  * There's an i2pd tunnels.conf.d file which sets up the tunnel in this repo,
    etc/i2pd/tunnels.conf.d

Chromium lets you set --proxy-bypass-list down to the port, so for instance
with the client tunnel running on 127.0.0.1:8065. So for instance, you can run

        chromium --incognito \
          --proxy-server="127.0.0.1:0" \
          --proxy-bypass-list="127.0.0.1:8065" \
          "127.0.0.1:8065" \
          "127.0.0.1:7567"

and in the first tab Mattermost will be visible, but in the second tab the
router console will *not* be visible. Same for your CUPS Server and all that
too. In this configuration, Chromium will use your i2p HTTP proxy for all
requests not made to the Mattermost tunnel.

Firefox requires you to create a profile, and doesn't allow setting the proxy
bypass down to the port, so it's more difficult to block requests to the
localhost(This still isn't accomplished here). I've modified firefox.profile.i2p
and placed the modified config in the directory usr/lib/mattermost.profile.i2p.
You can copy it to your $HOME folder and then launch firefox with --profile. So
if it were in $HOME/.mattermost.profile.i2p

        firefox --no-remote \
            --profile $HOME/.mattermost.profile.i2p \
            --private-window 127.0.0.1:8065

would work.

You can do essentially the same thing with the desktop client and a tunnel. Just
use the http\_proxy, https\_proxy, no\_proxy environment variables, then connect
the client to the client tunnel.

         http_proxy="http://127.0.0.1:4444" \
         https_proxy="http://127.0.0.1:4444" \
         no_proxy="127.0.0.1:8065" \
         /opt/Mattermost/mattermost-desktop

# i2p-mattermost-desktop

Notes about configuring a desktop client for Mattermost to reliably work with an
i2p client tunnel. Mattermost Desktop works with i2p if you pass the proxy using
the chromium-like flags --proxy-server --proxy-bypass-list.

## What is Mattermost Desktop

 * An electron app
 * has browser-like characteristics, like making remote requests, potentially
   via scripts.
 * A browser app
 * a third-party .deb
 * Uses WebSockets

## Configuration TL:DR

### Windows

#### Desktop

First, install the Mattermost desktop client for Windows. When installing, make
sure to create a shortcut to the Mattermost client on your desktop or somewhere
else accessible.

Next, copy-and-paste the Mattermost shortcut somewhere and re-name the copy
"Mattermost I2P."

Right click the "Mattermost I2P" shortcut you just created and open the
"Properties" menu. Change Target from:

        C:\Users\$YOURNAME\AppData\Local\mattermost\Mattermost.exe

into

        C:\Users\$YOURNAME\AppData\Local\mattermost\Mattermost.exe --proxy-server=127.0.0.1:4444

Now you can use Mattermost-over-I2P by launching the "Mattermost I2P" shortcut.

#### Web

You can also use the I2P Browser for connecting to Mattermost over the eepWeb.
In order to do this, you will need to enable scripts for the Mattermost domain
and disable HTTPS Everywhere for the Mattermost domain.

### Debian/Ubuntu, generally modern and apt-based.

i2pd users on Debian or Ubuntu-based distros could just run

        make all

and

        sudo make install

if they Mattermost's latest .deb release installed. It can also be
checkinstall'ed.

i2p users have to configure their own tunnels for now. It's probably
self-explanatory, but just in case, here's a step-by-step guide using the tunnel
wizard with pictures.

**Step 1:** Open the local tunnel manager.

![01-i2p.png](/usr/share/doc/assets/01-i2p.png)

**Step 2:** Start the tunnel creation wizard.

![02-i2p.png](/usr/share/doc/assets/02-i2p.png)

**Step 3:** Select a client tunnel.

![03-i2p.png](/usr/share/doc/assets/03-i2p.png)

**Step 4:** Select the "Standard" tunnel type.

![04-i2p.png](/usr/share/doc/assets/04-i2p.png)

**Step 5:** Name it.

![05-i2p.png](/usr/share/doc/assets/05-i2p.png)

**Step 6:** Set the binding address.

![06-i2p.png](/usr/share/doc/assets/06-i2p.png)

**Step 7:** Set the tunnel destination.

![07-i2p.png](/usr/share/doc/assets/07-i2p.png)

**Step 8:** Optionally start the tunnel when your router starts.

![08-i2p.png](/usr/share/doc/assets/08-i2p.png)

**Step 9:** In the end, these settings seem to be successful.

![09-i2p.png](/usr/share/doc/assets/09-i2p.png)

## Where can you run it over i2p

### HTTP Proxy Based

You can run it in a browser over the HTTP proxy by visiting it's web interface.

  * This is the easiest way
  * But there are some reports of unreliability.

You can run it in the desktop application, which both accepts the same flags as
Chromium browsers, and honors the http\_proxy, https\_proxy, no\_proxy
environment variables. This is also pretty easy, you just use the .b32.i2p
address in place of the domain name and run it with a command like this:

         /opt/Mattermost/mattermost-desktop \
            --proxy-server="127.0.0.1:4444"

### Client Tunnel Based

### Chromium

You can give it it's own client tunnel, then connect your browser to it on the
local host.

  * There's an i2pd tunnels.conf.d file which sets up the tunnel in this repo,
    etc/i2pd/tunnels.conf.d

Chromium lets you set --proxy-bypass-list down to the port, so for instance
with the client tunnel running on 127.0.0.1:8065, you can run

        chromium --incognito \
          --proxy-server="127.0.0.1:0" \
          --proxy-bypass-list="127.0.0.1:8065" \
          "127.0.0.1:8065" \
          "127.0.0.1:7567"

and in the first tab Mattermost will be visible, but in the second tab the
router console will *not* be visible. Same for your CUPS Server and all that
too. In this configuration, Chromium will use your i2p HTTP proxy for all
requests not made to the Mattermost tunnel.

### Firefox

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

### Desktop

You can do essentially the same thing with the desktop client and a tunnel. Just
use the same flags as you would for Chromium-based browsers.

         /opt/Mattermost/mattermost-desktop \
            --proxy-server="127.0.0.1:4444" \
            --proxy-bypass-list="127.0.0.1:8065"

### [MatterIRCD](https://github.com/42wim/matterircd)

[MatterIRCD](https://github.com/42wim/matterircd) is a bridge between mattermost
and IRC that can be run locally. There's not much to it, you just point the
matterircd client at the mattermost server, in this case, it's our client
tunnel. Once that's connected, you should be able to use any old IRC client,
although I've not quite got the hang of it yet. This is the configuration I've
used for matterircd.

        ###############################
        ##### GLOBAL SETTINGS #########
        ###############################
        Bind = "127.0.0.1:7667"
        Debug = false
        TLSBind = "127.0.0.1:7697"
        TLSDir = "./etc/pki/tls/mattermost/"
        ##################################
        ##### MATTERMOST SETTINGS ########
        ##################################
        [mattermost]
        DefaultServer = "127.0.0.1:8065"
        DefaultTeam = "i2p"
        Insecure = true
        JoinInclude = ["#town-square"]
        PartFake = true
        Restrict = ["127.0.0.1:8065"]
        SkipTLSVerify = true

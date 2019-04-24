Return-Path: <linux-doc-owner@vger.kernel.org>
Date: Wed, 24 Apr 2019 13:41:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
Message-ID: <20190424134109.2891a7cc.cohuck@redhat.com>
In-Reply-To: <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
        <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 22 Apr 2019 10:27:20 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Convert all text files with s390 documentation to ReST format.
> 
> Tried to preserve as much as possible the original document
> format. Still, some of the files required some work in order
> for it to be visible on both plain text and after converted
> to html.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |    4 +-
>  Documentation/driver-api/s390-drivers.rst     |    4 +-
>  Documentation/s390/{3270.txt => 3270.rst}     |   85 +-
>  Documentation/s390/{cds.txt => cds.rst}       |  354 ++-
>  .../s390/{CommonIO => common_io.rst}          |   49 +-
>  Documentation/s390/{DASD => dasd.rst}         |   33 +-
>  .../{Debugging390.txt => debugging390.rst}    | 2389 ++++++++++-------
>  .../{driver-model.txt => driver-model.rst}    |  179 +-
>  Documentation/s390/index.rst                  |   30 +
>  .../s390/{monreader.txt => monreader.rst}     |   85 +-
>  Documentation/s390/{qeth.txt => qeth.rst}     |   36 +-
>  Documentation/s390/s390dbf.rst                |  803 ++++++
>  Documentation/s390/s390dbf.txt                |  667 -----
>  Documentation/s390/text_files.rst             |   11 +
>  .../s390/{vfio-ap.txt => vfio-ap.rst}         |  487 ++--
>  .../s390/{vfio-ccw.txt => vfio-ccw.rst}       |   90 +-
>  .../s390/{zfcpdump.txt => zfcpdump.rst}       |    2 +
>  MAINTAINERS                                   |    4 +-
>  arch/s390/Kconfig                             |    4 +-
>  arch/s390/include/asm/debug.h                 |    4 +-
>  drivers/s390/char/zcore.c                     |    2 +-
>  21 files changed, 3089 insertions(+), 2233 deletions(-)
>  rename Documentation/s390/{3270.txt => 3270.rst} (90%)
>  rename Documentation/s390/{cds.txt => cds.rst} (64%)
>  rename Documentation/s390/{CommonIO => common_io.rst} (87%)
>  rename Documentation/s390/{DASD => dasd.rst} (92%)
>  rename Documentation/s390/{Debugging390.txt => debugging390.rst} (53%)
>  rename Documentation/s390/{driver-model.txt => driver-model.rst} (73%)
>  create mode 100644 Documentation/s390/index.rst
>  rename Documentation/s390/{monreader.txt => monreader.rst} (81%)
>  rename Documentation/s390/{qeth.txt => qeth.rst} (62%)
>  create mode 100644 Documentation/s390/s390dbf.rst
>  delete mode 100644 Documentation/s390/s390dbf.txt
>  create mode 100644 Documentation/s390/text_files.rst
>  rename Documentation/s390/{vfio-ap.txt => vfio-ap.rst} (72%)
>  rename Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst} (89%)
>  rename Documentation/s390/{zfcpdump.txt => zfcpdump.rst} (97%)
> 

(...)

> diff --git a/Documentation/s390/3270.txt b/Documentation/s390/3270.rst
> similarity index 90%
> rename from Documentation/s390/3270.txt
> rename to Documentation/s390/3270.rst
> index 7c715de99774..e09e77954238 100644
> --- a/Documentation/s390/3270.txt
> +++ b/Documentation/s390/3270.rst

(...)

> @@ -17,12 +21,12 @@ twenty and thirty years ago.
>  You may have 3270s in-house and not know it.  If you're using the
>  VM-ESA operating system, define a 3270 to your virtual machine by using
>  the command "DEF GRAF <hex-address>"  This paper presumes you will be
> -defining four 3270s with the CP/CMS commands
> +defining four 3270s with the CP/CMS commands:
>  
> -	DEF GRAF 620
> -	DEF GRAF 621
> -	DEF GRAF 622
> -	DEF GRAF 623
> +	- DEF GRAF 620
> +	- DEF GRAF 621
> +	- DEF GRAF 622
> +	- DEF GRAF 623

IIUC, this makes this into a bulleted list... but the user is supposed
to enter these commands (similar to the shell commands further down in
this file).

>  
>  Your network connection from VM-ESA allows you to use x3270, tn3270, or
>  another 3270 emulator, started from an xterm window on your PC or

(...)

> @@ -84,20 +92,22 @@ Here are the installation steps in detail:
>  		make modules_install
>  
>  	2. (Perform this step only if you have configured tub3270 as a
> -	module.)  Add a line to a file /etc/modprobe.d/*.conf to automatically
> +	module.)  Add a line to a file `/etc/modprobe.d/*.conf` to automatically
>  	load the driver when it's needed.  With this line added, you will see
>  	login prompts appear on your 3270s as soon as boot is complete (or
>  	with emulated 3270s, as soon as you dial into your vm guest using the
>  	command "DIAL <vmguestname>").  Since the line-mode major number is
> -	227, the line to add should be:
> +	227, the line to add should be::
> +
>  		alias char-major-227 tub3270
>  
>  	3. Define graphic devices to your vm guest machine, if you
>  	haven't already.  Define them before you reboot (reipl):
> -		DEFINE GRAF 620
> -		DEFINE GRAF 621
> -		DEFINE GRAF 622
> -		DEFINE GRAF 623
> +
> +		- DEFINE GRAF 620
> +		- DEFINE GRAF 621
> +		- DEFINE GRAF 622
> +		- DEFINE GRAF 623

Same here.

>  
>  	4. Reboot.  The reboot process scans hardware devices, including
>  	3270s, and this enables the tub3270 driver once loaded to respond

(...)


> diff --git a/Documentation/s390/CommonIO b/Documentation/s390/common_io.rst
> similarity index 87%
> rename from Documentation/s390/CommonIO
> rename to Documentation/s390/common_io.rst
> index 6e0f63f343b4..846485681ce7 100644
> --- a/Documentation/s390/CommonIO
> +++ b/Documentation/s390/common_io.rst
> @@ -1,5 +1,9 @@
> -S/390 common I/O-Layer - command line parameters, procfs and debugfs entries
> -============================================================================
> +======================
> +S/390 common I/O-Layer
> +======================
> +
> +command line parameters, procfs and debugfs entries
> +===================================================

I don't see why this should be split into two lines? If anything needs
to be changed, I'd drop the hyphen.

>  
>  Command line parameters
>  -----------------------
> @@ -13,7 +17,7 @@ Command line parameters
>  	device := {all | [!]ipldev | [!]condev | [!]<devno> | [!]<devno>-<devno>}
>  
>    The given devices will be ignored by the common I/O-layer; no detection
> -  and device sensing will be done on any of those devices. The subchannel to 
> +  and device sensing will be done on any of those devices. The subchannel to
>    which the device in question is attached will be treated as if no device was
>    attached.
>  
> @@ -28,14 +32,20 @@ Command line parameters
>    keywords can be used to refer to the CCW based boot device and CCW console
>    device respectively (these are probably useful only when combined with the '!'
>    operator). The '!' operator will cause the I/O-layer to _not_ ignore a device.
> -  The command line is parsed from left to right.
> +  The command line
> +  is parsed from left to right.

Why this change?

> +
> +  For example::
>  
> -  For example, 
>  	cio_ignore=0.0.0023-0.0.0042,0.0.4711
> +
>    will ignore all devices ranging from 0.0.0023 to 0.0.0042 and the device
>    0.0.4711, if detected.
> -  As another example,
> +
> +  As another example::
> +
>  	cio_ignore=all,!0.0.4711,!0.0.fd00-0.0.fd02
> +
>    will ignore all devices but 0.0.4711, 0.0.fd00, 0.0.fd01, 0.0.fd02.
>  
>    By default, no devices are ignored.

(...)

> diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/debugging390.rst
> similarity index 53%
> rename from Documentation/s390/Debugging390.txt
> rename to Documentation/s390/debugging390.rst
> index c35804c238ad..d49305fd5e1a 100644
> --- a/Documentation/s390/Debugging390.txt
> +++ b/Documentation/s390/debugging390.rst

I'll skip this one...

(Question for the s390 arch maintainers: I remember that there was some
interesting stuff in there, but I'm not sure how much of it is still
accurate/useful... is it worth spending time on trying to update this?)

(...)


> diff --git a/Documentation/s390/s390dbf.rst b/Documentation/s390/s390dbf.rst
> new file mode 100644
> index 000000000000..ec2a1faa414b
> --- /dev/null
> +++ b/Documentation/s390/s390dbf.rst

(...)

> diff --git a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.txt
> deleted file mode 100644
> index 61329fd62e89..000000000000
> --- a/Documentation/s390/s390dbf.txt
> +++ /dev/null

I wonder why this does not show up as a rename?

(...)

> diff --git a/Documentation/s390/text_files.rst b/Documentation/s390/text_files.rst
> new file mode 100644
> index 000000000000..c94d05d4fa17
> --- /dev/null
> +++ b/Documentation/s390/text_files.rst
> @@ -0,0 +1,11 @@
> +ibm 3270 changelog
> +------------------
> +
> +.. include:: 3270.ChangeLog
> +    :literal:
> +
> +ibm 3270 config3270.sh
> +----------------------
> +
> +.. literalinclude:: config3270.sh
> +    :language: shell


Another question for the s390 arch maintainers: How valuable is this still?

(...)

> diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.rst
> similarity index 89%
> rename from Documentation/s390/vfio-ccw.txt
> rename to Documentation/s390/vfio-ccw.rst
> index 2be11ad864ff..1f6d0b56d53e 100644
> --- a/Documentation/s390/vfio-ccw.txt
> +++ b/Documentation/s390/vfio-ccw.rst

(...)

> @@ -295,6 +321,6 @@ Reference
>  1. ESA/s390 Principles of Operation manual (IBM Form. No. SA22-7832)
>  2. ESA/390 Common I/O Device Commands manual (IBM Form. No. SA22-7204)
>  3. https://en.wikipedia.org/wiki/Channel_I/O
> -4. Documentation/s390/cds.txt
> +4. Documentation/s390/cds.rst
>  5. Documentation/vfio.txt
>  6. Documentation/vfio-mediated-device.txt

Are these two renamed in a later patch?

(...)

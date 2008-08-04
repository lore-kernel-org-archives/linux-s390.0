Return-Path: <linux-kernel-owner+w=401wt.eu-S1760923AbYHDGtJ@vger.kernel.org>
Date: Mon, 4 Aug 2008 08:48:53 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch 3/3] kmsg: convert xpram messages to kmsg api.
Message-ID: <20080804064853.GB23933@atrey.karlin.mff.cuni.cz>
References: <20080730165656.118280544@de.ibm.com> <20080730171157.550296160@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080730171157.550296160@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen Vo? <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

Hi!
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  Documentation/kmsg/s390/xpram |   54 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/s390/block/xpram.c    |   41 ++++++++++++++-----------------
>  2 files changed, 73 insertions(+), 22 deletions(-)
> 
> Index: linux-2.6/Documentation/kmsg/s390/xpram
> ===================================================================
> --- /dev/null
> +++ linux-2.6/Documentation/kmsg/s390/xpram
> @@ -0,0 +1,54 @@
> +/*?
> + * Tag: xpram.1
> + * Text: "%d is not a valid number of XPRAM devices"
> + * Severity: Error
> + * Parameter:
> + *   @1: number of partitions
> + * Description:
> + * The number of XPRAM partitions specified for the 'devs' module parameter
> + * or with the 'xpram.parts' kernel parameter must be an integer in the
> + * range 1 to 32. The XPRAM device driver created a maximum of 32 partitions
> + * that are probably not configured as intended.
> + * User action:
> + * If the XPRAM device driver has been compiled as a separate module,
> + * unload the module and load it again with a correct value for the
> + * 'devs' module parameter. If the XPRAM device driver has been compiled
> + * into the kernel, correct the 'xpram.parts' parameter in the kernel
> + * parameter line and restart Linux.

It is "Kernel command line". Plus, I do not think I find "User action"
section really helpful here.

...user that does not understand what "between 1 and 32 means" is
unlikely to know if the driver is built-in or module...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

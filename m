Return-Path: <linux-kernel-owner+w=401wt.eu-S1757571AbYG3Tu5@vger.kernel.org>
Date: Wed, 30 Jul 2008 12:39:42 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080730193942.GA22441@suse.de>
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080730171156.824640459@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 30, 2008 at 06:56:57PM +0200, Martin Schwidefsky wrote:
> From: Michael Holzheu <holzheu@de.ibm.com>
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Introduce a new family of printk macros which prefixes each kmsg message
> with a component name and allows to tag the printk with a message id.
> 
> The kmsg component name is defined per source file with the KMSG_COMPONENT
> macro. The first argument of each kmsg printk is the message id. The
> message id "0" is special as it will suppress the message id prefix.
> 
> If the message id will be printed to the console / syslog at all depends
> on CONFIG_MSG_IDS. If it is "n" then a kmsg_xxx call is just another
> printk wrapper. These macros are intended to be used uniformly in the
> s390 architecture and the s390 device drivers.
> 
> Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  arch/s390/Kconfig    |    9 +++
>  include/linux/kmsg.h |  124 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
> 
> Index: linux-2.6/arch/s390/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/s390/Kconfig
> +++ linux-2.6/arch/s390/Kconfig
> @@ -568,6 +568,15 @@ bool "s390 guest support (EXPERIMENTAL)"
>  	select VIRTIO_CONSOLE
>  	help
>  	  Select this option if you want to run the kernel under s390 linux
> +
> +config KMSG_IDS
> +	bool "Kernel message numbers"
> +	default y
> +	help
> +	  Select this option if you want to include a message number to the
> +	  prefix for kernel messages issued by the s390 architecture and
> +	  driver code. See "Documentation/s390/kmsg.txt" for more details.
> +
>  endmenu
>  
>  source "net/Kconfig"
> Index: linux-2.6/include/linux/kmsg.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6/include/linux/kmsg.h
> @@ -0,0 +1,124 @@
> +#ifndef _LINUX_KMSG_H
> +#define _LINUX_KMSG_H
> +
> +#ifndef __KMSG_CHECKER
> +#define __KMSG_CHECK(level, id) KERN_##level
> +#endif

What if __KMSG_CHECKER is enabled?  What does __KMSG_CHECK resolve to
then?

And what sets __KMSG_CHECKER?

thanks,

greg k-h

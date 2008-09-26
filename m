Return-Path: <linux-kernel-owner+w=401wt.eu-S1754029AbYIZTpV@vger.kernel.org>
Date: Fri, 26 Sep 2008 10:57:45 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 2/6] kmsg: tagged device messages.
Message-ID: <20080926175745.GD700@suse.de>
References: <20080925162827.818261893@de.ibm.com> <20080925163019.750494793@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080925163019.750494793@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Sep 25, 2008 at 06:28:29PM +0200, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> From: Michael Holzheu <holzheu@de.ibm.com>
> 
> Add CONFIG_MSG_IDS support to the dev_xxx printk family. The message
> tag for a device printk consists of the driver name and the 24 bit
> hash over the message text. The hash is included in the printed line
> if the KMSG_COMPONENT macro is defined and CONFIG_MSG_IDS=y. For
> source files that do not define KMSG_COMPONENT or CONFIG_MSG_IDS=n
> the dev_xxx printks use the old-style format. 
> 
> To make it possible for a script to extract the correct message tag
> for the dev_xxx printks the KMSG_COMPONENT and the driver name need to
> be identical for all dev_xxx printks in a source file. If a source file
> is supposed to be converted to use message tags and there are dev_xxx
> printks with driver names different to KMSG_COMPONENT these dev_xxx
> printks need to be replaced with kmsg_xxx printks. In praxis this
> should not be a problem since there are very few dev_xxx printks outside
> of driver code.
> 
> In addition to the KMSG_COMPONENT changes in include/linux/device.h the
> dev_xxx macros with variable arguments are converted from the gcc specific
> '## arg' to the C99 variant '##__VA_ARGS__'.
> 
> Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Nice, thanks for reworking this.  Feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
here.

Note that you will get some merge errors with -next in device.h due to
the dynamic debug printk work that is in my tree and in -next as well.
But it should be simple to resolve.

thanks,

greg k-h

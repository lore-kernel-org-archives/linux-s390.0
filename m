Return-Path: <linux-kernel-owner+w=401wt.eu-S1752128AbYHKKzG@vger.kernel.org>
Date: Mon, 11 Aug 2008 12:54:53 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080811105453.GD24625@duck.suse.cz>
References: <20080730171156.824640459@de.ibm.com> <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com> <20080730220432.GA24800@suse.de> <1217495404.8555.20.camel@localhost> <20080805223117.GA6552@suse.de> <1218011716.20769.12.camel@localhost> <20080806200721.GA30086@suse.de> <1218097901.1033.10.camel@localhost> <20080807170144.GB9214@suse.de> <1218326621.14983.17.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218326621.14983.17.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun 10-08-08 02:03:41, Martin Schwidefsky wrote:
...
> Then lets look at how this will look like. First a standard printk
> message and its conversion to kmsg:
> 	printk(KERN_WARNING
>                "cpcmd: could not allocate response buffer\n");
> vs.
> 	kmsg_warn(1, "The cpcmd kernel function failed "
>                      "to allocate a response buffer\n");
> 
> The message comes out as
> 	cpcmd: cound not allocate response buffer
> vs.
> 	cpcmd.1: The cpcmd kernel function failed to allocate a response buffer
> 
> As an example for a dev_printk I use a message from the zfcp driver:
> 	dev_warn(&req->adapter->ccw_device->dev,
>                  "The local link is down: no light detected.\n");
> vs.
>         kmsg_dev_warn(27, &req->adapter->ccw_device->dev,
>                  "The local link is down: no light detected.\n");
> 
> The dev_printk versus the original kmsg macro comes out as
> 	zfcp: 0.0.1234: The local link is down: no light detected.
> vs.
> 	zfcp.27: 0.0.1234: The local link is down: no light detected.
> 
> If I would just use dev_printk in kmsg_dev_warn as proposed by Greg:
> 	zfcp: 0.0.1234: zfcp.27: The  local link is down: no light detected.
> 
> If the message component is skipped from the message tag:
> 	zfcp: 0.0.1234: 27: The  local link is down: no light detected.
> 
> Is it just me who thinks that the later two message variants are crap? 
  If I may vote in this poll ;) I agree with you that the first two device
messages look better (more comprehensible) than the last two...

									Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR

Return-Path: <linux-kernel-owner+w=401wt.eu-S1754705AbYHJAEr@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080807170144.GB9214@suse.de>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
	 <20080730220432.GA24800@suse.de> <1217495404.8555.20.camel@localhost>
	 <20080805223117.GA6552@suse.de> <1218011716.20769.12.camel@localhost>
	 <20080806200721.GA30086@suse.de> <1218097901.1033.10.camel@localhost>
	 <20080807170144.GB9214@suse.de>
Content-Type: text/plain
Date: Sun, 10 Aug 2008 02:03:41 +0200
Message-Id: <1218326621.14983.17.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-08-07 at 10:01 -0700, Greg KH wrote: 
> On Thu, Aug 07, 2008 at 10:31:41AM +0200, Martin Schwidefsky wrote:
> > On Wed, 2008-08-06 at 13:07 -0700, Greg KH wrote:
> > > > > > Using dev_printk won't work because of the order of the elements of the
> > > > > > printk. The kmsg tag should not have a "random" position in the printk
> > > > > > but should be the first element. If we use dev_printk the kmsg tag will
> > > > > > be the third element, for other kmsg printks it will be the first. In
> > > > > > addition the kmsg message tag for the device drivers already includes
> > > > > > the driver name ..
> > > > > 
> > > > > But the structure of dev_printk() is well definied and should be pretty
> > > > > trival to parse even with missing fields.
> > > > 
> > > > The missing field is the message tag. Which is the key for the message
> > > > lookup. As far as the kmsg catalog is concerned this is a pretty
> > > > important field that may not be missing from the printk itself.
> > > 
> > > No, I mean use dev_printk() as the base for your logging macro.  Add
> > > your message tag as the first field after the dev_printk() information.
> > 
> > Hmm, you are proposing to introduce a second format for the kmsg
> > messages to avoid the need for some more printk wrapper macros. To me it
> > seems that this has two problems:
> 
> No, only 1 format, use dev_printk() instead of printk() in your macro.

No, there are more printks in the system then just dev_printk. The kmsg interface
is supposed to cover all of them.

> > 1) The message tag is for the user of the system. If it does not have a
> > fixed position it gets confusing.
> 
> How would it not be in a fixed position with dev_printk()?

It is fixed in the macro for standard kmsg printks, there the message
tag is the first field. It is fixed in the macro for the dev_printk
variant of the kmsg message, there it is the third field. This mismatch
I refer to as not have a fixed position, for some message (the standard
ones) it is at the start of the final message, for others (the
dev_printk ones) it is in the middle of the message. Not good.

> > 2) The message tag for a driver message usually already includes the
> > driver name, the dev_printk will print it again. This is ugly and
> > reduces the quality of the message.
> 
> Then the message needs to change and remove that "driver name", as it is
> redundant, saving a tiny ammount of space :)

Then lets look at how this will look like. First a standard printk
message and its conversion to kmsg:
	printk(KERN_WARNING
               "cpcmd: could not allocate response buffer\n");
vs.
	kmsg_warn(1, "The cpcmd kernel function failed "
                     "to allocate a response buffer\n");

The message comes out as
	cpcmd: cound not allocate response buffer
vs.
	cpcmd.1: The cpcmd kernel function failed to allocate a response buffer

As an example for a dev_printk I use a message from the zfcp driver:
	dev_warn(&req->adapter->ccw_device->dev,
                 "The local link is down: no light detected.\n");
vs.
        kmsg_dev_warn(27, &req->adapter->ccw_device->dev,
                 "The local link is down: no light detected.\n");

The dev_printk versus the original kmsg macro comes out as
	zfcp: 0.0.1234: The local link is down: no light detected.
vs.
	zfcp.27: 0.0.1234: The local link is down: no light detected.

If I would just use dev_printk in kmsg_dev_warn as proposed by Greg:
	zfcp: 0.0.1234: zfcp.27: The  local link is down: no light detected.

If the message component is skipped from the message tag:
	zfcp: 0.0.1234: 27: The  local link is down: no light detected.

Is it just me who thinks that the later two message variants are crap? 

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

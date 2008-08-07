Return-Path: <linux-kernel-owner+w=401wt.eu-S1754127AbYHGRPH@vger.kernel.org>
Date: Thu, 7 Aug 2008 10:01:44 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080807170144.GB9214@suse.de>
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com> <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com> <20080730220432.GA24800@suse.de> <1217495404.8555.20.camel@localhost> <20080805223117.GA6552@suse.de> <1218011716.20769.12.camel@localhost> <20080806200721.GA30086@suse.de> <1218097901.1033.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218097901.1033.10.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 07, 2008 at 10:31:41AM +0200, Martin Schwidefsky wrote:
> On Wed, 2008-08-06 at 13:07 -0700, Greg KH wrote:
> > > > > Using dev_printk won't work because of the order of the elements of the
> > > > > printk. The kmsg tag should not have a "random" position in the printk
> > > > > but should be the first element. If we use dev_printk the kmsg tag will
> > > > > be the third element, for other kmsg printks it will be the first. In
> > > > > addition the kmsg message tag for the device drivers already includes
> > > > > the driver name ..
> > > > 
> > > > But the structure of dev_printk() is well definied and should be pretty
> > > > trival to parse even with missing fields.
> > > 
> > > The missing field is the message tag. Which is the key for the message
> > > lookup. As far as the kmsg catalog is concerned this is a pretty
> > > important field that may not be missing from the printk itself.
> > 
> > No, I mean use dev_printk() as the base for your logging macro.  Add
> > your message tag as the first field after the dev_printk() information.
> 
> Hmm, you are proposing to introduce a second format for the kmsg
> messages to avoid the need for some more printk wrapper macros. To me it
> seems that this has two problems:

No, only 1 format, use dev_printk() instead of printk() in your macro.

> 1) The message tag is for the user of the system. If it does not have a
> fixed position it gets confusing.

How would it not be in a fixed position with dev_printk()?

> 2) The message tag for a driver message usually already includes the
> driver name, the dev_printk will print it again. This is ugly and
> reduces the quality of the message.

Then the message needs to change and remove that "driver name", as it is
redundant, saving a tiny ammount of space :)

thanks,

greg k-h

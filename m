Return-Path: <linux-kernel-owner+w=401wt.eu-S1754158AbYGaJL2@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080730220432.GA24800@suse.de>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
	 <20080730220432.GA24800@suse.de>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 11:10:04 +0200
Message-Id: <1217495404.8555.20.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-07-30 at 15:04 -0700, Greg KH wrote:
> On Thu, Jul 31, 2008 at 12:02:04AM +0200, Kay Sievers wrote:
> > On Wed, Jul 30, 2008 at 18:56, Martin Schwidefsky
> > <schwidefsky@de.ibm.com> wrote:
> > 
> > > +#define kmsg_dev_alert(id, dev, format, arg...) \
> > > +       printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
> > > +               ": %s: " format, (dev)->bus_id , ## arg)
> > 
> > Care to use dev_name(), bus_id will be removed soon.
> 
> Hm, just use dev_printk() instead, it handles all of these kinds of
> changes automatically.

Using dev_printk won't work because of the order of the elements of the
printk. The kmsg tag should not have a "random" position in the printk
but should be the first element. If we use dev_printk the kmsg tag will
be the third element, for other kmsg printks it will be the first. In
addition the kmsg message tag for the device drivers already includes
the driver name ..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1756185AbYHODqn@vger.kernel.org>
Date: Thu, 14 Aug 2008 20:44:19 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080815034419.GB803@suse.de>
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com> <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com> <1218733457.2651.11.camel@localhost> <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com> <1218769739.24527.76.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1218769739.24527.76.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Tim Hockin <thockin@hockin.org>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 14, 2008 at 08:08:59PM -0700, Joe Perches wrote:
> On Thu, 2008-08-14 at 11:50 -0700, Tim Hockin wrote:
> >     // this is the actual implementation
> >     extern void send_kmsg(int level, const char *fmt, ...);
> >     // this is a convenience wrapper, maybe not needed as they get combinatoric
> >     #define kmsg_err(fmt, ...) \
> >     	send_kmsg(KERN_ERROR, fmt, ##__VA_ARGS__)
> >   inside a subsystem-specific header:
> >     #define mysubsys_kmsg_err(fmt, ...) \
> >     	kmsg_err("mysubsys:" fmt "\n", ##__VA_ARGS__)
> >   inside each subsystem-driver:
> >     #define mydriver_kmsg_err(fmt, ...) \
> >     	mysubsys_kmsg_err("mydriver:" fmt, ##__VA_ARGS__)
> >   then the driver just calls:
> >     mydriver_kmsg_err("something happened");
> 
> I think adding system/subsystem/driver prefixes
> to function names is not good.

Eeek!

What is wrong with what we have already agreed to standardise on here
people?  dev_printk() for devices!  It uniquely shows the device, what
driver is bound to it (if any), the bus id, and everything else.

It's in a parseable, standard format, that everyone agreed a few years
was going to be the way to go!

And now you want to create your own new one?  Come on, please don't be
that foolish.  Please work with what we already have.  Extend it or
something to have these "magic tokens" that you all want to index off
of, that's fine, I really could care less (and I really think it's going
to be a pain in the end, does everyone forget how frickin fast this
body of software moves?)

But whatever you do, don't create yet-another-printk-macro that you are
going to want everyone to use in their drivers/modules.  We've already
done that, and we are still slowly converting people over to them (I did
just that for a large number USB drivers just today...)

Work off of dev_printk() and friends, don't do something new.

thanks,

greg k-h

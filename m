Return-Path: <linux-kernel-owner+w=401wt.eu-S1759238AbYHOQG5@vger.kernel.org>
Date: Fri, 15 Aug 2008 09:03:55 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080815160355.GD23720@suse.de>
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com> <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com> <1218733457.2651.11.camel@localhost> <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com> <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de> <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 14, 2008 at 10:33:10PM -0700, Tim Hockin wrote:
> On Thu, Aug 14, 2008 at 8:44 PM, Greg KH <gregkh@suse.de> wrote:
> >
> > What is wrong with what we have already agreed to standardise on here
> > people?  dev_printk() for devices!  It uniquely shows the device, what
> > driver is bound to it (if any), the bus id, and everything else.
> 
> Part of the problem, imho, is the "if any" part.  But I am more than happy to
> build on existing solutions.  All the world is not a dev, though.

No, but way over half the kernel is.

> I'd like to be able to report something like an OOM kill in (roughly)
> the same way as an ATA error, and I want (though could be talked out
> of) a way to tell these "events" (for lack of a better word) apart
> from plain-old-printk()s.

That's great, then create something that can handle both!  Don't throw
away some wonderful information that way over half the kernel has access
to just because the minority doesn't.  That would mean that we would
loose information in those drivers overall.

thanks,

greg k-h

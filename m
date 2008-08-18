Return-Path: <linux-kernel-owner+w=401wt.eu-S1752655AbYHRJXw@vger.kernel.org>
Date: Mon, 18 Aug 2008 11:23:20 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080818092317.GD6635@atrey.karlin.mff.cuni.cz>
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com> <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com> <1218733457.2651.11.camel@localhost> <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com> <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de> <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com> <20080815112117.GP10078@bolzano.suse.de> <b3ece790808150839i54fde73uf068cb04d4027156@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ece790808150839i54fde73uf068cb04d4027156@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Jan Blunck <jblunck@suse.de>, Greg KH <gregkh@suse.de>, Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?iso-8859-2?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

Hi!

> > I don't think that he wants to unify all the printk's in the system. I don't
> > think that reporting all errors "in the same way as an ATA error" makes any
> > sense. That would just lead to very stupid and unnatural messages for all
> > errors that are not like "ATA errors". Annotation of existing errors is a much
> > more flexible and feasible solution to that problem.
> 
> Please don't misinterpret.  I don't want to make other errors parse
> like an ATA error, I want to make the plumbing be parallel.  I want
> one umbrella mechanism for reporting things that are more important
> than just-another-printk().
> 
> Because frankly, "parse dmesg" is a pretty crappy way to have to
> monitor your system for failures, and I am tired of explaining to
> people why we still do that.

"parse dmesg" does not work for monitoring your system for failures;
dmesg buffer can overflow.

If something fails, you should get errno returned for userspace, and
that's where you should be doing the monitoring.

So... what parts don't return enough information to userspace so that
you need to parse dmesg? Lets fix them.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

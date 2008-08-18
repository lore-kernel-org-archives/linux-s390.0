Return-Path: <linux-kernel-owner+w=401wt.eu-S1753802AbYHRKkM@vger.kernel.org>
Date: Mon, 18 Aug 2008 12:39:56 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080818103956.GB11378@duck.suse.cz>
References: <20080730171156.824640459@de.ibm.com> <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com> <1218733457.2651.11.camel@localhost> <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com> <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de> <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com> <20080815112117.GP10078@bolzano.suse.de> <b3ece790808150839i54fde73uf068cb04d4027156@mail.gmail.com> <20080818092317.GD6635@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080818092317.GD6635@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Tim Hockin <thockin@hockin.org>, Jan Blunck <jblunck@suse.de>, Greg KH <gregkh@suse.de>, Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon 18-08-08 11:23:20, Pavel Machek wrote:
> Hi!
> 
> > > I don't think that he wants to unify all the printk's in the system. I don't
> > > think that reporting all errors "in the same way as an ATA error" makes any
> > > sense. That would just lead to very stupid and unnatural messages for all
> > > errors that are not like "ATA errors". Annotation of existing errors is a much
> > > more flexible and feasible solution to that problem.
> > 
> > Please don't misinterpret.  I don't want to make other errors parse
> > like an ATA error, I want to make the plumbing be parallel.  I want
> > one umbrella mechanism for reporting things that are more important
> > than just-another-printk().
> > 
> > Because frankly, "parse dmesg" is a pretty crappy way to have to
> > monitor your system for failures, and I am tired of explaining to
> > people why we still do that.
> 
> "parse dmesg" does not work for monitoring your system for failures;
> dmesg buffer can overflow.
> 
> If something fails, you should get errno returned for userspace, and
> that's where you should be doing the monitoring.
  Yes, but there are far to few errno's to identify the problem. Imagine
how many different causes can result in EIO. Or have you ever tried to find
out why the crappy filesystem doesn't want to mount without looking into
kernel messages - the returned errno is always the same :). So I don't
think errno is a solution...

> So... what parts don't return enough information to userspace so that
> you need to parse dmesg? Lets fix them.
  
									Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR

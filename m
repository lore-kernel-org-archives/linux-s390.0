Return-Path: <linux-kernel-owner+w=401wt.eu-S1756215AbYHQRdp@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200808171511.09346.rusty@rustcorp.com.au>
References: <20080730165656.118280544@de.ibm.com>
	 <1218908985.6037.12.camel@localhost>
	 <b3ece790808161340x4b03b91er6f0bfcc46c6fb3ad@mail.gmail.com>
	 <200808171511.09346.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Sun, 17 Aug 2008 19:33:00 +0200
Message-Id: <1218994380.20098.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tim Hockin <thockin@hockin.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2008-08-17 at 15:11 +1000, Rusty Russell wrote:
> > > Ok, so  a specialized version of printk will do the work to calculate
> > > the hash. Only, what will we do if there ever is a conflict? The message
> > > tag has to be unique. The shorter the hash is, the more likely a
> > > collision gets. Don't know if 6 hash digits is enough to just ignore the
> > > problem.
> >
> > And if you ever need to change the text that is in the format string?
> > The hash changes.  That seems exactly counter to your goal...
> 
> You need to catalogue them all anyway, so you can detect clashes at build 
> time.  Yes, you have to change the new string in that case, but that's easy.

Is the suggestion that in case of a clash just change the message string
slightly to avoid the clash ? 

> And the number changing as the message changes is arguably a feature.  You 
> shouldn't (and we generally don't) idly change kernel messages.

This is very true. If a message is touched most likely the message
description has to be changed as well. If the message hash then changes
the tools can warn about it. The small thing now only is the matter of
actually implementing the hash and changing the script to work on them..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

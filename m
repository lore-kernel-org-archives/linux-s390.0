Return-Path: <linux-kernel-owner+w=401wt.eu-S1753681AbYHYQEf@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200808131433.02966.rusty@rustcorp.com.au>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <200808131433.02966.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Mon, 25 Aug 2008 17:56:30 +0200
Message-Id: <1219679790.16131.28.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-08-13 at 14:33 +1000, Rusty Russell wrote:
> On Thursday 31 July 2008 02:56:57 Martin Schwidefsky wrote:
> > From: Michael Holzheu <holzheu@de.ibm.com>
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >
> > Introduce a new family of printk macros which prefixes each kmsg message
> > with a component name and allows to tag the printk with a message id.
> 
> Can you hash the format string to generate the id?  6 hex digits should be 
> enough, and your tool can check for clashes.  As it's bad form to have 
> identical strings for different semantics anyway, this seems to make sense.

If we go with hashes there is one more thing: kmsg(0, <string>)
The variant where we manually assign the message ids knows about the
"special" id 0. There is no documentation required for id 0 and none is
wanted. If we replace the manual ids with hashes this will get lost. You
could argue that a kmsg with id 0 is a normal printk so why not just use
printk? What is lost is the information that this printk has been found
to be not important enough to be documented.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

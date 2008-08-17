Return-Path: <linux-kernel-owner+w=401wt.eu-S1754345AbYHQDkc@vger.kernel.org>
Date: Sat, 16 Aug 2008 23:39:03 -0400 (EDT)
From: Rick Troth <rmt@casita.net>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <b3ece790808161340x4b03b91er6f0bfcc46c6fb3ad@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0808162317050.10939@jeremiah.casita.net>
References: <20080730165656.118280544@de.ibm.com>  <200808131433.02966.rusty@rustcorp.com.au>
  <1218733623.2651.14.camel@localhost>  <200808150922.23277.rusty@rustcorp.com.au>
  <1218908985.6037.12.camel@localhost> <b3ece790808161340x4b03b91er6f0bfcc46c6fb3ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: schwidefsky@de.ibm.com, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

This is really an easy thing to do.
It can be achieved without a huge retro-fit.
It can happen even without yet another macro.
(Not saying that there should not be a new macro or new function,
just that we can enjoy unique message IDs without those mechanisms.)

Martin Schwidefsky said:
> > Ok, so  a specialized version of printk will do the work to calculate
> > the hash. Only, what will we do if there ever is a conflict? The message
> > tag has to be unique. The shorter the hash is, the more likely a
> > collision gets. Don't know if 6 hash digits is enough to just ignore the
> > problem.

Point to note: the message tag has to be unique.
The tag is what's relevant, what gets catalogued.

I don't really see the value of a hash per se.
What Martin has suggested (unless I have misunderstood) is
the driver name combined with some index number ==> unique msg id.
That's not exactly a "hash".  (One can generate a hash from it,
but why bother?  You've got a unique string already.)

Then Tim Hockin wrote:
> And if you ever need to change the text that is in the format string?
> The hash changes.  That seems exactly counter to your goal...

Whether hashed or not, what's needed is premeditated reporting,
intentional dividing between variable content (like device ID)
and the explanatory text arround it.  Prefix each line with a token
(or as most are calling it, a "tag") that can be looked up off-line.

I hope no one is thinking gettext in this thread.
Don't clutter the kernel with something like gettext.

And don't burden the kernel with run-time text crunching.
Message codes go in when the module is written.
They get looked up either in user space or off-line.
Easy!  Almost trivial!

-- R;   <><

Return-Path: <linux-kernel-owner+w=401wt.eu-S1757189AbYHNRFG@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 19:04:17 +0200
Message-Id: <1218733457.2651.11.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2008-08-12 at 17:35 -0700, Tim Hockin wrote:
> On Wed, Jul 30, 2008 at 9:56 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > From: Michael Holzheu <holzheu@de.ibm.com>
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >
> > Introduce a new family of printk macros which prefixes each kmsg message
> > with a component name and allows to tag the printk with a message id.
> 
> We've been talking about doing something like this, just this week.  AKPM
> pointed me at this thread.  Good timing. :)

Good to hear that we are not the only one working on this.

> > +#define kmsg_dev_alert(id, dev, format, arg...) \
> > +    printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
> > +        ": %s: " format, (dev)->bus_id , ## arg)
> 
> Rather than the gcc-specific '## arg', shouldn't we use the standard C99
> form: '##__VA_ARGS__'  ?

Ok, I changed the macros accordingly.

> As a format, I would argue to leave out the spaces after colons, making
> the inevitable string splitting even easier.

Makes sense and it does not make the message harder to read.

> I don't care for the magic file-global KMSG_COMPONENT.  It just feels
> wrong.  In most cases, I want the prefix to be hierarchical.  For example,
> rather than "tg3" I want "net.tg3" or "netdev:tg3" or something.

But what is the alternative to the #define to specify the base name of
the message tag? KBUILD_MODNAME has been proposed but I don't think this
is a good idea since I want the message tags to be independent of the
code structure.

> Further, We want to make a clearer denotation between "just another
> printk()" and these things, which are really "important events".  Maybe a
> global prefix that makes it easy to seperate them out?  Or a parallel
> "event" interface that logs to printk() and a netlink socket?

Well the kmsg macros distinguish between id==0 and id>0 messages. For a
id==0 message there is no documentation required and the kmsg prefix
will be just the KMSG_COMPONENT. You could consider that to be "just
another printk". For id>0 the kmsg macros will create the tuppel
KMSG_COMPONENT.ID so you already can separate "normal" and "important"
prinkts.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

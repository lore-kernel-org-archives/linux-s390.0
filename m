Return-Path: <linux-kernel-owner+w=401wt.eu-S1754792AbYHGQLb@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Joe Perches <joe@perches.com>
In-Reply-To: <1218097901.1033.10.camel@localhost>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
	 <20080730220432.GA24800@suse.de> <1217495404.8555.20.camel@localhost>
	 <20080805223117.GA6552@suse.de> <1218011716.20769.12.camel@localhost>
	 <20080806200721.GA30086@suse.de>  <1218097901.1033.10.camel@localhost>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 08:59:30 -0700
Message-Id: <1218124771.5882.37.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-08-07 at 10:31 +0200, Martin Schwidefsky wrote:
> On Wed, 2008-08-06 at 13:07 -0700, Greg KH wrote:
> > No, I mean use dev_printk() as the base for your logging macro.  Add
> > your message tag as the first field after the dev_printk() information.
> Hmm, you are proposing to introduce a second format for the kmsg
> messages to avoid the need for some more printk wrapper macros. To me it
> seems that this has two problems:
> 1) The message tag is for the user of the system. If it does not have a
> fixed position it gets confusing.

I think the message tag today is not useful for a user.

It seems a barely useful maintainer value.

Perhaps the message tag allows for run-time language
translation and maybe a bit better selective logging.

> 2) The message tag for a driver message usually already includes the
> driver name, the dev_printk will print it again. This is ugly and
> reduces the quality of the message.

Ugly is a beholder problem.

Either printk or dev_printk could reorder the output.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1754205AbYI0XQm@vger.kernel.org>
Subject: Re: [patch 1/6] kmsg: tagged kernel messages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200809271715.33968.rusty@rustcorp.com.au>
References: <20080925162827.818261893@de.ibm.com>
	 <200809261448.05391.rusty@rustcorp.com.au>
	 <1222417774.22679.2.camel@localhost>
	 <200809271715.33968.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Sun, 28 Sep 2008 01:16:40 +0200
Message-Id: <1222557400.14610.9.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 2008-09-27 at 17:15 +1000, Rusty Russell wrote:
> > These are just the regular printk levels. If your old printk used a
> > particular level, have the kmsg_xxx printk use the same level. The
> > question about message severity and message documenation are
> > independent, aren't they?
> 
> Yes, but since it's a new message API, I thought you might have an idea.  It's 
> hard for authors (eg. me) to know which level to use.  As a result, levels 
> currently seem to be chosen randomly.
> 
> If you felt inspired to rationalize them, it would let us clean that up as 
> things moved to kmsg :)

Urgs, you are after a sort of definition what the differences is between
a warning, an error, an alert, etc is, aren't you?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

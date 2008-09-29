Return-Path: <linux-kernel-owner+w=401wt.eu-S1753809AbYI2Ig3@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [patch 1/6] kmsg: tagged kernel messages.
Date: Mon, 29 Sep 2008 10:35:00 +0200
References: <20080925162827.818261893@de.ibm.com> <1222557400.14610.9.camel@localhost> <200809281209.55902.rusty@rustcorp.com.au>
In-Reply-To: <200809281209.55902.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809291035.00986.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?utf-8?q?Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Am Sonntag, 28. September 2008 schrieb Rusty Russell:
> On Sunday 28 September 2008 09:16:40 Martin Schwidefsky wrote:
> > On Sat, 2008-09-27 at 17:15 +1000, Rusty Russell wrote:
> > > It's hard for authors (eg. me) to know which level to use.  As a result,
> > > levels currently seem to be chosen randomly.
> > >
> > > If you felt inspired to rationalize them, it would let us clean that up
> > > as things moved to kmsg :)
> >
> > Urgs, you are after a sort of definition what the differences is between
> > a warning, an error, an alert, etc is, aren't you?
> 

Rusty,

Since Kernel message levels are used directly by syslog, the Open Group Base 
Specifications Issue 6 defines what these levels are:
http://www.opengroup.org/onlinepubs/009695399/basedefs/syslog.h.html

LOG_EMERG
A panic condition was reported to all processes.
LOG_ALERT
A condition that should be corrected immediately.
LOG_CRIT
A critical condition.
LOG_ERR
An error message.
LOG_WARNING
A warning message.
LOG_NOTICE
A condition requiring special handling.
LOG_INFO
A general information message.
LOG_DEBUG
A message useful for debugging programs.

I dont think, that the kernel should define anything different.
We could add a more verbose description or a howto to CodingStyle later on, 
but this is really orthogonal to kmsg and would be valid for printk, 
dev_printk and any other printk wrapper.

Futhermore, this really smells like a bike shed color question and IMHO we 
should not hold of the kmsg patches to answer this kind of controversial 
questions ;-)

Christian 

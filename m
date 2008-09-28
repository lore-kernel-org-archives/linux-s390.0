Return-Path: <linux-kernel-owner+w=401wt.eu-S1753123AbYI1CKR@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 1/6] kmsg: tagged kernel messages.
Date: Sun, 28 Sep 2008 12:09:54 +1000
References: <20080925162827.818261893@de.ibm.com> <200809271715.33968.rusty@rustcorp.com.au> <1222557400.14610.9.camel@localhost>
In-Reply-To: <1222557400.14610.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809281209.55902.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?utf-8?q?Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sunday 28 September 2008 09:16:40 Martin Schwidefsky wrote:
> On Sat, 2008-09-27 at 17:15 +1000, Rusty Russell wrote:
> > It's hard for authors (eg. me) to know which level to use.  As a result,
> > levels currently seem to be chosen randomly.
> >
> > If you felt inspired to rationalize them, it would let us clean that up
> > as things moved to kmsg :)
>
> Urgs, you are after a sort of definition what the differences is between
> a warning, an error, an alert, etc is, aren't you?

And it is a sign of my admiration for your intellect that I asked you for it.  
(Does that help?)

Rusty.

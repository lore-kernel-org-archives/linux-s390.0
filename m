Return-Path: <linux-kernel-owner+w=401wt.eu-S1760620AbYHORD0@vger.kernel.org>
Message-ID: <b3ece790808151003o24e518a1ra217010f6658c2c6@mail.gmail.com>
Date: Fri, 15 Aug 2008 10:03:16 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <20080815160355.GD23720@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
	 <1218733457.2651.11.camel@localhost>
	 <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
	 <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de>
	 <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
	 <20080815160355.GD23720@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 15, 2008 at 9:03 AM, Greg KH <gregkh@suse.de> wrote:

>> I'd like to be able to report something like an OOM kill in (roughly)
>> the same way as an ATA error, and I want (though could be talked out
>> of) a way to tell these "events" (for lack of a better word) apart
>> from plain-old-printk()s.
>
> That's great, then create something that can handle both!  Don't throw
> away some wonderful information that way over half the kernel has access
> to just because the minority doesn't.  That would mean that we would
> loose information in those drivers overall.

Sorry, I never meant to imply that dev_printk() was to be ignored, my
examples was meant to be trivial to demonstrate :)  dev_printk() is
good.  We should keep it :)

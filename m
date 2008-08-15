Return-Path: <linux-kernel-owner+w=401wt.eu-S1756636AbYHOFdW@vger.kernel.org>
Message-ID: <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
Date: Thu, 14 Aug 2008 22:33:10 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <20080815034419.GB803@suse.de>
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
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 14, 2008 at 8:44 PM, Greg KH <gregkh@suse.de> wrote:
>
> What is wrong with what we have already agreed to standardise on here
> people?  dev_printk() for devices!  It uniquely shows the device, what
> driver is bound to it (if any), the bus id, and everything else.

Part of the problem, imho, is the "if any" part.  But I am more than happy to
build on existing solutions.  All the world is not a dev, though.  I'd like to
be able to report something like an OOM kill in (roughly) the same way as an
ATA error, and I want (though could be talked out of) a way to tell these
"events" (for lack of a better word) apart from plain-old-printk()s.

Tim

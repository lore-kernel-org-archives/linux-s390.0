Return-Path: <linux-kernel-owner+w=401wt.eu-S1755655AbYHQR14@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1218915375.24527.105.camel@localhost>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
	 <20080730220432.GA24800@suse.de> <1217495404.8555.20.camel@localhost>
	 <20080805223117.GA6552@suse.de> <1218011716.20769.12.camel@localhost>
	 <20080806200721.GA30086@suse.de>  <1218097901.1033.10.camel@localhost>
	 <1218124771.5882.37.camel@localhost>  <1218326902.14983.22.camel@localhost>
	 <1218915375.24527.105.camel@localhost>
Content-Type: text/plain
Date: Sun, 17 Aug 2008 19:27:39 +0200
Message-Id: <1218994059.20098.4.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 2008-08-16 at 12:36 -0700, Joe Perches wrote:
> Doesn't this example better illustrate the barely useful
> user value of such a message and documentation?
> 
> In your example, monwriter.1 with a return code of 5 isn't possible.

That is true, thanks for pointing out this bug. I doesn't change
anything about the need for a message documentation though, it only
proves that the documentation can have errors. At least the customers
running linux on System z want to have the documentation.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

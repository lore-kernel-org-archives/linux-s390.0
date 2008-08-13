Return-Path: <linux-kernel-owner+w=401wt.eu-S1756022AbYHMOul@vger.kernel.org>
Message-ID: <b3ece790808130750x37e44e48u125a95780ff32d8a@mail.gmail.com>
Date: Wed, 13 Aug 2008 07:50:14 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <20080813071323.GA6298@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <200808131433.02966.rusty@rustcorp.com.au>
	 <b3ece790808130004p4763b11fveaf4c8380c7c86f7@mail.gmail.com>
	 <20080813071323.GA6298@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 13, 2008 at 12:13 AM, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
>> But there are a number of places that have different strings for the
>> same meaning: "Can't" vs "can't" vs "can not" vs "failed to", etc.
>
> Do you have examples?
>
> That wastes space in bzImage (and hints of duplicated code), so we may
> want to fix it anyway.

I can look for the specific examples.  I just saw the regexes we use
this week and was taken aback at how they have been loosened for these
sorts of cases.

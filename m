Return-Path: <linux-kernel-owner+w=401wt.eu-S1755518AbYHMHs6@vger.kernel.org>
Date: Wed, 13 Aug 2008 09:13:26 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
Message-ID: <20080813071323.GA6298@elf.ucw.cz>
References: <20080730165656.118280544@de.ibm.com> <20080730171156.824640459@de.ibm.com> <200808131433.02966.rusty@rustcorp.com.au> <b3ece790808130004p4763b11fveaf4c8380c7c86f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ece790808130004p4763b11fveaf4c8380c7c86f7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

Hi!

> But there are a number of places that have different strings for the
> same meaning: "Can't" vs "can't" vs "can not" vs "failed to", etc.

Do you have examples?

That wastes space in bzImage (and hints of duplicated code), so we may
want to fix it anyway.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

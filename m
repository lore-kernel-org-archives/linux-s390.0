Return-Path: <linux-kernel-owner+w=401wt.eu-S1760009AbYHEIEL@vger.kernel.org>
Subject: Re: [patch 0/3] [RFC] kmsg macros and script, take x+1.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080804202614.GA29170@uranus.ravnborg.org>
References: <20080730165656.118280544@de.ibm.com>
	 <20080804202614.GA29170@uranus.ravnborg.org>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 10:03:29 +0200
Message-Id: <1217923409.23678.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-08-04 at 22:26 +0200, Sam Ravnborg wrote:
> > The lastest changes:
> >  * kmsg.h has been moved from include/asm-s390 to include/linux
> >  * The s390 specific documentation is now in Documentation/kmsg/s390
> >  * The script checks for messages in the source file, Documentation/kmsg
> >    and Documentation/kmsg/$SRCARCH
> 
> The tendency is that all ARCH specific files should be part of
> arch/$ARCH/*
> What is the correct approach here I dunno.

Hmm, arch/$ARCH/kmsg. But then Documentation/kmsg doesn't really fit,
does it? Don't no either.. 

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

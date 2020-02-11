Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33027 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgBKU0n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 15:26:43 -0500
Date: Tue, 11 Feb 2020 13:26:40 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: -Wtautological-constant-compare in arch/s390/include/asm/page.h
Message-ID: <20200211202640.GA12483@ubuntu-m2-xlarge-x86>
References: <20200208125714.GA9164@ubuntu-x2-xlarge-x86>
 <1f54ae4c-8748-496b-0833-80749d8d4f6c@de.ibm.com>
 <your-ad-here.call-01581426089-ext-6170@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01581426089-ext-6170@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Tue, Feb 11, 2020 at 02:01:29PM +0100, Vasily Gorbik wrote:
> On Mon, Feb 10, 2020 at 08:55:46AM +0100, Christian Borntraeger wrote:
> > 
> > 
> > On 08.02.20 13:57, Nathan Chancellor wrote:
> > > Hi all,
> > > 
> > > We noticed that you all added support for building s390 with clang,
> > > which is great! I have noticed a few warnings for which I will send
> > > patches but this one has me stumped.
> > > 
> > > In file included from ../lib/crypto/sha256.c:16:
> > > In file included from ../include/linux/module.h:13:
> > > In file included from ../include/linux/stat.h:19:
> > > In file included from ../include/linux/time.h:6:
> > > In file included from ../include/linux/seqlock.h:36:
> > > In file included from ../include/linux/spinlock.h:51:
> > > In file included from ../include/linux/preempt.h:78:
> > > In file included from ../arch/s390/include/asm/preempt.h:6:
> > > In file included from ../include/linux/thread_info.h:38:
> > > In file included from ../arch/s390/include/asm/thread_info.h:26:
> > > ../arch/s390/include/asm/page.h:45:6: warning: converting the result of '<<' to a boolean always evaluates to false [-Wtautological-constant-compare]
> > >         if (PAGE_DEFAULT_KEY)
> > >             ^
> > > ../arch/s390/include/asm/page.h:23:44: note: expanded from macro 'PAGE_DEFAULT_KEY'
> > > #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
> > >                                                   ^
> > > 1 warning generated.
> 
> This warning only shows up for the decompressor code and purgatory which
> have separate set of build flags not derived from top level KBUILD_CFLAGS.
> For the rest of the code this warning is suppressed by:
> Makefile:
>  740 ifdef CONFIG_CC_IS_CLANG
> ...
>  744 # Quiet clang warning: comparison of unsigned expression < 0 is always false
>  745 KBUILD_CFLAGS += -Wno-tautological-compare
> 
> At the same time both decompressor and purgatory Makefiles include
> CLANG_FLAGS into their CFLAGS. And this -Wno-tautological-compare is
> clang specific. So I believe this option belongs to CLANG_FLAGS
> rather than being included into KBUILD_CFLAGS under ifdef
> CONFIG_CC_IS_CLANG. But this raises question about other clang
> specific options inside that ifdef CONFIG_CC_IS_CLANG. Should they all
> be made part of CLANG_FLAGS?

Hi Vasily,

I am trying to turn on -Wtautological-compare for the kernel as a whole,
hence me trying to deal with this one now :) That flag controls a bunch
of useful subwarnings that can point out potentially problematic code.

I think that it would be worth adding warnings that we want disabled in
all code to CLANG_FLAGS but as of right now, this is the only instance
of this warning that I see within the s390 code so it is probably just
worth silencing with an explicit comparison (!= 0). I will send a patch
for this later.

Cheers,
Nathan

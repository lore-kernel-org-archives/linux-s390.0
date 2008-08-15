Return-Path: <linux-kernel-owner+w=401wt.eu-S1761232AbYHOTC4@vger.kernel.org>
Date: Fri, 15 Aug 2008 22:00:43 +0300
From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [RFC: 2.6 patch] s390: use kernel/uid.c
Message-ID: <20080815190043.GC1973@cs181140183.pp.htv.fi>
References: <20080810204031.GC8399@cs181140183.pp.htv.fi> <200808151734.43710.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200808151734.43710.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 15, 2008 at 05:34:43PM +0200, Arnd Bergmann wrote:
> On Sunday 10 August 2008, Adrian Bunk wrote:
> > Unless I missed a twist the only reason for s390 to not use the code in 
> > kernel/uid.c was that it copied the code from sparc64 (that is now 
> > being changed in a similar way by David).
> > 
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> I tried doing this before but couldn't figure out an easy way,
> but the circumstances may have changed by now.
> 
> Back then, the basic problem was that CONFIG_UID16 had side-effects
> that break the 64-bit versions of some syscalls. I don't see that
> being the case any more, but from what I can tell, you still need
> to add definitions for __kernel_old_uid_t etc on s390x.

They are already in arch/s390/include/asm/posix_types.h

The one thing I can say about my patch is that it compiles with the 
defconfig (where the uid16 code is used due to COMPAT=y).

> If that does the trick, great work!
> 
> 	Arnd <><

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

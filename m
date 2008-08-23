Return-Path: <linux-kernel-owner+w=401wt.eu-S1755708AbYHWNDw@vger.kernel.org>
Date: Sat, 23 Aug 2008 15:03:05 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC: 2.6 patch] s390: use kernel/uid.c
Message-ID: <20080823130305.GA5683@osiris.boeblingen.de.ibm.com>
References: <20080810204031.GC8399@cs181140183.pp.htv.fi> <200808151734.43710.arnd@arndb.de> <20080815190043.GC1973@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080815190043.GC1973@cs181140183.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 15, 2008 at 10:00:43PM +0300, Adrian Bunk wrote:
> On Fri, Aug 15, 2008 at 05:34:43PM +0200, Arnd Bergmann wrote:
> > On Sunday 10 August 2008, Adrian Bunk wrote:
> > > Unless I missed a twist the only reason for s390 to not use the code in 
> > > kernel/uid.c was that it copied the code from sparc64 (that is now 
> > > being changed in a similar way by David).
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> > 
> > I tried doing this before but couldn't figure out an easy way,
> > but the circumstances may have changed by now.
> > 
> > Back then, the basic problem was that CONFIG_UID16 had side-effects
> > that break the 64-bit versions of some syscalls. I don't see that
> > being the case any more, but from what I can tell, you still need
> > to add definitions for __kernel_old_uid_t etc on s390x.
> 
> They are already in arch/s390/include/asm/posix_types.h
> 
> The one thing I can say about my patch is that it compiles with the 
> defconfig (where the uid16 code is used due to COMPAT=y).

A lot of stuff compiles ;) .
If I remember correctly this doesn't work because the types of
__kernel_old_uid_t are different on 64BIT on !64BIT on s390.
So you can't use the generic uid16 code for compat calls.
Tried the same more than two years ago and decided it wasn't worth
the effort: http://lkml.org/lkml/2006/7/10/49

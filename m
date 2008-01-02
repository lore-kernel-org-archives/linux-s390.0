Return-Path: <linux-kernel-owner+w=401wt.eu-S1756041AbYABJtX@vger.kernel.org>
Date: Wed, 2 Jan 2008 10:49:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: (Try #3) [Patch 3/8] S390: Remove 'TOPDIR' from Makefile
Message-ID: <20080102094913.GA7815@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101072555.GD2496@hacking> <20080101101720.GC28913@uranus.ravnborg.org> <20080101132739.GC2499@hacking> <20080101174214.GB31575@uranus.ravnborg.org> <20080102064219.GG2493@hacking> <1199266295.9147.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1199266295.9147.1.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 02, 2008 at 10:31:35AM +0100, Martin Schwidefsky wrote:
> On Wed, 2008-01-02 at 14:42 +0800, WANG Cong wrote:
> > diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> > index 56cb710..b3b650a 100644
> > --- a/arch/s390/kernel/Makefile
> > +++ b/arch/s390/kernel/Makefile
> > @@ -31,7 +31,3 @@ S390_KEXEC_OBJS := machine_kexec.o crash.o
> >  S390_KEXEC_OBJS += $(if
> > $(CONFIG_64BIT),relocate_kernel64.o,relocate_kernel.o)
> >  obj-$(CONFIG_KEXEC) += $(S390_KEXEC_OBJS)
> > 
> > -#
> > -# This is just to get the dependencies...
> > -#
> > -binfmt_elf32.o:        $(TOPDIR)/fs/binfmt_elf.c
> 
> This one is correct. I'll add it to git390.

Thanks Martin.

	Sam

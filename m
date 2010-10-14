Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] mutex: Introduce mutex_cpu_relax()
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reply-To: gerald.schaefer@de.ibm.com
In-Reply-To: <1287071960.29097.284.camel@twins>
References: <1287070392.8344.15.camel@thinkpad>
	 <1287071960.29097.284.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Oct 2010 19:31:05 +0200
Message-ID: <1287077465.8344.47.camel@thinkpad>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Do, 2010-10-14 at 17:59 +0200, Peter Zijlstra wrote:
> On Thu, 2010-10-14 at 17:33 +0200, Gerald Schaefer wrote:
> 
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -100,6 +100,7 @@ config S390
> >  	select HAVE_KERNEL_BZIP2
> >  	select HAVE_KERNEL_LZMA
> >  	select HAVE_KERNEL_LZO
> > +	select HAVE_MUTEX_CPU_RELAX
> >  	select ARCH_INLINE_SPIN_TRYLOCK
> >  	select ARCH_INLINE_SPIN_TRYLOCK_BH
> >  	select ARCH_INLINE_SPIN_LOCK
> 
> >  
> > +#ifndef HAVE_MUTEX_CPU_RELAX
> > +#define mutex_cpu_relax()	cpu_relax()
> > +#endif
> 
> Won't KConfig make CONFIG_HAVE_MUTEX_CPU_RELAX from that?
> 
> Also, don't you have to first create a dummy Kconfig variable before you
> select it?

Of course you're right. I first used a #define in a header file,
but decided to rather use the Kconfig approach to avoid header
file dependency problems, should have been more careful with that.

I'll send a new patch.

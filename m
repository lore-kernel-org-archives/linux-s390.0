Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 28 Sep 2018 08:24:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809280823220.8118@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 28 Sep 2018, Thomas Gleixner wrote:

> On Thu, 27 Sep 2018, Andy Lutomirski wrote:
> > I have a couple questions here:
> > 
> >  - Is this actually okay on all architectures?  That is, are there
> >    cases where we'll screw up if we fail a USER_DS access this early?
> >    s390 stands out as the obvious special case (where USER_DS is not
> >    than just a subset of KERNEL_DS), but s390 opts out.
> >
> >  - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
> >    some 32-bit configurations that don't have cmpxchg and don't know
> >    about it at compile time?
> 
> I'm not entirely sure. Have to dig into the details. I assume S390 just can
> set it though.

x86 as well. It's supported from 486 onwards and we ripped out 386 years ago.

Thanks,

	tglx

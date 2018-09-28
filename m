Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 28 Sep 2018 10:31:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809281029350.2004@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Finn Thain <fthain@telegraphics.com.au>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 28 Sep 2018, Geert Uytterhoeven wrote:
> 
> On Fri, Sep 28, 2018 at 8:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 27 Sep 2018, Andy Lutomirski wrote:
> > > I have a couple questions here:
> > >
> > >  - Is this actually okay on all architectures?  That is, are there
> > >    cases where we'll screw up if we fail a USER_DS access this early?
> > >    s390 stands out as the obvious special case (where USER_DS is not
> > >    than just a subset of KERNEL_DS), but s390 opts out.
> > >
> > >  - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
> > >    some 32-bit configurations that don't have cmpxchg and don't know
> > >    about it at compile time?
> >
> > I'm not entirely sure. Have to dig into the details. I assume S390 just can
> > set it though.
> 
> Not sure. My "[PATCH] futex: Switch to USER_DS for futex test"
> (https://www.spinics.net/lists/stable/msg28846.html), which is
> basically the same
> as this patch, broke s390, so it was never merged.
> 
> See "[BUG -next] "futex: switch to USER_DS for futex test" breaks s390"
> (https://www.spinics.net/lists/linux-next/msg27902.html)
> 
> Heiko said:
> | Martin and I discussed this today and we will change the s390 code so that
> | it will also survive very early USER_DS accesses (without valid current->mm)
> | since we also discovered a couple of other oddities in our code.
> 
> I don't know if that has happened, and whether it would work on s390 now.

Duh yes, forgot about that one. But as S390 always has cmpxchg it simply
can set HAVE_FUTEX_CMPXCHG which avoids the check completely.

Surely they want to fix the other oddities or have done so already :)

Thanks,

	tglx

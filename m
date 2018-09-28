Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 28 Sep 2018 10:37:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
        <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
        <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
Message-Id: <20180928103726.07761672@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Finn Thain <fthain@telegraphics.com.au>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 28 Sep 2018 09:12:10 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Thomas,
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

commit 03b8c7b623c80af264c4c8d6111e5c6289933666
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Sun Mar 2 13:09:47 2014 +0100

    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic() test
    
    If an architecture has futex_atomic_cmpxchg_inatomic() implemented and there
    is no runtime check necessary, allow to skip the test within futex_init().
    
    This allows to get rid of some code which would always give the same result,
    and also allows the compiler to optimize a couple of if statements away.
    
    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
    Cc: Finn Thain <fthain@telegraphics.com.au>
    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue.
We just skip the runtime check as well as arc, m68k and sh. Not sure
about xtensa, the set it config option only for !MMU.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

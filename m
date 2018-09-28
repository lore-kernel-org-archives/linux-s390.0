Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
 <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Sep 2018 09:12:10 +0200
Message-ID: <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Finn Thain <fthain@telegraphics.com.au>
List-ID: <linux-s390.vger.kernel.org>

Hi Thomas,

On Fri, Sep 28, 2018 at 8:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
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

Not sure. My "[PATCH] futex: Switch to USER_DS for futex test"
(https://www.spinics.net/lists/stable/msg28846.html), which is
basically the same
as this patch, broke s390, so it was never merged.

See "[BUG -next] "futex: switch to USER_DS for futex test" breaks s390"
(https://www.spinics.net/lists/linux-next/msg27902.html)

Heiko said:
| Martin and I discussed this today and we will change the s390 code so that
| it will also survive very early USER_DS accesses (without valid current->mm)
| since we also discovered a couple of other oddities in our code.

I don't know if that has happened, and whether it would work on s390 now.

> >  kernel/futex.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index 11fc3bb456d6..16bd3e72602a 100644
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -3593,6 +3593,7 @@ static void __init futex_detect_cmpxchg(void)
> >  {
> >  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> >       u32 curval;
> > +     mm_segment_t old_seg;
> >
> >       /*
> >        * This will fail and we want it. Some arch implementations do
> > @@ -3604,8 +3605,11 @@ static void __init futex_detect_cmpxchg(void)
> >        * implementation, the non-functional ones will return
> >        * -ENOSYS.
> >        */
> > +     old_seg = get_fs();
> > +     set_fs(USER_DS);
> >       if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
> >               futex_cmpxchg_enabled = 1;
> > +     set_fs(old_seg);
> >  #endif
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

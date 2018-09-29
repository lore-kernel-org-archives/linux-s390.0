Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 29 Sep 2018 08:32:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMo8Bf+mfK72DPehvphfJnvLc=ne-0bn52drOnMawp1oKjYsig@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809290832360.1432@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1>
 <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1> <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com> <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com>
 <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de> <A3EEA386-DC02-432B-8B53-F1ECD035F431@amacapital.net> <CAMo8Bf+mfK72DPehvphfJnvLc=ne-0bn52drOnMawp1oKjYsig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1766059854-1538202775=:1432"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, fthain@telegraphics.com.au
List-ID: <linux-s390.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1766059854-1538202775=:1432
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Sep 2018, Max Filippov wrote:
> On Fri, Sep 28, 2018 at 2:08 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> On Sep 28, 2018, at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >>> On Fri, 28 Sep 2018, Max Filippov wrote:
> >>>
> >>>> On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >>>> There may be a much nicer solution.  Unless I missed something, only
> >>>> mips and xtensa even have the possibility of cmpxchg being missing.
> >>>> We could just make those arches supply a futex-detecting helper.
> >>>
> >>> In case of xtensa availability of cmpxchg is known at build time.
> >>
> >> That makes it even simpler. Could you provide a patch which selects
> >> CONFIG_HAVE_FUTEX_CMPXCHG for the right set of CPUs please?
> >>
> >>
> >
> > I think that’s the wrong approach, since it won’t cover mips. How about adding this to mips and xtensa only:
> >
> > static inline void arch_have_futex_cmpxchg(void) {...};
> > #define arch_have_futex_cmpxchg arch_have_futex_cmpxchg
> >
> > And getting rid of the config option.
> 
> I'd rather do that, given that defining Kconfig entries that describe
> parts of xtensa configuration is somewhat awkward and redundant.

Fair enough.

Thanks,

	tglx
--8323329-1766059854-1538202775=:1432--

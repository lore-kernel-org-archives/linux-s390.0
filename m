Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 28 Sep 2018 21:38:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809282137260.1432@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1>
 <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1> <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-519499137-1538163517=:1432"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, fthain@telegraphics.com.au
List-ID: <linux-s390.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-519499137-1538163517=:1432
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Sep 2018, Andy Lutomirski wrote:
> On Fri, Sep 28, 2018 at 7:53 AM Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > On Fri, 28 Sep 2018 07:11:44 -0700 Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > > There’s another way to skin this cat: keep KERNEL_DS but pass a valid pointer.
> > > I don’t suppose you remember why you didn’t do that?
> >
> > No, I don't remember. To use a valid kernel pointer with KERNEL_DS and
> > then test for == 0 (vs -ENOSYS) imho should work.
> >
> 
> There may be a much nicer solution.  Unless I missed something, only
> mips and xtensa even have the possibility of cmpxchg being missing.
> We could just make those arches supply a futex-detecting helper.

That makes sense.

Thanks,

	tglx


--8323329-519499137-1538163517=:1432--

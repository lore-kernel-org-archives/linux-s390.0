Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 28 Sep 2018 22:26:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1>
 <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1> <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
 <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, fthain@telegraphics.com.au
List-ID: <linux-s390.vger.kernel.org>

On Fri, 28 Sep 2018, Max Filippov wrote:

> On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> > There may be a much nicer solution.  Unless I missed something, only
> > mips and xtensa even have the possibility of cmpxchg being missing.
> > We could just make those arches supply a futex-detecting helper.
> 
> In case of xtensa availability of cmpxchg is known at build time.

That makes it even simpler. Could you provide a patch which selects
CONFIG_HAVE_FUTEX_CMPXCHG for the right set of CPUs please?

Thanks,

	tglx

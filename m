Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de>
Date: Fri, 28 Sep 2018 14:08:10 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3EEA386-DC02-432B-8B53-F1ECD035F431@amacapital.net>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de> <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1> <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com> <CAMo8BfJ7t-qPWzGPb6JzqEhPm9JBzvAX0a2paBXeQt-RCeHe_w@mail.gmail.com> <alpine.DEB.2.21.1809282224090.1432@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, fthain@telegraphics.com.au
List-ID: <linux-s390.vger.kernel.org>



> On Sep 28, 2018, at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Fri, 28 Sep 2018, Max Filippov wrote:
>>=20
>>> On Fri, Sep 28, 2018 at 11:02 AM, Andy Lutomirski <luto@amacapital.net> w=
rote:
>>> There may be a much nicer solution.  Unless I missed something, only
>>> mips and xtensa even have the possibility of cmpxchg being missing.
>>> We could just make those arches supply a futex-detecting helper.
>>=20
>> In case of xtensa availability of cmpxchg is known at build time.
>=20
> That makes it even simpler. Could you provide a patch which selects
> CONFIG_HAVE_FUTEX_CMPXCHG for the right set of CPUs please?
>=20
>=20

I think that=E2=80=99s the wrong approach, since it won=E2=80=99t cover mips=
. How about adding this to mips and xtensa only:

static inline void arch_have_futex_cmpxchg(void) {...};
#define arch_have_futex_cmpxchg arch_have_futex_cmpxchg

And getting rid of the config option.=

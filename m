Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
 <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
 <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com>
 <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
 <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net> <20180928165321.0ddaf948@mschwideX1>
In-Reply-To: <20180928165321.0ddaf948@mschwideX1>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 28 Sep 2018 11:02:26 -0700
Message-ID: <CALCETrXm_-YVVw4YQVn8E+hHGAQ6tv+ie8Sfq=h72R5U8=hf-g@mail.gmail.com>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, fthain@telegraphics.com.au
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 28, 2018 at 7:53 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Fri, 28 Sep 2018 07:11:44 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
> > > On Sep 28, 2018, at 1:42 AM, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> > >
> > >> On Fri, 28 Sep 2018, Martin Schwidefsky wrote:
> > >> On Fri, 28 Sep 2018 09:12:10 +0200
> > >> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>> I don't know if that has happened, and whether it would work on s39=
0 now.
> > >>
> > >> commit 03b8c7b623c80af264c4c8d6111e5c6289933666
> > >> Author: Heiko Carstens <heiko.carstens@de.ibm.com>
> > >> Date:   Sun Mar 2 13:09:47 2014 +0100
> > >>
> > >>    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic(=
) test
> > >>
> > >>    If an architecture has futex_atomic_cmpxchg_inatomic() implemente=
d and there
> > >>    is no runtime check necessary, allow to skip the test within fute=
x_init().
> > >>
> > >>    This allows to get rid of some code which would always give the s=
ame result,
> > >>    and also allows the compiler to optimize a couple of if statement=
s away.
> > >>
> > >>    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > >>    Cc: Finn Thain <fthain@telegraphics.com.au>
> > >>    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > >>    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
> > >>    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >>
> > >>
> > >> Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue=
.
> > >> We just skip the runtime check as well as arc, m68k and sh. Not sure
> > >> about xtensa, the set it config option only for !MMU.
> > >
> > > Duh. grep would have told me. -ENOTENOUGHCOFFEE
> > >
> > >
> >
> > There=E2=80=99s another way to skin this cat: keep KERNEL_DS but pass a=
 valid pointer.
> > I don=E2=80=99t suppose you remember why you didn=E2=80=99t do that?
>
> No, I don't remember. To use a valid kernel pointer with KERNEL_DS and
> then test for =3D=3D 0 (vs -ENOSYS) imho should work.
>

There may be a much nicer solution.  Unless I missed something, only
mips and xtensa even have the possibility of cmpxchg being missing.
We could just make those arches supply a futex-detecting helper.

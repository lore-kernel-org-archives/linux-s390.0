Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
Date: Fri, 28 Sep 2018 07:11:44 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B38810F-3E22-45A8-9D5D-EDEABD214148@amacapital.net>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org> <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de> <CAMuHMdWWxgvo0a+8UvesiVikWS_45yOXRhM39F31Vn17kN+Ptg@mail.gmail.com> <20180928103726.07761672@mschwideX1> <alpine.DEB.2.21.1809281041420.2004@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Finn Thain <fthain@telegraphics.com.au>
List-ID: <linux-s390.vger.kernel.org>



> On Sep 28, 2018, at 1:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Fri, 28 Sep 2018, Martin Schwidefsky wrote:
>> On Fri, 28 Sep 2018 09:12:10 +0200
>> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> I don't know if that has happened, and whether it would work on s390 now=
.
>>=20
>> commit 03b8c7b623c80af264c4c8d6111e5c6289933666
>> Author: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Date:   Sun Mar 2 13:09:47 2014 +0100
>>=20
>>    futex: Allow architectures to skip futex_atomic_cmpxchg_inatomic() tes=
t
>>=20
>>    If an architecture has futex_atomic_cmpxchg_inatomic() implemented and=
 there
>>    is no runtime check necessary, allow to skip the test within futex_ini=
t().
>>=20
>>    This allows to get rid of some code which would always give the same r=
esult,
>>    and also allows the compiler to optimize a couple of if statements awa=
y.
>>=20
>>    Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>>    Cc: Finn Thain <fthain@telegraphics.com.au>
>>    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>    Link: http://lkml.kernel.org/r/20140302120947.GA3641@osiris
>>    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>=20
>>=20
>> Heiko created the CONFIG_HAVE_FUTEX_CMPXCHG to get around this issue.
>> We just skip the runtime check as well as arc, m68k and sh. Not sure
>> about xtensa, the set it config option only for !MMU.
>=20
> Duh. grep would have told me. -ENOTENOUGHCOFFEE
>=20
>=20

There=E2=80=99s another way to skin this cat: keep KERNEL_DS but pass a vali=
d pointer. I don=E2=80=99t suppose you remember why you didn=E2=80=99t do th=
at?=

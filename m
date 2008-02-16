Return-Path: <linux-kernel-owner+w=401wt.eu-S1757198AbYBPTqh@vger.kernel.org>
Date: Sat, 16 Feb 2008 11:45:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] 2.6.25-rc2-mm1 - kernel oops while bootup on s390x
Message-Id: <20080216114527.48408288.akpm@linux-foundation.org>
In-Reply-To: <47B70C3A.4050600@linux.vnet.ibm.com>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>
	<47B70C3A.4050600@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 16 Feb 2008 21:45:54 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ib=
m.com> wrote:

> Hi Andrew,
>=20
> The 2.6.25-rc2-mm1 kernel panic's while boot up on the s390x
>=20
> Unable to handle kernel pointer dereference at virtual kernel address 000=
0000000
> 000000
> Oops: 0004 #1=A8 SMP
> Modules linked in:
> CPU: 0 Not tainted 2.6.25-rc2-mm1-autotest #1
> Process swapper (pid: 1, task: 000000003f830000, ksp: 000000003f83ba48)
> Krnl PSW : 0704a00180000000 000000000024b2be (futex_atomic_cmpxchg_std+0x=
12/0x28
> )
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:2 CC:2 PM:0 EA:3
> Krnl GPRS: 0000000000000074 00000000fffffff2 0000000000000000 00000000000=
00000
>            0000000000000000 0000000000000001 0000000000000000 00000000004=
d0764
>            0000000000000000 00000000004d8768 0000000000000000 000000003f8=
3bdb0
>            0000000000000040 0000000000343950 00000000000627e4 000000003f8=
3bdb0
> Krnl Code: 000000000024b2b2: b90400bf           lgr     %r11,%r15
>            000000000024b2b6: a718fff2           lhi     %r1,-14
>            000000000024b2ba: b2790100           sacf    256
>           >000000000024b2be: ba342000           cs      %r3,%r4,0(%r2)
>            000000000024b2c2: 1813               lr      %r1,%r3
>            000000000024b2c4: b2790000           sacf    0
>            000000000024b2c8: b9140021           lgfr    %r2,%r1
>            000000000024b2cc: e3b0b0700004       lg      %r11,112(%r11)
> Call Trace:
> (<000000003f83bda8>=A8 0x3f83bda8)
>  <00000000004bdeec>=A8 init+0x30/0x104
>  <00000000004b0c40>=A8 kernel_init+0x1e0/0x370
>  <000000000001a5c6>=A8 kernel_thread_starter+0x6/0xc
>  <000000000001a5c0>=A8 kernel_thread_starter+0x0/0xc
>=20
>  <4>--- end trace 561bb236c800851f =A8---
> note: swapper1=A8 exited with preempt_count 1
> Kernel panic - not syncing: Attempted to kill init!
>=20

Possibilities are that something has gone wrong with the recent cmpxchg
changes which are now in mainline, or there's something wrong with
futex-fix-init-order.patch or
futex-runtime-enable-pi-and-robust-functionality.patch.

Or, of course, it's something else ;)

First question is: does this happen in current mainline?

If not, it would be useful if someone could test futex-fix-init-order.patch
and futex-runtime-enable-pi-and-robust-functionality.patch on curent
mainline, because those are planned for 2.6.25.

Thanks.

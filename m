Return-Path: <linux-kernel-owner+w=401wt.eu-S1756422AbYBQJHR@vger.kernel.org>
Date: Sun, 17 Feb 2008 10:06:16 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [BUG] 2.6.25-rc2-mm1 - kernel oops while bootup on s390x
Message-ID: <20080217090616.GA8030@osiris.ibm.com>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org> <47B70C3A.4050600@linux.vnet.ibm.com> <20080216114527.48408288.akpm@linux-foundation.org> <alpine.LFD.1.00.0802162048120.7583@apollo.tec.linutronix.de> <alpine.LFD.1.00.0802162050020.7583@apollo.tec.linutronix.de> <47B7ACBE.1090904@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <47B7ACBE.1090904@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 17, 2008 at 09:10:46AM +0530, Kamalesh Babulal wrote:
> To conform the patches causing the panic, I tested the 2.6.24.2 kernel wi=
th the futex-fix-init-order.patch and
> futex-runtime-enable-pi-and-robust-functionality.patch applied and they s=
eem to cause the kernel
> panic.
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

Thanks for reporting! Patch below should fix it.

Index: linux-2.6/arch/s390/lib/uaccess_std.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/s390/lib/uaccess_std.c
+++ linux-2.6/arch/s390/lib/uaccess_std.c
@@ -293,8 +293,8 @@ int futex_atomic_cmpxchg_std(int __user=20
=20
 	asm volatile(
 		"   sacf 256\n"
-		"   cs   %1,%4,0(%5)\n"
-		"0: lr   %0,%1\n"
+		"0: cs   %1,%4,0(%5)\n"
+		"   lr   %0,%1\n"
 		"1: sacf 0\n"
 		EX_TABLE(0b,1b)
 		: "=3Dd" (ret), "+d" (oldval), "=3Dm" (*uaddr)

Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D84C77C8;
	Wed,  8 Jul 2026 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535862; cv=none; b=A7q8l0oYpirr0jbIhE5FsFug1SJlolGeGKDp9hegvX+uZU55SNzqdwjgJLO7zLub3tm7Nev/5JQRxc4LCRdQErkKEcwgCgdsR8iv+6YgtEgS5s8Npwvh5sTvVFS0nv4PSdWH561bVq33pIik5Z0DA1PD3bfsog22GK22A53s7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535862; c=relaxed/simple;
	bh=47mfftpidT/9Wsw+p7VvEqhivHeFAm8tBlZdw0i+e70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S9oWHaFtomVUlmtGsxZty2Pz4tueIXe4+wr9+/lnofLwMKs9TdZhxaI1nk0gkfGZDucYyXrtaOa7kWEqWwEXKCRygXWWUFnEaLdrB9rX+X+0Ev01ReAM56Nxu1INJ1tVe7tXwt3fIqNYx5UfFBMGNppJ8pQGVQk0jE2KSIxca84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=MYg2quQs; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="MYg2quQs"
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id BD677C343E;
	Wed,  8 Jul 2026 21:37:17 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro BD677C343E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783535859;
	bh=J8eh6Rp71aMkUZPGbdf4HwpQyZ/mRcCB+VtPzFZfm0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MYg2quQsJUR7e8ayAFMJcRvjHsrwKzUQqkhrJdU4nanpzL1jX14m8Z+Ds91DdqoKn
	 QJReaLyNa/iLaBx/8t9LaIJgpO/V9u0Qk+ctVFHOLXc1PsNN77To6wbQLDR/wbO2Jd
	 LI7Oyckd8G3uDywiL3AEPP+/6veZtLhQL8vDm8MBdhsqbXlk1PXB64z0Yki4BQsRic
	 1MYR+Jrgudnmn+eQyNCJp23VAJq+mVC5zubA5AQHg1rSP6wds0PtsFuUt0GISnCwHY
	 EbF0YrfTMJrddRnwe6si6lyEajabery7sEfS+bc1aT49zcfePemMerT/qsFH4wmqB6
	 HEkaGc5AmP+eg==
Message-ID: <335387752ace30084a3f709acf34556443300d1f.camel@rendec.net>
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Huacai Chen
 <chenhuacai@kernel.org>, 	loongarch@lists.linux.dev, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,  Paul Walmsley	
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>,  Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven	 <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Helge Deller	 <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, 	linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, 	linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta	 <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>,  Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 14:37:13 -0400
In-Reply-To: <20260707190253.865955911@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.865955911@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-07 at 21:06 +0200, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
>=20
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var=
()
> as that code is invoked with interrupts disabled.
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
> =C2=A0arch/loongarch/kernel/syscall.c |=C2=A0=C2=A0=C2=A0 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -11,7 +11,6 @@
> =C2=A0#include <linux/linkage.h>
> =C2=A0#include <linux/nospec.h>
> =C2=A0#include <linux/objtool.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/syscalls.h>
> =C2=A0#include <linux/unistd.h>
> =C2=A0
> @@ -70,9 +69,7 @@ void noinstr __no_stack_protector do_sys
> =C2=A0	regs->orig_a0 =3D regs->regs[4];
> =C2=A0	regs->regs[4] =3D -ENOSYS;
> =C2=A0
> -	nr =3D syscall_enter_from_user_mode(regs, nr);
> -
> -	add_random_kstack_offset();
> +	nr =3D syscall_enter_from_user_mode_randomize_stack(regs, nr);
> =C2=A0
> =C2=A0	if (nr < NR_syscalls) {
> =C2=A0		syscall_fn =3D sys_call_table[array_index_nospec(nr, NR_syscalls)=
];

Reviewed-by: Radu Rendec <radu@rendec.net>

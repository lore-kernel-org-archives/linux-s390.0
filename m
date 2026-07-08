Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9153B7742;
	Wed,  8 Jul 2026 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544252; cv=none; b=ntxVFbb/0m8Pj8BIheu8ko85D2t4RGc4kavFkzTZeouVoTxYm6yIZd+C3YM+pFYmlw2VMviz60KTKEpb7PR+dPhDffarR5QWpiJZxiZoQGA1zd39+lmPuU09Tay63Qrx1BklT29E7uAr3B3tK3J5nPiyJ5Q5TpE2O4l7Pm29jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544252; c=relaxed/simple;
	bh=2hzi9Savg6iPJ9G2+nDa/XygxlgJhPb8lJ2xty74coc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaP0hj1u+lVPk8r/MCE5cx/UDQuamwyEw77XLC4VR+U4+jmPjukDhtOkJwH+J73c/8zeeFyErGLim/eilvODRKTdxGzgVMhrCHoUE7aW0L1chnT5eDS2b8r5tvjI5irUiPuI5jb5w6dbrMbXMb0+qWphIBfE5qPhpBsFKaEZBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=ynS36ddU; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="ynS36ddU"
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 276CAC3437;
	Wed,  8 Jul 2026 23:57:05 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 276CAC3437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783544246;
	bh=up349XAcstBbuMmtgpGoCSrvvL3bQC70drCvWmoD2ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ynS36ddUdp8eq69SvUl6OgUXVC9QL2tj6JdfNjNoPXNVKwC/3CN8EubMigM7yTWhw
	 wN2l7xiScOadwqXH8k1Mr6pkHvNMtNLdr91wDtAcHVTHHdPCMoFrB5PPDCaDQEpQ/7
	 nrAG0UN1qXnV/0+w7ire/3DQ71IknBguOljyr+0fQFSjwNiLglUjXiqoASKEjWfiP9
	 hdpfN4vBD8SgIx0jZq/vsbn+u9RcOw90ghJIPsraTy3Kmn5rysmmntnF1EMEJ6MLYT
	 FeMAfAFofJ6Q5u7zyyWHuX3D2olPOI2XjVzaGihUsp+73EBHAshY/LugN1FUs+Ocpp
	 c1dTfe4hj1cHA==
Message-ID: <a8aea664b6dbe92a3ae0c2f084f5c9b1ce591792.camel@rendec.net>
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,  Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen	 <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Sven Schnelle	 <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland	
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski	 <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>,  Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,  Richard Weinberger	
 <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann	
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>,  Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, 	linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, 	sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?ISO-8859-1?Q?Such=E1nek?=	
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org
Date: Wed, 08 Jul 2026 16:57:00 -0400
In-Reply-To: <20260707190253.974626922@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.974626922@kernel.org>
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
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
> =C2=A0arch/riscv/kernel/traps.c |=C2=A0=C2=A0=C2=A0 5 +----
> =C2=A01 file changed, 1 insertion(+), 4 deletions(-)
>=20
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -7,7 +7,6 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/irqflags.h>
> -#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/sched/debug.h>
> =C2=A0#include <linux/sched/signal.h>
> @@ -333,9 +332,7 @@ void do_trap_ecall_u(struct pt_regs *reg
> =C2=A0
> =C2=A0		riscv_v_vstate_discard(regs);
> =C2=A0
> -		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> -
> -		add_random_kstack_offset();
> +		syscall =3D syscall_enter_from_user_mode_randomize_stack(regs, syscall=
);
> =C2=A0
> =C2=A0		if (syscall >=3D 0 && syscall < NR_syscalls) {
> =C2=A0			syscall =3D array_index_nospec(syscall, NR_syscalls);

Reviewed-by: Radu Rendec <radu@rendec.net>

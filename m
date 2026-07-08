Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FE36212C;
	Wed,  8 Jul 2026 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531616; cv=none; b=PcHdBNBB1bKMQcG+dbN9okvP2062qGiagNAzV8uSuvs4l2kuUa4MFYAJbvNLzfdJe2z2FNUxTytEYtKCg+JpjngL7QdHUjryvYe1iZSR6sLHstE44xJ13LtccKPc2xTe+jTIlTcdp6f2f8ac7mcwvoOVUu0UxOtXzCdxz+4RwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531616; c=relaxed/simple;
	bh=2hoJA0I8rorlRGOq+HwlWXfcZlYFh59K/rfqYRa+z8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnmEaSSdpxvXPv09TxQGxPwiuszf1jrd+H5sNQTRXTaYE3CURpgmB1N2cpVhkeDT9wMRWxFJXOI30aEeHuWrCEUWwy3RjCDAEPEt14vQi9DdnUyDo3CU/EDWY3oSH4hM9qCRziEy66Q1yL52akxkPSuJl71amcwRnIdxnh5dNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=Z6pyfRb1; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="Z6pyfRb1"
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 1B198C343D;
	Wed,  8 Jul 2026 20:26:25 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 1B198C343D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531613;
	bh=1gcsmXz67IjQqMY0eBQ3O8esAmywA90IGOEUSqxZHJQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z6pyfRb1XnNrJb7Iy5l8RXt+U4vqsGvqqzStbhN7435vjpK29RR4S8ie2UFwESgWv
	 CcSG+nZyfqWkQNIiMihfXIe5SU5d9xFxuT/FVpIkY2si8YfqZBiGdxwpOgc4+v6GTu
	 NSt9pFgzwrUImE/LpJy0sei+Lk+GBqVAsmPsiJ8VtpU8nMjFtYkmKduWX13Ouy9uBJ
	 1ENXVXzDYQWjK4BhPh/7z7U3FCNNVQhlgPxqvAWAfKgmRqCj2sxf9iIIgCC2PgpYcH
	 RSMOv3KD/QpK9l25WlQ3grvgf5R2LttSDjfKaawhSgxe9j5XVHCFPDPCqOj6a4P2dQ
	 eMxeS2+WglD9w==
Message-ID: <8b21dbb1e167b4a50b72613f09fdbb800a420fb8.camel@rendec.net>
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
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
Date: Wed, 08 Jul 2026 13:26:19 -0400
In-Reply-To: <20260707190253.816918647@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.816918647@kernel.org>
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
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
>=20
> Provide two new macros to consolidate that:
>=20
> =C2=A0 - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
>=20
> =C2=A0 - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
> =C2=A0=C2=A0=C2=A0=20
> to reduce boiler plate code.
>=20
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0 56 +++++++++++++++++++++=
++++++++++++++++++++++
> =C2=A01 file changed, 56 insertions(+)
>=20
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/irq-entry-common.h>
> =C2=A0#include <linux/livepatch.h>
> =C2=A0#include <linux/ptrace.h>
> +#include <linux/randomize_kstack.h>
> =C2=A0#include <linux/resume_user_mode.h>
> =C2=A0#include <linux/seccomp.h>
> =C2=A0#include <linux/sched.h>
> @@ -150,6 +151,61 @@ static __always_inline long syscall_ente
> =C2=A0}
> =C2=A0
> =C2=A0/**
> + * enter_from_user_mode_randomize_stack - Establish state and add stack =
randomization
> + *					=C2=A0 before invoking syscall_enter_from_user_mode_work()
> + * @regs:	Pointer to currents pt_regs
                           ^^^^^^^^

Nit: current

> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the fun=
ction
> + * returns all state is correct, interrupts are still disabled and the
> + * subsequent functions can be instrumented.
> + *
> + * Implemented as a macro so that the stack randomization is effective
> + * throughout the function in which it is invoked. An inline would only =
make it
> + * effective in the scope of the inline function.
> + */
> +#define enter_from_user_mode_randomize_stack(regs)			\
> +do {									\
> +	enter_from_user_mode(regs);					\
> +	instrumentation_begin();					\
> +	add_random_kstack_offset_irqsoff();				\
> +	instrumentation_end();						\
> +} while (0)
> +
> +/**
> + * syscall_enter_from_user_mode_randomize_stack - Establish state and ch=
eck and handle work
> + *						=C2=A0 before invoking a syscall
> + * @regs:	Pointer to currents pt_regs
                           ^^^^^^^^

Same here.

> + * @syscall:	The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * disabled. The calling code has to be non-instrumentable. When the
> + * function returns all state is correct, interrupts are enabled and the
> + * subsequent functions can be instrumented.
> + *
> + * This is the combination of enter_from_user_mode_randomize_stack() and
> + * syscall_enter_from_user_mode_work() to be used when there is no
> + * architecture specific work to be done between the two.
> + *
> + * Returns: The original or a modified syscall number. See
> + * syscall_enter_from_user_mode_work() for further explanation.
> + *
> + * Implemented as a macro to make stack randomization effective in the c=
alling
> + * scope.
> + */
> +#define syscall_enter_from_user_mode_randomize_stack(regs, syscall)	\
> +({									\
> +	enter_from_user_mode_randomize_stack(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	local_irq_enable();						\
> +	long _ret =3D syscall_enter_from_user_mode_work(regs, syscall);	\
> +	instrumentation_end();						\
> +									\
> +	_ret;								\
> +})
> +
> +/**
> =C2=A0 * syscall_enter_from_user_mode - Establish state and check and han=
dle work
> =C2=A0 *				=C2=A0 before invoking a syscall
> =C2=A0 * @regs:	Pointer to currents pt_regs

With the above nits,

Reviewed-by: Radu Rendec <radu@rendec.net>

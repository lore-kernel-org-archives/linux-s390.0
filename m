Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796F36212C;
	Wed,  8 Jul 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531510; cv=none; b=P4b0ne1Ur4BcVDHf5zykwDF5jXjU8gihgCtIE5Ms4N1vNxStqofIHUnMSbvn06Saqpj7toXG0fzYE9V0CVOwvAgH+DI+0ZlXPYRebIeDFRhndc3bXn1oCZEDs6ZbHMK0b0g728O/zTLt8Aj5kBuj7PO4F96sNgjnx1SnfMGg08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531510; c=relaxed/simple;
	bh=+vr3rkQW2LSYCUlbLOF8LC9jOocAXenj6nApMOfDgGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkk39GvKzBt7vsoRmbybR90crv9A81GO/bkKMEvIDj8JfOHw2zv9An2PJDno7gccCwyG2a6U27k8hozUzCOF+XnFO/UEwj/1m6p9wTuyqo7njayfHGBc0+R0K72NMPqbMr5jzzyYqbkF/YZ7CXxzlgI6y5nxYLRSG07db8y1qCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=OJuzJLG2; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="OJuzJLG2"
Received: from bat.kanata.rendec.net (unknown [24.114.111.125])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 1E89DC2B1F;
	Wed,  8 Jul 2026 20:24:38 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 1E89DC2B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1783531507;
	bh=oMlf4rzg7sFMgtBO8f/rqo4QHF22NzBws1cUSUO+r80=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OJuzJLG2oJHC8E6/z6u4YL1brifg3n0KypZd9zeBUsdEd6uLxd+9vUKIXm8fNb+sD
	 40TB/onHyQSWEZ0oPdpje/xAjGna37MjawhgGr3bVxva9cjLjk1XfUhqToNdmtUx7z
	 YMvmViVzUq9/FTET4wtq/Yhx/L0ZlUxPuNUXmfoDanL5GBZtufQoF3ZbsskDV434aw
	 kxDRuhqvAGGem4j2hDVIoI59nXr2IxQ3aAqoNF0TEbKK88RSrx6CqBol40sxnwMfxK
	 rd7e4S6y5Zb6OYXlWmLIfxqvBAfINm0f8D7u03YVplchQ7tuJ84O05FoHalkh1Nik9
	 f0YRdybiCZuUQ==
Message-ID: <db4b8c27df9be997f935928f2624a863a1f998d6.camel@rendec.net>
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,  Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
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
Date: Wed, 08 Jul 2026 13:24:33 -0400
In-Reply-To: <20260707190253.768842729@kernel.org>
References: <20260707181957.433213175@kernel.org>
	 <20260707190253.768842729@kernel.org>
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
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
>=20
> Provide a irqsoff() variant, which avoids that.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> ---
> =C2=A0include/linux/randomize_kstack.h |=C2=A0=C2=A0 19 +++++++++++++++++=
++
> =C2=A01 file changed, 19 insertions(+)
>=20
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -77,8 +77,27 @@ static __always_inline u32 get_kstack_of
> =C2=A0	}								\
> =C2=A0} while (0)
> =C2=A0
> +/**
> + * add_random_kstack_offset_irqsoff - Increase stack utilization by a ra=
ndom offset.
> + *
> + * This should be used in the syscall entry path after user registers ha=
ve been
> + * stored to the stack. Interrupts must be still disabled.
> + */
> +#define add_random_kstack_offset_irqsoff()					\
> +do {										\
> +	lockdep_assert_irqs_disabled();						\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,		\
> +				&randomize_kstack_offset)) {			\
> +		u32 offset =3D prandom_u32_state(raw_cpu_ptr(&kstack_rnd_state));	\
> +		u8 *ptr =3D __kstack_alloca(KSTACK_OFFSET_MAX(offset));		\
> +		/* Keep allocation even after "ptr" loses scope. */		\
> +		asm volatile("" :: "r"(ptr) : "memory");			\
> +	}									\
> +} while (0)
> +
> =C2=A0#else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> =C2=A0#define add_random_kstack_offset()		do { } while (0)
> +#define add_random_kstack_offset_irqsoff()	do { } while (0)
> =C2=A0#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> =C2=A0
> =C2=A0#endif

Reviewed-by: Radu Rendec <radu@rendec.net>

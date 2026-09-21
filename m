Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558E457E77
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980776; cv=none; b=RKsLDHNreP8wRQ1FPyHSObTzPvJ9GepVgXvW1Hmnc+BlvWC5ww8p83XrAd3GuzUoyUxdyl7IvvmNOJZrd3ebj9RJDxiOdUoFL37FlL3GcF37TKclmmYFcBGyCsUS2bJgapLEUc8yPwa6dUgXmTBGLqNd2VUECBsVuMLwchmpRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980776; c=relaxed/simple;
	bh=0Ba95uFT0vLwHzIRccYFq4b7l+HDVHg5V1q3U9BjDY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rAkEmDsjeywdvVdZY9li6IoPgX+sLiB/NexZVYqxDUjB2RMjOkmbajo6WJXhcIFjM1WhZJjScNlzC/klMrx3vn7o+FEGsDjtiRiuAfzQUurXkg3zGZ6Wti/rRm8hJxK9KVds/Fdu2x74uNFqd4x7rE+kPBWjYvl68ermJYgiq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB5txSxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB5txSxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0881F000FF;
	Mon, 21 Sep 2026 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980774;
	bh=eWHrOaIlehLKnvuHKtOqAOQKue0bdBFb0PWxTQmCILE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB5txSxeh9IRDRU2owAwQCeP+cAXRVZnj6tb9qCPrSBdz8gHAiE1H2pLVNTGeL6li
	 4IG0yPAxrfqSm8HDK29ZZFXO5dBC/P66OQOq98MMlCa/fFhAdv4edKWdti7UCaXQ6r
	 OIWyI/lJVPcjjkTT/Vl9csSD3ibRRBy1QOmqf90WD0c/6BDXZPZQitPBabxjtRl6c8
	 ztVAKFySScMfPvv4xUg7nIFF+mPwQGzKLQkfR6zx6moQRxBKZzKbQzWEt3973XgIyv
	 8iYS0lDR0idPF9IZGyne9a2sbxrA8aq94i2DjK3wK+r6jWqLmhehU7G6ddGjQtxCOf
	 R0SGP9s7TMAJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/11] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-12-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:52:52 +0000
Message-Id: <20260921085253.5E0881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] s390/percpu: GCC can allocate %r0 for offset register causing =
memory corruption
--

commit 7d2dae81caa8a6021304f844d79c9291c54c5a8b
Author: Heiko Carstens <hca@linux.ibm.com>

s390/percpu: Rework to simplify percpu_entry() and percpu_exit()

This commit reworks s390 percpu code sections to use a new register encoding
strategy similar to arm64. It removes the need to check specific instructio=
ns
during interrupts by using a register pair to encode the percpu variable
address and offset, adjusting them in percpu_exit() upon CPU migration.

Link: https://lore.kernel.org/all/20260908151741.394589-1-mark.rutland@arm.=
com/

> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percp=
u.h
> index 46368131b932b..db30f5ac40427 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
[ ... ]
> +#define __PCPU_LA(regptr, regoff, regpcp)					\
> +	"	la	" regptr ",0(" regoff "," regpcp ")\n"

[Severity: Critical]
Does this code safely handle the case where regoff is assigned to %r0?
The la (load address) instruction treats %r0 as 0 when used as an index or
base register. If regoff evaluates to %r0, the instruction would effectively
ignore the percpu offset entirely. This could cause subsequent atomic
operations to modify the base .data..percpu variable instead of the current
CPU's local instance.

> +
> +#define __PCPU_CALC_REGVAL(regpcp, regoff)					\
> +	"(" regpcp " << " __stringify(PCPU_REG_PCP_SHIFT) ") |"			\
> +	"(" regoff " << " __stringify(PCPU_REG_OFF_SHIFT) ")"
> +
> +#define __PCPU_CHECK_REGS(regpcp, regoff, regptr)				\
> +	".if " regoff " & 1\n"							\
> +	"	.error \"Percpu offset register must be even\"\n"		\
> +	".endif\n"								\
> +	".if " regptr " !=3D " regoff " + 1\n"					\
> +	"	.error \"Percpu pointer and offset register must be a pair\"\n" \
> +	".endif\n"								\
> +	".if " regptr " =3D=3D 0\n"							\
> +	"	.error \"Percpu pointer register must be non-zero\"\n"		\

[Severity: Critical]
Does this assembler check protect against the %r0 base/index semantic
described above? It looks like it checks regptr instead of regoff. If the
compiler allocates the %r0 and %r1 pair, regptr will be %r1, which silently
bypasses this check. Should this be checking if regoff is 0 instead?

[ ... ]
> @@ -158,25 +194,27 @@ do {										\
>  	if (__builtin_constant_p(val__) &&					\
>  	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
>  		asm volatile(							\
> -			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
> -			op2 "   0(%[ptr__]),%[val__]\n"				\
> +			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
> +				      "%[pair__]","%N[pair__]")			\
> +			op2 "   0(%N[pair__]),%[val__]\n"			\
>  			__PCPU_END("%[lcreg]")					\
> -			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
> +			: [pair__] "=3D&d" (rp__.pair), "+m" (*ptr__),		\

[Severity: Critical]
Can GCC allocate %r0 for the pair here? The "=3D&d" constraint allows the
compiler to select any general-purpose register, meaning it could allocate
the %r0 and %r1 pair for rp__.pair. Would using "=3D&a" (address registers)
instead prevent %r0 allocation and avoid the code generation issue with the
la instruction above? This seems to apply to all modified percpu macros in
this file using the "=3D&d" constraint for the register pair.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D11

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AE377A99;
	Mon, 31 Aug 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203768; cv=none; b=blqgJMOA3orD7we8ivGuCGgbIf0HsK/DoFQX1gdkED3FEALpmG0BmtiY4CwSKW+QcYo9Tzyax4No8sbSpBc510qcndkrG8ohz6Dq8dLaRhWcmCuU9kcQbCneJLtKYHI2/dSOfaRsclldg/T9dbyn/Scyd//QR8KQuFkYqvtPv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203768; c=relaxed/simple;
	bh=72gmDrzJMX35lS8wS4FCr2JgnB3OcudCKAosoJKXl4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKWa6lTznpy0mwxJH4CLBw+CX5vKdLbTeUzIvrvTgLcWgVVraEtz6QrgkQAs4cLT8n3jK6YoQBJs0AYcI0MHQ/AetOHVAvlqocY8mLQUokYwMg8Z6heLFEPqW1BlBgX1TXyE4m4QQSCrV6AcfEaclAlQsYbzi8uDnaz/lAEeqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj7Btzcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj7Btzcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C031F000E9;
	Mon, 31 Aug 2026 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203766;
	bh=2bTI/DCIhntkuCBfMYQgMRj4HrrREfbQspbA2FAy5qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yj7BtzcsiIeXlH7Oph4ZQJWZ7PP1XXlf9TY6GjKNd4s8TMiqqARS0PqlRK3jemPcN
	 thlbSSxN2Cd6jnTTw/P3KsjIFwSmvXIuQEBpL5z+kMFT7dK02U9VhwSXrFhqFeOzYQ
	 XEJIayzQce3wv7IeN5bzfiIswX+UzbtuP9KwzjS86Ra1EpEQGSwnaZ8QibMHaeOsuZ
	 pMCPhJxkKTa0GFBwqyrnjKhhf5ixGbPNEUfiTpzwPbnNIsFwHgnDM0pIxjFnm5fhXI
	 2eOmN9Bw6CnxIGXo0w1DaNS+Ifsidzcc2EBRLbyK4rO+FEgMj7J/xpAq/HJLQ5W3lW
	 kFnkgpjgj6iwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/20] s390: Introduce read/write ARM sysreg
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831145536.913567-10-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-10-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:16:05 +0000
Message-Id: <20260831191606.04C031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Casting the physical address 'sdo' to a virtual pointer in inline =
assembly constraints breaks compiler alias analysis.
- [Medium] Speculative: Inconsistent physical vs virtual address usage for =
SAE hardware structures.
- [Medium] Speculative uninitialized memory leak if `EASR` fails and sets a=
 condition code instead of a hard trap.
- [Low] Trailing comma in SASR and EASR assembler macros introduces an inva=
lid empty argument.
- [Low] Silent bitwise truncation of the `flags` parameter in the `RIE_H` a=
ssembler macro.
--

commit 60f79315be3a103c198fd6153c59e6ac32172d24
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Introduce read/write ARM sysreg instructions

Introduce Extract Arm System Register and Store Arm System Register to
enable s390 hosts to read and write system registers for arm64 guests.
The new instructions use the new RIE_H instruction format.

> diff --git a/arch/s390/include/asm/sae-asm.h b/arch/s390/include/asm/sae-=
asm.h
> index 0000000000000..d81ed89eb4ed7
> --- /dev/null
> +++ b/arch/s390/include/asm/sae-asm.h

[ ... ]

> +/*
> + * RIE_H - RIE-h instruction format
> + *
> + * RIE-h format: <insn> R1, R3, I2, M4
> + *    +--------+----+----+----+-----------------+----+--------+
> + *    | OpCode | R1 |////| R3 |        I2       | M4 | Opcode |
> + *    +--------+----+----+----+-----------------+----+--------+
> + *    0        8    12   16   20                36   40      47
> + */
> +.macro RIE_H	opc, gr1, gr3, imm2, m4
> +	GPR_NUM	r1, \gr1
> +	GPR_NUM	r3, \gr3
> +	.byte	(\opc & 0xff00) >> 8
> +	.byte	r1 << 4
> +	.byte	(r3 << 4) | ((\imm2 & 0xf000) >> 12)
> +	.byte	((\imm2 & 0x0ff0) >> 4)
> +	.byte	((\imm2 & 0x000f) << 4) | (\m4 & 0xf)

[Severity: Low]
Does this bitwise AND silently truncate flags exceeding 4 bits?

The inline functions sasr() and easr() use the "I" constraint for the flags
parameter, which permits up to 8-bit unsigned constants (0-255). If a flag
greater than or equal to 16 is passed, it will compile successfully but the
upper bits will be silently discarded here.

> +	.byte	\opc & 0xff
> +.endm
> +
> +.macro SASR r1, r3, i2, m4
> +	RIE_H 0xed99, \r1, \r3, \i2, \m4,

[Severity: Low]
Is this trailing comma intentional?

It passes 6 arguments to RIE_H, which only declares 5 parameters. In GNU
Assembler, this creates an empty 6th argument, which can trigger a 'too
many positional arguments' error.

> +.endm
> +
> +.macro EASR r1, r3, i2, m4
> +	RIE_H 0xed9b, \r1, \r3, \i2, \m4,

[Severity: Low]
Is this trailing comma intentional?

Like SASR above, this passes an empty 6th argument to RIE_H.

> +.endm

> diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
> index 389c5ac2a36c0..6580536544eef 100644
> --- a/arch/s390/include/asm/sae.h
> +++ b/arch/s390/include/asm/sae.h

[ ... ]

> +/**
> + * sasr() - Set Arm System Register
> + * @arm_reg: ARM system register identifier; compile-time constant
> + * @val: Value to set
> + * @save_area: Pointer to SAE save area
> + * @flags: Operation flags; compile-time constant
> + *
> + * Sets an ARM system register value.
> + */
> +static __always_inline void sasr(unsigned int arm_reg, u64 val,
> +				 struct kvm_sae_save_area *save_area,
> +				 u64 flags)
> +{
> +	struct kvm_sae_save_area *sdo =3D (void *)save_area->sdo;

[Severity: High]
Does casting the physical address sdo to a virtual pointer without
phys_to_virt() break compiler alias analysis?

The save_area->sdo field holds a physical address. Casting it directly to a
virtual pointer and passing it to the inline assembly memory constraints
below ("+m" (*sdo)) misinforms the compiler about which memory is accessed.

Since the compiler is given a pointer missing the identity base offset, it
does not register that the actual virtual memory of sae_block is being
modified, allowing it to incorrectly reorder C-level reads/writes or cache
stale values in registers.

> +	u16 reg =3D arm_reg >> _SAE_ASR_REG_SHIFT;
> +
> +	asm volatile (
> +		"	SASR	%[r1],%[r3],%[i2],%[m4]\n"
> +		: "+m" (*save_area), "+m" (*sdo)
> +		: [r1] "d" (val),
> +		  [r3] "a" (save_area), [i2] "K" (reg), [m4] "I" (flags)

[Severity: Medium]
Does the SASR instruction expect a physical address here?

The sae64a() function explicitly converts sae_block to a physical address
before passing it to the hardware instruction, and save_area->sdo stores a
physical address. However, this inline assembly passes the save_area pointer
directly as a virtual address.

If SASR requires a physical address, passing a virtual address will cause a
hardware addressing exception when KASLR is active.

> +	);
> +}
> +
> +/**
> + * easr() - Extract Arm System Register
> + * @arm_reg: ARM system register identifier; compile-time constant
> + * @save_area: Pointer to SAE save area
> + * @flags: Operation flags; compile-time constant
> + *
> + * Reads an ARM system register value.
> + *
> + * Return: Register value
> + */
> +static __always_inline u64 easr(unsigned int arm_reg,
> +				const struct kvm_sae_save_area *save_area,
> +				u64 flags)
> +{
> +	struct kvm_sae_save_area *sdo =3D (void *)save_area->sdo;
> +	u16 reg =3D arm_reg >> _SAE_ASR_REG_SHIFT;
> +	u64 val;
> +
> +	asm volatile(
> +		"	EASR	%[r1],%[r3],%[i2],%[m4]\n"
> +		: [r1] "=3Dd"(val)

[Severity: Medium]
Can this leak uninitialized stack or register data if EASR fails?

If EASR sets a condition code to report failure instead of injecting a
program check, the target register remains unmodified. Because the code
unconditionally returns val without checking a condition code and does not
initialize it, uninitialized memory could be returned.

> +		: "m"(*save_area),
> +		  "m"(*sdo), [r3] "a"(save_area), [i2] "K"(reg), [m4] "I"(flags)
> +	);
> +	return val;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D9

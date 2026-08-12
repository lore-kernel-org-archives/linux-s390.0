Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCE38F64E;
	Wed, 12 Aug 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551884; cv=none; b=VCh1q+sy32S+XLwynUCKRYuHNFyhSfzQaI++yN7BwLflBLPy+753M3Bt4Qy4k1npOgIf+jQjABeGlIGnhcT+e2E90L3V8nKw97hO8OtRY6UBCxSGN3Wg9nOdm7F7yaCQldhFdmy0LxSR1KNmspp9WmdeDq13w30QWktnVysP62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551884; c=relaxed/simple;
	bh=gGQ5N8WUKV0FwkX8mIv40iaUBcLsnM1+YTAYDvVfmxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cpR9hgP4rC2YgIJJN3JrD3VncxpX+X0bBbNdDo78UABdVPhCWSVlrHJKmWn8yeazWuzwMq8178qDZpV3nZxJlkA8+ZkM08Ce3Bg7mGKni7evVk0/GgPnO2DiYXfU9hMbl1DxQu9gaS4hItishPQYHRIXp9XLwfn4i7ugP3Fn1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAzXTkww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAzXTkww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B12C1F000E9;
	Wed, 12 Aug 2026 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551882;
	bh=w4WlyKGpVa6l3YTfIhSOEGz+pb9dMGkGvqofcNV/sJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAzXTkwwjQPGvrraTb8K0LHOap1dUxMOdxqFARK4VTEhACPJFdV9k1I4BqanLBXRw
	 w6Fym+doU1Mf0XIsoapHHQNolAs9fT0vknOLkSmNQzLUGIewyD24fUuBSCI0FAVW1V
	 kpUlSsx7V2zJb1CmFFgCkeMNv4h8cRWSdtrhCX3NwKiQKCTKsEejWbSoPJxJWg/s33
	 xn4a8TbRgBFuTezWOxbESuPbaWnFR2eE5ZlI/2H3NhwjgFC9wfsUCQ9VBg1M8XDhDF
	 9co4myX0QnTHqPN5C7xqftJ+4bwKvyG4LUDSCkVKNwswBZ9XzhuzXPAE0cH83Wbn5v
	 bz2tqGW+flAcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/33] s390: Introduce Start Arm Execution
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260812153631.3376090-26-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-26-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:24:41 +0000
Message-Id: <20260812162442.5B12C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] __sae64a lacks integration with the host's machine check handler, =
causing guest-induced machine checks to panic the host kernel.
- [High] Missing branch prediction isolation (Spectre v2 mitigation) around=
 the SAE instruction.
- [High] Missing host interrupt intercept/exit protocol for SAE, which can =
lead to a CPU lockup.
- [Medium] Potential machine check misattribution due to a missing NOP padd=
ing instruction immediately after the SAE instruction.
--

--- Patch [25]: [PATCH v6 25/33] s390: Introduce Start Arm Execution instru=
ction ---
commit 06d16be51e15035979052bdd29d727897f102ac2
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Introduce Start Arm Execution instruction

This commit introduces the Start Arm Execution (SAE) instruction to enable
accelerated execution of arm64 virtual machines on s390. It adds the __sae6=
4a
assembly function to handle the execution context switch.

[ ... ]

> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 10dd9bbdf9856..5d9817acab0b6 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -245,6 +245,28 @@ EXPORT_SYMBOL(__sie64a)
>  EXPORT_SYMBOL(sie_exit)
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_KVM_ARM64)
> +/*
> + * __sae64a calling convention:
> + * %r2 pointer to sae control block physical address
> + */
> +SYM_FUNC_START(__sae64a)
> +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
> +	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register

[Severity: High]
Are we missing branch predictor isolation (BPEXIT/BPOFF/BPENTER) around
the sae instruction?

Without these macros, the host branch predictor might be left exposed to
the guest. Could a malicious guest intentionally mistrain the branch predic=
tor
to mount a Spectre v2 branch target injection attack against the host kerne=
l?

[Severity: High]
Should this function set a thread flag before execution, similar to __TI_si=
e,
to allow host interrupts to break the execution loop?

Without a flag like __TI_sae, host interrupt handlers (like ext_int_handler
and io_int_handler) will return directly to the sae instruction instead of
rewriting the return address. Could this cause the host VCPU thread to enter
an infinite execution loop, preventing signal delivery and causing a CPU lo=
ckup?

> +	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution

[Severity: High]
Does this instruction need .Lsae_entry and .Lsae_leave bounds, similar
to __sie64a, so the machine check handler can detect guest context?

In mcck_int_handler(), it checks for .Lsie_entry bounds:

mcck_int_handler:
	larl	%r14,.Lsie_entry
	clgrjl	%r9,%r14, 4f
	larl	%r14,.Lsie_leave
	clgrjhe	%r9,%r14, 4f
	lg	%r10,__LC_PCPU(%r13)
	oi	__PCPU_FLAGS+7(%r10), _CIF_MCCK_GUEST

Without equivalent bounds for sae, a guest-induced machine check might be
incorrectly handled as a host kernel machine check, leaving _CIF_MCCK_GUEST
unset and panicking the host.

> +	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register

[Severity: Medium]
Is a padding instruction needed immediately following the sae instruction?

In __sie64a, a nopr 7 instruction immediately follows the sie instruction
to safely absorb deferred boundary machine checks without attributing them =
to
the host context. Without padding, could a deferred machine check be incorr=
ectly
attributed to the host?

> +	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
> +	xgr	%r0,%r0				# clear guest registers to
> +	xgr	%r1,%r1				# prevent speculative use
> +	xgr	%r2,%r2
> +	xgr	%r3,%r3
> +	xgr	%r4,%r4
> +	xgr	%r5,%r5
> +	BR_EX	%r14
> +SYM_FUNC_END(__sae64a)
> +EXPORT_SYMBOL(__sae64a)
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D25

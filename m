Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916330D401;
	Mon, 31 Aug 2026 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206414; cv=none; b=O5u8WmY6BWTikVwUKYcVOh5JiULT56Y3VPDoPydj4msoXad6UNqq0DFkjRx6yio2eaZMtIk7FY51FFs/Qe7hjBhSYppkSRClMGkXC+FsMreQ2h9CpcDpcilClboQ6fgGfEqU61VUpeEqO6vApaGrqLFxDeBDErGqgrWw9a2ArNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206414; c=relaxed/simple;
	bh=kaaizj6aqkrP5K70TQbsuuz2rJJsUIbfrLO12FeT2+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e2qTLrLKwomJVfyS84nKPg7twU3+DWXgFQvcsNtwQe0Qe9GvalzH4Xok88A1k/dJxIuGge0ypfy0Wv8sQ8Jhxp/OaKqWIV4YsQhm7/VzZROetLvX31HlbsYMJgj1JwVtJDHLRE+x8ygJ26PrwIIWJF8/9RD6JLnewDfaW8NAQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1gkV5qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1gkV5qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D68F1F000E9;
	Mon, 31 Aug 2026 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206412;
	bh=7C9bAuq8A45ojKKFYtQJ/1NVVz6OEakV2bV2iQnPi2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1gkV5qxXSzPvNq8kvjpuX5ArDBkjlxLyx4q+3jHELs+Yet7QE2Pr5XkjheIvisTC
	 3W5pZfQp+uOuEnw9VhC1GZLnzuo56hatMxMqhIE4hBNQWtyNS83r1xhvgIRQ9srDBH
	 PI/O1do2gYLKBjPIkvG1lIo8Mr4cJLQPR5CoHmEM1CQGEswYQrGP8jtyN8FxrzWZUx
	 wzIPfVS1a3Le/fxt0o0UW51wMgTaex+76JoOmAuJVN3MaY3krX8IhxEYddQ+YywOsu
	 /SdzZ8a9XAVu1GSxGJtamPp2PJPXGd+bCO8QNobJPLE/3ak/L6QNiRL3VIY1vTg3tD
	 Ah8HYvuQpoAMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/23] s390: Introduce Start Arm Execution
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260831144802.834315-16-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:00:11 +0000
Message-Id: <20260831200012.0D68F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing hardware branch predictor isolation (Spectre v2 mitigation=
s) and alignment padding around the Start Arm Execution (SAE) instruction.
--

commit 5f700400137f55bf83aa7484eb428f79dafd9340
Author: Steffen Eiden <seiden@linux.ibm.com>

s390: Introduce Start Arm Execution instruction

This commit introduces the Start Arm Execution (SAE) instruction to enable
accelerated execution of arm64 virtual machines on s390. It adds the new
header variants, control block structures, and the __sae64a assembly routine
to handle host-guest register state transitions.

> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 10dd9bbdf9856..6f6f8f6ff9c48 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S

[ ... ]

> @@ -245,6 +245,28 @@ EXPORT_SYMBOL(__sie64a)
>  EXPORT_SYMBOL(sie_exit)
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_KVM_S390_ARM64)
> +/*
> + * __sae64a calling convention:
> + * %r2 pointer to sae control block physical address
> + */
> +SYM_FUNC_START(__sae64a)
> +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
> +	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
> +	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
> +	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register

[Severity: High]
Does this sequence safely handle branch predictor state when transitioning =
to
and from the untrusted guest?

Unlike the analogous __sie64a implementation, __sae64a appears to lack the
BPEXIT, BPOFF, and BPENTER macros to flush or isolate the branch predictor.
Could a malicious guest poison the host CPU's Branch Target Buffer (BTB) or
Return Stack Buffer (RSB), leading to speculative execution vulnerabilities
(Spectre v2) that leak host kernel memory?

Additionally, is a padding instruction such as "nopr 7" needed immediately
following the SAE instruction here? For SIE, this padding is required to
safely handle mishandled machine checks on the instruction boundary.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D15

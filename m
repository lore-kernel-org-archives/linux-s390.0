Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5823C4175;
	Fri, 17 Jul 2026 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280994; cv=none; b=L3PgI6f5rbCdlNCu8A4qHvBa/LA8URNaQAmB1eNm6sQLFecQZGtkB7MzdLnWK6n66hRyQUjFJ2e/oaH9XCPYLwBcWGFtArl6Lc2VUP2Eh8Md8vF+ikkvRBWlNPVk+syqm7iRPBC3TnKe0rwIDJocLusjIq4pYNwYY/F0RbcKMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280994; c=relaxed/simple;
	bh=jz/6WSAZO73NeFEFqQim4kP8EJaNHi4oU079vFsL2fA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3SkPAXfrmmm9xO0fZwcgvEAoYgWN146j9DCi76Vv3ljqoonQZlOyVXI2HY74qtt8XNX7cQ1e2RZm3m/sTiEzPkMOJWMxNYFAE3nR25ZYwOsKPkAnuPieTogvyv74fbQEq6f1JZTmZ2u7W+4q04QifWJL06rWg1nA3DTAZTDa5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDskeiiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDskeiiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3FF1F000E9;
	Fri, 17 Jul 2026 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280992;
	bh=yLvzY3FR3+diS3kv7lMDjR+kXF649/tP+a9eWKZqJLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDskeiiZlqcHsdCh6G60NGv4PO5ki05EnCz0zn10DE6mYPxYjbN0USRVvjag4Ejuz
	 Dj1pXiiUBmUdPIfg+ouOq+JU6i/Vg6OH0nVIF+tpI1iBzybYiXveDTwvX8lG77njTu
	 +71ZX2To5MhnUcnosZOJwk/HRbVOjoWC1UuWYWiU726Qj4Y8p1FNGC6rjxuikVh8xs
	 oPES+dkQI3RBeR+uvClF1CrhWpI+U4sFTo06tshrSCfSyZVGGQfBi9bFKRNuxhm+Qe
	 4oYpn1fy8R03MY3uAoNNMixdN9se3exZtsuJb0AJjaVYdbuA5leyhL40lSSYiQZW71
	 h72xN8CU8GhdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] s390: Add support for DCACHE_WORD_ACCESS (again)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260717092415.3039699-5-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:36:32 +0000
Message-Id: <20260717093632.8E3FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing earlyclobber constraint on the output register in `load_un=
aligned_zeropad` allows GCC to use the same register for input and output, =
leading to a kernel crash during secure storage access exception handling.
--

--- Patch [4]: [PATCH v2 4/4] s390: Add support for DCACHE_WORD_ACCESS (aga=
in) ---
commit 48318c86a5b130c4f8df66b5d5c16dda32e7448d
Author: Heiko Carstens <hca@linux.ibm.com>

s390: Add support for DCACHE_WORD_ACCESS (again)

This commit implements load_unaligned_zeropad() and enables
DCACHE_WORD_ACCESS to speed up string operations in fs/dcache.c and
fs/namei.c. It reinstates this support after addressing secure storage
access exception cases.

> diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/a=
sm/word-at-a-time.h
> --- a/arch/s390/include/asm/word-at-a-time.h
> +++ b/arch/s390/include/asm/word-at-a-time.h

[ ... ]

> +static inline unsigned long load_unaligned_zeropad(const void *addr)
> +{
> +	unsigned long data;
> +
> +	asm_inline volatile(
> +		"0:	lg	%[data],0(%[addr])\n"
> +		"1:	nopr	%%r7\n"
> +		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
> +		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
> +		: [data] "=3Dd" (data)

[Severity: High]
Could GCC allocate the same register for both the [addr] input and the
[data] output since there is no earlyclobber modifier here?

If a page-crosser triggers a terminating secure storage access exception,
the hardware leaves the result register in an unpredictable state.

The exception handler ex_handler_zeropad() relies on reading the original
address from the register specified by [addr] to compute the valid bytes.
If GCC uses the exact same register for both input and output, the handler
will read a corrupted address from the clobbered register, dereference it,
and cause a kernel panic.

Should this use the earlyclobber constraint "=3D&d" for the data output to
ensure the address register is preserved during a terminating exception?

> +		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
> +	return data;
> +}
> +
>  #endif /* _ASM_WORD_AT_A_TIME_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717092415.3039=
699-1-hca@linux.ibm.com?part=3D4

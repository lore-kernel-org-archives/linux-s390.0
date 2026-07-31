Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035D3C10A8;
	Fri, 31 Jul 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504083; cv=none; b=kGOWnOJf5h5CUi0yCJ09x61zef8h7u515YR5oAz7bebyBIcyPyqM0XjmCOQqnSfsXckGFtT60YSrtZDg3qi3h5w/4TeMDopShbp80GjCWUd075cSnf4ya5aW+0a8a1nfwaGcAoK6TDkiaKK9umnEi1MI+OIJwAHnMfI9HTAUh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504083; c=relaxed/simple;
	bh=TePFkCGrB2yrInvdRswDl5cpJpRiD28XpybbjGBrYWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtTepJEEypTTGAW0qmw5ET8elljA8FhdQNtupWRxnCNe4NJKi/4mahWYvSE0GMO0U0OKPy3KW/DpTXeQf0w5fA08Vz8z5OsDdIwbhoOofsxXpB6UMQnHWjpzGc3gRIRSUl/6glnqZreaVOVYMTJUYj30MKXe6dDQnfCUBR5uqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE/NfVim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE/NfVim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41A41F000E9;
	Fri, 31 Jul 2026 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504082;
	bh=bWFhxMpBpbzSuifJUU13lzqr4MTmfZiOVWLZOPmNaBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bE/NfVimF0R2DWVssTdKC5oFy7v9YAIpdnymKsNP3vHpYYsGRLo/XWchi6if9+yhJ
	 xyBy+OMHuWMAKmHT9zGotGup/TaHeJOLUdIxBTU3QJlIe9S54o8MuJ6fyXxhw8DkVs
	 scTuv+FZBy0BcgBn/lrGajwkyHcSkNPao/1J/VYBaVGbif+eYiJMosCo4LfoB9urFH
	 TjCFaknjz9eNZfcTdHk3sXrB0m8nxRSc4I+UQubulGBS3pImk8XD3+QrOQnJ02I8gn
	 uL4AIe8VzgBAC3jf+HbLDxuAqklMZHhfOqlOzqXDjy1VMNGxTH9DDoxWn4z8LWmavz
	 fW41wud4wL2Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/31] arm64: ptrace: Use constants for compat
 register numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130902.654679-6-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:21:21 +0000
Message-Id: <20260731132121.A41A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Build breakage due to undeclared identifier `__compat_lr_ab` in mac=
ro expansion.
- [Low] Inconsistent enum naming for FIQ registers (`_fi` instead of `_fiq`=
).
--

--- Patch [5]: [PATCH v5 05/31] arm64: ptrace: Use constants for compat reg=
ister numbers ---
commit 6ee1891b95815ce41b1528d3c9d07b5939a2f802
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: ptrace: Use constants for compat register numbers

This commit defines an enum for the register numbers used in mapping between
AArch32 and AArch64 registers. It updates the compat macros to use these
new enum values instead of hardcoded numbers.

> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptr=
ace.h
> index 39582511ad72f..6f5b79ee1f3f5 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -104,26 +104,48 @@
>  #define COMPAT_USER_SZ	296
> =20
>  /* Architecturally defined mapping between AArch32 and AArch64 registers=
 */
> +enum {
> +	__compat_fp	=3D 11,
[ ... ]
> +	__compat_r8_fiq	=3D 24,
> +	__compat_r9_fiq	=3D 25,
> +	__compat_r10_fi	=3D 26,
> +	__compat_r11_fi	=3D 27,
> +	__compat_r12_fi	=3D 28,

[Severity: Low]
This isn't a bug, but could the naming be made consistent here? The enum
variants for r8 and r9 use the _fiq suffix (e.g., __compat_r8_fiq), while
r10, r11, and r12 are truncated to _fi.

> +	__compat_sp_fiq	=3D 29,
> +	__compat_lr_fiq	=3D 30,
> +};
> +
>  #define compat_usr(x)	regs[(x)]
[ ... ]
> -#define compat_sp_svc	regs[19]
> -#define compat_lr_abt	regs[20]
> +#define compat_sp_svc	regs[__compat_sp_svc]
> +#define compat_lr_abt	regs[__compat_lr_ab]

[Severity: Low]
Does this cause a build failure? The enum value is defined as __compat_lr_a=
bt
above, but this macro attempts to use the undeclared __compat_lr_ab identif=
ier.
Code using this macro, such as enter_exception32() in
arch/arm64/kvm/hyp/exception.c, will fail to compile.

> +#define compat_sp_abt	regs[__compat_sp_abt]
> +#define compat_lr_und	regs[__compat_lr_und]
> +#define compat_sp_und	regs[__compat_sp_und]
> +#define compat_r8_fiq	regs[__compat_r8_fiq]
> +#define compat_r9_fiq	regs[__compat_r9_fiq]
> +#define compat_r10_fiq	regs[__compat_r10_fi]
> +#define compat_r11_fiq	regs[__compat_r11_fi]
> +#define compat_r12_fiq	regs[__compat_r12_fi]
> +#define compat_sp_fiq	regs[__compat_sp_fiq]
> +#define compat_lr_fiq	regs[__compat_lr_fiq]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D5

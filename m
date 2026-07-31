Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307923EC83E;
	Fri, 31 Jul 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504603; cv=none; b=BozwFDyuFTBXhxm+c/i8vb1658x+u+SdxU0/eRjG9ogEr4G5WieqmeklgsM+Dw232tBzRxFpDBlUwryesL0jF3+fssxmK1q3y5fZanJ4/Ytt6610jzB2XdFX0E5/ZHpgkOjHbu09kj3dUcYzMmstOEctyH67i+5yJZnCuaA0Ks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504603; c=relaxed/simple;
	bh=KG7ylJVUJT/Wc9udBN2SOvlZNHslpB2/WtjmMgks7FE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFv904aAQxzimxLnFWVHXp/tztoChS2/HGNuUizgSTlGFZ8KC1SZ0+zaBeaCqKgRFXVIdZWdV63dx2EtzAypuR+JNybhWPskPz7T67Bh4AdabxGzhtfXZC7ZSa5D/fTRaxnJX9h1dFhfe65nBecaoBVd/XXTzUgxJVOYpSJHuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR2oSUwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR2oSUwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507FC1F000E9;
	Fri, 31 Jul 2026 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504601;
	bh=y2S1QuhXDuJ/5YB9ogx7sDuk5oXj7jfVlLHrIxcon60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VR2oSUwv3riE+a097ixel4vfexIt1k0meH1YOfNoLE1npYyCuOXoFmXJ5BSN1TlG/
	 Go+IGTu52NN6krQzTgIv+fgwjQrQCgQWDcYUouV/FeJ1UKYLFt3oFY6+mdrIXwIc42
	 2bVi296X3qVwkkG8wJ/7345r5YY9UCPUZP4HPyBhrIiTN/xWYHHnv08COYvVNRs+z/
	 3FJPxYFvJeDIx+YtzsQh8ERq3m9ylXcOdsZWEJa0NxUg/O8/Jr6O1KwrtlmeGYdoIz
	 lGavWt8xYyQ8qZErIO7k5jUbvXSloPMKomjvnKglfHGdl4yAOLeGyAUCXCznRxYbC5
	 7pQ1JcUTm84qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/31] arm64/sysreg: Convert SPSR_ELx to automatic
 register generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731130902.654679-7-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-7-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:30:00 +0000
Message-Id: <20260731133001.507FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] SPSR_EL2 enum M incorrectly maps mode value 0b1001 to EL3h inste=
ad of EL2h.
- [Low] SPSR_EL1 and SPSR_EL2 mode enums use non-standard names (EL0, EL1tn=
v, EL1hnv).
--

--- Patch [6]: [PATCH v5 06/31] arm64/sysreg: Convert SPSR_ELx to automatic=
 register generation ---
commit ca584536167a8b3942fb084c2775b73ad663d641
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64/sysreg: Convert SPSR_ELx to automatic register generation

This commit converts the SPSR_EL1, SPSR_EL2, and SPSR_EL12 registers to
automatic register generation. It removes the manual definitions in the
sysreg header and adds them to the sysreg generator tool.

> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 7cb61aca3797f..2a4b94e8c62fd 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
[ ... ]
> @@ -401,6 +401,78 @@ Res0	3:1
>  Field	0	SO
>  EndSysreg
> =20
> +Sysreg	SPSR_EL1	3	0	4	0	0
[ ... ]
> +Field	5	T
> +Field	4	M4
> +Enum	3:0	M
> +	0b0000	EL0

[Severity: Low]
Does this code deviate from the standard architectural nomenclature? The
architectural manual and existing kernel constants (like PSR_MODE_EL0t)
refer to this as EL0t rather than EL0.

> +	0b0100	EL1t
> +	0b0101	EL1h
> +	0b1000	EL1tnv
> +	0b1001	EL1hnv

[Severity: Low]
Are these names intended to be EL2t and EL2h instead? When FEAT_NV is
implemented, the architectural manual refers to these as EL2t and EL2h.
Using EL1tnv and EL1hnv might lead to mismatching macros when compared to
existing constants like PSR_MODE_EL2t.

> +EndEnum
> +EndSysreg
> +
> +Sysreg	SPSR_EL2	3	4	4	0	0
[ ... ]
> +Field	5	T
> +Field	4	M4
> +Enum	3:0	M
> +	0b0000	EL0
> +	0b0100	EL1t
> +	0b0101	EL1h
> +	0b1000	EL2t
> +	0b1001	EL3h

[Severity: Medium]
Could EL3h be a typo for EL2h here? According to the ARM Architecture
Reference Manual, 0b1001 corresponds to EL2h. Since SPSR_EL2 cannot hold
EL3 exception states, this might generate an incorrect SPSR_EL2_M_EL3h
macro while leaving out the definition for EL2h.

> +EndEnum
> +EndSysreg

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D6

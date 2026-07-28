Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51794306744
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217085; cv=none; b=EINoL5SaKG5k+fuDjYXN6twKugnHv8uVzflXsTWPmTwmERC6JBOF8mHgBqz8/8lgDmEc23PXUfRM5v3mMHgW5sAPYl3bsVT/njugp9u9qtYo2D+xIe2Zgfj8WYO83HexEhfR2BmOhfNDnszM6kfNIRvKu8OxOAumcRMU183luks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217085; c=relaxed/simple;
	bh=kJX0hrkLjhq6IBJZF9RhnYNhI2TF1O3epJR6mV6qqUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GOVVFu0k5DwTXYVo/ezj2ptX4PCbbUcFDpjNiiuO6zF31a8jRUtwEUCHQwqKvVxlBrVY30aqCZNtQTXLi6JhXzspPraamvwEFBDtlhzOLO5gP7F9fnq23v/cylPA6zyRky5jG/zdujWRWlpOAqDOOA19JvVQ14vB6/v+9ucwOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nju1lAKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nju1lAKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6091F000E9;
	Tue, 28 Jul 2026 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785217083;
	bh=ISIml0oxnbbdKTf4/e+TJqtZGFpqg6iv7co++rwChwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nju1lAKDUnZVGXXcrha2yIzDvDkB1dtuvwuCP1ktVZoqyIEvhthRwjO8XCR7B/3dq
	 PVWRWnJTvK19Dy5EheLZbVuSAz/KNEcc5+Zy8u34HiuBhg2TTNLjZBJVA3MupE/+wd
	 YHLzEVQIZ1DuL084P8qTOhpEd2Wlgifw8rGWsLI9OHcl69Fgv9biSswNAOIbbNcA/R
	 yhNeb3pjTZmx/Vr/zEVoeB1YB8lYKmtk1sTZGJB6iMLfoiPUwkhxixAFx/W2xfdTSc
	 1jy31c+n9n9T8icMt9zj7w42mFkNTQiUByCQ1E0P9LNaYO8ahq9P//XJNMRLeBNcYd
	 PcDeaGJ43grRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260728052540.4728-6-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-6-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:38:03 +0000
Message-Id: <20260728053803.9D6091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The BUG_ON bounds check in `__runtime_fixup_mask` incorrectly pa=
nics the kernel on a valid 32-bit all-ones mask (0xFFFFFFFF) due to an off-=
by-one error caused by confusing bit index with bit width.
- [Medium] The commit message and inline comments incorrectly describe the =
instruction sequence and immediate shift calculations, contradicting the co=
rrect code implementation.
--

--- Patch [5]: [PATCH v6 5/8] riscv/runtime-const: Introduce runtime_const_=
mask_32() ---
commit f8085a85ab8321e958c65177cacf4c654afce3c8
Author: K Prateek Nayak <kprateek.nayak@amd.com>
Subject: riscv/runtime-const: Introduce runtime_const_mask_32()

This commit introduces runtime_const_mask_32() to optimize mask operations =
in
the futex hash computation hot path on RISC-V. It implements this using left
and right shifts, patching the immediate values at runtime.

Link: https://docs.riscv.org/reference/isa/_attachments/riscv-unprivileged.=
pdf [1]
Link: https://lore.kernel.org/lkml/20260430094730.31624-6-kprateek.nayak@am=
d.com/ [2]

> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. Since all the current use-cases
> are of the form GENMASK(n, 0), with n > 0, following sequence:
>=20
>   srli a0, a1, imm
>   slli a0, a0, imm
>=20
> is used for RISC-V where imm =3D (31 - width) to improve instruction
> density and performance.

[Severity: Medium]
Is this description in the commit message accurate?

The commit message describes using an srli + slli sequence and calculates t=
he
shift as imm =3D 31 - width. However, the actual macro implementation corre=
ctly
uses an slli + srli sequence (shifting left then right) to clear the upper
bits, and __runtime_fixup_mask() uses imm =3D 32 - width.

Could the commit message be updated to match the implementation?

> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/=
asm/runtime-const.h
> index 1ce02605d2e43..a472ebbf09718 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
[ ... ]
> @@ -262,6 +279,33 @@ static inline void __runtime_fixup_shift(void *where=
, unsigned long val)
>  	mutex_unlock(&text_mutex);
>  }
> =20
> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
> +{
> +	unsigned int width =3D (val) ? __fls(val) + 1 : 0;
> +
> +	/*
> +	 * XXX: Current implementation only supports patching masks of
> +	 * form GENMASK(width, 0) (width >=3D 0) using a SRLI + SLLI

[Severity: Medium]
Is the inline documentation here slightly out of sync with the code?

Similar to the commit message, this mentions SRLI + SLLI and GENMASK(width,=
 0),
but the code below uses GENMASK(width - 1, 0) and the macro actually implem=
ents=20
SLLI + SRLI.

> +	 * sequence instead of LUI + ADDI + AND sequence to improve
[ ... ]
> +	 * and outside the asm block before returning the result. Fixup
> +	 * can simply reuse the existing __runtime_fixup_32() to patch
> +	 * the LUI + ADDI sequence.
> +	 */
> +	BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) !=3D val));

[Severity: Medium]
Does this BUG_ON() condition reject a valid 32-bit mask?

When the mask is all ones (0xFFFFFFFF), __fls(val) + 1 evaluates to a width
of 32. The width > 31 check would trip the BUG_ON() and panic the kernel.

A shift of 32 - 32 =3D 0 is mathematically valid for RISC-V, as using slliw
and srliw with a 0 shift correctly truncates and zero-extends the 32-bit
value to 64 bits.

Should this check allow a full 32-bit mask instead?

> +
> +	__runtime_fixup_shift(where, 32 - width);
> +	__runtime_fixup_shift(where + 4, 32 - width);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D5

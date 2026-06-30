Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77573E1687
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796063; cv=none; b=gsly9kP4LRPzutoD9pYNyDRKQpH/DTVnGVuXt1TO2VLYTUDDphXdwmvzrYHtqB/bQn3P9Qa0KRfIcDy2dgXaPYEYwmDe+VqXE/vIbptP+RWwMAIzINe8OJKTA63FgCLxfolcQyG1y9a8AgLWxs84eeVMkGZgEBk/3y2AQAU5T7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796063; c=relaxed/simple;
	bh=b5cY51EjznmmdH3HqdKfGY5D6HnFt12ySsLAa1AtEtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LVc18RwKwLtUKZQmDLpLFLeXD/rZOr+zgaFEvUo4J58F2ZtXswSnm56g69skyThIZLkrlsgEoEJRcBAk3dF8UrVvQe3IgxOFYp4ZCYnaq3ht6nSut67Dkenfik77HlMCc8sIo+Bzyf6WFZLV4j2crIeacezy96cDOXGWwx9b0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmoBrmvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmoBrmvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBB21F000E9;
	Tue, 30 Jun 2026 05:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782796062;
	bh=5Bn7j8tE44yIYDE6KpKg9/kKcWAZGGEzxoWgkS55chs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QmoBrmvwpay1yvzLkGXGRCOyQQzIntwqKMJ8+O7nHaeyNjwBcvtBSbtbVIn+JsW2m
	 /179Coc7pn2LWARtRFQn4fgql4jgLZWTqbN9rVwCI22JrbciQGrU1TipfbEnPffqiW
	 VJnNykk1MwlGqORzAHtYBH47MwLc7svFEokqXTCIYPM22K5WwEfsFQtk9MKqGIEGbo
	 gQtBiufLWgF8qSNee5svq9dmsftCvQiIy/eRST7aj6SLfmYBZ5iBl3i5NerWHh3z+K
	 9mJmnrKpl3fJZ8igw1Jb9+KrKQtcC/R9nbH6o+87Vx5RuCR+AmUBCP963lEPrdvQ/+
	 q3lCdNmq3wm/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260630045531.3939-4-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 05:07:41 +0000
Message-Id: <20260630050742.0BBB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Calling `__fls(val)` before `BUG_ON(!val)` invokes undefined beh=
avior for `val =3D=3D 0`, potentially allowing the compiler to optimize awa=
y the safety check.
- [Low] The commit message incorrectly references `amd64` instead of `arm64=
` and misspells `density`.
--

commit e9b79c78d336baf757f7578713831df9b1c4c1b9
Author: K Prateek Nayak <kprateek.nayak@amd.com>

arm64/runtime-const: Introduce runtime_const_mask_32()

This patch introduces runtime_const_mask_32 to optimize the mask operation
in the futex hash computation hot path using the UBFX instruction. It also
adds __runtime_fixup_mask to patch the 32-bit mask in the asm block once
the mask is known.

Link: https://developer.arm.com/documentation/ddi0602/2026-03/Base-Instruct=
ions/ [1]
Link: https://lore.kernel.org/lkml/20260430094730.31624-4-kprateek.nayak@am=
d.com/ [2]

> instruction is used for amd64 to improve instruction dinsity and
> performance.

[Severity: Low]
This isn't a bug, but there are a couple of typos here. Should "amd64" be
"arm64", and "dinsity" be "density"?

> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/=
asm/runtime-const.h
> index 838145bc289d2..371c9a4bc2d4b 100644
> --- a/arch/arm64/include/asm/runtime-const.h
> +++ b/arch/arm64/include/asm/runtime-const.h
[ ... ]
> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
> +{
> +	unsigned int width =3D __fls(val) + 1;
> +	__le32 *p =3D where;
> +	u32 insn;
> +
> +	/*
[ ... ]
> +	 */
> +	BUG_ON(!val || width > 32 || (GENMASK(width - 1, 0) !=3D val));

[Severity: Medium]
Does evaluating __fls(val) before the BUG_ON(!val) check invoke undefined
behavior if val is 0?

Looking at __fls(), it uses __builtin_clzl(word) which is undefined when
the argument is 0:

include/asm-generic/bitops/builtin-__fls.h:__fls() {
    return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
}

Could the compiler use Value Range Propagation to assume val is non-zero
due to the __fls() call, and silently optimize away the !val safety guard?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630045531.3939=
-1-kprateek.nayak@amd.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B1377006
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973537; cv=none; b=qE6UbwyuudCiu/S0O1v6vp847AZsfxHP6SFtEoKhLFJweO9b0Vzn90hyj7cf5pxn86P5P6JixUw4zrkBS5sOPCudVgpUJyBnfNMl6+pqOXFzENS7a/D/WSzHfdNcQAOogoBqxr9tm2LsN2R5KuXNeetD1EHb5akVzqSqVk/EbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973537; c=relaxed/simple;
	bh=wnbe7jtvCVvq8FO3S2cNFsGLbJScQbJyrkwDMCkqFkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rUzxvzrJ5oQPyz3wutlY+iH13JdXHG4ZLquWbLsxmxAsHhnxbuNvHuOwO8uSCFt+4CXfoJZ0RzBsmadXIfi6Vh3vYs1uzZ2Vd0kbZeOVGwgCFjeKdF23chMdQw86V0pqtmhKl0ivRZmCOpYaTsTDKzszwbmLe+SN5ArbH3olvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0JebpuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0JebpuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B56C1F00893;
	Mon, 21 Sep 2026 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973535;
	bh=MxslGevireAJMCIfs0eM56PxBvGSsnsj42W0sG4XLyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y0JebpuMHGNHoufC87yY82hyVS13xNADV5KZVhTbGt5iXu5Fi2ZBmzwRBIIt2lqWx
	 G5o+abNO9z2K2niOIUloYvCg5uyHEYQMV0sdB6nXsJ7fjKGj692QPc4dN+G5Xg1qBG
	 ZWAyyXvoW2X0Wx10xxShIL/hRTiIcDnkqkwufPTezJGG77YqFiRUzEuPsmGXywJNhn
	 lrNa+kHIRaIY/Si6a01gc5CrIB8ZtyI1QaOKmh/pP0RW0GfRfTJ6JCEnFudhuZ+95q
	 ox9gKHHiF3+sLFM42IkSthIzRJPh/77tEKM7EqKIdRVtHHNZx3NHrdpyHK0Lu18ZyK
	 mmYKGT7MuvECA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] dma: swiotlb: Centralize memory-encryption pool
 sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921063628.362078-5-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:52:15 +0000
Message-Id: <20260921065215.8B56C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] swiotlb: 64-bit division build error and 32-bit multiplication ove=
rflow
--

commit 7f27b828f817aa2b9787b04060d6febbcd685bcf
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Centralize memory-encryption pool sizing

The patch moves the x86 guest-sizing policy into the SWIOTLB core, sizing
the SWIOTLB_POOL_CC_GUEST pool to 6% of guest memory. It also provides a
way for early users like the crash kernel to view the adjusted pool size
before SWIOTLB initialization.

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -480,6 +481,46 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
> =20
> +/**
> + * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
> + *
[ ... ]
> + */
> +unsigned long __init swiotlb_adjusted_size(void)
> +{
> +	unsigned long nslabs, size =3D swiotlb_size_or_default();
> +
> +	if (swiotlb_default_size_changed() ||
> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return size;

[Severity: High]
This is a pre-existing issue, but returning `size` directly here bypasses
area-aware alignment for explicitly configured sizes and non-CC_GUEST setup=
s.

Could this discrepancy, along with the behavior of `swiotlb_aligned_nslabs(=
)`
during early boot, cause the crash kernel to under-reserve memory?

The crash kernel reserves low memory based on the prospective size from
`swiotlb_adjusted_size()` (or explicit `swiotlb=3D` sizes). However, early
in boot, `default_nareas` is 0, so `swiotlb_aligned_nslabs()` merely aligns
to segments and skips the area-aware power-of-two rounding:

kernel/dma/swiotlb.c:swiotlb_aligned_nslabs() {
	...
	if (!default_nareas)
		return nslabs;

	if (nslabs < IO_TLB_SEGSIZE * default_nareas)
		nslabs =3D IO_TLB_SEGSIZE * default_nareas;
	else if (!is_power_of_2(nslabs))
		nslabs =3D roundup_pow_of_two(nslabs);
	...
}

Later, `swiotlb_init_remap()` initializes `default_nareas` and calls
`swiotlb_adjust_nareas()`, triggering `round_up_default_nslabs()` to round
the pool up to the next power of two.

As a result, the allocated SWIOTLB pool can be up to ~50% larger than the
reserved size (e.g., 600MB rounded to 1024MB). When the crash kernel
attempts to allocate this rounded-up size, will it exceed its reserved
memory and OOM?

> +	/*
> +	 * For SEV and TDX and CCA, all DMA has to occur via
[ ... ]
> +	 * The percentage of guest memory used here for SWIOTLB buffers is
> +	 * more of an approximation of the static adjustment which 64MB for
> +	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size =3D memblock_phys_mem_size() * 6 / 100;
> +	size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);

[Severity: High]
Does this calculation cause an undefined reference to `__udivdi3` on 32-bit
PAE builds, and overflow on 32-bit non-PAE builds?

The guest sizing logic has been relocated into `kernel/dma/swiotlb.c`, which
is compiled for all architectures. On 32-bit kernels with PAE, `phys_addr_t`
is 64-bit, so `memblock_phys_mem_size() * 6 / 100` performs a 64-bit divisi=
on
by 100. GCC will emit a call to `__udivdi3`, which is missing from the
kernel's libgcc, causing a fatal build link error.

On 32-bit kernels without PAE, `phys_addr_t` is 32-bit. If physical memory
exceeds ~715MB (`UINT_MAX / 6`), the multiplication `memblock_phys_mem_size=
()
* 6` overflows the 32-bit integer, resulting in a silently truncated and
incorrect pool size.

Should this be refactored to cast the operand to `u64` and use `div_u64()` =
to
be safe across all platforms?

> +	nslabs =3D swiotlb_aligned_nslabs(size);
> +
> +	return nslabs << IO_TLB_SHIFT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921063628.3620=
78-1-aneesh.kumar@kernel.org?part=3D4

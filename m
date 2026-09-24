Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956ED3B7769
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231169; cv=none; b=uKUg76GAke6jOf7A8K1H31DzwNenZ3aoAJdcfzbPGX9qOh4PiBPDGhM0Ndlja7BKIoE/6am8MHd5AZfJ5xor9rdMPATrfnIZZ26tXZgs/JbMjBzQZkiGaIsareVVAr/2wKJlfwLaPDQFn3b/d8VtyIYTw5P70Gpxg7w2nwg7UQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231169; c=relaxed/simple;
	bh=Gcr7Uy+spuPPcB600Ed/StkRIIvMgdQv3RKtgZWNKJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqI2sdT4W1ZqQwoJMe3IZxqGxu4wDvkdfgO2IqmUKLCEthctyW3+VBTExnDJy8R71U4h0JbDvh6uqpYyYz3/lmYezEYsnHD30lTPoqhJQNLFVgWYHERf4mCaKtGtFbkWu8WANqwCHzO4DnNrRP9bgKDbuW4MLjaU7qCMNbu5zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdtlJ2VC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdtlJ2VC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028C21F00893;
	Thu, 24 Sep 2026 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231168;
	bh=CHukA+oSXZ2Tx+H3yxdW7D6y6TvtJfda7+lwZch2dq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RdtlJ2VCz67BI9p/g3GWTNKBerfYSwXfDbZUmynpjDVZcco2o7KCE92ZqPz7gXV3R
	 +fZS+y5fA/Ig5pAR+bIZ6TbAr2XzPF8VcgvKoP+o/C8YOq+PDDad3sfuu83CiDkllK
	 g1NKMH89nrYQjLo9ya72pzIyRaUFurMy6dbhAv57WisMnP+GeSbffCxHLSPA1XVxae
	 DYfHIiR3OVKKcblUCvD8LIJbY7whpn2Ab3qZZ7v5CGczUWuo3t/pb3A/aJD5X5r0yo
	 +Y2c9meZo71Yv2byluVy7jvYVMuAj374VFunmB9S/aPSr3DxUQ8ZCZxHhkcu4ttZDB
	 HPkvJogFSJt5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260924060756.1325156-7-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:26:07 +0000
Message-Id: <20260924062608.028C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma: swiotlb: missing fallback disables default pool on CC guests =
with restricted DMA
- [High] x86: crash_reserve: low memory reservation undersized for CC guests
--

commit b7ccaf6e292795b26ab1ca8eb765bb8952de98b5
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Centralize memory-encryption pool sizing

Memory-encrypted guests use shared or unencrypted memory for DMA and may
route all DMA through SWIOTLB. The default pool can therefore be too
small for I/O-intensive workloads.

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 95bae74fdab23..912f22ca838f8 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
[ ... ]
> @@ -114,27 +111,6 @@ void __init mem_encrypt_setup_arch(void)
>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		return;
> =20
> -	/*
> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> -	 * Kernel uses SWIOTLB to make this happen without changing device
> -	 * drivers. However, depending on the workload being run, the
> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> -	 * performance degradation especially with high I/O workloads.
> -	 *
> -	 * Adjust the default size of SWIOTLB using a percentage of guest
> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> -	 * memory is allocated from low memory, ensure that the adjusted size
> -	 * is within the limits of low available memory.
> -	 *
> -	 * The percentage of guest memory used here for SWIOTLB buffers
> -	 * is more of an approximation of the static adjustment which
> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> -	 */
> -	size =3D total_mem * 6 / 100;
> -	size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> -	swiotlb_adjust_size(size);
> -

[Severity: High]
Does moving this SWIOTLB adjustment run too late for crashkernel reservatio=
n?

When this was called during mem_encrypt_setup_arch(), the SWIOTLB size was
adjusted before arch_reserve_crashkernel() called crash_low_size_default().

Now the dynamic guest sizing is evaluated later, so crash_low_size_default()
only sees the unadjusted 64MB default.

If the crash kernel is provided with a large amount of memory (e.g.,
crashkernel=3D4G,high), its own dynamically calculated SWIOTLB size could
exhaust the 256MB of low memory reserved by the main kernel.

Could this lead to out-of-memory errors in the low memory zone and break
kdump functionality on x86 memory-encrypted guests?

>  	/* Set restricted memory access for virtio. */
>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>  }
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 75ee63cd354e2..e626cca63ad11 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
[ ... ]
> @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>  	if (swiotlb_force_disable)
>  		return SWIOTLB_POOL_NONE;
> =20
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	    !restricted_dma_pool_present)
>  		return SWIOTLB_POOL_CC_GUEST;
> =20
>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))

[Severity: High]
Does this disable the default SWIOTLB pool entirely for confidential guests
with a restricted DMA pool?

If restricted_dma_pool_present is true on a confidential guest, this condit=
ion
fails.

If no other conditions match later in swiotlb_select_pool_policy()
(for instance, if there are no addressing limits because guest RAM is small,
such as on arm64 CCA), the function falls through and returns
SWIOTLB_POOL_NONE.

Could this result in devices not explicitly assigned to the restricted DMA =
pool
failing to map memory, leading to device malfunction or a system panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060756.1325=
156-1-aneesh.kumar@kernel.org?part=3D6

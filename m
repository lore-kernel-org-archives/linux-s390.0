Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1719C553
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372801; cv=none; b=fgZxLPVk+/vvdeOQIoJsIgzyxoSsf/HGy45VEl0de/rHaxRgI08/Om4BRLOQfDpm9hcDH7s8SNdLR+nND0gg9vC9yEIgnRNB88QO8P5RZB55OwKiWdpVValI+/UdPEKykMx+GfRRunNp/z0EXrZF1cIYYGJLyMxzpRD17KmRXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372801; c=relaxed/simple;
	bh=ti3lThMyPlck0nJ5C6XsUNhz8aC9Gp+940jXdLgnZ/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NX2MSOPBIJu6zFBrsTjR9i/J6hycRvnI3PMxMBoeeaOHx33Zngct6hGzEHun8y7/W+IrXU0MQ+lZgSNpAlTMHUbYkfF4HwyQ/NjotJ6Ca/KXlXfqvXX1aY1CAXDhoAXqY9m9Tynfu9HoOStfJa4OPjpfpmMiUlI/sKbOxbm3ooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRan/mPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRan/mPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0751F000FF;
	Mon, 14 Sep 2026 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372800;
	bh=4ic1X3bG4UDvAtY+D21mNYmC9JK52vPrLPzwRjTRHe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MRan/mPKnhreXIn6KKb/CNgbEXw/8+vdn2eu42Nh4mMaGuMxpjGAf/JehwEJhKZ/A
	 4Bj0RVbjWOWZsOdaEjUrpNZb8KmfSVRnR6BPnOQ0DF8gY40c0rukdImLWiGPaQlcsd
	 5qCpSO6LHVifJ7qhd9dSGT7zH3DXNxVRPv6rAL0+hVExRKodyzl3Ytq/DQ9/wS7Vqq
	 68UxmBSJH+vH5jhrrfun4pNeZrt2BrYxhzAK1nhHaS7Tr3B9aGTc4wsF5oBA8xKp/U
	 bjA05TWGZIcTPCeECyZiGl4PpNInELjWEU83AtWhq9LN7HMHewgCKjTDE105AMRr2K
	 ZqK1x7zJV84wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] dma: swiotlb: Remove SWIOTLB_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260914070135.313337-6-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:59:59 +0000
Message-Id: <20260914075959.AA0751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Subsystem guideline violation: Use of globally uninitialized high_=
memory in __init code
--

commit 61bbab3b84e605312f21e75e603675cd29154afc
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Remove SWIOTLB_ANY

This patch replaces SWIOTLB_ANY with SWIOTLB_INIT_ADDRESSING_LIMIT to
explicitly identify callers that need pools reachable by devices with
limited DMA addressing. It changes the default behavior to allow static
and dynamic pools anywhere in directly mapped memory when the limit flag
is omitted.

[ ... ]
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 6695da682f961..f8a77926b8b09 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
[ ... ]
> @@ -604,10 +599,10 @@ void __init swiotlb_init_remap(unsigned int flags,
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	if (!remap)
>  		io_tlb_default_mem.can_grow =3D true;
> -	if (flags & SWIOTLB_ANY)
> -		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
> -	else
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>  		io_tlb_default_mem.phys_limit =3D ARCH_LOW_ADDRESS_LIMIT;
> +	else
> +		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);

[Severity: High]
This is a pre-existing issue, but does this evaluation of high_memory in an
__init function risk calculating an incorrect physical limit?

The swiotlb_init_remap function in kernel/dma/swiotlb.c evaluates
virt_to_phys(high_memory - 1) during early kernel boot. However, the
high_memory global is uninitialized and evaluates to zero until
free_area_init() runs. Calculating a physical limit using high_memory here
can result in a bogus DMA boundary (such as zero or an underflowed limit),
which could lead to memory allocation failures or data corruption during
DMA mapping.

Could this code use memblock_end_of_DRAM() instead of high_memory during
early boot allocations?

>  #endif
> =20
>  	/* if we have host or guest memory encryption */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914070135.3133=
37-1-aneesh.kumar@kernel.org?part=3D5

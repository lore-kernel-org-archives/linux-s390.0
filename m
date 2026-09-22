Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC204A64F0;
	Tue, 22 Sep 2026 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060531; cv=none; b=mUMtYCtmfPSH1mRJTEwDMyvkE60Fl7Dg8KMVOkM8Q5VLJ2Jm8PCHibs0q1LNSVxUwnLFDvyZj+dcT0y1CjnspuVLiGJ4wMB7y34L5SH2cLxH08+GDSw/+eqVnw94KBN2ksUyig2/OdQ2GneOFxpY+2wGpe69/QX9EU7cCocU4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060531; c=relaxed/simple;
	bh=R3AzHEqXULPNoORASWKVj+dI+NYZd6UfGplvXrxbnQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=koNQIYitsO1ENe2Nsz7POHS+jFhSQaVGAWRqLpU5fgxGykwUwk4mSrvkzhKQeQiYYWS35QTdUMJ7wA5d8OSIStuJhF4gg6YDAV3zzuZ6BmTSMHcvsD0ljxelCXXX84rTKu72u0xnrf9jaMw5y+G26wq5Ys8eDUjfjxrNpiUBcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz6g1YZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz6g1YZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726E61F000FF;
	Tue, 22 Sep 2026 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060529;
	bh=qC3rQUz5miG1t79I4tIJ3ZCR0ByZd9SPu3Z2uztXyDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iz6g1YZZXlgRDRPrKg5u13/HkaXXfFcSp9gFwuS9fK7OEbRe6/HBG1AfOSYk5Cmvm
	 sz2trHAlOOhEYs+y27AHQp49ucQ/LuYR+W8jYdPDdOdS0us1tKjxxxqhha6wbYNNSF
	 +HRTmb+MEjQJjnRZlb3YFpaAZ7p6LZvocDwOff47+b1h5KCWOhLGUbHmw/qBWz15jN
	 g7n7jkBxEqlIGOmkFb+UgbPUEjmlK9ly6D+EBuRtJHY7zlp7m2MsGSsElFrHrLVeb0
	 cPJtja0vZ+1Cxb2PBzMmqnxDzfpeJG4fWj3of1qALCviL8ycJ6Rdx1smEqTu7nEwfK
	 w6g0QHD/EnGgg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 4/6] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <20260921065215.8B56C1F00893@smtp.kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-5-aneesh.kumar@kernel.org>
 <20260921065215.8B56C1F00893@smtp.kernel.org>
Date: Tue, 22 Sep 2026 12:32:04 +0530
Message-ID: <yq5amrt93h1v.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] swiotlb: 64-bit division build error and 32-bit multiplication overflow
> --
>
> commit 7f27b828f817aa2b9787b04060d6febbcd685bcf
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> dma: swiotlb: Centralize memory-encryption pool sizing
>
> The patch moves the x86 guest-sizing policy into the SWIOTLB core, sizing
> the SWIOTLB_POOL_CC_GUEST pool to 6% of guest memory. It also provides a
> way for early users like the crash kernel to view the adjusted pool size
> before SWIOTLB initialization.
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -480,6 +481,46 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
>>  
>> +/**
>> + * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
>> + *
> [ ... ]
>> + */
>> +unsigned long __init swiotlb_adjusted_size(void)
>> +{
>> +	unsigned long nslabs, size = swiotlb_size_or_default();
>> +
>> +	if (swiotlb_default_size_changed() ||
>> +	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +		return size;
>
> [Severity: High]
> This is a pre-existing issue, but returning `size` directly here bypasses
> area-aware alignment for explicitly configured sizes and non-CC_GUEST setups.
>
> Could this discrepancy, along with the behavior of `swiotlb_aligned_nslabs()`
> during early boot, cause the crash kernel to under-reserve memory?
>
> The crash kernel reserves low memory based on the prospective size from
> `swiotlb_adjusted_size()` (or explicit `swiotlb=` sizes). However, early
> in boot, `default_nareas` is 0, so `swiotlb_aligned_nslabs()` merely aligns
> to segments and skips the area-aware power-of-two rounding:
>
> kernel/dma/swiotlb.c:swiotlb_aligned_nslabs() {
> 	...
> 	if (!default_nareas)
> 		return nslabs;
>
> 	if (nslabs < IO_TLB_SEGSIZE * default_nareas)
> 		nslabs = IO_TLB_SEGSIZE * default_nareas;
> 	else if (!is_power_of_2(nslabs))
> 		nslabs = roundup_pow_of_two(nslabs);
> 	...
> }
>
> Later, `swiotlb_init_remap()` initializes `default_nareas` and calls
> `swiotlb_adjust_nareas()`, triggering `round_up_default_nslabs()` to round
> the pool up to the next power of two.
>
> As a result, the allocated SWIOTLB pool can be up to ~50% larger than the
> reserved size (e.g., 600MB rounded to 1024MB). When the crash kernel
> attempts to allocate this rounded-up size, will it exceed its reserved
> memory and OOM?
>

I added a new patch that consolidates the slab rounding and addresses
this issue.

>
>> +	/*
>> +	 * For SEV and TDX and CCA, all DMA has to occur via
> [ ... ]
>> +	 * The percentage of guest memory used here for SWIOTLB buffers is
>> +	 * more of an approximation of the static adjustment which 64MB for
>> +	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
>> +	 */
>> +	size = memblock_phys_mem_size() * 6 / 100;
>> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
>
> [Severity: High]
> Does this calculation cause an undefined reference to `__udivdi3` on 32-bit
> PAE builds, and overflow on 32-bit non-PAE builds?
>
> The guest sizing logic has been relocated into `kernel/dma/swiotlb.c`, which
> is compiled for all architectures. On 32-bit kernels with PAE, `phys_addr_t`
> is 64-bit, so `memblock_phys_mem_size() * 6 / 100` performs a 64-bit division
> by 100. GCC will emit a call to `__udivdi3`, which is missing from the
> kernel's libgcc, causing a fatal build link error.
>
> On 32-bit kernels without PAE, `phys_addr_t` is 32-bit. If physical memory
> exceeds ~715MB (`UINT_MAX / 6`), the multiplication `memblock_phys_mem_size()
> * 6` overflows the 32-bit integer, resulting in a silently truncated and
> incorrect pool size.
>
> Should this be refactored to cast the operand to `u64` and use `div_u64()` to
> be safe across all platforms?
>

Switched to div_u64() as shown below.

unsigned long __init swiotlb_adjusted_size(void)
{
	unsigned long nslabs;
	u64 size = swiotlb_size_or_default();

	if (!swiotlb_cmdline_size_set &&
	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
		/*
		 * For SEV and TDX and CCA, all DMA has to occur via
		 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
		 * happen without changing device drivers. However, depending on
		 * the workload being run, the default 64MB of SWIOTLB may not be
		 * enough and SWIOTLB may run out of buffers for DMA, resulting in
		 * I/O errors and/or performance degradation especially with high
		 * I/O workloads.
		 *
		 * Adjust the default size of SWIOTLB using a percentage of guest
		 * memory for SWIOTLB buffers.
		 *
		 * The percentage of guest memory used here for SWIOTLB buffers is
		 * more of an approximation of the static adjustment which 64MB for
		 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
		 */
		size = div_u64((u64)memblock_phys_mem_size() * 6, 100);
		size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
	}

	nslabs = swiotlb_calc_nslabs(size, default_nareas);

	return nslabs << IO_TLB_SHIFT;
}

-aneesh

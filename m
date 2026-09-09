Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C913E5577;
	Wed,  9 Sep 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946119; cv=none; b=FDSzmQVPo40ezCr1Tf/dVBQ9glCXekb7z1H5sjsFl11rtXVroUNsegiVs5HPiMoC+jlqUgs5ybqBBSzhiS5oUfn3jZWXud736XpeRAujH5XzrujoKAi0bBL1LguXbrR6XYENKbRx5t+Yh2459jPmeSpZ4bKpgGCTrIDMYgSpxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946119; c=relaxed/simple;
	bh=KqNZYPbdf5x1Mm9caBbJQVfZkniP3S3+b8Gomqetn54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sun/Dnm0DHF8jNtJSibbT0AQt5xovVEis8NbRpP4aPqvqINxab8NPpGwFem4TvqIszzOyNcOPuM0Vwezg4oWb1cqt0xeEoV5Skl99g3gYiKbOEYu5aCRg/E21qKMrjD8hipoEkksW/h7wjrMfqwJQg3LeksQbK1n6A7y94Ll9SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=disssKa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="disssKa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E725C1F00AC4;
	Wed,  9 Sep 2026 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946105;
	bh=uV+Kt1HMhAxsfK2lvTLAT0FGPZRjTMyHG0IkV4w1m5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=disssKa3d4rHXRZWqzXSdZxhWPx8NUtgRADSQ2zAdscD0T/SjDyrrEeUjDBfJZxJJ
	 tZE0U2c/b2aGaYP6Ad2rGwJkj9F1K/dAuf8suoZR3eZJPV+7qZbcc5OuLLkKBLa44W
	 Ox2hc4adkmejkgsC4Qk1IfRE/svNcAo82dQFkYEsfTM8AOPia98b9rNYDakZPHrXRc
	 sWpDwJz9tXqAbzA0NzquZl3bpKCEyUK0rWYiyChC02qEUHtllhJzorPiqf2CUk4XjP
	 bwP90k8g0YOYlreyYl02fE07mntl4B0sUcO6SKHNfadyQmYF1E24eFgK930bUUWGUV
	 QlB4jDbDANlsQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <20260904103644.CD15E1F00A3D@smtp.kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-4-aneesh.kumar@kernel.org>
 <20260904103644.CD15E1F00A3D@smtp.kernel.org>
Date: Wed, 09 Sep 2026 14:58:18 +0530
Message-ID: <yq5awlsuai4t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Skipping SWIOTLB_POOL_CC_GUEST when a restricted DMA pool is present can result in SWIOTLB_POOL_NONE or SWIOTLB_POOL_MINIMAL being selected, breaking DMA for all other devices.
> --
>
> commit d8ab20a637a8736036e923dfa3f89a8da55215c3
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> dma: swiotlb: Centralize memory-encryption pool sizing
>
> This patch centralizes SWIOTLB memory-encryption pool sizing for guests into
> the SWIOTLB core. It sizes the confidential guest pool to 6% of guest memory
> by default and records the presence of restricted DMA pools to avoid selecting
> the confidential-guest policy solely based on guest memory encryption.
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 90e0bfd0715cf..c4611b2c45403 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>
> [ ... ]
>
>> @@ -509,7 +553,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>>  	if (swiotlb_force_disable)
>>  		return SWIOTLB_POOL_NONE;
>>  
>> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> +	    !restricted_dma_pool_present)
>>  		return SWIOTLB_POOL_CC_GUEST;
>
> [Severity: High]
> Does skipping SWIOTLB_POOL_CC_GUEST here leave the system without a proper
> fallback for non-restricted devices?
>
> Looking at swiotlb_select_pool_policy() in kernel/dma/swiotlb.c, if a
> confidential guest boots with a restricted DMA pool present in the Device
> Tree, and system RAM is small enough that SWIOTLB_INIT_ADDRESSING_LIMIT is
> not set (e.g., <= 4GB), this check will skip SWIOTLB_POOL_CC_GUEST. 
>
> The function then falls through all the way to SWIOTLB_POOL_MINIMAL (a tiny
> 1MB/GB pool) or SWIOTLB_POOL_NONE. If it returns SWIOTLB_POOL_NONE,
> swiotlb_init_remap() will exit without allocating a default SWIOTLB pool.
> As a result, unassigned devices that still rely on the default pool for
> bounce buffers will fail to map DMA memory, potentially leading to I/O
> errors or boot panics.
>
> Should this path safely fall back to SWIOTLB_POOL_DEFAULT when a restricted
> DMA pool is present, to ensure a standard default pool is still allocated?
>

That is intentional. In a confidential guest, the presence of a
restricted-dma-pool is used as a hint not to set up an unencrypted
default swiotlb pool.

-aneesh

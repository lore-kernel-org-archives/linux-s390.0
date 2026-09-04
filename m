Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4C4734C6
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518206; cv=none; b=THHJpLelo3lM/EVU+SmObw+ZhIUSoiy39Ym1I4HSI+2R+85hZJwud/+/bE108xLXyFQo0UrEnpreSrcSS60uvYBlapLQaf7OIXuQ6Bg7Ho/JuB+a0T5PRsnclQ82Ptr/TA0sNutEI/wAg6rAGRVFZIaBZZyRH38z7cWyz2Y9zsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518206; c=relaxed/simple;
	bh=SHughckcQeg/3rPGkeE3+jE6Rcjmw+kOf6nawH8lhaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzSgNNU91KRgImN0XUptTGOt1EPqazkzqpIhJbDsygAAGlKeRV9ng/Yd4rusWOcgt/rcEd30cKGWeThXUSi5QZqJyjw3o9346+xXQYlYvZLH5doKGFcFKJAjcL10fhHwKni1TXhYjde/lQUWpAY84p1eW37M4z2j+L88OBnMRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb1ZbAIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb1ZbAIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD15E1F00A3D;
	Fri,  4 Sep 2026 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518205;
	bh=Rhz2vDBcweBGGt5pBa30NWVgNFp2zHhm+EPFCdeuy9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zb1ZbAIEgQ36driKGydBbLAT9MHHGmRXhgukBptcjeFief+rzizKGUL2v1EzYpqxV
	 YWbzg+llDeAXNSmFqInQqFpKzxjMVsOKt7AFY+cUOvyPKDGjA5kQGP5kmyKS3K2ifl
	 LGVOirvUlmS9u0JyA2YmQOkz5NjKgVmcPoZKpOO4DAGd78LmwOmrzjE70u+LAVyEQM
	 BpaSgYyn5tr/TeVxoe4/hEXkD0uj/HYoMXbub8SGmVvCJop3pQ5678o7oAdpJ9/Y1G
	 qWaLcEEPuKPD6GcWpfzaSiB/oM0JXHCoRUf7313WXIS0X20lpcCRYktitq1DvFWD4Y
	 0eNUFtvbDw9oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dma: swiotlb: Centralize memory-encryption pool
 sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904101810.1193505-4-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:36:44 +0000
Message-Id: <20260904103644.CD15E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping SWIOTLB_POOL_CC_GUEST when a restricted DMA pool is prese=
nt can result in SWIOTLB_POOL_NONE or SWIOTLB_POOL_MINIMAL being selected, =
breaking DMA for all other devices.
--

commit d8ab20a637a8736036e923dfa3f89a8da55215c3
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Centralize memory-encryption pool sizing

This patch centralizes SWIOTLB memory-encryption pool sizing for guests into
the SWIOTLB core. It sizes the confidential guest pool to 6% of guest memory
by default and records the presence of restricted DMA pools to avoid select=
ing
the confidential-guest policy solely based on guest memory encryption.

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 90e0bfd0715cf..c4611b2c45403 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c

[ ... ]

> @@ -509,7 +553,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>  	if (swiotlb_force_disable)
>  		return SWIOTLB_POOL_NONE;
> =20
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	    !restricted_dma_pool_present)
>  		return SWIOTLB_POOL_CC_GUEST;

[Severity: High]
Does skipping SWIOTLB_POOL_CC_GUEST here leave the system without a proper
fallback for non-restricted devices?

Looking at swiotlb_select_pool_policy() in kernel/dma/swiotlb.c, if a
confidential guest boots with a restricted DMA pool present in the Device
Tree, and system RAM is small enough that SWIOTLB_INIT_ADDRESSING_LIMIT is
not set (e.g., <=3D 4GB), this check will skip SWIOTLB_POOL_CC_GUEST.=20

The function then falls through all the way to SWIOTLB_POOL_MINIMAL (a tiny
1MB/GB pool) or SWIOTLB_POOL_NONE. If it returns SWIOTLB_POOL_NONE,
swiotlb_init_remap() will exit without allocating a default SWIOTLB pool.
As a result, unassigned devices that still rely on the default pool for
bounce buffers will fail to map DMA memory, potentially leading to I/O
errors or boot panics.

Should this path safely fall back to SWIOTLB_POOL_DEFAULT when a restricted
DMA pool is present, to ensure a standard default pool is still allocated?

> =20
>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>  		return SWIOTLB_POOL_DEFAULT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904101810.1193=
505-1-aneesh.kumar@kernel.org?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF93793DF;
	Fri,  7 Aug 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094510; cv=none; b=doHsOxcAU9OfLCPqbXbs04/ms1FfGy8EPy8p6mqeTTt4vCAKSxxwuj4cmHWyviwVQzJ60zenNy7yeWo867+e5E0YK+h8X3JTvSsWYN9EzflMQzzJHI89lp61st5U1C+Nvz9gCiXZTT2JjrKAx4v6Br4kQw5Bqv3haL/U+2SqiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094510; c=relaxed/simple;
	bh=C0dmANKqH39eWG4MQOTvSIOyvTlPYkY0RZOK5DUQdqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBQGnpIOCZJoRF+cz6VX/3tquJG3s6Nzdnw31GMXPPt+3WIapncgyUnUQp1iFo/pxEwdtivpnoI8ZtPDTiXcs/cQGmG8n+1ScLGRf5QzfElyCKO81QFSH+amgefwZxBZABEDKJHZmJqLhKl6TbVFy3loxUO9Y3Ml/KQXUJUK4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMQCJ/Gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMQCJ/Gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC51F000E9;
	Fri,  7 Aug 2026 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094506;
	bh=Pneo29ys3hGXogLk2+e1LzC80FrdOftuA2dSFmi144s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XMQCJ/Gj7Iu0ebVkhN13wsJt7AMBs/hyKYZHipvHCieM6Evyh/O2tF++XsVqENx/W
	 O4WpssKXAy1yB++mPLwn98gKLPnv8EJJ/xWJsxJdcHW3lvVwqg0WL0zQ3gkXU+TSmf
	 //VtTLKCKI8L/CclOy9PRdlovmOFa+u7XuDa26ivvRmK9rJgKLrvrxtkUPdmv+dDNU
	 LtPQ7TYk2UHyko3C2QTCSIU/KvPbS03jl7EOyg7RbatVxdODw0IY3BaCmRDRK3wPX2
	 Y5kMliqWeBs0luT8yI7Y4mRC+oPOczxGCmhB0P9lrQf7CzQN4ZpwcwEEKQH0dUWYGx
	 z/ew0497IG91Q==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
 <yq5azezfeeax.fsf@kernel.org>
 <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
Date: Fri, 07 Aug 2026 14:51:35 +0530
Message-ID: <yq5afr0q2sm8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>> This series tracks confidential-computing shared DMA state through the
>>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>>> DMA buffers are handled consistently.
>>>
>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>> shared/decrypted buffer handling. This series consolidates the
>>> force_dma_unencrypted() checks in the top-level functions and ensures
>>> that the remaining DMA interfaces use DMA attributes to make the correct
>>> decisions.
>>>
>>> The series separates mapping and allocation state:
>>> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>>>   mapping. It tells the DMA mapping path that the DMA address must target
>>>   shared/decrypted memory.
>>> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>>>   by allocation paths after the DMA core decides that the backing pages
>>>   must be allocated as shared/decrypted memory.
>>>
>>> The series:
>>> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
>>> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
>>> - teaches the atomic DMA pools to track encrypted versus decrypted
>>>   state
>>> - tracks swiotlb pool encryption state and enforces strict pool
>>>   selection
>>> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>>>   DMA attributes
>>> - passes DMA attributes down to dma_capable() so capability checks can
>>>   validate whether the selected DMA address encoding matches
>>>   DMA_ATTR_CC_SHARED
>>> - makes dma_direct_map_phys() choose the DMA address encoding from
>>>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>>>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>>>   relying on SWIOTLB_FORCE for DMA mappings
>>> - use the selected swiotlb pool state to derive the returned DMA
>>>   address
>>> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>>>   guests, and s390 protected virtualization guests.
>>>
>>> Dependency:
>>> This series depends on the pKVM changes posted at:
>>> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>>>
>>> Please merge this series only after the pKVM changes above are merged.
>>> Otherwise pKVM will be broken.
>>>
>> pKVM topic branch is now available 
>>
>> https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
> I've just got back from my holiday's and I see that there is everything ready to give
> this patchset some tests in linux-next. I hope nothing will break.
>
> I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with
> patch "[PATCH v8 17/23] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"
> rebased onto latest changes in arch/arm64/mm/init.c.
>

That might need a fix.

From 5a9af89e74e9e2671ed0a572af129ebfa6fd4640 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Date: Fri, 7 Aug 2026 13:14:51 +0530
Subject: [PATCH] arm64: swiotlb: Keep the default size for protected guests

Realm guests and protected KVM guests may require swiotlb for device DMA
even when all system RAM is addressable by the DMA zones.

Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
guests, as the reduced number of slots can be exhausted during CCA guest
operation.

Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e308a7cabd12..24caaf10e755 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-- 
2.43.0


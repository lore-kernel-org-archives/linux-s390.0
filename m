Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09583194C96;
	Tue,  7 Jul 2026 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429441; cv=none; b=mdUDKaDlvjlx7+5Vpft1g8F2uDck0B8eu0WdN0e2vAn9dLD/Vut6B1fPyLSwNqD9RL0/TziwmUT7K9tc7lRWQkCcRhmx4O2gQZRiidhNQK8HmQJ3LQdPMNPQ13Fw+yOvhXTlePNwL4qVFmSVs3JqROK/ST6xVf73tI3WYDPOrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429441; c=relaxed/simple;
	bh=I9l5C+AWVnctHlRI+9Q6TepCS4o9BXhroqvGump9+3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=nIzSQtwrc4DcC9K7WesxDzVvs7jXems67OLFe56tyX4oHDHHH+Ii8+8amHdk4dc0vd0As+fltd/QWeOgUPbwa8Us00Kf5oFI8mKN8utaPxjygufYT8DCpYNrofG2WkJ28uzOvfs1hvx6iSHKrnTmgW7pdBmRJ3UCo80ocdNwtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bIpgAugu; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bIpgAugu"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707130350euoutp01816b7aba68f35cc361a12757e4960321~AA55SXF0N2589025890euoutp01R;
	Tue,  7 Jul 2026 13:03:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707130350euoutp01816b7aba68f35cc361a12757e4960321~AA55SXF0N2589025890euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783429431;
	bh=1pXyGCmuZ2dd2pCX0ADJkgnLvZuWQnMbV/mJUc5jL2g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bIpgAugumnJ+vFbRlkBo8FzRtO/g5MYRDHE2BlHryQsTPFMC5fInDzKCOAgZ1npra
	 WjvJ/rWNe/t/bQYYXvdlEuuxIM77d/dc9M35H15wIneXXtBw3nINopT0vdG4B55jJi
	 2Rm+c3z4Adg15mIXdYkxRRDiDG8vmD3c75cZpyvY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260707130350eucas1p1721c804c0be9f8bcca8c74b90c602459~AA55DsDSM2891728917eucas1p1P;
	Tue,  7 Jul 2026 13:03:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260707130349eusmtip16fa04cbe7458b13574cd93f920780ed5~AA53jcBbZ1173511735eusmtip1K;
	Tue,  7 Jul 2026 13:03:49 +0000 (GMT)
Message-ID: <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
Date: Tue, 7 Jul 2026 15:03:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Marc
	Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
	Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5av7argr65.fsf@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707130350eucas1p1721c804c0be9f8bcca8c74b90c602459
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
X-EPHeader: CA
X-CMS-RootMailID: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
	<CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
	<yq5av7argr65.fsf@kernel.org>

On 07.07.2026 10:06, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>
>> This series tracks confidential-computing shared DMA state through the
>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>> DMA buffers are handled consistently.
>>
>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> shared/decrypted buffer handling. This series consolidates the
>> force_dma_unencrypted() checks in the top-level functions and ensures
>> that the remaining DMA interfaces use DMA attributes to make the correct
>> decisions.
>>
>> The series separates mapping and allocation state:
>> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>>   mapping. It tells the DMA mapping path that the DMA address must target
>>   shared/decrypted memory.
>> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>>   by allocation paths after the DMA core decides that the backing pages
>>   must be allocated as shared/decrypted memory.
>>
>> The series:
>> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
>> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
>> - teaches the atomic DMA pools to track encrypted versus decrypted
>>   state
>> - tracks swiotlb pool encryption state and enforces strict pool
>>   selection
>> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>>   DMA attributes
>> - passes DMA attributes down to dma_capable() so capability checks can
>>   validate whether the selected DMA address encoding matches
>>   DMA_ATTR_CC_SHARED
>> - makes dma_direct_map_phys() choose the DMA address encoding from
>>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>>   relying on SWIOTLB_FORCE for DMA mappings
>> - use the selected swiotlb pool state to derive the returned DMA
>>   address
>> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>>   guests, and s390 protected virtualization guests.
>>
>> Dependency:
>> This series depends on the pKVM changes posted at:
>> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>>
>> Please merge this series only after the pKVM changes above are merged.
>> Otherwise pKVM will be broken.
>>
> A rebased tree on top of the dependent pKVM changes can be found at:
> https://gitlab.arm.com/linux-arm/linux-cca/-/tree/scratch/pkvm/testing?ref_type=heads
>
> The patches had minor conflicts. I am not sure how we want to get this
> merged.
>
> Should we ask the pKVM maintainers for a topic branch, and then I can
> repost the updated series on top of that?
I'm fine with merging on top of the topic branch and I assume that this
patchset is mature enough to give it a try in linux-next, but first I
would like to get a review or at least acks from others with good CC
knowledge or experience.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


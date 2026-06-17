Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E3288D0;
	Wed, 17 Jun 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707619; cv=none; b=NfZCfsyYX0pTE1lGGcvNi4xmEU5rTqIjCZnn/Gd5afun3dfjrYK034pi56HSTTL6jC5ti8hJKoHGA+JHX2OeVumx3iAnANtiyNX1AgQcSTKC3pxM31qmQU1yk9R3Gth3TtYyMnEtBoSQsoEfKTyVyfWNBsbGecHRVKKQ25NQi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707619; c=relaxed/simple;
	bh=ZUvBAQH1J8WCF51d4zEXEtDIDU5wp7lcNIQ9chXCtSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dF0ukt3cCRUyev49WOamjwAzzMb8vTMF3KX6+OlpYlT5BCXvZkDwRyG6wbl7eVgMGzHq4nq+27jqU5f/CkIVF4IqVNR+dn2vzlff1RAKbw4VT3iEBP6fjrdAoTw8k9OKvxHh8o7HqBHDHyMS/wU5tiLcGeI7lkwJ9PLDUXpcajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laR53S4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laR53S4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370791F000E9;
	Wed, 17 Jun 2026 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707613;
	bh=erXy90F1aVhSTW8POQ0NgCMddX+dCML396UHDEIaezg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=laR53S4ZEFqpK1RU2C/yjKgmXtvMoVq6Ik55ii1gAWmh3rRuIBk1UrsjhJal8Mf7Y
	 nKNxtvFmqU30GaFlFd6gJbCL6OuI9sKlymNooPjqVLA22wKu2cf7YHqk3iUzTcFnOg
	 AonnWRxxacImdlprsatSccr+it2PVoCE2farsGQZ0BWMkTXGQH9HozuVaFKisG7AwT
	 5FkwBoRfJFlzW7mX9CM093Zy2Sxh6cGHKqN/0EWAVZkIvKHcMUePMuRTEjPFcC8cMu
	 msrJ3x9CnBMTnDsAFfGnXCnBCSM+Po6oFWp3nnIuybjDCDIkSmxHIeOL5R+Ez/oZG3
	 ThZCeuyOnZbdQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>, "Cheloha,
	Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
In-Reply-To: <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
Date: Wed, 17 Jun 2026 15:46:41 +0100
Message-ID: <yq5atsr1dy26.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 4/6/26 18:39, Aneesh Kumar K.V (Arm) wrote:
>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
>> dma-direct allocation path and use the attribute to drive the related
>> decisions.
>> 
>> This updates dma_direct_alloc(), dma_direct_free(), and
>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
>> 
>> Tested-by: Jiri Pirko <jiri@nvidia.com>
>> Tested-by: Michael Kelley <mhklinux@outlook.com>
>> Tested-by: Mostafa Saleh <smostafa@google.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   kernel/dma/direct.c | 53 +++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 44 insertions(+), 9 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index a741c8a2ee66..90dc5057a0c0 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>   {
>>   	bool remap = false, set_uncached = false;
>> -	bool mark_mem_decrypt = true;
>> +	bool mark_mem_decrypt = false;
>>   	struct page *page;
>>   	void *ret;
>>   
>> +	/*
>> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
>> +	 * attribute. The direct allocator uses it internally after it has
>> +	 * decided that the backing pages must be shared/decrypted, so the
>> +	 * rest of the allocation path can consistently select DMA addresses,
>> +	 * choose compatible pools and restore encryption on free.
>
> Why this limit?
>
> Context: I am looking for a memory pool for a few shared pages (to do
> some guest<->host communication), SWIOTLB seems like the right fit but
> swiotlb_alloc() is not exported and
> dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed. Thanks,
>

swiotlb is not the right pool to use for that, right?
CCA had a similar requirement for ITS pages and ended up creating a genpool:
b08e2f42e86b ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")

-aneesh

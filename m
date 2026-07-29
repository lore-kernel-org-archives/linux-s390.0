Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94C442FAD;
	Wed, 29 Jul 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316161; cv=none; b=DsXtbVsy7EXJM3o9iqsrNSuPq0FHc6BJ/Z6FlyZoow5vvi9hGrUGspKlJkne2srEF7kwY17tA3CHV7g79ZkP3zCp2rnzyh6XesYIJFkpOZ0hdl2D32hfNx3fiXHwIP5dXgKqCuBIvA8zObrdV4uHwY/clzeyvDHfk+1GQhLWXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316161; c=relaxed/simple;
	bh=hPcS3YA9tQ7BB8XX1AWw3zre5i5jAQ3HY/DvSaz1owM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDSKHTzrKgUg4yE8J1E/PYqTbdv0E7YrMVt9vjmoUuoxejPaqwBDV2ZmyjFKgga/yHMf8bYg6D274/mkrpdgo5U8s8eobyzmD6d5A2SJWAt8E9wpDYfueRFIV+U3d9ZphcOd07Y5tdL1GwFtJN2ngV9yOqpjqbW8KuXOgqcR/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2VcftX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2VcftX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD2D1F000E9;
	Wed, 29 Jul 2026 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785316160;
	bh=3SpSxnvuNGmLHWtJ7jUwkJNoaIB6p9cDPcBNT0kYRN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=A2VcftX+szPrGFM49eBI8rgFYkmukzvFokMsd6WGe+h74xvC6CtdICs0UZ4yjOqvR
	 fdcdUi7fzgpOIuZL4RtiddkR2ScDaD1cM0BLIuDlG5jfNQnWGV0+ncs9XXY9Jex52k
	 tM0VQtKPqoomYgjwCx715PfvDmGSE4Gn1EIUcmgyqaAnRRJQaMVwm6nS/F4mOO27ja
	 qcoSXdaQMlMbY8tkdYIqHfSFfCMxIeoHQkHUsXhWW/I8Fs/VcUew2AFEtR4JR7Y19H
	 PUnnq88/Wgvhkl2D7ezzQNWPFWPputmv9S883P/cocuobYpEolgl3n/xjWk2H65qch
	 z6Y42MpMAW7YQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 15/23] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
In-Reply-To: <ami9CIGanuQX3lxb@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-16-aneesh.kumar@kernel.org>
 <ami9CIGanuQX3lxb@google.com>
Date: Wed, 29 Jul 2026 14:39:08 +0530
Message-ID: <yq5a33x2go23.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

>>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>> -		bool is_ram)
>> +		bool is_ram, unsigned long attrs)
>>  {
>>  	dma_addr_t end = addr + size - 1;
>>  
>>  	if (addr == DMA_MAPPING_ERROR)
>>  		return false;
>> +	/*
>> +	 * The DMA address was derived from encrypted RAM, but this device
>> +	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
>> +	 * so the caller can fall back to a suitable SWIOTLB pool.
>> +	 */
>> +	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
>> +		return false;
>> +
>
> I guess it does not make sense to check the other way? I'd be worried if
> some a confidential device uses shared memory which might leak info.
>

From the perspective of the dma_capable() check, this should be allowed;
that is, a trusted device is permitted to access shared memory.

-aneesh

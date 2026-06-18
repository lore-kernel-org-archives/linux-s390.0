Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBF276049;
	Thu, 18 Jun 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771853; cv=none; b=LIeyk/IBtu4oqA3VzJL74bUPduqWYLeJfwAjIRgZkFq5fdSH8n32Xwm8bDWd608BF9LZ77J1dpRxAODkiCYQ5I4F2CWELDEmjXCpNdGAbCQZQcjGSIp7IXhUQUkBtY8wv1H/KmwaPBOPnZA2mp+m8oa/EXuY8j6MWqIoDpmZmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771853; c=relaxed/simple;
	bh=2p8Tyh/UWigSfVM1Alp/U1v3F1IYe71ZRicsBMgPa0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LpvhNLDfo3FDN0+JKJjC48n5JsK6BAIfOpLcdxFq0fTicyPamqrCAZxcrA4i62ihh/3GTcfjx3YBEq6BDzWcCpJUyzO6UnCVtD6MBF0xXZZcthlpvvmV0RLQzBDj+dq9K9ad4zp50/N7eglFl/B6IRz4mgHDsMjsRcc1ZpAX42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJYmurEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJYmurEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334ED1F000E9;
	Thu, 18 Jun 2026 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771851;
	bh=Tjfp3FF0f+SxzpFBuG9E9B1amsn/loCXBkKBhFITWIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bJYmurEUTf4p9ddXp1VSCskBHjygy+xD/oNjB9s2Ep/Uu73ZeAFn3grah/ZH/26bC
	 Z2IKNbkJrX3SQyniq2V3c43nApViK8ptRc8Gz9vZ5aBx3WYWws6jmsSQ1n8wC/ZhsC
	 aPXbP4vBO9+s7L7Gu2B1QTaU30Q3lwF3YsxuWM4vVa7T2kphUxDrfVTBh2RPbtKviM
	 f3h5f4VrWfNGB2xgQRFYm9r1q8fBv53E49ns83ljI6VaL3Opsq3DE6buX9d8xYbXtu
	 r9HlAXaeEfYUQ5HKSssJFRAz7y8WVKnEyAfSl5fBP2P87RedjDBY2R+S227cOm339+
	 HGR07rvOMXPTg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
Date: Thu, 18 Jun 2026 09:37:22 +0100
Message-ID: <yq5aqzm4dz25.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 10/6/26 00:47, Jason Gunthorpe wrote:
>> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
>>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>>> are handled consistently.
>>>>
>>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>> shared/decrypted buffer handling. This series consolidates the
>>>> force_dma_unencrypted() checks in the top-level functions and ensures
>>>> that the remaining DMA interfaces use DMA attributes to make the correct
>>>> decisions.
>>>
>>> Please check Sashiko's reports, it has some good points:
>>>
>>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>>>
>>> I think the main one is the swiotlb_tbl_map_single() changes which break
>>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
>>> but force_dma_unencrypted() is false. Normally you'd not end up on this
>>> path but you can have swiotlb=force.
>> 
>> IMHO that's an AMD issue, not with the design of this series..
>> 
>> The series is right, a device that is !force_dma_decrypted() must be
>> considerd to be a trusted device and we must never place any DMA
>> mappings for a trusted device into shared memory.
>
>
> swiotlb=force forces swiotlb, not decryption.
>
>> That AMD has done somethine insane:
>> 
>> bool force_dma_unencrypted(struct device *dev)
>> {
>> 	/*
>> 	 * For SEV, all DMA must be to unencrypted addresses.
>> 	 */
>> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> 		return true;
>> 
>> 	/*
>> 	 * For SME, all DMA must be to unencrypted addresses if the
>> 	 * device does not support DMA to addresses that include the
>> 	 * encryption mask.
>> 	 */
>> 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>> 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>> 						dev->bus_dma_limit);
>> 
>> 		if (dma_dev_mask <= dma_enc_mask)
>> 			return true;
>> 	}
>
>
> So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this patchset, it fails to boot. But it boots with a hack like this:
>
> ===
> @@ -39,7 +41,7 @@ bool force_dma_unencrypted(struct device *dev)
>                          return true;
>          }
>   
> -       return false;
> +       return swiotlb_force_bounce;
>   }
> ===
>
> Or we say "mem_encrypt=on iommu=pt swiotlb=force" combo is just weird and we won't be supporting which bit in this? Thanks,
>

Something like?

modified   arch/x86/mm/mem_encrypt.c
@@ -34,6 +34,13 @@ bool force_dma_unencrypted(struct device *dev)
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
+		/*
+		 * With memory encryption enabled, SWIOTLB is marked decrypted.
+		 * If SWIOTLB bouncing is forced, treat the device as requiring
+		 * decrypted DMA.
+		 */
+		if (is_swiotlb_force_bounce(dev))
+			return true;
 
 		if (dma_dev_mask <= dma_enc_mask)
 			return true;



-aneesh

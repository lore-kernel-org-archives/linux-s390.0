Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263437DE84;
	Fri, 10 Jul 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710606; cv=none; b=NqR84pZ/IQ+VxMW2mv0KdHGcSlPsLMnlgIIh4mCiABxnnKAOJPONrMNaAyf4Cw8BjIs0vlz71RZXMeB65zt0YkBKoOXtKLUKJa8B4ZiSTi226Y3feeVgmJPlyKPjXdK/0yR7/PvBD1hMDEMDbEoJpPowKQfj2f9SRyHki0FbLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710606; c=relaxed/simple;
	bh=T3NhY1Odkiqu1O5vVfFHhbxIja3A+wYbFcoqVrmS1IM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/e5FFZczUwecqxp+KglhMqDF/2dS7WSUd6vjBMLg+MRQfax95XpUzVyAWOOScU5zfK9UEazE5nDIz8HeYGGN1PdDSECSFAjr+q/y8SJTwnzS/FmoUICS1+5TLjBoIOJbTKqXmkVcpgs/0kGAmSpuTkm+InHOdlG7CbhazXmiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJVAQDeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJVAQDeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A666D1F000E9;
	Fri, 10 Jul 2026 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783710604;
	bh=W80wLEkD9W1pRB495wpgnQIxmPS8lDwtXqHw1IqIoXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gJVAQDeZh09mlIwH9aS39ydQbMv9ATCa+q6RzlotJlYDVCb0X489XGl54CievRuGV
	 bGeu8Trnzs9LKTmlXX1pDvL33HGewl6FHGfOjc0OpTWhcguWUb6nrHVON5SwxxlXxh
	 iJTpwsEFNo+/Gm+kYK5XFRHKL4VnmI2nxMSvTZO7jYF/1Rr/f9TiJImRsDON2mAQ0g
	 19pArOpGrtzlKcjk3UrEhjHcRxKRE7bBMnW84vRE1rhb/QkRefEY9u0Iubp2HtQgxb
	 ZzlSURdXD0kwVECjToI+lZg14zJMWTnVf7oLvDTrLlhMJEAMH6DYqS738Ii5K0QjYJ
	 coYrGCnVbQA5Q==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <20260710161945.GO118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com> <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com> <20260709181336.GM118978@ziepe.ca>
 <yq5ajyr3h106.fsf@kernel.org> <20260710161945.GO118978@ziepe.ca>
Date: Sat, 11 Jul 2026 00:39:49 +0530
Message-ID: <yq5atsq6hdaa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Jul 10, 2026 at 10:52:49AM +0530, Aneesh Kumar K.V wrote:
>> >> > 	/*
>> >> > 	 * For host memory encryption and device requiring unencrypted DMA,
>> >> > 	 * MMIO memory is treated as shared by default.
>> >> > 	 */
>> >> > 	if (attrs & DMA_ATTR_MMIO) {
>> >> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
>> >> > 			attrs |= DMA_ATTR_CC_SHARED;
>> >> > 	}
>> >> 
>> >> Yes, I think it does the trick, preserves the current semantics for AMD.
>> >> I guess you could use a single 'if' for all checks (up to you).
>> >
>> > Please don't change it, MMIO P2P is broken on CC systems today and it
>> > should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
>> > an error that we need to correct in the drivers not make work in the
>> > core code.
>> >
>> 
>> But the above changes are intended to handle HOST_MEM_ENCRYPT. In v7, we
>> had the following diff:
>
> To follow how the rest of the decrypted/encrypted stuff works the MMIO
> has to be flaged with CC_SHARED for HOST_MEM_ENCRYPT too, just like
> the PTEs.
>
>> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>  {
>>  	dma_addr_t dma_addr;
>>  
>> +	/*
>> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
>> +	 * as shared by default.
>> +	 */
>> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
>> +		attrs |= DMA_ATTR_CC_SHARED;
>
> force_dma_unencrypted() says nothing about the properties of the
> address passed in, this was nonsense :\
>
>> As we discussed [1], that can come in a later patch. In the meantime, adding
>> the HOST_MEM_ENCRYPT check preserves the previous behavior for SME.
>
> It never worked. When we added ATTR_MMIO it started to have a chance
> to work but prior to that it was always broken anyhow. I don't see
> there is much merit in preserving the narrow window when we
> inadvertantly had a half working ATTR_MMIO.
>
> But if you really want to it should be
> cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) *only* and get rid of the wrong
> force_dma_unencrypted().
>

Ok, I will update the changes to so we preserve the previous behaviour
for SME?

	if (attrs & DMA_ATTR_MMIO) {
		/*
		 * For host memory encryption treat MMIO memory as shared
		 */
		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
			attrs |= DMA_ATTR_CC_SHARED;
	}

Do let me know if you feel strongly that the above change should not be
included and that the SME P2P case should instead be handled in a future
patch.


>
> But IMHO, I'd rather this series treat ATTR_MMIO as private MMIO and
> ATTR_MMIO|CC_SHARED as shared MMIO and that's the right and correct
> thing for the DMA API.
>

If you think the rest of the series is ready for upstream, could you
please ack it so it can be picked up for the next merge window? I'll
repost v8, rebased on top of the pKVM topic branch.

-aneesh

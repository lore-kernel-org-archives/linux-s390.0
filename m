Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92F209F3C;
	Wed, 11 Dec 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942579; cv=none; b=onCSej8QIajD1YSaHz8c9No2UgiU089NhW87fs9FDUDeJ5cpNMJLKVQwWeiptKP3CHTLXBiI1Wsfavf/pEUY2zVoLdcXwgGgftS5zwQO1/SWSXZ78lJttnW7J7TwZ8h9GLIsYRtq3D5H9u+4J5MMS3Kgh1r/3Ve3kda3V31AV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942579; c=relaxed/simple;
	bh=nOxaA7vXSE8dZXi+JIJESbM9FVIYY69Bj4Igv6fd1WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOV/lxTonm7+6IEZn2hYKlbZG5PXG2W/w4D/4y3Np2kCrW0zHyR0afEjUy6g90A7GSn+nIA5qHtUprxmGLHJCq29Ut/87r0h+L4KyAS+mW7T8VMSqasH9E063dves7ENraUeU7/FKB0wmWe+AKwFxpC7Voyv1HwUbuvkbEO2nXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216EE1007;
	Wed, 11 Dec 2024 10:43:25 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D3D3F720;
	Wed, 11 Dec 2024 10:42:55 -0800 (PST)
Message-ID: <9e8fea35-9ec7-412b-8ce2-712c44a48021@arm.com>
Date: Wed, 11 Dec 2024 18:42:53 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iommu: document missing def_domain_type return
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, will@kernel.org,
 gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 clegoate@redhat.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
 <20241209192403.107090-6-mjrosato@linux.ibm.com>
 <3db6f346-0cb4-41f7-b532-91bcb0265849@linux.intel.com>
 <0e80948b-7593-4b59-bb77-2f78f00ad2c3@linux.ibm.com>
 <e2c80012-bf7a-4420-a478-482aac4903b8@arm.com>
 <b6edaea3-3ccb-424b-bd84-762936b7448e@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <b6edaea3-3ccb-424b-bd84-762936b7448e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2024 10:06 pm, Matthew Rosato wrote:
> On 12/10/24 1:42 PM, Robin Murphy wrote:
>> On 10/12/2024 4:26 pm, Matthew Rosato wrote:
>>> On 12/9/24 9:57 PM, Baolu Lu wrote:
>>>> On 12/10/24 03:24, Matthew Rosato wrote:
>>>>> In addition to IOMMU_DOMAIN_DMA, def_domain_type can also return
>>>>> IOMMU_DOMAIN_DMA_FQ when applicable, else flush queues will never be
>>>>> used.
>>>>>
>>>>> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
>>>>> ---
>>>>>     include/linux/iommu.h | 1 +
>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>>> index 05279109c732..d0da1918d2de 100644
>>>>> --- a/include/linux/iommu.h
>>>>> +++ b/include/linux/iommu.h
>>>>> @@ -585,6 +585,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>>>>>      * @def_domain_type: device default domain type, return value:
>>>>>      *        - IOMMU_DOMAIN_IDENTITY: must use an identity domain
>>>>>      *        - IOMMU_DOMAIN_DMA: must use a dma domain
>>>>> + *              - IOMMU_DOMAIN_DMA_FQ: dma domain with batch invalidation
>>>>
>>>> In which case must an iommu driver return IOMMU_DOMAIN_DMA_FQ?
>>>>
>>>> The flush queue is a policy of "when and how to synchronize the IOTLB"
>>>> in dma-iommu.c. The iommu driver actually has no need to understand such
>>>> policy.
>>>
>>> If you look ahead to the next patch where I implement def_domain_type for s390, I found that if I only ever return IOMMU_DOMAIN_DMA from ops->def_domain_type then when go through iommu_dma_init_domain() we will never call iommu_dma_init_fq() regardless of IOMMU_CAP_DEFERRED_FLUSH because of the if (domain->type == IOMMU_DOMAIN_DMA_FQ) check.  So something isn't right here.
>>
>> Conceptually I don't think it ever makes sense for a driver to *require* a device to use deferred invalidation. Furthermore it's been the whole design for a while now that drivers should never see nor have to acknowledge IOMMU_DOMAIN_DMA_FQ, it's now just an internal type which exists largely for the sake of making the sysfs interface work really neatly. Also beware that a major reason for overriding iommu_def_domain_type with a paging domain is for untrusted devices, so massaging the result based on iommu_dma_strict is still not necessarily appropriate anyway.
>>
>> It appears the real underlying issue is that, like everyone else in the same situation, you're doing def_domain_type wrong. If and when you can't support IOMMU_DOMAIN_IDENTITY, the expectation is that you make __iommu_alloc_identity_domain() fail, such that if iommu_def_domain_type is then ever set to passthrough, iommu_group_alloc_default_domain() falls back to IOMMU_DOMAIN_DMA by itself, and the user gets told they did a silly thing.
> 
> OK, I almost see where this all fits to throw out def_domain_type for this series...  but looking at __iommu_alloc_identity_domain, the preferred approach is using a static identity domain which turns __iommu_alloc_identity_domain into a nofail case once you define the identity_domain:
>   
> if (ops->identity_domain)
> 	return ops->identity_domain;
> 
> So it seems to me to be an all-or-nothing thing, whereas what I'm trying to achieve is a device-based decision on whether the group is allowed to use that identity domain.  Which reminds me that this is ultimately why I ended up looking into def_domain_type in the first place.

Well, yeah, the static domain is very much designed for the typical case 
where it *is* unconditionally available. Simple options right now would 
be to have two sets of ops and select them per-instance, or if it's a 
system-wide property perhaps have non-const ops and populate/clear 
identity_domain as appropriate, or possibly even just stick with the 
ops->domain_alloc(IOMMU_DOMAIN_IDENTITY) path (perhaps eventually 
evolving into a specialised domain_alloc_identity op to also become 
per-device?). What we should not have is mechanisms like the 
def_domain_type hack where something claims to be available, but then 
some other thing tries to say "oh but you mustn't touch that".

Thanks,
Robin.

> If I need __iommu_alloc_identity_domain to fail, I guess what I'm looking to do boils down to something like...
> 
> if (ops->identity_domain) {
> 	if (!ops->allow_identity || ops->allow_identity(dev))
> 		return ops->identity_domain;
> 	else
> 		return ERR_PTR(-EOPNOTSUPP);
> }
> 
> 
> 
> 
> 
> 

Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B153C17;
	Tue, 10 Dec 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856159; cv=none; b=gNb86CT3fR/3ifb4JO18VV6Te6Tz4T8hh28TB4aL6WjT31F+qOKdmrwkxz0blf7GtaMQ7Oq8U/RND6601ZagA/r58DyHvxtIgmRzIIwH9hAyYxXi7bSrvWtS89T0g0B7vqOzbonbxIc0Kxh1Z5yxDd3CETTydhlLhdO5T/2N5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856159; c=relaxed/simple;
	bh=13n6v+T01Xi8fpqVO4hjM7iv1ONrRbl6Glb7UC/yXMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2TB6nEC3TSYbLRnC5AruoTZ3uyLv3VNsHrDpyd0BekkJYS/xS+kV49pA4X6UoeFXsMK85bztnPeSktpGpF8/QYe3eyMy5kwCDRkeH/7Lmc5gTXyy/vzuNjjegwBOSg2p0dJZeGWSPzjzKSb0omi58369X2LFXjHluqTW/wTkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 233CD1063;
	Tue, 10 Dec 2024 10:43:04 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26DEC3F58B;
	Tue, 10 Dec 2024 10:42:34 -0800 (PST)
Message-ID: <e2c80012-bf7a-4420-a478-482aac4903b8@arm.com>
Date: Tue, 10 Dec 2024 18:42:27 +0000
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
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0e80948b-7593-4b59-bb77-2f78f00ad2c3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2024 4:26 pm, Matthew Rosato wrote:
> On 12/9/24 9:57 PM, Baolu Lu wrote:
>> On 12/10/24 03:24, Matthew Rosato wrote:
>>> In addition to IOMMU_DOMAIN_DMA, def_domain_type can also return
>>> IOMMU_DOMAIN_DMA_FQ when applicable, else flush queues will never be
>>> used.
>>>
>>> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
>>> ---
>>>    include/linux/iommu.h | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 05279109c732..d0da1918d2de 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -585,6 +585,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>>>     * @def_domain_type: device default domain type, return value:
>>>     *        - IOMMU_DOMAIN_IDENTITY: must use an identity domain
>>>     *        - IOMMU_DOMAIN_DMA: must use a dma domain
>>> + *              - IOMMU_DOMAIN_DMA_FQ: dma domain with batch invalidation
>>
>> In which case must an iommu driver return IOMMU_DOMAIN_DMA_FQ?
>>
>> The flush queue is a policy of "when and how to synchronize the IOTLB"
>> in dma-iommu.c. The iommu driver actually has no need to understand such
>> policy.
> 
> If you look ahead to the next patch where I implement def_domain_type for s390, I found that if I only ever return IOMMU_DOMAIN_DMA from ops->def_domain_type then when go through iommu_dma_init_domain() we will never call iommu_dma_init_fq() regardless of IOMMU_CAP_DEFERRED_FLUSH because of the if (domain->type == IOMMU_DOMAIN_DMA_FQ) check.  So something isn't right here.

Conceptually I don't think it ever makes sense for a driver to *require* 
a device to use deferred invalidation. Furthermore it's been the whole 
design for a while now that drivers should never see nor have to 
acknowledge IOMMU_DOMAIN_DMA_FQ, it's now just an internal type which 
exists largely for the sake of making the sysfs interface work really 
neatly. Also beware that a major reason for overriding 
iommu_def_domain_type with a paging domain is for untrusted devices, so 
massaging the result based on iommu_dma_strict is still not necessarily 
appropriate anyway.

It appears the real underlying issue is that, like everyone else in the 
same situation, you're doing def_domain_type wrong. If and when you 
can't support IOMMU_DOMAIN_IDENTITY, the expectation is that you make 
__iommu_alloc_identity_domain() fail, such that if iommu_def_domain_type 
is then ever set to passthrough, iommu_group_alloc_default_domain() 
falls back to IOMMU_DOMAIN_DMA by itself, and the user gets told they 
did a silly thing.

What you see apple-dart doing is a hack around the old bus-based 
iommu_domain_alloc() API where there wasn't enough information at the 
right point to necessarily do the right thing.

Thanks,
Robin.

> It looks to me like the following is happening:
> 
> We first have the iommu_def_domain_type set in iommu_subsys_init or via one of the set_default routines, e.g.:
> 	if (!iommu_default_passthrough() && !iommu_dma_strict)
> 		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
> 
> But when we arrive at iommu_group_alloc_default_domain()...
> 
> if we have no ops->def_domain_type() defined we will call __iommu_group_alloc_default_domain using what is in iommu_def_domain_type, which could be IOMMU_DOMAIN_DMA, IOMMU_DOMAIN_DMA_FQ or IOMMU_DOMAIN_IDENTITY based on strict/passthrough settings.  Testing an s390 scenario today without this series applied, we will call __iommu_group_alloc_default_domain with IOMMU_DOMAIN_DMA_FQ, as long as iommu.strict/passthrough is not specified, so then later in dma-iommu:iommu_dma_init_domain() we can use FQ based on IOMMU_CAP_DEFERRED_FLUSH.
> 
> but once we add ops->def_domain_type() then we end up calling iommu_group_alloc_default_domain() with a req_type == the return value from ops->def_domain_type(), which by the current definition can only be IOMMU_DOMAIN_DMA or IOMMU_DOMAIN_IDENTITY.  We will then call __iommu_group_alloc_default_domain with that req_type; so without this patch + the DMA_FQ path in patch 6 we would always end up allocating IOMMU_DOMAIN_DMA instead of IOMMU_DOMAIN_DMA_FQ by default, so when we arrive at dma:iommu_dma_init_domain() we won't check for IOMMU_CAP_DEFERRED_FLUSH because of the type.
> 
> So unless I'm missing something I think either we have to
> 1) be more flexible in what ops->default_domain_type() is allowed to return as this patch does
> or
> 2) iommu core needs to look at the return from ops->default_domain_type() and decide whether it's OK to convert IOMMU_DOMAIN_DMA->IOMMU_DOMAIN_DMA_FQ based on strict setting.  This removes the decision from the individual drivers and dma-iommu can later decide whether or not to use it or not based on IOMMU_CAP_DEFERRED_FLUSH?  But would also affect other users of def_domain_type() today that perhaps did not want DMA_FQ?  Unsure.  What I mean is something like (untested):
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6bdede4177ff..275daa7f819d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1744,9 +1744,11 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
>                   */
>                  type = ops->default_domain->type;
>          } else {
> -               if (ops->def_domain_type)
> +               if (ops->def_domain_type) {
>                          type = ops->def_domain_type(dev);
> -               else
> +                       if (type == IOMMU_DOMAIN_DMA && !iommu_dma_strict)
> +                               type = IOMMU_DOMAIN_DMA_FQ;
> +               } else
>                          return cur_type;
>          }
>          if (!type || cur_type == type)
> 
> 

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgGIK6V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 06:58:21 -0400
Subject: Re: [PATCH v5 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
 <1594283959-13742-3-git-send-email-pmorel@linux.ibm.com>
 <20200709105733.6d68fa53.cohuck@redhat.com>
 <20200709115553.2dde6ab1.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <12b1ca5c-fc03-18c7-bdca-cedabc5f1e1d@linux.ibm.com>
Date: Thu, 9 Jul 2020 12:58:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200709115553.2dde6ab1.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-07-09 11:55, Halil Pasic wrote:
> On Thu, 9 Jul 2020 10:57:33 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Thu,  9 Jul 2020 10:39:19 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> If protected virtualization is active on s390, the virtio queues are
>>> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
>>> negotiated. Use the new arch_validate_virtio_features() interface to
>>> fail probe if that's not the case, preventing a host error on access
>>> attempt
> 
> Punctuation at the end?
> 
> Also 'that's not the case' refers to the negation
> 'VIRTIO_F_IOMMU_PLATFORM has been negotiated',
> arch_validate_virtio_features() is however part of
> virtio_finalize_features(), which is in turn part of the feature
> negotiation. But that is details. I'm fine with keeping the message as
> is.
> 
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   arch/s390/mm/init.c | 27 +++++++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index 6dc7c3b60ef6..b8e6f90117da 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -45,6 +45,7 @@
>>>   #include <asm/kasan.h>
>>>   #include <asm/dma-mapping.h>
>>>   #include <asm/uv.h>
>>> +#include <linux/virtio_config.h>
>>>   
>>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>>   
>>> @@ -161,6 +162,32 @@ bool force_dma_unencrypted(struct device *dev)
>>>   	return is_prot_virt_guest();
>>>   }
>>>   
>>> +/*
>>> + * arch_validate_virtio_features
>>> + * @dev: the VIRTIO device being added
>>> + *
>>> + * Return an error if required features are missing on a guest running
>>> + * with protected virtualization.
>>> + */
>>> +int arch_validate_virtio_features(struct virtio_device *dev)
>>> +{
>>> +	if (!is_prot_virt_guest())
>>> +		return 0;
>>> +
>>> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>>> +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
>>
>> I'd probably use "legacy virtio not supported with protected
>> virtualization".
>>
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>> +		dev_warn(&dev->dev,
>>> +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>>
>> "support for limited memory access required for protected
>> virtualization"
>>
>> ?
>>
>> Mentioning the feature flag is shorter in both cases, though.
> 
> I liked the messages in v4. Why did we change those? Did somebody
> complain?
> 
> I prefer the old ones, but it any case:
> 
> Acked-by: Halil Pasic <pasic@linux.ibm.com>

Thanks,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen

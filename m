Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgHSIug (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 04:50:36 -0400
Subject: Re: [PATCH v8 1/2] virtio: let arch validate VIRTIO features
References: <1597762711-3550-1-git-send-email-pmorel@linux.ibm.com>
 <1597762711-3550-2-git-send-email-pmorel@linux.ibm.com>
 <20200818191910.1fc300f2.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <64acd55a-8a22-4b84-0f9e-e13196c1520d@linux.ibm.com>
Date: Wed, 19 Aug 2020 10:50:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200818191910.1fc300f2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 2020-08-18 19:19, Cornelia Huck wrote:
> On Tue, 18 Aug 2020 16:58:30 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
...
>> +config ARCH_HAS_RESTRICTED_MEMORY_ACCESS
>> +	bool
>> +	help
>> +	  This option is selected by any architecture enforcing
>> +	  VIRTIO_F_IOMMU_PLATFORM
> 
> This option is only for a very specific case of "restricted memory
> access", namely the kind that requires IOMMU_PLATFORM for virtio
> devices. ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS? Or is this intended
> to cover cases outside of virtio as well?

AFAIK we did not identify other restrictions so adding VIRTIO in the 
name should be the best thing to do.

If new restrictions appear they also may be orthogonal.

I will change to ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS if no one 
complains.

> 
>> +
>>   menuconfig VIRTIO_MENU
>>   	bool "Virtio drivers"
>>   	default y
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index a977e32a88f2..1471db7d6510 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -176,6 +176,10 @@ int virtio_finalize_features(struct virtio_device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = arch_has_restricted_memory_access(dev);
>> +	if (ret)
>> +		return ret;
> 
> Hm, I'd rather have expected something like
> 
> if (arch_has_restricted_memory_access(dev)) {

may be also change the callback name to
arch_has_restricted_virtio_memory_access() ?

> 	// enforce VERSION_1 and IOMMU_PLATFORM
> }
> 
> Otherwise, you're duplicating the checks in the individual architecture
> callbacks again.

Yes, I agree and go back this way.

> 
> [Not sure whether the device argument would be needed here; are there
> architectures where we'd only require IOMMU_PLATFORM for a subset of
> virtio devices?]

I don't think so and since we do the checks locally, we do not need the 
device argument anymore.


Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgHUNIt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Aug 2020 09:08:49 -0400
Subject: Re: [PATCH v9 1/2] virtio: let arch advertise guest's memory access
 restrictions
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
 <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
 <20200821135906.1c6bede3.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <91c83bba-9a75-4ed4-b682-fcdce26edd54@linux.ibm.com>
Date: Fri, 21 Aug 2020 15:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200821135906.1c6bede3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 2020-08-21 13:59, Cornelia Huck wrote:
> On Wed, 19 Aug 2020 18:23:17 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> An architecture may restrict host access to guest memory.
> 
> "e.g. IBM s390 Secure Execution or AMD SEV"
> 
> Just to make clearer what you are referring to?

yes, thanks

> 
>>
>> Provide a new Kconfig entry the architecture can select,
>> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
>> the arch_has_restricted_virtio_memory_access callback to advertise
> 
> s/advertise/advertise to/

OK

> 
>> VIRTIO common code when the architecture restricts memory access
>> from the host.
> 
> "The common code can then fail the probe for any device where
> VIRTIO_F_IOMMU_PLATFORM is required, but not set."
> 
> ?

Yes, better thanks

> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/virtio/Kconfig        |  6 ++++++
>>   drivers/virtio/virtio.c       | 15 +++++++++++++++
>>   include/linux/virtio_config.h |  9 +++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 5809e5f5b157..509f3b4d8ba1 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -6,6 +6,12 @@ config VIRTIO
>>   	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>>   	  or CONFIG_S390_GUEST.
>>   
>> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>> +	bool
>> +	help
>> +	  This option is selected by any architecture enforcing
>> +	  VIRTIO_F_IOMMU_PLATFORM
> 
> "This option is selected if the architecture may need to enforce
> VIRTIO_F_IOMMU_PLATFORM."
> 
> ?

yes, better thanks

> 
>> +
>>   menuconfig VIRTIO_MENU
>>   	bool "Virtio drivers"
>>   	default y
> 
> (...)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

I will make the rewordings.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

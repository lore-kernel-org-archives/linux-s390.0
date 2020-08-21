Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
 <1597854198-2871-3-git-send-email-pmorel@linux.ibm.com>
 <20200821140510.3849410c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <19f742f8-8cc2-8f5a-90b0-c33e7b6a45b9@linux.ibm.com>
Date: Fri, 21 Aug 2020 15:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200821140510.3849410c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 2020-08-21 14:05, Cornelia Huck wrote:
> On Wed, 19 Aug 2020 18:23:18 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> If protected virtualization is active on s390, VIRTIO has retricted
> 
> s/retricted/only restricted/
> 
>> access to the guest memory.
>> Define CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS and export
>> arch_has_restricted_virtio_memory_access to advertize VIRTIO if that's
>> the case, preventing a host error on access attempt.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/Kconfig   |  1 +
>>   arch/s390/mm/init.c | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
> 
> (...)
> 
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 6dc7c3b60ef6..8febd73ed6ca 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -45,6 +45,7 @@
>>   #include <asm/kasan.h>
>>   #include <asm/dma-mapping.h>
>>   #include <asm/uv.h>
>> +#include <linux/virtio_config.h>
> 
> I don't think you need this include anymore.

right,
> 
>>   
>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>   
> 
> (...)
> 
> With the nit fixed,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

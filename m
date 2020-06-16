Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
 <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
 <20200616115202.0285aa08.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ef235cc9-9d4b-1247-c01a-9dd1c63f437c@linux.ibm.com>
Date: Tue, 16 Jun 2020 12:52:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200616115202.0285aa08.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, David Gibson <david@gibson.dropbear.id.au>, Ram Pai <linuxram@us.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 2020-06-16 11:52, Halil Pasic wrote:
> On Mon, 15 Jun 2020 14:39:24 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> I find the subject (commit short) sub optimal. The 'arch' is already
> accepting devices 'without IOMMU feature'. What you are introducing is
> the ability to reject.
> 
>> An architecture protecting the guest memory against unauthorized host
>> access may want to enforce VIRTIO I/O device protection through the
>> use of VIRTIO_F_IOMMU_PLATFORM.
>>
>> Let's give a chance to the architecture to accept or not devices
>> without VIRTIO_F_IOMMU_PLATFORM.
>>
> 
> I don't particularly like the commit message. In general, I believe
> using access_platform instead of iommu_platform would really benefit us.

IOMMU_PLATFORM is used overall in Linux, and I did not find any 
occurrence for ACCESS_PLATFORM.


> 
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/mm/init.c     | 6 ++++++
>>   drivers/virtio/virtio.c | 9 +++++++++
>>   include/linux/virtio.h  | 2 ++
>>   3 files changed, 17 insertions(+)
>>
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 87b2d024e75a..3f04ad09650f 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -46,6 +46,7 @@
>>   #include <asm/kasan.h>
>>   #include <asm/dma-mapping.h>
>>   #include <asm/uv.h>
>> +#include <linux/virtio.h>
> 
> arch/s390/mm/init.c including virtio.h looks a bit strange to me, but
> if Heiko and Vasily don't mind, neither do I.

Do we have a better place to install the hook?
I though that since it is related to memory management and that, since 
force_dma_unencrypted already is there, it would be a good place.

However, kvm-s390 is another candidate.

> 
>>   
>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>   
>> @@ -162,6 +163,11 @@ bool force_dma_unencrypted(struct device *dev)
>>   	return is_prot_virt_guest();
>>   }
>>   
>> +int arch_needs_iommu_platform(struct virtio_device *dev)
> 
> Maybe prefixing the name with virtio_ would help provide the
> proper context.

The virtio_dev makes it obvious and from the virtio side it should be 
obvious that the arch is responsible for this.

However if nobody has something against I change it.

> 
>> +{
>> +	return is_prot_virt_guest();
>> +}
>> +
>>   /* protected virtualization */
>>   static void pv_init(void)
>>   {
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index a977e32a88f2..30091089bee8 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -167,6 +167,11 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>>   }
>>   EXPORT_SYMBOL_GPL(virtio_add_status);
>>   
>> +int __weak arch_needs_iommu_platform(struct virtio_device *dev)
>> +{
>> +	return 0;
>> +}
>> +
> 
> Adding some people that could be interested in overriding this as well
> to the cc list.

Thanks,

> 
>>   int virtio_finalize_features(struct virtio_device *dev)
>>   {
>>   	int ret = dev->config->finalize_features(dev);
>> @@ -179,6 +184,10 @@ int virtio_finalize_features(struct virtio_device *dev)
>>   	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>   		return 0;
>>   
>> +	if (arch_needs_iommu_platform(dev) &&
>> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM))
>> +		return -EIO;
>> +
> 
> Why EIO?

Because I/O can not occur correctly?
I am open to suggestions.

> 
> Overall, I think it is a good idea to have something that is going to
> protect us from this scenario.
> 

It would clearly be a good thing that trusted hypervizors like QEMU 
forbid this scenario however should we let the door open?

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3228 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbgFPHf2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 03:35:28 -0400
Subject: Re: [PATCH v2 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
References: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
 <1592224764-1258-2-git-send-email-pmorel@linux.ibm.com>
 <74b6cf8a-d5a6-e0bf-f1c1-e453af133614@de.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <a93bf169-55ca-2a77-f9a5-b27bf18176e2@linux.ibm.com>
Date: Tue, 16 Jun 2020 09:35:19 +0200
MIME-Version: 1.0
In-Reply-To: <74b6cf8a-d5a6-e0bf-f1c1-e453af133614@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org



On 2020-06-16 08:55, Christian Borntraeger wrote:
> 
> 
> On 15.06.20 14:39, Pierre Morel wrote:
>> An architecture protecting the guest memory against unauthorized host
>> access may want to enforce VIRTIO I/O device protection through the
>> use of VIRTIO_F_IOMMU_PLATFORM.
>>
>> Let's give a chance to the architecture to accept or not devices
>> without VIRTIO_F_IOMMU_PLATFORM.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks,

> 
> Shouldnt we maybe add a pr_warn if that happens to help the admins to understand what is going on?
> 
> 

Yes, Connie asked for it too, good that you remind it to me, I add it.

Thanks,
Pierre

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
>>   
>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>   
>> @@ -162,6 +163,11 @@ bool force_dma_unencrypted(struct device *dev)
>>   	return is_prot_virt_guest();
>>   }
>>   
>> +int arch_needs_iommu_platform(struct virtio_device *dev)
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
>>   	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>>   	status = dev->config->get_status(dev);
>>   	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index a493eac08393..2c46b310c38c 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -195,4 +195,6 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>>   #define module_virtio_driver(__virtio_driver) \
>>   	module_driver(__virtio_driver, register_virtio_driver, \
>>   			unregister_virtio_driver)
>> +
>> +int arch_needs_iommu_platform(struct virtio_device *dev);
>>   #endif /* _LINUX_VIRTIO_H */
>>

-- 
Pierre Morel
IBM Lab Boeblingen

From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] vfio: ap: register IOMMU VFIO notifier
Date: Thu, 28 Feb 2019 09:48:39 +0100
Message-ID: <f13769d5-26a4-c1fa-0858-e4a1acef7bb9@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-5-git-send-email-pmorel@linux.ibm.com>
 <d90f4746-887f-2d9c-df37-c834f22e85fd@de.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d90f4746-887f-2d9c-df37-c834f22e85fd@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 28/02/2019 09:23, Christian Borntraeger wrote:
> On 22.02.2019 16:29, Pierre Morel wrote:
>> To be able to use the VFIO interface to facilitate the
>> mediated device memory pining/unpining we need to register
>> a notifier for IOMMU.
> 
> You might want to add that while we start to pin one guest page for the
> interrupt indicator byte in the next patch, this is still ok with ballooning
> as this page will never be used by the guest virtio-balloon driver. So the
> pinned page will never be freed. And even a broken guest does so, that would
> not impact the host as the original page is still in control by vfio.
> 

Thanks, I ll do.

Regards,
Pierre

>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 53 ++++++++++++++++++++++++++++++++---
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   2 files changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 172d6eb..1b5130a 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -748,6 +748,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>>   };
>>   
>>   /**
>> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>> + *
>> + * @nb: The notifier block
>> + * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)
>> + * @data: the specific unmap structure for vfio_iommu_type1
>> + *
>> + * Unpins the guest IOVA. (The NIB guest address we pinned before).
>> + * Return NOTIFY_OK after unpining on a UNMAP request.
>> + * otherwise, returns NOTIFY_DONE .
>> + */
>> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>> +				       unsigned long action, void *data)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
>> +
>> +	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
>> +		struct vfio_iommu_type1_dma_unmap *unmap = data;
>> +		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
>> +
>> +		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
>> +		return NOTIFY_OK;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +
>> +/**
>>    * vfio_ap_mdev_set_kvm
>>    *
>>    * @matrix_mdev: a mediated matrix device
>> @@ -846,12 +876,25 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   
>>   	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>   				     &events, &matrix_mdev->group_notifier);
>> -	if (ret) {
>> -		module_put(THIS_MODULE);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto err_group;
>> +
>> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> +
>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				     &events, &matrix_mdev->iommu_notifier);
>> +	if (ret)
>> +		goto err_iommu;
>>   
>>   	return 0;
>> +
>> +err_iommu:
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +				 &matrix_mdev->group_notifier);
>> +err_group:
>> +	module_put(THIS_MODULE);
>> +	return ret;
>>   }
>>   
>>   static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> @@ -864,6 +907,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>   	vfio_ap_mdev_reset_queues(mdev);
>>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>   				 &matrix_mdev->group_notifier);
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				 &matrix_mdev->iommu_notifier);
>>   	matrix_mdev->kvm = NULL;
>>   	module_put(THIS_MODULE);
>>   }
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 2760178..e535735 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -81,8 +81,10 @@ struct ap_matrix_mdev {
>>   	struct list_head node;
>>   	struct ap_matrix matrix;
>>   	struct notifier_block group_notifier;
>> +	struct notifier_block iommu_notifier;
>>   	struct kvm *kvm;
>>   	struct list_head qlist;
>> +	struct mdev_device *mdev;
>>   };
>>   
>>   extern int vfio_ap_mdev_register(void);
>>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

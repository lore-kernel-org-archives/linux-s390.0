From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 4/7] vfio: ap: register IOMMU VFIO notifier
Date: Thu, 28 Mar 2019 16:46:53 -0400
Message-ID: <1731fb82-7877-9018-d12e-fd0e2406ac19@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-5-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553265828-27823-5-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 3/22/19 10:43 AM, Pierre Morel wrote:
> To be able to use the VFIO interface to facilitate the
> mediated device memory pinning/unpinning we need to register
> a notifier for IOMMU.
> 
> While we will start to pin one guest page for the interrupt indicator
> byte, this is still ok with ballooning as this page will never be
> used by the guest virtio-balloon driver.
> So the pinned page will never be freed. And even a broken guest does
> so, that would not impact the host as the original page is still
> in control by vfio.

I apologize, but I do not understand what you are saying in the second
sentence of the paragraph above. Why will the pinned page never be 
freed? I understand that the pinned page is under the control of vfio
until it is freed, but have no idea what you mean by "and even a broken
guest does so"? A broken guest does what? Can you please reword this so
it makes more sense?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 38 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index bdb36e0..3478499 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -787,6 +787,35 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   	NULL
>   };
>   
> +/**
> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
> + *
> + * @nb: The notifier block
> + * @action: Action to be taken
> + * @data: data associated with the request
> + *
> + * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
> + * pinned before). Other requests are ignored.
> + *
> + */
> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
> +

I don't understand why we registered this notifier. I may be wrong, but
AFAIU, this notifier will be invoked only when the VFIO_IOMMU_UNMAP_DMA
ioctl is called from userspace. I did an experiment and inserted some
printf's to see if this ever gets called and verified it does not. Maybe
you have a good reason of which I'm not aware. Can you enlighten me
here?

> +	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
> +		struct vfio_iommu_type1_dma_unmap *unmap = data;
> +		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
> +
> +		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   				       unsigned long action, void *data)
>   {
> @@ -897,6 +926,13 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   		goto free_notifier;
>   	}
>   
> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				     &events, &matrix_mdev->iommu_notifier);
> +	if (ret)
> +		goto free_notifier;
> +
>   	ret = vfio_ap_mdev_set_kvm(matrix_mdev);
>   	if (!ret)
>   		goto unlock;
> @@ -917,6 +953,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   
>   	mutex_lock(&matrix_dev->lock);
>   	vfio_ap_mdev_unset_kvm(matrix_mdev);
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &matrix_mdev->iommu_notifier);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	module_put(THIS_MODULE);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 3e6940c..4a287c8 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -82,9 +82,11 @@ struct ap_matrix_mdev {
>   	struct list_head node;
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
> +	struct notifier_block iommu_notifier;
>   	struct kvm *kvm;
>   	struct kvm_s390_module_hook pqap_hook;
>   	struct list_head qlist;
> +	struct mdev_device *mdev;
>   };
>   
>   extern int vfio_ap_mdev_register(void);
> 

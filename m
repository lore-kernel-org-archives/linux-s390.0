From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
Date: Tue, 26 Feb 2019 13:23:15 -0500
Message-ID: <d8eead83-6d93-4213-c702-c7e684142ff2@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/22/19 10:29 AM, Pierre Morel wrote:
> We register the AP PQAP instruction hook during the open
> of the mediated device. And unregister it on release.
> 
> In the AP PQAP instruction hook, if we receive a demand to
> enable IRQs,
> - we retrieve the vfio_ap_queue based on the APQN we receive
>    in REG1,
> - we retrieve the page of the guest address, (NIB), from
>    register REG2
> - we the mediated device to use the VFIO pinning infratrsucture
>    to pin the page of the guest address,
> - we retrieve the pointer to KVM to register the guest ISC
>    and retrieve the host ISC
> - finaly we activate GISA
> 
> If we receive a demand to disable IRQs,
> - we deactivate GISA
> - unregister from the GIB
> - unping the NIB
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |   1 +
>   drivers/s390/crypto/ap_bus.h          |   1 +
>   drivers/s390/crypto/vfio_ap_ops.c     | 199 +++++++++++++++++++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_private.h |   1 +
>   4 files changed, 199 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 49cc8b0..5f3bb8c 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -720,6 +720,7 @@ struct kvm_s390_cpu_model {
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
>   	int (*pqap_hook)(struct kvm_vcpu *vcpu);
> +	void *vfio_private;
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
> index bfc66e4..323f2aa 100644
> --- a/drivers/s390/crypto/ap_bus.h
> +++ b/drivers/s390/crypto/ap_bus.h
> @@ -43,6 +43,7 @@ static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
>   #define AP_RESPONSE_BUSY		0x05
>   #define AP_RESPONSE_INVALID_ADDRESS	0x06
>   #define AP_RESPONSE_OTHERWISE_CHANGED	0x07
> +#define AP_RESPONSE_INVALID_GISA	0x08
>   #define AP_RESPONSE_Q_FULL		0x10
>   #define AP_RESPONSE_NO_PENDING_REPLY	0x10
>   #define AP_RESPONSE_INDEX_TOO_BIG	0x11
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 1b5130a..0196065 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -43,7 +43,7 @@ struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
>   	return NULL;
>   }
>   
> -static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
> +int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>   {
>   	struct ap_queue_status status;
>   	int retry = 20;
> @@ -75,6 +75,27 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>   	return -EBUSY;
>   }
>   
> +/**
> + * vfio_ap_free_irq:
> + * @q: The vfio_ap_queue
> + *
> + * Unpin the guest NIB
> + * Unregister the ISC from the GIB alert
> + * Clear the vfio_ap_queue intern fields
> + */
> +static void vfio_ap_free_irq(struct vfio_ap_queue *q)
> +{
> +	if (!q)
> +		return;
> +	if (q->g_pfn)
> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->g_pfn, 1);
> +	if (q->isc)
> +		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->isc);
> +	q->nib = 0;
> +	q->isc = 0;
> +	q->g_pfn = 0;
> +}
> +
>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>   				struct ap_matrix *matrix)
>   {
> @@ -97,6 +118,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   	}
>   
>   	INIT_LIST_HEAD(&matrix_mdev->qlist);
> +	matrix_mdev->mdev = mdev;
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>   	mdev_set_drvdata(mdev, matrix_mdev);
>   	mutex_lock(&matrix_dev->lock);
> @@ -109,10 +131,16 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>   {
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_queue *q, *qtmp;
>   
>   	if (matrix_mdev->kvm)
>   		return -EBUSY;
>   
> +	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
> +		q->matrix_mdev = NULL;
> +		vfio_ap_mdev_reset_queue(q);
> +		list_move(&q->list, &matrix_dev->free_list);
> +	}
>   	mutex_lock(&matrix_dev->lock);
>   	list_del(&matrix_mdev->node);
>   	mutex_unlock(&matrix_dev->lock);
> @@ -748,6 +776,161 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   };
>   
>   /**
> + * vfio_ap_clrirq: Disable Interruption for a APQN
> + *
> + * @dev: the device associated with the ap_queue
> + * @q:   the vfio_ap_queue holding AQIC parameters
> + *
> + * Issue the host side PQAP/AQIC
> + * On success: unpin the NIB saved in *q and unregister from GIB
> + * interface
> + *
> + * Return the ap_queue_status returned by the ap_aqic()
> + */
> +static struct ap_queue_status vfio_ap_clrirq(struct vfio_ap_queue *q)
> +{
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct ap_queue_status status;
> +
> +	status = ap_aqic(q->apqn, aqic_gisa, NULL);
> +	if (!status.response_code)
> +		vfio_ap_free_irq(q);
> +
> +	return status;
> +}
> +
> +/**
> + * vfio_ap_setirq: Enable Interruption for a APQN
> + *
> + * @dev: the device associated with the ap_queue
> + * @q:   the vfio_ap_queue holding AQIC parameters
> + *
> + * Pin the NIB saved in *q
> + * Register the guest ISC to GIB interface and retrieve the
> + * host ISC to issue the host side PQAP/AQIC
> + *
> + * Response.status may be set to following Response Code in case of error:
> + * - AP_RESPONSE_INVALID_ADDRESS: vfio_pin_pages failed
> + * - AP_RESPONSE_OTHERWISE_CHANGED: Hypervizor GISA internal error
> + *
> + * Otherwise return the ap_queue_status returned by the ap_aqic()
> + */
> +static struct ap_queue_status vfio_ap_setirq(struct vfio_ap_queue *q)
> +{
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct ap_queue_status status = {};
> +	struct kvm_s390_gisa *gisa;
> +	struct kvm *kvm;
> +	unsigned long g_pfn, h_nib, h_pfn;
> +	int ret;
> +
> +	kvm = q->matrix_mdev->kvm;
> +	gisa = kvm->arch.gisa_int.origin;
> +
> +	g_pfn = q->nib >> PAGE_SHIFT;
> +	ret = vfio_pin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1,
> +			     IOMMU_READ | IOMMU_WRITE, &h_pfn);
> +	switch (ret) {
> +	case 1:
> +		break;
> +	case -EINVAL:
> +	case -E2BIG:
> +		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
> +		/* Fallthrough */
> +	default:
> +		return status;
> +	}
> +
> +	h_nib = (h_pfn << PAGE_SHIFT) | (q->nib & ~PAGE_MASK);
> +	aqic_gisa.gisc = q->isc;
> +	aqic_gisa.isc = kvm_s390_gisc_register(kvm, q->isc);
> +	aqic_gisa.ir = 1;
> +	aqic_gisa.gisa = gisa->next_alert >> 4;
> +
> +	status = ap_aqic(q->apqn, aqic_gisa, (void *)h_nib);
> +	switch (status.response_code) {
> +	case AP_RESPONSE_NORMAL:
> +		if (q->g_pfn)
> +			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> +					 &q->g_pfn, 1);
> +		q->g_pfn = g_pfn;
> +		break;
> +	case AP_RESPONSE_OTHERWISE_CHANGED:
> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1);
> +		break;
> +	case AP_RESPONSE_INVALID_GISA:
> +		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
> +	default:	/* Fall Through */
> +		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> +			status.response_code);
> +		vfio_ap_free_irq(q);
> +		break;
> +	}
> +
> +	return status;
> +}
> +
> +/**
> + * handle_pqap: PQAP instruction callback
> + *
> + * @vcpu: The vcpu on which we received the PQAP instruction
> + *
> + * Get the general register contents to initialize internal variables.
> + * REG[0]: APQN
> + * REG[1]: IR and ISC
> + * REG[2]: NIB
> + *
> + * Response.status may be set to following Response Code:
> + * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
> + * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
> + * - AP_RESPONSE_NORMAL (0) : in case of successs
> + *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
> + *
> + * Return 0 if we could handle the request inside KVM.
> + * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)

Change this function name to handle_pqap_aqic

> +{
> +	uint64_t status;
> +	uint16_t apqn;
> +	struct vfio_ap_queue *q;
> +	struct ap_queue_status qstatus = {};
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	/* If we do not use the AIV facility just go to userland */
> +	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
> +		return -EOPNOTSUPP;
> +
> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> +	matrix_mdev = vcpu->kvm->arch.crypto.vfio_private;
> +	if (!matrix_mdev)
> +		return -EOPNOTSUPP;
> +	q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
> +	if (!q) {
> +		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
> +		goto out;
> +	}
> +
> +	status = vcpu->run->s.regs.gprs[1];
> +
> +	/* If IR bit(16) is set we enable the interrupt */
> +	if ((status >> (63 - 16)) & 0x01) {
> +		q->isc = status & 0x07;
> +		q->nib = vcpu->run->s.regs.gprs[2];
> +		qstatus = vfio_ap_setirq(q);
> +		if (qstatus.response_code) {
> +			q->nib = 0;
> +			q->isc = 0;
> +		}
> +	} else
> +		qstatus = vfio_ap_clrirq(q);
> +
> +out:
> +	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
> +	return 0;
> +}

Add this function:

static int handle_pqap(struct kvm_vcpu *vcpu)
{
	int ret;
	uint8_t fc;

	fc = vcpu->run->s.regs.gprs[0] >> 24;
	switch (fc) {
	case 0x03:
		ret = handle_pqap_aqic(vcpu);
		break;
	default:
		ret = -EOPNOTSUPP;
		break;
	}

	return ret;
}

> +
> + /*
>    * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>    *
>    * @nb: The notifier block
> @@ -767,9 +950,10 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>   
>   	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
>   		struct vfio_iommu_type1_dma_unmap *unmap = data;
> -		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
> +		unsigned long pfn = unmap->iova >> PAGE_SHIFT;
>   
> -		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
> +		if (matrix_mdev->mdev)
> +			vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &pfn, 1);
>   		return NOTIFY_OK;
>   	}
>   
> @@ -879,6 +1063,11 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   	if (ret)
>   		goto err_group;
>   
> +	if (!matrix_mdev->kvm) {
> +		ret = -ENODEV;
> +		goto err_iommu;
> +	}
> +
>   	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>   	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>   
> @@ -887,6 +1076,8 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   	if (ret)
>   		goto err_iommu;
>   
> +	matrix_mdev->kvm->arch.crypto.pqap_hook = handle_pqap;
> +	matrix_mdev->kvm->arch.crypto.vfio_private = matrix_mdev;

I do not see this used anywhere, why do we need it?

>   	return 0;
>   
>   err_iommu:
> @@ -905,6 +1096,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>   
>   	vfio_ap_mdev_reset_queues(mdev);
> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +	matrix_mdev->kvm->arch.crypto.vfio_private = NULL;

Ditto

>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index e535735..e2fd2c0 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -94,6 +94,7 @@ struct vfio_ap_queue {
>   	struct list_head list;
>   	struct ap_matrix_mdev *matrix_mdev;
>   	unsigned long nib;
> +	unsigned long g_pfn;

Can't this be calculated from the nib?

>   	int	apqn;
>   	unsigned char isc;
>   };
> 

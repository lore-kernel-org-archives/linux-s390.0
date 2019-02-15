From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 7/9] s390: ap: implement PAPQ AQIC interception in
 kernel
Date: Fri, 15 Feb 2019 18:11:20 -0500
Message-ID: <77e18463-67e7-322f-db61-c0a0ecbc4fd9@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/14/19 8:51 AM, Pierre Morel wrote:
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
>   drivers/s390/crypto/ap_bus.h          |   1 +
>   drivers/s390/crypto/vfio_ap_ops.c     | 191 +++++++++++++++++++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_private.h |   2 +
>   3 files changed, 191 insertions(+), 3 deletions(-)
> 
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
> index 6eddc2c..5664cf3 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -77,6 +77,28 @@ static void vfio_ap_put_queue(struct vfio_ap_queue *q)
>   	q->dev = NULL;
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
> +	unsigned long pfn = q->nib >> PAGE_SHIFT;
> +
> +	if (!q)
> +		return;
> +	if (q->nib)
> +		vfio_unpin_pages(mdev_dev(q->matrix->mdev), &pfn, 1);
> +	if (q->isc)
> +		kvm_s390_gisc_unregister(q->matrix->kvm, q->isc);
> +	q->nib = 0;
> +	q->isc = 0;
> +}
> +
>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>   				struct ap_matrix *matrix)
>   {
> @@ -98,6 +120,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   		return -ENOMEM;
>   	}
>   
> +	matrix_mdev->mdev = mdev;
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>   	mdev_set_drvdata(mdev, matrix_mdev);
>   	mutex_lock(&matrix_dev->lock);
> @@ -781,6 +804,156 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
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
> +	kvm = q->matrix->kvm;
> +	gisa = kvm->arch.gisa_int.origin;
> +
> +	g_pfn = q->nib >> PAGE_SHIFT;
> +	ret = vfio_pin_pages(mdev_dev(q->matrix->mdev), &g_pfn, 1,
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
> +	if (status.response_code == AP_RESPONSE_INVALID_GISA) {
> +		status.response_code = AP_RESPONSE_OTHERWISE_CHANGED;
> +		pr_warn("vfio_ap: apqn %02x.%04x: AP_RESPONSE_INVALID_GISA\n",
> +			(q->apqn >> 8) & 0xff, q->apqn & 0xff);
> +	}
> +
> +	if (status.response_code)
> +		vfio_ap_free_irq(q);
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

This function be nothing more than a switch statement for the
function code sent with the PQAP instruction. Each case should
be a call to a appropriate PQAP function handler. This will make
it much easier to add additional handlers for the 6 other
PQAP functions if necessary at some time down the road.

> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{	int ret.
	uint8_t fc;

	fc = vcpu->run->s.regs.gprs[0] >> 24;
	switch(fc) {
	case 0x03:
		ret = handle_pqap_aqic(vcpu);
	default:
		ret = -EOPNOTSUPP;
	}

	return ret;
}

static int handle_pqap_aqic(struct kvm_vcpu *vcpu) {
> +	uint64_t status;
> +	uint16_t apqn;
	struct device *qdev;
> +	struct vfio_ap_queue *q;
> +	struct ap_queue_status qstatus = {};
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	/* If we do not use the AIV facility just go to userland */
> +	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
> +		return -EOPNOTSUPP;
> +
> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> +	q = vfio_ap_get_queue(apqn);

Replace with:
	qdev = vfio_ap_get_queue_dev(apqn);

> +	if (!q) {

Replace with:
	if (!qdev)

> +		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
> +		goto out;
> +	}
> +
> +	/* Check if the queue is associated with a guest matrix */

Add this:
	q = dev_get_drvdata(qdev);

> +	matrix_mdev = q->matrix;
> +	if (!matrix_mdev || !matrix_mdev->kvm) {
> +		qstatus.response_code = AP_RESPONSE_DECONFIGURED

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
> +	vfio_ap_put_queue(q);

Replace with:
	put_device(qdev);

Can we just do a put_device(qdev) right after we get it since we only
need it to get the drvdata, or do we need to wait until the other work
is done?

> +	return 0;
> +}
> +
> + /*
>    * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>    *
>    * @nb: The notifier block
> @@ -802,7 +975,9 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>   		struct vfio_iommu_type1_dma_unmap *unmap = data;
>   		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
>   
> -		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
> +		if (matrix_mdev->mdev)
> +			vfio_unpin_pages(mdev_dev(matrix_mdev->mdev),
> +					 &g_pfn, 1);
>   		return NOTIFY_OK;
>   	}
>   
> @@ -877,11 +1052,15 @@ static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>   				    unsigned int retry)
>   {
>   	struct ap_queue_status status;
> +	struct vfio_ap_queue *q;
> +
> +	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
>   
>   	do {
>   		status = ap_zapq(AP_MKQID(apid, apqi));
>   		switch (status.response_code) {
>   		case AP_RESPONSE_NORMAL:
> +			vfio_ap_free_irq(q);
>   			return 0;
>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>   		case AP_RESPONSE_BUSY:
> @@ -999,6 +1178,11 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
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
> @@ -1011,6 +1195,7 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   	if (ret)
>   		goto err_associate;
>   
> +	matrix_mdev->kvm->arch.crypto.pqap_hook = handle_pqap;
>   	return 0;
>   
>   err_associate:
> @@ -1031,12 +1216,12 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   	if (matrix_mdev->kvm)
>   		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>   
> -	vfio_ap_mdev_reset_queues(mdev);
> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +	vfio_ap_dissociate_queues(matrix_mdev);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>   				 &matrix_mdev->iommu_notifier);
> -	vfio_ap_dissociate_queues(matrix_mdev);
>   	matrix_mdev->kvm = NULL;
>   	module_put(THIS_MODULE);
>   }
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 2781720..16c99e9 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -92,5 +92,7 @@ struct vfio_ap_queue {
>   	struct device *dev;
>   	int	apqn;
>   	struct ap_matrix_mdev *matrix;
> +	unsigned long nib;
> +	unsigned char isc;

>   };
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

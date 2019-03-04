From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
Date: Mon, 4 Mar 2019 02:57:39 +0100
Message-ID: <20190304025739.17d0f245@oc2783563651>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Feb 2019 16:29:58 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We register the AP PQAP instruction hook during the open
> of the mediated device. And unregister it on release.
> 
> In the AP PQAP instruction hook, if we receive a demand to
> enable IRQs,
> - we retrieve the vfio_ap_queue based on the APQN we receive
>   in REG1,
> - we retrieve the page of the guest address, (NIB), from
>   register REG2
> - we the mediated device to use the VFIO pinning infratrsucture
>   to pin the page of the guest address,
> - we retrieve the pointer to KVM to register the guest ISC
>   and retrieve the host ISC
> - finaly we activate GISA
> 
> If we receive a demand to disable IRQs,
> - we deactivate GISA
> - unregister from the GIB
> - unping the NIB
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
[..]
> + */
> +static void vfio_ap_free_irq(struct vfio_ap_queue *q)
> +{
> +	if (!q)
> +		return;
> +	if (q->g_pfn)
> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->g_pfn, 1);
> +	if (q->isc)
> +		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->isc);

Ain't isc 0 a perfectly legit isc?

> +	q->nib = 0;
> +	q->isc = 0;
> +	q->g_pfn = 0;
> +}
> +
[..]
> @@ -109,10 +131,16 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>  static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>  {
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_queue *q, *qtmp;
>  
>  	if (matrix_mdev->kvm)
>  		return -EBUSY;
>  
> +	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
> +		q->matrix_mdev = NULL;
> +		vfio_ap_mdev_reset_queue(q);
> +		list_move(&q->list, &matrix_dev->free_list);

How about matrix_dev->lock? I guess you should protect free_list with
it. If not maybe a code comment would help not stumble over this.

> +	}
>  	mutex_lock(&matrix_dev->lock);
>  	list_del(&matrix_mdev->node);
>  	mutex_unlock(&matrix_dev->lock);

[..]

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

Shouldn't you call kvm_s390_gisc_unregister() here.

> +		q->g_pfn = g_pfn;
> +		break;
> +	case AP_RESPONSE_OTHERWISE_CHANGED:
> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &g_pfn, 1);

and here.

> +		break;
> +	case AP_RESPONSE_INVALID_GISA:
> +		status.response_code = AP_RESPONSE_INVALID_ADDRESS;
> +	default:	/* Fall Through */
> +		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> +			status.response_code);
> +		vfio_ap_free_irq(q);

This guy won't unpin g_pfn but only q->g_pfn if not zero :/

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
> + *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible
> RC.
> + *
> + * Return 0 if we could handle the request inside KVM.
> + * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)
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

This get is not a 'refcount affecting get' any more...

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

... and I don't see what should prevent a potential use after free here.

Regards,
Halil

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

[..]

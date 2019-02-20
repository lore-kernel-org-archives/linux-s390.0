From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 7/9] s390: ap: implement PAPQ AQIC interception in
 kernel
Date: Wed, 20 Feb 2019 12:54:20 +0100
Message-ID: <20190220125420.04984405@oc2783563651>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 14 Feb 2019 14:51:07 +0100
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
> +	q = vfio_ap_get_queue(apqn);
> +	if (!q) {
> +		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
> +		goto out;
> +	}
> +
> +	/* Check if the queue is associated with a guest matrix */
> +	matrix_mdev = q->matrix;
> +	if (!matrix_mdev || !matrix_mdev->kvm) {
> +		qstatus.response_code = AP_RESPONSE_DECONFIGURED;
> +		goto out;
> +	}
> +
> +	status = vcpu->run->s.regs.gprs[1];
> +
> +	/* If IR bit(16) is set we enable the interrupt */
> +	if ((status >> (63 - 16)) & 0x01) {
> +		q->isc = status & 0x07;
> +		q->nib = vcpu->run->s.regs.gprs[2];

Careful! You may already have q->nib set (may or may not be a 0x07
scenario). You should unpin the old nib if set interruption controls
works out, if we get 0x07 response then you unpin the new one.


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
> +	return 0;
> +}

[..]

>  
> @@ -877,11 +1052,15 @@ static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				    unsigned int retry)
>  {
>  	struct ap_queue_status status;
> +	struct vfio_ap_queue *q;
> +
> +	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
>  
>  	do {
>  		status = ap_zapq(AP_MKQID(apid, apqi));
>  		switch (status.response_code) {
>  		case AP_RESPONSE_NORMAL:

You could do the get queue here

> +			vfio_ap_free_irq(q);

And the put here.


Regards,
Halil

>  			return 0;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:
> @@ -999,6 +1178,11 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  	if (ret)
>  		goto err_group;
>  
> +	if (!matrix_mdev->kvm) {
> +		ret = -ENODEV;
> +		goto err_iommu;
> +	}
> +
>  	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>  	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>  

[..]

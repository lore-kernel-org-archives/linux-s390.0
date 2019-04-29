Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 29 Apr 2019 18:50:02 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 3/4] s390: ap: implement PAPQ AQIC interception in
 kernel
In-Reply-To: <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
        <1556283688-556-4-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190429185002.6041eecc.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 15:01:27 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> +static struct ap_queue_status vfio_ap_setirq(struct vfio_ap_queue *q)
> +{
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct ap_queue_status status = {};
> +	struct kvm_s390_gisa *gisa;
> +	struct kvm *kvm;
> +	unsigned long h_nib, h_pfn;
> +	int ret;
> +
> +	q->a_pfn = q->a_nib >> PAGE_SHIFT;
> +	ret = vfio_pin_pages(mdev_dev(q->matrix_mdev->mdev), &q->a_pfn, 1,
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

Can we actually hit the default label? AFICT you would return an
all-zero status, i.e. status.response_code == 0 'Normal completion'.

> +	}
> +
> +	kvm = q->matrix_mdev->kvm;
> +	gisa = kvm->arch.gisa_int.origin;
> +
> +	h_nib = (h_pfn << PAGE_SHIFT) | (q->a_nib & ~PAGE_MASK);
> +	aqic_gisa.gisc = q->a_isc;
> +	aqic_gisa.isc = kvm_s390_gisc_register(kvm, q->a_isc);
> +	aqic_gisa.ir = 1;
> +	aqic_gisa.gisa = gisa->next_alert >> 4;

Why gisa->next_alert? Isn't this supposed to get set to gisa origin
(without some bits on the left)?

> +
> +	status = ap_aqic(q->apqn, aqic_gisa, (void *)h_nib);
> +	switch (status.response_code) {
> +	case AP_RESPONSE_NORMAL:
> +		/* See if we did clear older IRQ configuration */
> +		if (q->p_pfn)
> +			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> +					 &q->p_pfn, 1);
> +		if (q->p_isc != VFIO_AP_ISC_INVALID)
> +			kvm_s390_gisc_unregister(kvm, q->p_isc);
> +		q->p_pfn = q->a_pfn;
> +		q->p_isc = q->a_isc;
> +		break;
> +	case AP_RESPONSE_OTHERWISE_CHANGED:
> +		/* We could not modify IRQ setings: clear new configuration */
> +		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev), &q->a_pfn, 1);
> +		kvm_s390_gisc_unregister(kvm, q->a_isc);

Hm, see below. Wouldn't you want to set a_isc to VFIO_AP_ISC_INVALID?

> +		break;
> +	default:	/* Fall Through */

Is it 'break' or is it 'Fall Through'?

> +		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> +			status.response_code);
> +		vfio_ap_free_irq_data(q);
> +		break;
> +	}
> +
> +	return status;
> +}

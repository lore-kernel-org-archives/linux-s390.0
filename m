Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726611AbgIUPrA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 11:47:00 -0400
Date: Mon, 21 Sep 2020 17:45:36 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: fix unregister GISC when KVM is already
 gone results in OOPS
Message-ID: <20200921174536.49e45e68.pasic@linux.ibm.com>
In-Reply-To: <20200918170234.5807-1-akrowiak@linux.ibm.com>
References: <20200918170234.5807-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pmorel@linux.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, kwankhede@nvidia.com, borntraeger@de.ibm.com

On Fri, 18 Sep 2020 13:02:34 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Attempting to unregister Guest Interruption Subclass (GISC) when the
> link between the matrix mdev and KVM has been removed results in the
> following:
> 
>    "Kernel panic -not syncing: Fatal exception: panic_on_oops"
> 
> This patch fixes this bug by verifying the matrix mdev and KVM are still
> linked prior to unregistering the GISC.


I read from your commit message that this happens when the link between
the KVM and the matrix mdev was established and then got severed. 

I assume the interrupts were previously enabled, and were not been
disabled or cleaned up because q->saved_isc != VFIO_AP_ISC_INVALID.

That means the guest enabled  interrupts and then for whatever
reason got destroyed, and this happens on mdev cleanup.

Does it happen all the time or is it some sort of a race?

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e0bde8518745..847a88642644 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -119,11 +119,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>   */
>  static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>  {
> -	if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev)
> -		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
> -	if (q->saved_pfn && q->matrix_mdev)
> -		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> -				 &q->saved_pfn, 1);
> +	if (q->matrix_mdev) {
> +		if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev->kvm)
> +			kvm_s390_gisc_unregister(q->matrix_mdev->kvm,
> +						 q->saved_isc);

I don't quite understand the logic here. I suppose we need to ensure
that the struct kvm is 'alive' at least until kvm_s390_gisc_unregister()
is done. That is supposed be ensured by kvm_get_kvm() in
vfio_ap_mdev_set_kvm() and kvm_put_kvm() in vfio_ap_mdev_release().

If the critical section in vfio_ap_mdev_release() is done and
matrix_mdev->kvm was set to NULL there then I would expect that the
queues are already reset and q->saved_isc == VFIO_AP_ISC_INVALID. So
this should not blow up.

Now if this happens before the critical section in
vfio_ap_mdev_release() is done, I ask myself how are we going to do the
kvm_put_kvm()?

Another question. Do we hold the matrix_dev->lock here?

> +		if (q->saved_pfn)
> +			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> +					 &q->saved_pfn, 1);
> +	}
> +
>  	q->saved_pfn = 0;
>  	q->saved_isc = VFIO_AP_ISC_INVALID;
>  }

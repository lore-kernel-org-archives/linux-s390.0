Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726507AbgIUJXc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 05:23:32 -0400
Date: Mon, 21 Sep 2020 11:23:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390/vfio-ap: fix unregister GISC when KVM is already
 gone results in OOPS
Message-ID: <20200921112318.0d11a2e5.cohuck@redhat.com>
In-Reply-To: <20200918170234.5807-1-akrowiak@linux.ibm.com>
References: <20200918170234.5807-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, borntraeger@de.ibm.com

On Fri, 18 Sep 2020 13:02:34 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Attempting to unregister Guest Interruption Subclass (GISC) when the
> link between the matrix mdev and KVM has been removed results in the
> following:
> 
>    "Kernel panic -not syncing: Fatal exception: panic_on_oops"

I'm wondering how we get there (why are we unregistering the gisc if
the mdev and kvm are not yet linked or are already unlinked?), so I
agree that the actual backchain would be helpful here.

> 
> This patch fixes this bug by verifying the matrix mdev and KVM are still
> linked prior to unregistering the GISC.
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

If checking for ->kvm is the right thing to do, I agree that moving the
check here would be easier to read.

> -		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
> -	if (q->saved_pfn && q->matrix_mdev)
> -		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> -				 &q->saved_pfn, 1);
> +	if (q->matrix_mdev) {
> +		if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev->kvm)
> +			kvm_s390_gisc_unregister(q->matrix_mdev->kvm,
> +						 q->saved_isc);
> +		if (q->saved_pfn)
> +			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> +					 &q->saved_pfn, 1);
> +	}
> +
>  	q->saved_pfn = 0;
>  	q->saved_isc = VFIO_AP_ISC_INVALID;
>  }

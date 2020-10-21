Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731418AbgJUPq5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Oct 2020 11:46:57 -0400
Subject: Re: [PATCH] s390/vfio-ap: fix unregister GISC when KVM is already
 gone results in OOPS
References: <20200918170234.5807-1-akrowiak@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <f3d21bbf-4d25-eac8-cc88-c654b8406316@linux.ibm.com>
Date: Wed, 21 Oct 2020 11:46:49 -0400
MIME-Version: 1.0
In-Reply-To: <20200918170234.5807-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, kwankhede@nvidia.com, borntraeger@de.ibm.com

In trying to recreate this problem in order to get a stack trace, I 
discovered that
it only occurs within a local repository that has several new patches 
applied,
so the problem is not part of the base code and will be fixed via this 
new set
of patches forthcoming.

On 9/18/20 1:02 PM, Tony Krowiak wrote:
> Attempting to unregister Guest Interruption Subclass (GISC) when the
> link between the matrix mdev and KVM has been removed results in the
> following:
>
>     "Kernel panic -not syncing: Fatal exception: panic_on_oops"
>
> This patch fixes this bug by verifying the matrix mdev and KVM are still
> linked prior to unregistering the GISC.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e0bde8518745..847a88642644 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -119,11 +119,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
>    */
>   static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>   {
> -	if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev)
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
>   	q->saved_pfn = 0;
>   	q->saved_isc = VFIO_AP_ISC_INVALID;
>   }

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731882AbgKZJmr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 04:42:47 -0500
Date: Thu, 26 Nov 2020 10:42:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 02/17] s390/vfio-ap: decrement reference count to
 KVM
Message-ID: <20201126104234.0bee248d.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-3-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-3-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@stny.rr.com>

On Tue, 24 Nov 2020 16:40:01 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Decrement the reference count to KVM when notified that KVM pointer is
> invalidated via the vfio group notifier.

Can you please explain more thoroughly. Is this a bug you found? If
yes do we need to backport it (cc stabe, fixes tag)? 

It doesn't see related to the objective of the series. If not related,
why not spin it separately?


> 
> Signed-off-by: Tony Krowiak <akrowiak@stny.rr.com>

This s-o-b is probably by accident.

> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 66fd9784a156..31e39c1f6e56 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1095,7 +1095,11 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>  
>  	if (!data) {
> +		if (matrix_mdev->kvm)
> +			kvm_put_kvm(matrix_mdev->kvm);
> +
>  		matrix_mdev->kvm = NULL;
> +
>  		return NOTIFY_OK;
>  	}
>  

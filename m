Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbhAUIWc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 03:22:32 -0500
Date: Thu, 21 Jan 2021 09:20:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390/vfio-ap: No need to disable IRQ after queue
 reset
Message-ID: <20210121092044.628b77c7.cohuck@redhat.com>
In-Reply-To: <20210121072008.76523-1-pasic@linux.ibm.com>
References: <20210121072008.76523-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com

On Thu, 21 Jan 2021 08:20:08 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> The queues assigned to a matrix mediated device are currently reset when:
> 
> * The VFIO_DEVICE_RESET ioctl is invoked
> * The mdev fd is closed by userspace (QEMU)
> * The mdev is removed from sysfs.
> 
> Immediately after the reset of a queue, a call is made to disable
> interrupts for the queue. This is entirely unnecessary because the reset of
> a queue disables interrupts, so this will be removed.
> 
> Furthermore, vfio_ap_irq_disable() does an unconditional PQAP/AQIC which
> can result in a specification exception (when the corresponding facility
> is not available), so this is actually a bugfix.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> [pasic@linux.ibm.com: minor rework before merging]
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
> Cc: <stable@vger.kernel.org>
> 
> ---
> 
> Since it turned out disabling the interrupts via PQAP/AQIC is not only
> unnecesary but also buggy, we decided to put this patch, which
> used to be apart of the series https://lkml.org/lkml/2020/12/22/757 on the fast
> lane.
> 
> If the backports turn out to be a bother, which I hope won't be the case
> not, I am happy to help with those.
> 
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |   6 +-
>  drivers/s390/crypto/vfio_ap_ops.c     | 100 ++++++++++++++++----------
>  drivers/s390/crypto/vfio_ap_private.h |  12 ++--
>  3 files changed, 69 insertions(+), 49 deletions(-)
> 

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index f46dde56b464..28e9d9989768 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -88,11 +88,6 @@ struct ap_matrix_mdev {
>  	struct mdev_device *mdev;
>  };
>  
> -extern int vfio_ap_mdev_register(void);
> -extern void vfio_ap_mdev_unregister(void);
> -int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> -			     unsigned int retry);
> -
>  struct vfio_ap_queue {
>  	struct ap_matrix_mdev *matrix_mdev;
>  	unsigned long saved_pfn;
> @@ -100,5 +95,10 @@ struct vfio_ap_queue {
>  #define VFIO_AP_ISC_INVALID 0xff
>  	unsigned char saved_isc;
>  };
> -struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);
> +
> +int vfio_ap_mdev_register(void);
> +void vfio_ap_mdev_unregister(void);

Nit: was moving these two necessary?

> +int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
> +			     unsigned int retry);
> +
>  #endif /* _VFIO_AP_PRIVATE_H_ */
> 
> base-commit: 9791581c049c10929e97098374dd1716a81fefcc

Anyway, if I didn't entangle myself in the various branches, this seems
sane.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32252 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728279AbgDHKsP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 06:48:15 -0400
Date: Wed, 8 Apr 2020 12:48:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: store queue struct in hash table
 for quick access
Message-ID: <20200408124801.2d61bc5b.cohuck@redhat.com>
In-Reply-To: <20200407192015.19887-2-akrowiak@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-2-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Tue,  7 Apr 2020 15:20:01 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Rather than looping over potentially 65535 objects, let's store the
> structures for caching information about queue devices bound to the
> vfio_ap device driver in a hash table keyed by APQN.

This also looks like a nice code simplification.

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 28 +++------
>  drivers/s390/crypto/vfio_ap_ops.c     | 90 ++++++++++++++-------------
>  drivers/s390/crypto/vfio_ap_private.h | 10 ++-
>  3 files changed, 60 insertions(+), 68 deletions(-)
> 

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 5c0f53c6dde7..134860934fe7 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -26,45 +26,16 @@
>  
>  static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
>  
> -static int match_apqn(struct device *dev, const void *data)
> -{
> -	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> -
> -	return (q->apqn == *(int *)(data)) ? 1 : 0;
> -}
> -
> -/**
> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
> - * @matrix_mdev: the associated mediated matrix
> - * @apqn: The queue APQN
> - *
> - * Retrieve a queue with a specific APQN from the list of the
> - * devices of the vfio_ap_drv.
> - * Verify that the APID and the APQI are set in the matrix.
> - *
> - * Returns the pointer to the associated vfio_ap_queue

Any reason you're killing this comment, instead of adapting it? The
function is even no longer static...

> - */
> -static struct vfio_ap_queue *vfio_ap_get_queue(
> -					struct ap_matrix_mdev *matrix_mdev,
> -					int apqn)
> +struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
>  {
>  	struct vfio_ap_queue *q;
> -	struct device *dev;
> -
> -	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
> -		return NULL;
> -	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
> -		return NULL;

These were just optimizations and therefore can be dropped now?

> -
> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				 &apqn, match_apqn);
> -	if (!dev)
> -		return NULL;
> -	q = dev_get_drvdata(dev);
> -	q->matrix_mdev = matrix_mdev;
> -	put_device(dev);
>  
> -	return q;
> +	hash_for_each_possible(matrix_dev->qtable, q, qnode, apqn) {
> +		if (q && (apqn == q->apqn))
> +			return q;
> +	}

Do we need any serialization here? Previously, the driver core made
sure we could get a reference only if the device was still registered;
not sure if we need any further guarantees now.

> +
> +	return NULL;
>  }
>  
>  /**

(...)

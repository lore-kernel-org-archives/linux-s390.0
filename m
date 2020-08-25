Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729795AbgHYKNy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:54 -0400
Date: Tue, 25 Aug 2020 12:13:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 02/16] s390/vfio-ap: use new AP bus interface to
 search for queue devices
Message-ID: <20200825121334.0ff35d7a.cohuck@redhat.com>
In-Reply-To: <20200821195616.13554-3-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-3-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>

On Fri, 21 Aug 2020 15:56:02 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> This patch refactor's the vfio_ap device driver to use the AP bus's

s/refactor's/refactors/

> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
> information about a queue that is bound to the vfio_ap device driver.
> The bus's ap_get_qdev() function retrieves the queue device from a
> hashtable keyed by APQN. This is much more efficient than looping over
> the list of devices attached to the AP bus by several orders of
> magnitude.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 27 ++-------
>  drivers/s390/crypto/vfio_ap_ops.c     | 86 +++++++++++++++------------
>  drivers/s390/crypto/vfio_ap_private.h |  8 ++-
>  3 files changed, 59 insertions(+), 62 deletions(-)
> 

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e0bde8518745..ad3925f04f61 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -26,43 +26,26 @@
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
>  /**
> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
> - * @matrix_mdev: the associated mediated matrix
> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
>   * @apqn: The queue APQN
>   *
> - * Retrieve a queue with a specific APQN from the list of the
> - * devices of the vfio_ap_drv.
> - * Verify that the APID and the APQI are set in the matrix.
> + * Retrieve a queue with a specific APQN from the AP queue devices attached to
> + * the AP bus.
>   *
> - * Returns the pointer to the associated vfio_ap_queue
> + * Returns the pointer to the vfio_ap_queue with the specified APQN, or NULL.
>   */
> -static struct vfio_ap_queue *vfio_ap_get_queue(
> -					struct ap_matrix_mdev *matrix_mdev,
> -					int apqn)
> +static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
>  {
> +	struct ap_queue *queue;
>  	struct vfio_ap_queue *q;
> -	struct device *dev;
>  
> -	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
> -		return NULL;
> -	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))

I think you should add some explanation to the patch description why
testing the matrix bitmasks is not needed anymore.

> +	queue = ap_get_qdev(apqn);
> +	if (!queue)
>  		return NULL;
>  
> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				 &apqn, match_apqn);
> -	if (!dev)
> -		return NULL;
> -	q = dev_get_drvdata(dev);
> -	q->matrix_mdev = matrix_mdev;
> -	put_device(dev);
> +	q = dev_get_drvdata(&queue->ap_dev.device);
> +	put_device(&queue->ap_dev.device);
>  
>  	return q;
>  }

(...)

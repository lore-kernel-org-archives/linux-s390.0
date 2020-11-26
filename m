Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Nov 2020 14:37:35 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 04/17] s390/vfio-ap: No need to disable IRQ after
 queue reset
Message-ID: <20201126143735.65e5d5e8.pasic@linux.ibm.com>
In-Reply-To: <20201124214016.3013-5-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-5-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 24 Nov 2020 16:40:03 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

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
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

As I said previously, I would prefer the cleanup of the airq
resources being part of reset_queue(), but I can propose that
later.

> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 8e6972495daa..dc699fd54505 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -26,14 +26,6 @@
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
> -
>  /**
>   * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
>   * @matrix_mdev: the associated mediated matrix
> @@ -1121,20 +1113,6 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> -static void vfio_ap_irq_disable_apqn(int apqn)
> -{
> -	struct device *dev;
> -	struct vfio_ap_queue *q;
> -
> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				 &apqn, match_apqn);
> -	if (dev) {
> -		q = dev_get_drvdata(dev);
> -		vfio_ap_irq_disable(q);
> -		put_device(dev);
> -	}
> -}
> -
>  static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				    unsigned int retry)
>  {
> @@ -1169,6 +1147,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>  {
>  	int ret;
>  	int rc = 0;
> +	struct vfio_ap_queue *q;
>  	unsigned long apid, apqi;
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  
> @@ -1184,7 +1163,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>  			 */
>  			if (ret)
>  				rc = ret;
> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
> +
> +			q = vfio_ap_get_queue(matrix_mdev, AP_MKQID(apid, apqi);
> +			if (q)
> +				vfio_ap_free_aqic_resources(q);
>  		}
>  	}
>  

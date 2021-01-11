Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 Jan 2021 17:32:06 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 02/15] s390/vfio-ap: No need to disable IRQ after
 queue reset
Message-ID: <20210111173206.27808b79.pasic@linux.ibm.com>
In-Reply-To: <20201223011606.5265-3-akrowiak@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-3-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 22 Dec 2020 20:15:53 -0500
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
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |  1 -
>  drivers/s390/crypto/vfio_ap_ops.c     | 40 +++++++++++++++++----------
>  drivers/s390/crypto/vfio_ap_private.h |  1 -
>  3 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index be2520cc010b..ca18c91afec9 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -79,7 +79,6 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>  	apid = AP_QID_CARD(q->apqn);
>  	apqi = AP_QID_QUEUE(q->apqn);
>  	vfio_ap_mdev_reset_queue(apid, apqi, 1);
> -	vfio_ap_irq_disable(q);
>  	kfree(q);
>  	mutex_unlock(&matrix_dev->lock);
>  }
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 7339043906cf..052f61391ec7 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -25,6 +25,7 @@
>  #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>  
>  static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
> +static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
>  
>  static int match_apqn(struct device *dev, const void *data)
>  {
> @@ -49,20 +50,15 @@ static struct vfio_ap_queue *(
>  					int apqn)
>  {
>  	struct vfio_ap_queue *q;
> -	struct device *dev;
>  
>  	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
>  		return NULL;
>  	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
>  		return NULL;
>  
> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				 &apqn, match_apqn);
> -	if (!dev)
> -		return NULL;
> -	q = dev_get_drvdata(dev);
> -	q->matrix_mdev = matrix_mdev;
> -	put_device(dev);
> +	q = vfio_ap_find_queue(apqn);
> +	if (q)
> +		q->matrix_mdev = matrix_mdev;
>  
>  	return q;
>  }
> @@ -1126,24 +1122,27 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	return notify_rc;
>  }
>  
> -static void vfio_ap_irq_disable_apqn(int apqn)
> +static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
>  {
>  	struct device *dev;
> -	struct vfio_ap_queue *q;
> +	struct vfio_ap_queue *q = NULL;
>  
>  	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>  				 &apqn, match_apqn);
>  	if (dev) {
>  		q = dev_get_drvdata(dev);
> -		vfio_ap_irq_disable(q);
>  		put_device(dev);
>  	}
> +
> +	return q;
>  }

This hunk and the previous one are a rewrite of vfio_ap_get_queue() and
have next to nothing to do with the patch's objective. If we were at an
earlier stage, I would ask to split it up.

>  
>  int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  			     unsigned int retry)
>  {
>  	struct ap_queue_status status;
> +	struct vfio_ap_queue *q;
> +	int ret;
>  	int retry2 = 2;
>  	int apqn = AP_MKQID(apid, apqi);
>  
> @@ -1156,18 +1155,32 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				status = ap_tapq(apqn, NULL);
>  			}
>  			WARN_ON_ONCE(retry2 <= 0);
> -			return 0;
> +			ret = 0;
> +			goto free_aqic_resources;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:
>  			msleep(20);
>  			break;
>  		default:
>  			/* things are really broken, give up */
> -			return -EIO;
> +			ret = -EIO;
> +			goto free_aqic_resources;

Do we really want the unpin here? I mean the reset did not work and
we are giving up. So the irqs are potentially still enabled.

Without this patch we try to disable the interrupts using AQIC, and
do the cleanup after that.

I'm aware, the comment says we should not take the default branch,
but if that's really the case we should IMHO log an error and leak the
page.

It's up to you if you want to change this. I don't want to delay the
series any further than absolutely necessary.

Acked-by: Halil Pasic <pasic@linux.ibm.com>

>  		}
>  	} while (retry--);
>  
>  	return -EBUSY;
> +
> +free_aqic_resources:
> +	/*
> +	 * In order to free the aqic resources, the queue must be linked to
> +	 * the matrix_mdev to which its APQN is assigned and the KVM pointer
> +	 * must be available.
> +	 */
> +	q = vfio_ap_find_queue(apqn);
> +	if (q && q->matrix_mdev && q->matrix_mdev->kvm)

Is this of the type "we know there are no aqic resources to be freed" if
precondition is false?

vfio_ap_free_aqic_resources() checks the matrix_mdev pointer but not the
kvm pointer. Could we just check the kvm pointer in
vfio_ap_free_aqic_resources()?

At the end of the series, is seeing q! indicating a bug, or is it
something we expect to see under certain circumstances?


> +		vfio_ap_free_aqic_resources(q);
> +
> +	return ret;
>  }
>  
>  static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> @@ -1189,7 +1202,6 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>  			 */
>  			if (ret)
>  				rc = ret;
> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
>  		}
>  	}
>  
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index f46dde56b464..0db6fb3d56d5 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -100,5 +100,4 @@ struct vfio_ap_queue {
>  #define VFIO_AP_ISC_INVALID 0xff
>  	unsigned char saved_isc;
>  };
> -struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);
>  #endif /* _VFIO_AP_PRIVATE_H_ */

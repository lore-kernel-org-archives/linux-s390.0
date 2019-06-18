Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 18 Jun 2019 18:14:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/7] s390: vfio-ap: Refactor vfio_ap driver probe and
 remove callbacks
Message-ID: <20190618181456.0252227b.cohuck@redhat.com>
In-Reply-To: <1560454780-20359-2-git-send-email-akrowiak@linux.ibm.com>
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
        <1560454780-20359-2-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

On Thu, 13 Jun 2019 15:39:34 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> In order to limit the number of private mdev functions called from the
> vfio_ap device driver as well as to provide a landing spot for dynamic
> configuration code related to binding/unbinding AP queue devices to/from
> the vfio_ap driver, the following changes are being introduced:
> 
> * Move code from the vfio_ap driver's probe callback into a function
>   defined in the mdev private operations file.
> 
> * Move code from the vfio_ap driver's remove callback into a function
>   defined in the mdev private operations file.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 27 ++++++++++-----------------
>  drivers/s390/crypto/vfio_ap_ops.c     | 28 ++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  6 +++---
>  3 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 003662aa8060..3c60df70891b 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -49,15 +49,15 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>   */
>  static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>  {
> -	struct vfio_ap_queue *q;
> -
> -	q = kzalloc(sizeof(*q), GFP_KERNEL);
> -	if (!q)
> -		return -ENOMEM;
> -	dev_set_drvdata(&apdev->device, q);
> -	q->apqn = to_ap_queue(&apdev->device)->qid;
> -	q->saved_isc = VFIO_AP_ISC_INVALID;
> +	int ret;
> +	struct ap_queue *queue = to_ap_queue(&apdev->device);
> +
> +	ret = vfio_ap_mdev_probe_queue(queue);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
> +

Maybe you could even condense this into a simple

return vfio_ap_mdev_probe_queue(to_ap_queue(&apdev->device));

(Unless you plan to do more things with queue in a future patch, of
course.)

>  }
>  
>  /**

(...)

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index f46dde56b464..5cc3c2ebf151 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -90,8 +90,6 @@ struct ap_matrix_mdev {
>  
>  extern int vfio_ap_mdev_register(void);
>  extern void vfio_ap_mdev_unregister(void);
> -int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> -			     unsigned int retry);

If you don't need that function across files anymore, you probably want
to make it static.

>  
>  struct vfio_ap_queue {
>  	struct ap_matrix_mdev *matrix_mdev;
> @@ -100,5 +98,7 @@ struct vfio_ap_queue {
>  #define VFIO_AP_ISC_INVALID 0xff
>  	unsigned char saved_isc;
>  };
> -struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);

Same here.

> +int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
> +void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
> +
>  #endif /* _VFIO_AP_PRIVATE_H_ */

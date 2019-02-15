From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
Date: Fri, 15 Feb 2019 17:13:21 -0500
Message-ID: <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/14/19 8:51 AM, Pierre Morel wrote:
> We need to find the queue with a specific APQN during the
> handling of the interception of the PQAP/AQIC instruction.
> 
> To handle the AP associated device reference count we keep
> track of it in the vfio_ap_queue until we put the device.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>   2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 900b9cf..2a52c9b 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -24,6 +24,60 @@
>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>   
> +/**
> + * vfio_ap_check_apqn: check if a ap_queue is of a given APQN
> + *
> + * Returns 1 if we have a match.
> + * Otherwise returns 0.
> + */
> +static int vfio_ap_check_apqn(struct device *dev, void *data)
> +{
> +	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> +
> +	return (q->apqn == *(int *)data);
> +}
> +
> +/**
> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
> + * @apqn: The queue APQN
> + *
> + * Retrieve a queue with a specific APQN from the list of the
> + * devices associated to the vfio_ap_driver.
> + *
> + * The vfio_ap_queue has been already associated with the device
> + * during the probe.
> + * Store the associated device for reference counting
> + *
> + * Returns the pointer to the associated vfio_ap_queue
> + */
> +static  __attribute__((unused))
> +	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)

I think you should change this signature for the reasons I stated
below:

struct device *vfio_ap_get_queue_dev(int apqn)

> +{
> +	struct device *dev;
> +	struct vfio_ap_queue *q;
> +
> +	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL, &apqn,
> +				 vfio_ap_check_apqn);
> +	if (!dev)
> +		return NULL;
> +	q = dev_get_drvdata(dev);
> +	q->dev = dev;

Why store the device with the vfio_ap_queue object? Why not just return
the device. The caller can get the vfio_ap_queue from the device's
driver data. It seems the only reason for the 'dev' field is to
temporarily hold a ref to the device so it can be put later. Why not
just put the device.

> +	return q;
> +}
> +
> +/**
> + * vfio_ap_put_queue: lower device reference count for a queue
> + * @q: The queue
> + *
> + * put the associated device
> + *
> + */
> +static  __attribute__((unused)) void vfio_ap_put_queue(struct vfio_ap_queue *q)
> +{
> +	put_device(q->dev);
> +	q->dev = NULL;
> +}

I would get rid of this function. If you take my suggestion above, you
can just call the put_device() directly. There will be no need for
this superfluous 'dev' field.

> +
>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>   				struct ap_matrix *matrix)
>   {
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 8836f01..081f0d7 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -87,6 +87,7 @@ extern int vfio_ap_mdev_register(void);
>   extern void vfio_ap_mdev_unregister(void);
>   
>   struct vfio_ap_queue {
> +	struct device *dev;

No need for this as per my comments above.

>   	int	apqn;
>   };
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

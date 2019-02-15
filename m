From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
Date: Fri, 15 Feb 2019 18:29:04 -0500
Message-ID: <f60b520b-7342-da0d-48cb-5a16190b7f40@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/14/19 8:51 AM, Pierre Morel wrote:
> When the device is remove, we must make sure to
> clear the interruption and reset the AP device.
> 
> We also need to clear the CRYCB of the guest.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 92 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_ops.c     |  2 +-
>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>   3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 03153e6..50428be 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -5,6 +5,7 @@
>    * Copyright IBM Corp. 2018
>    *
>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
>    */
>   
>   #include <linux/module.h>
> @@ -12,6 +13,8 @@
>   #include <linux/slab.h>
>   #include <linux/string.h>
>   #include <asm/facility.h>
> +#include <linux/bitops.h>
> +#include <linux/kvm_host.h>
>   #include "vfio_ap_private.h"
>   
>   #define VFIO_AP_ROOT_NAME "vfio_ap"
> @@ -64,6 +67,88 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>   	return 0;
>   }
>   
> +/*
> + * vfio_ap_drain_queue
> + * @q: the queue to drain
> + *
> + * This function waits until the queue is empty.
> + */
> +static void vfio_ap_drain_queue(struct vfio_ap_queue *q)
> +{
> +	struct ap_queue_status status;
> +	int retry = 20;
> +
> +	status = ap_tapq(q->apqn, NULL);
> +	while (!status.queue_empty && retry--)  {
> +		msleep(200);
> +		status = ap_tapq(q->apqn, NULL);
> +	}
> +	if (retry <= 0) {
> +		pr_warn("%s: queue not empty after zapq on apqn 0x%04x\n",
> +			__func__, q->apqn);
> +	}
> +}
> +
> +/*
> + * vfio_ap_zapq
> + * @q: The queue to zerro
> + *
> + * It is best effort, no return value is done, however on success
> + * we will drain the queue before getting the queue back to the
> + * AP bus.
> + */
> +static void vfio_ap_zapq(struct vfio_ap_queue *q)
> +{
> +	struct ap_queue_status status;
> +	int retry = 20;
> +
> +	do {
> +		status = ap_zapq(q->apqn);
> +		switch (status.response_code) {
> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> +		case AP_RESPONSE_BUSY:
> +			msleep(20);
> +			break;
> +		default:
> +			pr_warn("%s: zapq error %02x on apqn 0x%04x\n",
> +				__func__, status.response_code, q->apqn);
> +			return;
> +		case AP_RESPONSE_NORMAL:
> +			vfio_ap_drain_queue(q);

I don't think this is necessary. The zeroize is performed on
each AP-queue entry in an AP queue. My understanding is that when a
reset or zeroize is pending, any AP instructions subsequently issued
are rejected with condition-code 3 indicating an AP queue reset is in
progress. It is also my understanding that once the AP commands 
currently executing in a given AP queue entry complete, the queue
entry will be zeroized. So it seems to me that there is no need to
"drain" the queue, it will have already been done by the zeroize.

If you agree we don't need to "drain" the queue, then I'd rather just
make the zapq function in the vfio_ap_ops.c non-static and make it
available to the driver. There is no sense in duplicating this code. In
fact, even if you keep the draining function, you still don't need to
duplicate a zaapq instruction here, you can just call the vfio_ap_ops.c
version and then drain the queue on AP_RESPONSE_NORMAL.


> +			return;
> +		}
> +	} while (retry--);
> +	pr_warn("%s: zapq retry count exceeded code %02x on apqn 0x%04x\n",
> +		__func__, status.response_code, q->apqn);
> +}
> +
> +/**
> + * vfio_ap_update_crycb
> + * @q: A pointer to the queue being removed
> + *
> + * We clear the APID of the queue, making this queue unusable for the guest.
> + * After this function we can reset the queue without to fear a race with
> + * the guest to access the queue again.
> + * We do not fear race with the host as we still get the device.
> + */
> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = q->matrix;
> +
> +	if (!matrix_mdev)
> +		return;
> +
> +	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
> +
> +	if (!matrix_mdev->kvm)
> +		return;
> +
> +	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
> +				  matrix_mdev->matrix.apm,
> +				  matrix_mdev->matrix.aqm,
> +				  matrix_mdev->matrix.adm);
> +}
> +
>   /**
>    * vfio_ap_queue_dev_remove:
>    *
> @@ -74,6 +159,13 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>   	struct vfio_ap_queue *q;
>   
>   	q = dev_get_drvdata(&apdev->device);
> +	if (!q)
> +		return;
> +
> +	vfio_ap_update_crycb(q);
> +	vfio_ap_zapq(q);
> +
> +	vfio_ap_free_irq(q);

If you make the zapq function in vfio_ap_ops.c available to the driver
rather than duplicating it in this file, you won't need this call
to vfio_ap_free_irq because it is done as part of the zapq in
vfio_ap_ops.c.

>   	kfree(q);
>   }
>   
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 5664cf3..7ec957c 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -85,7 +85,7 @@ static void vfio_ap_put_queue(struct vfio_ap_queue *q)
>    * Unregister the ISC from the GIB alert
>    * Clear the vfio_ap_queue intern fields
>    */
> -static void vfio_ap_free_irq(struct vfio_ap_queue *q)
> +void vfio_ap_free_irq(struct vfio_ap_queue *q)
>   {
>   	unsigned long pfn = q->nib >> PAGE_SHIFT;
>   
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 16c99e9..d108c6d 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -4,6 +4,7 @@
>    *
>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>    *	      Halil Pasic <pasic@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
>    *
>    * Copyright IBM Corp. 2018
>    */
> @@ -95,4 +96,5 @@ struct vfio_ap_queue {
>   	unsigned long nib;
>   	unsigned char isc;
>   };
> +void vfio_ap_free_irq(struct vfio_ap_queue *q);
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

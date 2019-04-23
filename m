Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 7/8] s390: vfio-ap: handle bind and unbind of AP queue
 device
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 23 Apr 2019 15:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <1555796980-27920-8-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <bf7ecaa0-a38c-9052-81e0-673ade8bc4d9@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 20/04/2019 23:49, Tony Krowiak wrote:
> There is an implied guarantee that when an AP queue device is bound to a
> device driver, that driver will have exclusive control over the device.
> When an AP queue device is unbound from the vfio_ap driver while the
> queue is in use by a guest and subsquently bound to a zcrypt driver, the
> guarantee that the zcrypt driver has exclusive control of the queue
> device will be violated. Likewise, when an AP queue device is bound to
> the vfio_ap device driver and its APQN is assigned to an mdev device in
> use by a guest, the expectation is that the guest will have access to
> the queue.
> 
> The purpose of this patch is to ensure three things:
> 
> 1. When an AP queue device in use by a guest is unbound, the guest shall
>     no longer access the queue. Due to the limitations of the
>     architecture, access to a single queue can not be denied to a guest,
>     so access to the AP card to which the queue is connected will be
>     denied to the guest.
> 
> 2. When an AP queue device with an APQN assigned to an mdev device is
>     bound to the vfio_ap driver while the mdev device is in use by a guest,
>     the guest shall be granted access to the queue.
> 
> 3. When a guest is started, each APQN assigned to the guest's mdev device
>     must be owned by the vfio_ap driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 16 ++++++-
>   drivers/s390/crypto/vfio_ap_ops.c     | 82 ++++++++++++++++++++++++++++++++++-
>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>   3 files changed, 97 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index e9824c35c34f..0f5dafddf5b1 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -42,12 +42,26 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>   
>   static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>   {
> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
> +	unsigned long apid = AP_QID_CARD(apq->qid);
> +	unsigned long apqi = AP_QID_QUEUE(apq->qid);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	vfio_ap_mdev_probe_queue(apid, apqi);
> +	mutex_unlock(&matrix_dev->lock);
> +
>   	return 0;
>   }
>   
>   static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>   {
> -	/* Nothing to do yet */
> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
> +	unsigned long apid = AP_QID_CARD(apq->qid);
> +	unsigned long apqi = AP_QID_QUEUE(apq->qid);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	vfio_ap_mdev_remove_queue(apid, apqi);
> +	mutex_unlock(&matrix_dev->lock);
>   }
>   
>   static void vfio_ap_matrix_dev_release(struct device *dev)
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 31ce30ee784d..3f9506516545 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -763,8 +763,8 @@ static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, unsigned long apqi)
>   			msleep(20);
>   			break;
>   		default:
> -			pr_warn("%s: tapq err %02x: 0x%04x may not be empty\n",
> -				__func__, status.response_code, q->apqn);
> +			pr_warn("%s: tapq err %02x: %02lx%04lx may not be empty\n",
> +				__func__, status.response_code, apid, apqi);
>   			return;
>   		}
>   	} while (--retry);
> @@ -823,6 +823,14 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>   
>   static int vfio_ap_mdev_create_shadow_crycb(struct ap_matrix_mdev *matrix_mdev)
>   {
> +	/*
> +	 * If an AP resource is not owned by the vfio_ap driver - e.g., it was
> +	 * unbound from the driver while still assigned to the mdev device
> +	 */
> +	if (ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
> +					       matrix_mdev->matrix.aqm))
> +		return -EADDRNOTAVAIL;
> +
>   	matrix_mdev->shadow_crycb = kzalloc(sizeof(*matrix_mdev->shadow_crycb),
>   					    GFP_KERNEL);
>   	if (!matrix_mdev->shadow_crycb)
> @@ -847,6 +855,18 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   	if (!try_module_get(THIS_MODULE))
>   		return -ENODEV;
>   
> +	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
> +						 matrix_mdev->matrix.aqm);
> +
> +	/*
> +	 * If any APQN is owned by a default driver, it can not be used by the
> +	 * guest. This can happen if a queue is unbound from the vfio_ap
> +	 * driver but not unassigned from the mdev device.
> +	 */
> +	ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
> +	if (ret)
> +		return ret;
> +
>   	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>   	events = VFIO_GROUP_NOTIFY_SET_KVM;
>   
> @@ -938,3 +958,61 @@ void vfio_ap_mdev_unregister(void)
>   {
>   	mdev_unregister_device(&matrix_dev->device);
>   }
> +
> +static struct ap_matrix_mdev *vfio_ap_mdev_find_matrix_mdev(unsigned long apid,
> +							    unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
> +		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
> +			return matrix_mdev;
> +	}
> +
> +	return NULL;
> +}
> +
> +void vfio_ap_mdev_remove_queue(unsigned long apid, unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
> +
> +	/*
> +	 * If the queue is assigned to the mdev device and the mdev device
> +	 * is in use by a guest
> +	 */
> +	if (matrix_mdev && matrix_mdev->kvm) {
> +		/*
> +		 * Unplug the adapter from the guest but don't unassign it
> +		 * from the mdev device
> +		 */
> +		clear_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
> +		vfio_ap_mdev_update_crycb(matrix_mdev);
> +	}
> +
> +	vfio_ap_mdev_reset_queue(apid, apqi);
> +}
> +
> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
> +
> +	/*
> +	 * If the queue is assigned to the mdev device and the mdev device
> +	 * is in use by a guest
> +	 */
> +	if (matrix_mdev && matrix_mdev->kvm) {
> +		/* Plug the adapter into the guest */
> +		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);

Before you set the bit in the shadow...

> +
> +		/* Make sure the queue is also plugged in to the guest */

I Think we must take care in the use of queues and domains to avoid 
being confusing.

> +		if (!test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm))
> +			set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
> +
> +		vfio_ap_mdev_update_crycb(matrix_mdev);

...and you update the real CRYCB,

don't you need to verify that all ap queues which verify APID and any 
already pre-existing APQI are bound to the driver?

Same for pre-existing APID if you set the APQI.


> +	}
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index e8457aa61976..00eaae3b853f 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -87,5 +87,7 @@ struct ap_matrix_mdev {
>   
>   extern int vfio_ap_mdev_register(void);
>   extern void vfio_ap_mdev_unregister(void);
> +void vfio_ap_mdev_remove_queue(unsigned long apid, unsigned long apqi);
> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi);
>   
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 5/7] s390: vfio-ap: allow hot plug/unplug of AP
 resources using mdev device
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-6-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 6 May 2019 12:42:51 +0200
MIME-Version: 1.0
In-Reply-To: <1556918073-13171-6-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <d97cf90c-3750-bea0-2f9f-bae81f61e288@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 03/05/2019 23:14, Tony Krowiak wrote:
> Let's allow AP resources to be assigned to or unassigned from an AP matrix
> mdev device while it is in use by a guest. If a guest is using the mdev
> device while assignment is taking place, the guest will be granted access
> to the resource as long as the guest will not be given access to an AP
> queue device that is not bound to the vfio_ap device driver. If a guest is
> using the mdev device while unassignment is taking place, access to the
> resource will be taken from the guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 116 ++++++++++++++++++++++++++++----------
>   1 file changed, 86 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index ea24caf17a16..ede45184eb67 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -226,6 +226,8 @@ static struct device *vfio_ap_get_queue_dev(unsigned long apid,
>   				  &apqn, match_apqn);
>   }
>   
> +
> +

two white lines

>   static int vfio_ap_mdev_validate_masks(unsigned long *apm, unsigned long *aqm)
>   {
>   	int ret;
> @@ -237,6 +239,26 @@ static int vfio_ap_mdev_validate_masks(unsigned long *apm, unsigned long *aqm)
>   	return vfio_ap_mdev_verify_no_sharing(apm, aqm);
>   }
>   
> +static bool vfio_ap_queues_on_drv(unsigned long *apm, unsigned long *aqm)
> +{
> +	unsigned long apid, apqi, apqn;
> +	struct device *dev;
> +
> +	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
> +		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
> +			apqn = AP_MKQID(apid, apqi);

You do not use apqn in the function.

> +
> +			dev = vfio_ap_get_queue_dev(apid, apqi);
> +			if (!dev)
> +				return false;
> +
> +			put_device(dev);
> +		}
> +	}
> +
> +	return true;
> +}
> +
>   /**
>    * assign_adapter_store
>    *
> @@ -247,7 +269,10 @@ static int vfio_ap_mdev_validate_masks(unsigned long *apm, unsigned long *aqm)
>    * @count:	the number of bytes in @buf
>    *
>    * Parses the APID from @buf and sets the corresponding bit in the mediated
> - * matrix device's APM.
> + * matrix device's APM. If a guest is using the mediated matrix device and each
> + * new APQN formed as a result of the assignment identifies an AP queue device
> + * that is bound to the vfio_ap device driver, the guest will be granted access
> + * to the adapter with the specified APID.
>    *
>    * Returns the number of bytes processed if the APID is valid; otherwise,
>    * returns one of the following errors:
> @@ -279,10 +304,6 @@ static ssize_t assign_adapter_store(struct device *dev,
>   	struct mdev_device *mdev = mdev_from_dev(dev);
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -	/* If the guest is running, disallow assignment of adapter */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>   	ret = kstrtoul(buf, 0, &apid);
>   	if (ret)
>   		return ret;
> @@ -300,6 +321,14 @@ static ssize_t assign_adapter_store(struct device *dev,
>   		return ret;
>   	}
>   	set_bit_inv(apid, matrix_mdev->matrix.apm);
> +
> +	if (matrix_mdev->shadow_crycb) {
> +		if (vfio_ap_queues_on_drv(apm,
> +					  matrix_mdev->shadow_crycb->aqm)) {
> +			set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> @@ -315,7 +344,9 @@ static DEVICE_ATTR_WO(assign_adapter);
>    * @count:	the number of bytes in @buf
>    *
>    * Parses the APID from @buf and clears the corresponding bit in the mediated
> - * matrix device's APM.
> + * matrix device's APM. If a guest is using the mediated matrix device and has
> + * access to the AP adapter with the specified APID, access to the adapter will
> + * be taken from the guest.
>    *
>    * Returns the number of bytes processed if the APID is valid; otherwise,
>    * returns one of the following errors:
> @@ -332,10 +363,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   	struct mdev_device *mdev = mdev_from_dev(dev);
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -	/* If the guest is running, disallow un-assignment of adapter */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>   	ret = kstrtoul(buf, 0, &apid);
>   	if (ret)
>   		return ret;
> @@ -345,6 +372,13 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
> +
> +	if (matrix_mdev->shadow_crycb) {
> +		if (test_bit_inv(apid, matrix_mdev->shadow_crycb->apm)) {
> +			clear_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> @@ -361,7 +395,10 @@ static DEVICE_ATTR_WO(unassign_adapter);
>    * @count:	the number of bytes in @buf
>    *
>    * Parses the APQI from @buf and sets the corresponding bit in the mediated
> - * matrix device's AQM.
> + * matrix device's AQM. If a guest is using the mediated matrix device and each
> + * new APQN formed as a result of the assignment identifies an AP queue device
> + * that is bound to the vfio_ap device driver, the guest will be given access
> + * to the AP queue(s) with the specified APQI.
>    *
>    * Returns the number of bytes processed if the APQI is valid; otherwise returns
>    * one of the following errors:
> @@ -394,10 +431,6 @@ static ssize_t assign_domain_store(struct device *dev,
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
>   
> -	/* If the guest is running, disallow assignment of domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>   	ret = kstrtoul(buf, 0, &apqi);
>   	if (ret)
>   		return ret;
> @@ -414,6 +447,14 @@ static ssize_t assign_domain_store(struct device *dev,
>   		return ret;
>   	}
>   	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
> +
> +	if (matrix_mdev->shadow_crycb) {
> +		if (vfio_ap_queues_on_drv(matrix_mdev->shadow_crycb->apm,
> +					  aqm)) {
> +			set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> @@ -431,7 +472,9 @@ static DEVICE_ATTR_WO(assign_domain);
>    * @count:	the number of bytes in @buf
>    *
>    * Parses the APQI from @buf and clears the corresponding bit in the
> - * mediated matrix device's AQM.
> + * mediated matrix device's AQM. If a guest is using the mediated matrix device
> + * and has access to queue(s) with the specified domain APQI, access to
> + * the queue(s) will be taken away from the guest.
>    *
>    * Returns the number of bytes processed if the APQI is valid; otherwise,
>    * returns one of the following errors:
> @@ -447,10 +490,6 @@ static ssize_t unassign_domain_store(struct device *dev,
>   	struct mdev_device *mdev = mdev_from_dev(dev);
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -	/* If the guest is running, disallow un-assignment of domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>   	ret = kstrtoul(buf, 0, &apqi);
>   	if (ret)
>   		return ret;
> @@ -460,6 +499,13 @@ static ssize_t unassign_domain_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
> +
> +	if (matrix_mdev->shadow_crycb) {
> +		if (test_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm)) {
> +			clear_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> @@ -475,7 +521,9 @@ static DEVICE_ATTR_WO(unassign_domain);
>    * @count:	the number of bytes in @buf
>    *
>    * Parses the domain ID from @buf and sets the corresponding bit in the mediated
> - * matrix device's ADM.
> + * matrix device's ADM. If a guest is using the mediated matrix device and the
> + * guest does not have access to the control domain with the specified ID, the
> + * guest will be granted access to it.
>    *
>    * Returns the number of bytes processed if the domain ID is valid; otherwise,
>    * returns one of the following errors:
> @@ -491,10 +539,6 @@ static ssize_t assign_control_domain_store(struct device *dev,
>   	struct mdev_device *mdev = mdev_from_dev(dev);
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -	/* If the guest is running, disallow assignment of control domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>   	ret = kstrtoul(buf, 0, &id);
>   	if (ret)
>   		return ret;
> @@ -504,6 +548,13 @@ static ssize_t assign_control_domain_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   	set_bit_inv(id, matrix_mdev->matrix.adm);
> +
> +	if (matrix_mdev->shadow_crycb) {
> +		if (!test_bit_inv(id, matrix_mdev->shadow_crycb->adm)) {
> +			set_bit_inv(id, matrix_mdev->shadow_crycb->adm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> @@ -519,7 +570,9 @@ static DEVICE_ATTR_WO(assign_control_domain);
>    * @count:	the number of bytes in @buf
>    *
>    * Parses the domain ID from @buf and clears the corresponding bit in the
> - * mediated matrix device's ADM.
> + * mediated matrix device's ADM. If a guest is using the mediated matrix device
> + * and has access to control domain with the specified domain ID, access to
> + * the control domain will be taken from the guest.
>    *
>    * Returns the number of bytes processed if the domain ID is valid; otherwise,
>    * returns one of the following errors:
> @@ -536,10 +589,6 @@ static ssize_t unassign_control_domain_store(struct device *dev,
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
>   
> -	/* If the guest is running, disallow un-assignment of control domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>   	ret = kstrtoul(buf, 0, &domid);
>   	if (ret)
>   		return ret;
> @@ -548,6 +597,13 @@ static ssize_t unassign_control_domain_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   	clear_bit_inv(domid, matrix_mdev->matrix.adm);
> +
> +	if (matrix_mdev->shadow_crycb) {
> +		if (test_bit_inv(domid, matrix_mdev->shadow_crycb->adm)) {
> +			clear_bit_inv(domid, matrix_mdev->shadow_crycb->adm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> 

beside the two NITs, look good to me.
Still need to test.



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v11 05/14] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-6-akrowiak@linux.ibm.com>
 <20201027142711.1b57825e.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <6a5feb16-46b5-9dca-7e85-7d344b0ffa24@linux.ibm.com>
Date: Fri, 13 Nov 2020 12:14:22 -0500
MIME-Version: 1.0
In-Reply-To: <20201027142711.1b57825e.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10/27/20 9:27 AM, Halil Pasic wrote:
> On Thu, 22 Oct 2020 13:12:00 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> Let's implement the callback to indicate when an APQN
>> is in use by the vfio_ap device driver. The callback is
>> invoked whenever a change to the apmask or aqmask would
>> result in one or more queue devices being removed from the driver. The
>> vfio_ap device driver will indicate a resource is in use
>> if the APQN of any of the queue devices to be removed are assigned to
>> any of the matrix mdevs under the driver's control.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     |  1 +
>>   drivers/s390/crypto/vfio_ap_ops.c     | 78 +++++++++++++++++++--------
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   3 files changed, 60 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 73bd073fd5d3..8934471b7944 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -147,6 +147,7 @@ static int __init vfio_ap_init(void)
>>   	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
>>   	vfio_ap_drv.probe = vfio_ap_mdev_probe_queue;
>>   	vfio_ap_drv.remove = vfio_ap_mdev_remove_queue;
>> +	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
>>   	vfio_ap_drv.ids = ap_queue_ids;
>>   
>>   	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 1357f8f8b7e4..9e9fad560859 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -522,18 +522,40 @@ vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
>>   	return 0;
>>   }
>>   
>> +#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
>> +			 "already assigned to %s"
>> +
>> +static void vfio_ap_mdev_log_sharing_err(const char *mdev_name,
>> +					 unsigned long *apm,
>> +					 unsigned long *aqm)
>> +{
>> +	unsigned long apid, apqi;
>> +
>> +	for_each_set_bit_inv(apid, apm, AP_DEVICES)
>> +		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS)
>> +			pr_err(MDEV_SHARING_ERR, apid, apqi, mdev_name);
> Isn't error rather severe for this? For my taste even warning would be
> severe for this.

The user only sees a EADDRINUSE returned from the sysfs interface,
so Conny asked if I could log a message to indicate which APQNs are
in use by which mdev. I can change this to an info message, but it
will be missed if the log level is set higher. Maybe Conny can put in
her two cents here since she asked for this.

>
>> +}
>> +
>>   /**
>>    * vfio_ap_mdev_verify_no_sharing
>>    *
>> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
>> - * and AP queue indexes comprising the AP matrix are not configured for another
>> + * Verifies that each APQN derived from the cross product of the AP adapter IDs
>> + * and AP queue indexes comprising an AP matrix is not assigned to a
>>    * mediated device. AP queue sharing is not allowed.
>>    *
>> - * @matrix_mdev: the mediated matrix device
>> + * @matrix_mdev: the mediated matrix device to which the APQNs being verified
>> + *		 are assigned. If the value is not NULL, then verification will
>> + *		 proceed for all other matrix mediated devices; otherwise, all
>> + *		 matrix mediated devices will be verified.
>> + * @mdev_apm: mask indicating the APIDs of the APQNs to be verified
>> + * @mdev_aqm: mask indicating the APQIs of the APQNs to be verified
>>    *
>> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
>> + * Returns 0 if no APQNs are not shared, otherwise; returns -EADDRINUSE if one
>> + * or more APQNs are shared.
>>    */
>> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>> +static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev,
>> +					  unsigned long *mdev_apm,
>> +					  unsigned long *mdev_aqm)
>>   {
>>   	struct ap_matrix_mdev *lstdev;
>>   	DECLARE_BITMAP(apm, AP_DEVICES);
>> @@ -550,14 +572,15 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>>   		 * We work on full longs, as we can only exclude the leftover
>>   		 * bits in non-inverse order. The leftover is all zeros.
>>   		 */
>> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
>> -				lstdev->matrix.apm, AP_DEVICES))
>> +		if (!bitmap_and(apm, mdev_apm, lstdev->matrix.apm, AP_DEVICES))
>>   			continue;
>>   
>> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
>> -				lstdev->matrix.aqm, AP_DOMAINS))
>> +		if (!bitmap_and(aqm, mdev_aqm, lstdev->matrix.aqm, AP_DOMAINS))
>>   			continue;
>>   
>> +		vfio_ap_mdev_log_sharing_err(dev_name(mdev_dev(lstdev->mdev)),
>> +					     apm, aqm);
>> +
>>   		return -EADDRINUSE;
>>   	}
>>   
>> @@ -683,6 +706,7 @@ static ssize_t assign_adapter_store(struct device *dev,
>>   {
>>   	int ret;
>>   	unsigned long apid;
>> +	DECLARE_BITMAP(apm, AP_DEVICES);
>>   	struct mdev_device *mdev = mdev_from_dev(dev);
>>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>   
>> @@ -708,18 +732,18 @@ static ssize_t assign_adapter_store(struct device *dev,
>>   	if (ret)
>>   		goto done;
>>   
>> -	set_bit_inv(apid, matrix_mdev->matrix.apm);
>> +	memset(apm, 0, sizeof(apm));
>> +	set_bit_inv(apid, apm);
>>   
>> -	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
>> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev, apm,
>> +					     matrix_mdev->matrix.aqm);
> What is the benefit of using a copy here? I mean we have the vfio_ap lock
> so nobody can see the bit we speculatively flipped.

The vfio_ap_mdev_verify_no_sharing() function definition was changed
so that it can also be re-used by the vfio_ap_mdev_resource_in_use()
function rather than duplicating that code for the in_use callback. The
in-use callback is invoked by the AP bus which has no concept of
a mediated device, so I made this change to accommodate that fact.

>
> I've also pointed out in the previous patch that in_use() isn't
> perfectly reliable (at least in theory) because of a race.

We discussed that privately and determined that the sysfs assignment
interfaces will use mutex_trylock() to avoid races.

>
> Otherwise looks good to me!
>
>>   	if (ret)
>> -		goto share_err;
>> +		goto done;
>>   
>> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
>>   	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APID, apid);
>>   	ret = count;
>> -	goto done;
>>   
>> -share_err:
>> -	clear_bit_inv(apid, matrix_mdev->matrix.apm);
>>   done:
>>   	mutex_unlock(&matrix_dev->lock);
>>   
>> @@ -831,6 +855,7 @@ static ssize_t assign_domain_store(struct device *dev,
>>   {
>>   	int ret;
>>   	unsigned long apqi;
>> +	DECLARE_BITMAP(aqm, AP_DOMAINS);
>>   	struct mdev_device *mdev = mdev_from_dev(dev);
>>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>   	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
>> @@ -851,18 +876,18 @@ static ssize_t assign_domain_store(struct device *dev,
>>   	if (ret)
>>   		goto done;
>>   
>> -	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
>> +	memset(aqm, 0, sizeof(aqm));
>> +	set_bit_inv(apqi, aqm);
>>   
>> -	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
>> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev,
>> +					     matrix_mdev->matrix.apm, aqm);
>>   	if (ret)
>> -		goto share_err;
>> +		goto done;
>>   
>> +	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
>>   	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APQI, apqi);
>>   	ret = count;
>> -	goto done;
>>   
>> -share_err:
>> -	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
>>   done:
>>   	mutex_unlock(&matrix_dev->lock);
>>   
>> @@ -1442,3 +1467,14 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>>   	kfree(q);
>>   	mutex_unlock(&matrix_dev->lock);
>>   }
>> +
>> +bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
>> +{
>> +	bool in_use;
>> +
>> +	mutex_lock(&matrix_dev->lock);
>> +	in_use = !!vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
>> +	mutex_unlock(&matrix_dev->lock);
>> +
>> +	return in_use;
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 4e5cc72fc0db..c1d8b5507610 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -105,4 +105,6 @@ struct vfio_ap_queue {
>>   int vfio_ap_mdev_probe_queue(struct ap_device *queue);
>>   void vfio_ap_mdev_remove_queue(struct ap_device *queue);
>>   
>> +bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */

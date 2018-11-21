From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 21 Nov 2018 18:13:25 +0000
Subject: Re: [PATCH 3/5] vfio: ccw: Set subchannel state STANDBY on open
Message-Id: <cfb16c56-58f9-22a6-3eab-d83650940e87@linux.ibm.com>
In-Reply-To: <20181121174846.2ea0033c.cohuck@redhat.com>
References: <20181121174846.2ea0033c.cohuck@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 21/11/2018 17:48, Cornelia Huck wrote:
> On Wed, 17 Oct 2018 11:18:41 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> The subchannel enablement and the according setting to the
>> VFIO_CCW_STATE_STANDBY state should only be done when all
>> parts of the VFIO mediated device have been initialized
>> i.e. after the mediated device has been successfully opened.
>>
>> Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
>> device has been opened.
>>
>> When the mediated device is closed,  disable the sub channel
>> by calling vfio_ccw_sch_quiesce().
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c | 10 +---------
>>   drivers/s390/cio/vfio_ccw_ops.c | 23 +++++++++++++++++++++--
>>   2 files changed, 22 insertions(+), 11 deletions(-)
> 
> (...)
> 
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index f673e10..87a8f8c 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -146,11 +146,29 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
>>   	struct vfio_ccw_private *private =
>>   		dev_get_drvdata(mdev_parent_dev(mdev));
>>   	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> +	struct subchannel *sch = private->sch;
>> +	int ret;
>>   
>>   	private->nb.notifier_call = vfio_ccw_mdev_notifier;
>>   
>> -	return vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> -				      &events, &private->nb);
>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				     &events, &private->nb);
>> +	if (ret)
>> +		return ret;
>> +
>> +	spin_lock_irq(private->sch->lock);
>> +	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
>> +		goto error;
>> +
>> +	private->state = VFIO_CCW_STATE_STANDBY;
>> +	spin_unlock_irq(sch->lock);
>> +	return 0;
>> +
>> +error:
>> +	spin_unlock_irq(sch->lock);
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				 &private->nb);
>> +	return -EFAULT;
> 
> This -EFAULT looks a bit odd. Wouldn't it make more sense to relay the
> return code of cio_enable_subchannel() here?

It looks odd.

It took me a long time to go through the code to see what happens with 
these error codes and why.

... for at the end agree with your conclusion that returning the 
cio_enable_subchannel() code is the best solution.

The QEMU code currently do not make use of the return value but we open 
us possibilities for retries or analyze.

Thanks.
Regards,

Pierre

> 
>>   }
>>   
>>   static void vfio_ccw_mdev_release(struct mdev_device *mdev)
>> @@ -158,6 +176,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
>>   	struct vfio_ccw_private *private =
>>   		dev_get_drvdata(mdev_parent_dev(mdev));
>>   
>> +	vfio_ccw_sch_quiesce(private->sch);
>>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>   				 &private->nb);
>>   }
> 


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany

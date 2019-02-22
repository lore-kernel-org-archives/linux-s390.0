From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
Date: Fri, 22 Feb 2019 10:04:55 -0500
Message-ID: <522c48c8-411d-3363-17e1-8b0da0b07cc4@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
 <56f583e7-fb41-ec54-ccf9-585a3e51b1c4@linux.ibm.com>
 <20190218132111.3684b1f1.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218132111.3684b1f1.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/18/19 7:21 AM, Cornelia Huck wrote:
> On Fri, 15 Feb 2019 17:13:21 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>> We need to find the queue with a specific APQN during the
>>> handling of the interception of the PQAP/AQIC instruction.
>>>
>>> To handle the AP associated device reference count we keep
>>> track of it in the vfio_ap_queue until we put the device.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
>>>    drivers/s390/crypto/vfio_ap_private.h |  1 +
>>>    2 files changed, 55 insertions(+)
> 
>>> +/**
>>> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
>>> + * @apqn: The queue APQN
>>> + *
>>> + * Retrieve a queue with a specific APQN from the list of the
>>> + * devices associated to the vfio_ap_driver.
>>> + *
>>> + * The vfio_ap_queue has been already associated with the device
>>> + * during the probe.
>>> + * Store the associated device for reference counting
>>> + *
>>> + * Returns the pointer to the associated vfio_ap_queue
>>> + */
>>> +static  __attribute__((unused))
>>> +	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
>>
>> I think you should change this signature for the reasons I stated
>> below:
>>
>> struct device *vfio_ap_get_queue_dev(int apqn)
>>
>>> +{
>>> +	struct device *dev;
>>> +	struct vfio_ap_queue *q;
>>> +
>>> +	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL, &apqn,
>>> +				 vfio_ap_check_apqn);
>>> +	if (!dev)
>>> +		return NULL;
>>> +	q = dev_get_drvdata(dev);
>>> +	q->dev = dev;
>>
>> Why store the device with the vfio_ap_queue object? Why not just return
>> the device. The caller can get the vfio_ap_queue from the device's
>> driver data. It seems the only reason for the 'dev' field is to
>> temporarily hold a ref to the device so it can be put later. Why not
>> just put the device.

After thinking about this further, I question whether we even need
this function if it is going to return 'struct device *'. In that case,
why not just call driver_find_device() when the device is needed?
If you want to keep the function, then the function needs only one 
statement:

	return driver_find_device(...).

> 
> Having looked at the remainder of the patches, I tend to agree that we
> don't really need the backlink; we walk the driver's list of devices in
> any case IIUC.
> 
> We *might* want a mechanism to grab the queue quickly (i.e. without
> walking the list) if there's anything performance sensitive in there;
> but from the patch descriptions, I don't think anything is done in a
> hot path, so it should be fine.
> 

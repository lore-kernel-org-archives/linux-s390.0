Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53974 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406230AbgDORKW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:22 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-4-akrowiak@linux.ibm.com>
 <20200414145851.562867ae.cohuck@redhat.com>
Message-ID: <35d8c3cb-78bb-8f84-41d8-c6e59d201ba0@linux.ibm.com>
Date: Wed, 15 Apr 2020 13:10:10 -0400
MIME-Version: 1.0
In-Reply-To: <20200414145851.562867ae.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 4/14/20 8:58 AM, Cornelia Huck wrote:
> On Tue,  7 Apr 2020 15:20:03 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> Introduces a new driver callback to prevent a root user from unbinding
>> an AP queue from its device driver if the queue is in use. The intent of
>> this callback is to provide a driver with the means to prevent a root user
>> from inadvertently taking a queue away from a guest and giving it to the
>> host while the guest is still using it. The callback will
>> be invoked whenever a change to the AP bus's sysfs apmask or aqmask
>> attributes would result in one or more AP queues being removed from its
>> driver. If the callback responds in the affirmative for any driver
>> queried, the change to the apmask or aqmask will be rejected with a device
>> in use error.
>>
>> For this patch, only non-default drivers will be queried. Currently,
>> there is only one non-default driver, the vfio_ap device driver. The
>> vfio_ap device driver manages AP queues passed through to one or more
>> guests and we don't want to unexpectedly take AP resources away from
>> guests which are most likely independently administered.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/ap_bus.c | 144 +++++++++++++++++++++++++++++++++--
>>   drivers/s390/crypto/ap_bus.h |   4 +
>>   2 files changed, 142 insertions(+), 6 deletions(-)
> (...)
>
>> @@ -1196,12 +1202,75 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
>>   	return rc;
>>   }
>>   
>> +int __verify_card_reservations(struct device_driver *drv, void *data)
>> +{
>> +	int rc = 0;
>> +	struct ap_driver *ap_drv = to_ap_drv(drv);
>> +	unsigned long *newapm = (unsigned long *)data;
>> +
>> +	/*
>> +	 * If the reserved bits do not identify cards reserved for use by the
>> +	 * non-default driver, there is no need to verify the driver is using
>> +	 * the queues.
> I had to read that one several times... what about
> "No need to verify whether the driver is using the queues if it is the
> default driver."
>
> ?

Sure, that's better.

>
>> +	 */
>> +	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
>> +		return 0;
>> +
>> +	/* The non-default driver's module must be loaded */
>> +	if (!try_module_get(drv->owner))
>> +		return 0;
> Is that really needed? I would have thought that the driver core's
> klist usage would make sure that the callback would not be invoked for
> drivers that are not registered anymore. Or am I missing a window?
>
>> +
>> +	if (ap_drv->in_use)
>> +		if (ap_drv->in_use(newapm, ap_perms.aqm))
> Can we log the offending apm somewhere, preferably with additional info
> that allows the admin to figure out why an error was returned?

One of the things on my TODO list is to add logging to the vfio_ap
module which will track all significant activity within the device
driver. I plan to do that with a patch or set of patches specifically
put together for that purpose. Having said that, the best place to
log this would be in the in_use callback in the vfio_ap device driver
(see next patch) where the APQNs that are in use can be identified.
For now, I will log a message to the dmesg log indicating which
APQNs are in use by the matrix mdev.

>
>> +			rc = -EADDRINUSE;
>> +
>> +	module_put(drv->owner);
>> +
>> +	return rc;
>> +}
> (Same comments for the other changes further along in this patch.)
>

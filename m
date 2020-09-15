Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57244 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727686AbgIOTdr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 15:33:47 -0400
Subject: Re: [PATCH v10 04/16] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-5-akrowiak@linux.ibm.com>
 <20200914172947.533ddf56.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <fe3ba715-8ea7-45df-4144-d1f5dec38a45@linux.ibm.com>
Date: Tue, 15 Sep 2020 15:32:35 -0400
MIME-Version: 1.0
In-Reply-To: <20200914172947.533ddf56.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>



On 9/14/20 11:29 AM, Cornelia Huck wrote:
> On Fri, 21 Aug 2020 15:56:04 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> Introduces a new driver callback to prevent a root user from unbinding
>> an AP queue from its device driver if the queue is in use. The intent of
>> this callback is to provide a driver with the means to prevent a root user
>> from inadvertently taking a queue away from a matrix mdev and giving it to
>> the host while it is assigned to the matrix mdev. The callback will
>> be invoked whenever a change to the AP bus's sysfs apmask or aqmask
>> attributes would result in one or more AP queues being removed from its
>> driver. If the callback responds in the affirmative for any driver
>> queried, the change to the apmask or aqmask will be rejected with a device
>> in use error.
>>
>> For this patch, only non-default drivers will be queried. Currently,
>> there is only one non-default driver, the vfio_ap device driver. The
>> vfio_ap device driver facilitates pass-through of an AP queue to a
>> guest. The idea here is that a guest may be administered by a different
>> sysadmin than the host and we don't want AP resources to unexpectedly
>> disappear from a guest's AP configuration (i.e., adapters, domains and
>> control domains assigned to the matrix mdev). This will enforce the proper
>> procedure for removing AP resources intended for guest usage which is to
>> first unassign them from the matrix mdev, then unbind them from the
>> vfio_ap device driver.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> This looks a bit odd...

I've removed all of those. These kernel test robot errors were flagged
in the last series. The review comments from the robot suggested
the reported-by, but I assume that was for patches intended to
fix those errors, so I am removing these as per Christian's comments.

>
>> ---
>>   drivers/s390/crypto/ap_bus.c | 148 ++++++++++++++++++++++++++++++++---
>>   drivers/s390/crypto/ap_bus.h |   4 +
>>   2 files changed, 142 insertions(+), 10 deletions(-)
>>
> (...)
>
>> @@ -1107,12 +1118,70 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
>>   	return rc;
>>   }
>>   
>> +static int __verify_card_reservations(struct device_driver *drv, void *data)
>> +{
>> +	int rc = 0;
>> +	struct ap_driver *ap_drv = to_ap_drv(drv);
>> +	unsigned long *newapm = (unsigned long *)data;
>> +
>> +	/*
>> +	 * No need to verify whether the driver is using the queues if it is the
>> +	 * default driver.
>> +	 */
>> +	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
>> +		return 0;
>> +
>> +	/* The non-default driver's module must be loaded */
>> +	if (!try_module_get(drv->owner))
>> +		return 0;
>> +
>> +	if (ap_drv->in_use)
>> +		if (ap_drv->in_use(newapm, ap_perms.aqm))
>> +			rc = -EADDRINUSE;
> ISTR that Christian suggested -EBUSY in a past revision of this series?
> I think that would be more appropriate.

I went back and looked and sure enough, he did recommend that.
You have a great memory! I didn't respond to that comment, so I
must have missed it at the time.

I personally prefer EADDRINUSE because I think it is more indicative
of the reason an AP resource can not be assigned back to the host
drivers is because it is in use by a guest or, at the very least, reserved
for use by a guest (i.e., assigned to an mdev). To say it is busy implies
that the device is busy performing encryption services which may or
may not be true at a given moment. Even if so, that is not the reason
for refusing to allow reassignment of the device.

>
> Also, I know we have discussed this before, but it is very hard to
> figure out the offending device(s) if the sysfs manipulation failed. Can
> we at least drop something into the syslog? That would be far from
> perfect, but it gives an admin at least a chance to figure out why they
> got an error. Some more structured way that would be usable from tools
> can still be added later.

I see you found the patch that logged this:)

>
>> +
>> +	module_put(drv->owner);
>> +
>> +	return rc;
>> +}

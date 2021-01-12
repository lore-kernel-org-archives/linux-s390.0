Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbhALOPA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 09:15:00 -0500
Subject: Re: [PATCH v13 11/15] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
 <20201223011606.5265-12-akrowiak@linux.ibm.com>
 <20210112022012.4bad464f.pasic@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <d717a554-6d0c-6075-38fd-e725b9622437@linux.ibm.com>
Date: Tue, 12 Jan 2021 09:14:07 -0500
MIME-Version: 1.0
In-Reply-To: <20210112022012.4bad464f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On 1/11/21 8:20 PM, Halil Pasic wrote:
> On Tue, 22 Dec 2020 20:16:02 -0500
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
>> There is potential for a deadlock condition between the matrix_dev->lock
>> used to lock the matrix device during assignment of adapters and domains
>> and the ap_perms_mutex locked by the AP bus when changes are made to the
>> sysfs apmask/aqmask attributes.
>>
>> Consider following scenario (courtesy of Halil Pasic):
>> 1) apmask_store() takes ap_perms_mutex
>> 2) assign_adapter_store() takes matrix_dev->lock
>> 3) apmask_store() calls vfio_ap_mdev_resource_in_use() which tries
>>     to take matrix_dev->lock
>> 4) assign_adapter_store() calls ap_apqn_in_matrix_owned_by_def_drv
>>     which tries to take ap_perms_mutex
>>
>> BANG!
>>
>> To resolve this issue, instead of using the mutex_lock(&matrix_dev->lock)
>> function to lock the matrix device during assignment of an adapter or
>> domain to a matrix_mdev as well as during the in_use callback, the
>> mutex_trylock(&matrix_dev->lock) function will be used. If the lock is not
>> obtained, then the assignment and in_use functions will terminate with
>> -EBUSY.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     |  1 +
>>   drivers/s390/crypto/vfio_ap_ops.c     | 21 ++++++++++++++++++---
>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>   3 files changed, 21 insertions(+), 3 deletions(-)
>>
> [..]
>>   }
>> +
>> +int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
>> +{
>> +	int ret;
>> +
>> +	if (!mutex_trylock(&matrix_dev->lock))
>> +		return -EBUSY;
>> +	ret = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
> 
> If we detect that resources are in use, then we spit warnings to the
> message log, right?
> 
> @Matt: Is your userspace tooling going to guarantee that this will never
> happen?

Yes, but only when using the tooling to modify apmask/aqmask.  You would 
still be able to create such a scenario by bypassing the tooling and 
invoking the sysfs interfaces directly.

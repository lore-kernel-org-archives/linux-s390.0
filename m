Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgLODxE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Dec 2020 22:53:04 -0500
Subject: Re: [PATCH v12 07/17] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
 <20201124214016.3013-8-akrowiak@linux.ibm.com>
 <20201126165431.6ef1457a.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <56ffa0c6-0518-907e-2635-ff3d7cf1f395@linux.ibm.com>
Date: Mon, 14 Dec 2020 22:52:17 -0500
MIME-Version: 1.0
In-Reply-To: <20201126165431.6ef1457a.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 11/26/20 10:54 AM, Halil Pasic wrote:
> On Tue, 24 Nov 2020 16:40:06 -0500
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
> Good news is: the final product is OK with regards to in_use(). Bad news
> is: this patch does not do enough. At this stage we are still racy.
>
> The problem is that the assign operations don't bother to take the
> ap_perms_mutex lock under the matrix_dev->lock.
>
> The scenario is the following:
> 1) apmask_store() takes ap_perms_mutex
> 2) apmask_store() calls vfio_ap_mdev_resource_in_use() which
>       takes matrix_dev->lock
> 3) vfio_ap_mdev_resource_in_use() releases matrix_dev->lock
>     and returns 0
> 4) assign_adapter_store() takes matrix_dev->lock does the
>     assign (the queues are still bound to vfio_ap) and releases
>     matrix_dev->lock
> 5) apmask_store() carries on, does the update to apask and releases
>     ap_perms_mutex
> 6) The queues get 'stolen' from vfio ap while used.

You're missing an interim step between 5 and 6 where the apmask_store()
function executes the device_reprobe() function which results in queues
to be taken from vfio_ap getting unbound. In this case, the
vfio_ap_mdev_remove_queue() function gets called to remove the
queues resulting in unplugging

>
> This gets fixed with "s390/vfio-ap: allow assignment of unavailable AP
> queues to mdev device". Maybe we can reorder these patches. I didn't
> look into that.
>
> We could also just ignore the problem, because it is just for a couple
> of commits, but I would prefer it gone.

Reordering the patches is not a trivial task, I perfer not to do it.

>
> Regards,
> Halil
>     
>
>

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730237AbgDQLXL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 07:23:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HB5Osx039116
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 07:23:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30fay90vev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 07:23:10 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 17 Apr 2020 12:23:03 +0100
Subject: Re: [PATCH v7 04/15] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-5-akrowiak@linux.ibm.com>
 <20200416131845.3ef6b3b5.cohuck@redhat.com>
 <5cf7d611-e30c-226d-0d3d-d37170f117f4@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 17 Apr 2020 13:23:03 +0200
MIME-Version: 1.0
In-Reply-To: <5cf7d611-e30c-226d-0d3d-d37170f117f4@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <458e4bfe-6736-42b5-a510-21a4594df0e1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 2020-04-16 16:45, Tony Krowiak wrote:
> 
> 
> On 4/16/20 7:18 AM, Cornelia Huck wrote:
>> On Tue,  7 Apr 2020 15:20:04 -0400
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> Let's implement the callback to indicate when an APQN
>>> is in use by the vfio_ap device driver. The callback is
>>> invoked whenever a change to the apmask or aqmask would
>>> result in one or more queue devices being removed from the driver. The
>>> vfio_ap device driver will indicate a resource is in use
>>> if the APQN of any of the queue devices to be removed are assigned to
>>> any of the matrix mdevs under the driver's control.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_drv.c     |  1 +
>>>   drivers/s390/crypto/vfio_ap_ops.c     | 47 +++++++++++++++++----------
>>>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>>   3 files changed, 33 insertions(+), 17 deletions(-)
>>> @@ -1369,3 +1371,14 @@ void vfio_ap_mdev_remove_queue(struct ap_queue 
>>> *queue)
>>>       kfree(q);
>>>       mutex_unlock(&matrix_dev->lock);
>>>   }
>>> +
>>> +bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long 
>>> *aqm)
>>> +{
>>> +    bool in_use;
>>> +
>>> +    mutex_lock(&matrix_dev->lock);
>>> +    in_use = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm) ? true : 
>>> false;
>> Maybe
>>
>> in_use = !!vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
>>
>> ?
> 
> To be honest, I find the !! expression very confusing. Every time I see 
> it, I have
> to spend time thinking about what the result of !! is going to be. I think
> the statement should be left as-is because it more clearly expresses
> the intent.



In other places you use
"
         ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
         if (ret)
                 goto share_err;
"
then why use a boolean here?

If you want to return a boolean and you do not want to use !! you can do:

  ...
   ret = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
...
   return (ret) ? false : true;

> 
>>
>>> +    mutex_unlock(&matrix_dev->lock);
>>> +
>>> +    return in_use;
>>> +}
> 

-- 
Pierre Morel
IBM Lab Boeblingen

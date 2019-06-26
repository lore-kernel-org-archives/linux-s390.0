Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZVOB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 17:14:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QLE0Ru043386
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 17:14:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcgemg01t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 17:13:59 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 26 Jun 2019 22:13:59 +0100
Subject: Re: [PATCH v4 3/7] s390: zcrypt: driver callback to indicate resource
 in use
From: Tony Krowiak <akrowiak@linux.ibm.com>
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
 <1560454780-20359-4-git-send-email-akrowiak@linux.ibm.com>
 <20190618182558.7d7e025a.cohuck@redhat.com>
 <2366c6b6-fd9e-0c32-0e9d-018cd601a0ad@linux.ibm.com>
Date: Wed, 26 Jun 2019 17:13:50 -0400
MIME-Version: 1.0
In-Reply-To: <2366c6b6-fd9e-0c32-0e9d-018cd601a0ad@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <44f13e89-2fb4-bf8c-7849-641aae8d08cc@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

On 6/19/19 9:04 AM, Tony Krowiak wrote:
> On 6/18/19 12:25 PM, Cornelia Huck wrote:
>> On Thu, 13 Jun 2019 15:39:36 -0400
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> Introduces a new driver callback to prevent a root user from unbinding
>>> an AP queue from its device driver if the queue is in use. This prevents
>>> a root user from inadvertently taking a queue away from a guest and
>>> giving it to the host, or vice versa. The callback will be invoked
>>> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
>>> result in one or more AP queues being removed from its driver. If the
>>> callback responds in the affirmative for any driver queried, the change
>>> to the apmask or aqmask will be rejected with a device in use error.
>>>
>>> For this patch, only non-default drivers will be queried. Currently,
>>> there is only one non-default driver, the vfio_ap device driver. The
>>> vfio_ap device driver manages AP queues passed through to one or more
>>> guests and we don't want to unexpectedly take AP resources away from
>>> guests which are most likely independently administered.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/ap_bus.c | 138 
>>> +++++++++++++++++++++++++++++++++++++++++--
>>>   drivers/s390/crypto/ap_bus.h |   3 +
>>>   2 files changed, 135 insertions(+), 6 deletions(-)
>>
>> Hm... I recall objecting to this patch before, fearing that it makes it
>> possible for a bad actor to hog resources that can't be removed by
>> root, even forcefully. (I have not had time to look at the intervening
>> versions, so I might be missing something.)
>>
>> Is there a way for root to forcefully override this?
> 
> You recall correctly; however, after many internal crypto team
> discussions, it was decided that this feature was important
> and should be kept.
> 
> Allow me to first address your fear that a bad actor can hog
> resources that can't be removed by root. With this enhancement,
> there is nothing preventing a root user from taking resources
> from a matrix mdev, it simply forces him/her to follow the
> proper procedure. The resources to be removed must first be
> unassigned from the matrix mdev to which they are assigned.
> The AP bus's /sys/bus/ap/apmask and /sys/bus/ap/aqmask
> sysfs attributes can then be edited to transfer ownership
> of the resources to zcrypt.
> 
> The rationale for keeping this feature is:
> 
> * It is a bad idea to steal an adapter in use from a guest. In the worst
>    case, the guest could end up without access to any crypto adapters
>    without knowing why. This could lead to performance issues on guests
>    that rely heavily on crypto such as guests used for blockchain
>    transactions.
> 
> * There are plenty of examples in linux of the kernel preventing a root
>    user from performing a task. For example, a module can't be removed
>    if references are still held for it. Another example would be trying
>    to bind a CEX4 adapter to a device driver not registered for CEX4;
>    this action will also be rejected.
> 
> * The semantics are much cleaner and the logic is far less complicated.
> 
> * It forces the use of the proper procedure to change ownership of AP
>    queues.
>

Any feedback on this?

Tony K

> 
>>
> 

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgJ3VNq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Oct 2020 17:13:46 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v11 01/14] s390/vfio-ap: No need to disable IRQ after
 queue reset
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-2-akrowiak@linux.ibm.com>
 <20201027074846.30ee0ddc.pasic@linux.ibm.com>
 <7a2c5930-9c37-8763-7e5d-c08a3638e6a1@linux.ibm.com>
 <20201030185406.7fa13fbe.pasic@linux.ibm.com>
 <d1aae333-3f10-bd21-257f-baf8f8df7a24@linux.ibm.com>
Message-ID: <684234fa-03a9-71cd-14f3-ddf9b06e7e2e@linux.ibm.com>
Date: Fri, 30 Oct 2020 17:13:38 -0400
MIME-Version: 1.0
In-Reply-To: <d1aae333-3f10-bd21-257f-baf8f8df7a24@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 10/30/20 4:53 PM, Tony Krowiak wrote:
>
>
> On 10/30/20 1:54 PM, Halil Pasic wrote:
>> On Thu, 29 Oct 2020 19:29:35 -0400
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>>>> @@ -1177,7 +1166,10 @@ static int vfio_ap_mdev_reset_queues(struct 
>>>>> mdev_device *mdev)
>>>>>                 */
>>>>>                if (ret)
>>>>>                    rc = ret;
>>>>> -            vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
>>>>> +            q = vfio_ap_get_queue(matrix_mdev,
>>>>> +                          AP_MKQID(apid, apqi));
>>>>> +            if (q)
>>>>> +                vfio_ap_free_aqic_resources(q);
>> [..]
>>
>>>> Under what circumstances do we expect !q? If we don't, then we need to
>>>> complain one way or another.
>>> In the current code (i.e., prior to introducing the subsequent hot
>>> plug patches), an APQN can not be assigned to an mdev unless it
>>> references a queue device bound to the vfio_ap device driver; however,
>>> there is nothing preventing a queue device from getting unbound
>>> while the guest is running (one of the problems mostly resolved by this
>>> series). In that case, q would be NULL.
>> But if the queue does not belong to us any more it does not make sense
>> call vfio_ap_mdev_reset_queue() on it's APQN, or?
>
> This is precisely why we prevent a queue from being taken away
> from vfio_ap (the in-use callback) when its APQN is assigned to an
> mdev in this patch series. On the other hand, this is a very good
> point.
>
>>
>> I think we should have
>>
>> if(!q)
>>     continue;
>> at the very beginning of the loop body, or we want to be sure that q is
>> not null.
>
> I agree, I'll go ahead and make this change.

After thinking about this a bit more, I don't think it makes sense to make
this change in this patch. For the current implementation, it is incumbent
upon the system administrator to ensure that a queue device is not unbound
from the vfio_ap device driver if its APQN is assigned to an mdev, so the
assumption here is that any APQN assigned to the mdev is (or was) bound to
the vfio_ap driver. If it was erroneously unbound while in use by a guest,
then both the guest and possibly the zcrypt driver will have simultaneous
access (one of the things fixed by this patch series). In that case, I think
it ought to be reset regardless of whether it is bound to vfio_ap or not.

Having said that, I think it makes sense to make the change you recommend
in patch 03/14. In that patch, the vfio_ap_queue object is retrieved 
from the
matrix_mdev. Since these queue objects are linked only when the queue
device is probed and unlinked when the the queue device is removed and
a queue device can not get bound to another driver while its APQN is 
assigned
to an mdev, it would make perfect sense to forego reset of a queue when
its APQN is assigned to an mdev.

>
>
>
>
>>
>

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730458AbgLDTtu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 14:49:50 -0500
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM pointer
 invalidated
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
 <20201203185514.54060568.pasic@linux.ibm.com>
 <a5a613ef-4c74-ad68-46bd-7159fbafef47@linux.ibm.com>
 <20201204175707.13f019cf.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <8e3caeb1-49b1-0b00-a6e6-80e98f5d82e9@linux.ibm.com>
Date: Fri, 4 Dec 2020 14:47:50 -0500
MIME-Version: 1.0
In-Reply-To: <20201204175707.13f019cf.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com



On 12/4/20 11:57 AM, Cornelia Huck wrote:
> On Fri, 4 Dec 2020 11:48:24 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 12/3/20 12:55 PM, Halil Pasic wrote:
>>> On Wed,  2 Dec 2020 18:41:01 -0500
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> The vfio_ap device driver registers a group notifier with VFIO when the
>>>> file descriptor for a VFIO mediated device for a KVM guest is opened to
>>>> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
>>>> event). When the KVM pointer is set, the vfio_ap driver stashes the pointer
>>>> and calls the kvm_get_kvm() function to increment its reference counter.
>>>> When the notifier is called to make notification that the KVM pointer has
>>>> been set to NULL, the driver should clean up any resources associated with
>>>> the KVM pointer and decrement its reference counter. The current
>>>> implementation does not take care of this clean up.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Do we need a Fixes tag? Do we need this backported? In my opinion
>>> this is necessary since the interrupt patches.
>> I'll put in a fixes tag:
>> Fixes: 258287c994de (s390: vfio-ap: implement mediated device open callback)
> The canonical format would be
>
> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")

Okay.

>
>> Yes, this should probably be backported.
>>
>>>   
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++--------
>>>>    1 file changed, 13 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>>> index e0bde8518745..eeb9c9130756 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -1083,6 +1083,17 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>>>>    	return NOTIFY_DONE;
>>>>    }
>>>>    
>>>> +static void vfio_ap_mdev_put_kvm(struct ap_matrix_mdev *matrix_mdev)
>>> I don't like the name. The function does more that put_kvm. Maybe
>>> something  like _disconnect_kvm()?
>> Since the vfio_ap_mdev_set_kvm() function is called by the
>> notifier when the KVM pointer is set, how about:
>>
>> vfio_ap_mdev_unset_kvm()
>>
>> for when the KVM pointer is nullified?
> Sounds good to me.
>

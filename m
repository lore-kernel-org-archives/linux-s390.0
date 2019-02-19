From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
Date: Tue, 19 Feb 2019 20:04:22 +0100
Message-ID: <fb4711cb-bcd6-ff63-7a73-c9452ea7564b@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
 <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
 <20190219105946.29e510a6@oc2783563651>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219105946.29e510a6@oc2783563651>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 19/02/2019 10:59, Halil Pasic wrote:
> On Fri, 15 Feb 2019 17:55:35 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>> To be able to use the VFIO interface to facilitate the
>>> mediated device memory pining/unpining we need to register
>>> a notifier for IOMMU.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    drivers/s390/crypto/vfio_ap_ops.c     | 64 +++++++++++++++++++++++++++++++----
>>>    drivers/s390/crypto/vfio_ap_private.h |  2 ++
>>>    2 files changed, 60 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 1851b24..6eddc2c 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> 
> [..]
>    	struct vfio_ap_queue *q;
>>> @@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>>    
>>>    	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>    				     &events, &matrix_mdev->group_notifier);
>>> -	if (ret) {
>>> -		module_put(THIS_MODULE);
>>> -		return ret;
>>> -	}
>>> +	if (ret)
>>> +		goto err_group;
>>> +
>>> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>>> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>>> +
>>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>> +				     &events, &matrix_mdev->iommu_notifier);
>>> +	if (ret)
>>> +		goto err_iommu;
>>> +
>>> +	ret = vfio_ap_associate_queues(matrix_mdev);
>>> +	if (ret)
>>> +		goto err_associate;
>>
>> I think the matrix_mdev should be associated with queues when an
>> assignment of an adapter or domain is made to the mdev device via its
>> sysfs interfaces. I say this because assigning an adapter or domain to
>> an mdev device effectively grants ownership of any additional AP queues
>> added to the mdev device's AP matrix as a result of the assignment. It
>> only makes sense to assign ownership to the vfio_ap_queue objects
>> representing the queues at that time. If an adapter or domain is
>> dynamically assigned while a guest is using the affected queues, then
>> the associations will have to be made at that time and this code will
>> likely go bye bye.
>>
> 
> 
> Actually, we need the stuff in vfio_ap_queues only if the guest is
> offered to  decides to use AP adaper interrupts. I would prefer to have
> it around only when needed: as long as we have the nib pinned for any
> given queue. Is there a reason why not to do so?
> 
> Regards,
> Halil
>   
> [..]
> 

Since I will rework the vfio_ap_queue life cycle, I will study this.
But I find the creation / deletion in probe/remove and the link/unlimk 
to the matrix device in assign/un_assign as suggested by Tony more logical.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

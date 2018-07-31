From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 31 Jul 2018 15:49:33 +0000
Subject: Re: [PATCH v7 18/22] s390: vfio-ap: zeroize the AP queues.
Message-Id: <ab6c98e9-a109-d4d4-59cd-c6606d2849ac@linux.ibm.com>
In-Reply-To: <74727f11-9b1a-8bd6-16bd-c0164d4b5ee7@linux.ibm.com>
References: <74727f11-9b1a-8bd6-16bd-c0164d4b5ee7@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 07/31/2018 04:48 PM, Cornelia Huck wrote:
> On Tue, 31 Jul 2018 16:18:03 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 07/31/2018 03:40 PM, Cornelia Huck wrote:
>>> On Tue, 31 Jul 2018 15:12:59 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On 07/31/2018 02:24 PM, Cornelia Huck wrote:
>>>>>> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev, bool force)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +	int rc = 0;
>>>>>> +	unsigned long apid, apqi;
>>>>>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>>> +
>>>>>> +	if (!matrix_mdev->activated) {
>>>>>> +		pr_err("%s: reset failed for mdev %s, not activated",
>>>>>> +		       VFIO_AP_MODULE_NAME, matrix_mdev->name);
>>>>>> +
>>>>>> +		return -EPERM;
>>>>>> +	}
>>>>> Hm... if we stick with the activation approach, what happens if we:
>>>>> - open the mdev
>>>>> - activate the matrix
>>>>> - deactivate the matrix
>>>>
>>>> I guess this step will fail and the matrix remains activated.
>>>>
>>>> Have a look at vfio_ap_mdev_deactivate()
>>>
>>> Hm, I don't see it...
>>>    
>> static int vfio_ap_mdev_deactivate(struct ap_matrix_mdev *matrix_mdev)
>> {
>>           int ret = 0;
>>                                                                                   
>>           if (!matrix_mdev->activated)
>>                   return 0;
>>                                                                                   
>>           if (matrix_mdev->kvm) {
>>                   pr_warn("%s: %s: deactivate failed, mdev %s is in use by guest %s\n",
>>                           VFIO_AP_MODULE_NAME, __func__, matrix_mdev->name,
>>                           matrix_mdev->kvm->arch.dbf->name);
>>                   return -EBUSY;       <===================================== Return -EBUSY and don't deactivate.
> 
> Yes, but what forces ->kvm to be !NULL? I did not see this in the code,
> and I'm not sure what I'm missing. (If ->kvm is guaranteed to be !NULL,
> why do we check for it during open?)

The ->kvm should become !NULL as a part of the open. If there is a guest (kvm),
and we strongly hope that vfio_register_notifier() will give us a pointer
to kvm via the callback. The vfio_register_notifier() is written in such
way, that if we can have a pointer to the kvm representing the VM immediately
after the call to it we will. We used to depend on this in v6. If the
vfio_ap_mdev_group_notifier() callback is called substantially later we
still have a problem, as we don't re-check for sharing conflicts before
we do the copy into the crycb in vfio_ap_mdev_group_notifier(). And
we could not prevent the guest from starting but it would end up with
a dysfunctional vfio_ap mdev that looks good.

> 
>>                                                     
>>           }
>>                                                                                   
>>           matrix_mdev->activated = false;
>>                                                                                   
>>           return ret;
>> }
>>
>>
>>>>   
>>>>> - release the mdev, triggering this function
>>>>>
>>>>> It seems we won't call PAPQ(ZAPQ) in that case -- is that how it is
>>>>> supposed to work?
>>>>>       
>>>>
>>>> So basically the device remains active until the mdev release is
>>>> called if I'm correct.
>>>
>>> So, why do we need the activate/deactivate approach, then? Why can't we
>>> do the verification etc. during open?
>>>    
>>
>> We ca do the verification during open. If there was no activate before
>> the open we actually try to do one.
>>
>> With activate however the admin can claim the resources before the
>> open (that is the guest start). We have a mechanism for both 'let's
>> overcommit and fail when we hit the wall' and 'let's make sure everything
>> is reserved before we give it to the guest'. The admin is free to
>> decide on his policy.
> 
> OK, let's discuss that in the other thread, then. I am not sure that
> departing from the general mdev model is worth it.
> 
> (I have not yet gotten to replying there.)
> 

Let's continue the discussion there. I'm hoping Daniel will chime in.
In my understanding, we are inherently different than the rest of the
mdev devices. And I don't think we depart regarding the common stuff
regulated by mdev (e.g. the max instances). But we wanted to discuss
such stuff there...

Regards,
Halil

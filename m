From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 4/7] s390: ap: setup relation betwen KVM and mediated
 device
Date: Tue, 19 Mar 2019 17:48:24 +0100
Message-ID: <1dd78905-bc87-d47c-6e8a-ba0a2a00102d@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
 <20190315191557.6c8d7668@oc2783563651>
 <7c199329-0e82-ff61-46b7-78237a0f01ce@linux.ibm.com>
 <20190319125425.0cf5324e@oc2783563651>
 <2c459ebe-2b37-72bc-1ede-b196e54dc78d@linux.ibm.com>
 <dc32eea1-31c9-790e-f012-71259e51cb8c@linux.ibm.com>
 <20190319162712.37f804f8@oc2783563651>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319162712.37f804f8@oc2783563651>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 19/03/2019 16:27, Halil Pasic wrote:
> On Tue, 19 Mar 2019 15:47:05 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>>>>>         if (matrix_mdev->kvm)
>>>>>>>             kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>>>>
>>>>>> This still conditional?
>>>>>
>>>>> Yes, nothing to clear if there is no KVM.
>>>>>   
>>>>
>>>> Since we have ensured the open only works if there is a KVM at that
>>>> point in time, and we have taken a reference to KVM, I would expect
>>>> KVM can not go away before we give up our reference.
>>>
>>> Right.
>>
>> Right but based on the assumption we do a kvm_get_kvm() during open.
>>
>> But now we will do it inside the notifier, so the logic is to do a
>> kvm_put_kvm in the notifier too.
>> This is important because userland will ask us to release the KVM/VFIO
>> link through this notifier.
>> So I will have to rework this part where KVM==NULL in the notifier too.
>>
>> Regards,
>> Pierre
> 
> I think it can be done both ways. If you ensure KVM != NULL if the open
> succeeds and take the reference in the notifier. I suppose if open()
> fails release() won't be called. But the logic/code in open() would get
> quite ugly because the callback could be called assync so that it
> overlaps with the rest of open().

Not necessary, but there is more than just the kvm_get_kvm().

When the user calls KVM_DEV_VFIO_GROUP_DEL he asks to break the link 
between VFIO and KVM.

Currently we just ignore this instead of stopping all activity 
associated with KVM.

But we have more bugs there:
We should not support multiple open of the mdev which will overwrite 
matrix->kvm for the same mdev with a different KVM.
I send a bugfix for this.


> 
> Not failing open() in case of no KVM is there yet is in my opinion
> cleaner anyway.

If we handle correctly the notifiers and the exclusivity, we can do this.
I will make this correctly for the next iteration.

Regards,
Pierre

> 
> Regards,
> Halil
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

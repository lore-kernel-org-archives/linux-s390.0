From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 06/13] KVM: s390: interfaces to manage guest's AP
 matrix
Date: Mon, 21 May 2018 11:23:51 -0400
Message-ID: <4ac3ee39-45f6-6c2c-1d23-7ceacd07d0ed@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <be2e8810-2a03-c67c-b1aa-41cf7c82980e@linux.ibm.com>
 <bf6191a9-ca0f-238c-d078-d6f0d6be1616@linux.vnet.ibm.com>
 <edf541b4-f3d6-95ac-46c8-32560c1d0b0c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edf541b4-f3d6-95ac-46c8-32560c1d0b0c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/16/2018 10:41 AM, Pierre Morel wrote:
> On 16/05/2018 16:29, Tony Krowiak wrote:
>> On 05/11/2018 12:08 PM, Halil Pasic wrote:
>>>
>>>
>>> On 05/07/2018 05:11 PM, Tony Krowiak wrote:
>>>> Provides interfaces to manage the AP adapters, usage domains
>>>> and control domains assigned to a KVM guest.
>>>>
>>>> The guest's SIE state description has a satellite structure called the
>>>> Crypto Control Block (CRYCB) containing three bitmask fields
>>>> identifying the adapters, queues (domains) and control domains
>>>> assigned to the KVM guest:
>>>
>>> [..]
>>>
>>>> index 00bcfb0..98b53c7 100644
>>>> --- a/arch/s390/kvm/kvm-ap.c
>>>> +++ b/arch/s390/kvm/kvm-ap.c
>>>> @@ -7,6 +7,7 @@
>>>
>>> [..]
>>>
>>>> +
>>>> +/**
>>>> + * kvm_ap_validate_queue_sharing
>>>> + *
>>>> + * Verifies that the APQNs derived from the cross product of the 
>>>> AP adapter IDs
>>>> + * and AP queue indexes comprising the AP matrix are not 
>>>> configured for
>>>> + * another guest. AP queue sharing is not allowed.
>>>> + *
>>>> + * @kvm: the KVM guest
>>>> + * @matrix: the AP matrix
>>>> + *
>>>> + * Returns 0 if the APQNs are valid, otherwise; returns -EBUSY.
>>>> + */
>>>> +static int kvm_ap_validate_queue_sharing(struct kvm *kvm,
>>>> +                     struct kvm_ap_matrix *matrix)
>>>> +{
>>>> +    struct kvm *vm;
>>>> +    unsigned long *apm, *aqm;
>>>> +    unsigned long apid, apqi;
>>>> +
>>>> +
>>>> +    /* No other VM may share an AP Queue with the input VM */
>>>> +    list_for_each_entry(vm, &vm_list, vm_list) {
>>>> +        if (kvm == vm)
>>>> +            continue;
>>>> +
>>>> +        apm = kvm_ap_get_crycb_apm(vm);
>>>> +        if (!bitmap_and(apm, apm, matrix->apm, matrix->apm_max + 1))
>>>> +            continue;
>>>> +
>>>> +        aqm = kvm_ap_get_crycb_aqm(vm);
>>>> +        if (!bitmap_and(aqm, aqm, matrix->aqm, matrix->aqm_max + 1))
>>>> +            continue;
>>>> +
>>>> +        for_each_set_bit_inv(apid, apm, matrix->apm_max + 1)
>>>> +            for_each_set_bit_inv(apqi, aqm, matrix->aqm_max + 1)
>>>> +                kvm_ap_log_sharing_err(vm, apid, apqi);
>>>> +
>>>> +        return -EBUSY;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix 
>>>> *matrix)
>>>> +{
>>>> +    int ret = 0;
>>>> +
>>>> +    mutex_lock(&kvm->lock);
>>>
>>> You seem to take only kvm->lock, vm_list however (used in
>>> kvm_ap_validate_queue_sharing()) seems to be protected by
>>> kvm_lock.
>>>
>>> Can you tell me why is this supposed to be safe?
>>>
>>> What is supposed to prevent an execution like
>>> vm1: call kvm_ap_configure_matrix(m1)
>>> vm2: call kvm_ap_configure_matrix(m2)
>>> vm1: call kvm_ap_validate_queue_sharing(m1)
>>> vm2: call kvm_ap_validate_queue_sharing(m2)
>>> vm1: call kvm_ap_set_crycb_masks(m1)
>>> vm2: call kvm_ap_set_crycb_masks(m2)
>>>
>>> where, let's say, m1 and m2 are equal in the sense that the
>>> mask values are the same?
>>
>> vm1 will get the kvm->lock first in your scenario when
>> kvm_ap_configure_matrix(m1) is invoked. Since the other
>> functions - i.e., kvm_ap_validate_queue_sharing(m1) and
>> kvm_ap_set_crycb_masks(m1) - are static and only called
>> from the kvm_ap_configure_matrix(m1), your scenario
>> can never happen because vm2 will not get the lock until
>> kvm_ap_configure_matrix(m1) has completed. I see your
>> point, however, and maybe I should also acquire the kvm_lock.
>
> AFAIU the locks you are talking about are KVM specific
> but the example from Halil use two different VM,
> i.e. two different locks are used and vm2 never wait for vw1.

Right you are! Perhaps I need to hold the kvm_lock, at least
in the kvm_ap_validate_queue_sharing() function while looping
over vm_list.

>
>
>>
>>>
>>>
>>> Regards,
>>> Halil
>>>
>>>> +
>>>> +    ret = kvm_ap_validate_queue_sharing(kvm, matrix);
>>>> +    if (ret)
>>>> +        goto done;
>>>> +
>>>> +    kvm_ap_set_crycb_masks(kvm, matrix);
>>>> +
>>>> +done:
>>>> +    mutex_unlock(&kvm->lock);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +EXPORT_SYMBOL(kvm_ap_configure_matrix);
>>>> +
>>
>>
>

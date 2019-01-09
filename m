From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
Date: Wed, 9 Jan 2019 12:39:06 +0100
Message-ID: <68fae932-b589-f978-3a4a-3bc6643227bb@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
 <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
 <1889d0a2-d22a-1170-10bd-0bfc91549388@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1889d0a2-d22a-1170-10bd-0bfc91549388@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mimu@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07/01/2019 20:18, Michael Mueller wrote:
> 
> 
> On 03.01.19 15:43, Pierre Morel wrote:
>> On 19/12/2018 20:17, Michael Mueller wrote:
>>> This function processes the Gib Alert List (GAL). It is required
...snip...
> +    struct kvm *kvm;
>>> +
>>> +    do {
>>> +        /*
>>> +         * If the NONE_GISA_ADDR is still stored in the alert list
>>> +         * origin, we will leave the outer loop. No further GISA has
>>> +         * been added to the alert list by millicode while processing
>>> +         * the current alert list.
>>> +         */
>>> +        final = (origin & NONE_GISA_ADDR);
>>> +        /*
>>> +         * Cut off the alert list and store the NONE_GISA_ADDR in the
>>> +         * alert list origin to avoid further GAL interruptions.
>>> +         * A new alert list can be build up by millicode in parallel
>>> +         * for guests not in the yet cut-off alert list. When in the
>>> +         * final loop, store the NULL_GISA_ADDR instead. This will re-
>>> +         * enable GAL interruptions on the host again.
>>> +         */
>>> +        origin = xchg(&gib->alert_list_origin,
>>> +                  (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
>>> +        /* Loop through the just cut-off alert list. */
>>> +        while (origin & GISA_ADDR_MASK) {
>>> +            gisa = (struct kvm_s390_gisa *)(u64)origin;
>>> +            next_alert = gisa->next_alert;
>>> +            /* Unlink the GISA from the alert list. */
>>> +            gisa->next_alert = origin;
>>
>> AFAIU this enable GISA interrupt for the guest...
> 
> Only together with the IAM being set what could happen if
> __floating_airqs_kick() calls get_ipm and the IPM is clean already. :(

confused, AFAIK IAM is used to allow interrupt for the host
not for the guest.

> 
>>
>>> +            kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>>> +            /* Kick suitable vcpus */
>>> +            __floating_airqs_kick(kvm);
>>
>> ...and here we kick a VCPU for the guest.
>>
>> Logically I would do it in the otherway, first kicking the vCPU then 
>> enabling the GISA interruption again.

!! sorry to have introduce this confusion.
You did it in the right order.
I should have not send these comments after I gave my R-B

>>
>> If the IPM bit is cleared by the firmware during delivering the 
>> interrupt to the guest before we enter get_ipm() called by 
>> __floating_airqs_kick() we will set the IAM despite we have a running 
>> CPU handling the IRQ.
> 
> I will move the unlink below the kick that will assure get_ipm will 
> never take the IAM restore path.

!! Sorry, you were right.
We must re-enable interrupt before kicking the vcpu, as you did, or the 
vcpu could go to wait before it gets the interrupt.

> 
>> In the worst case we can also set the IAM with the GISA in the alert 
>> list.
>> Or we must accept that the firmware can deliver the IPM as soon as we 
>> reset the GISA next field.
> 
> See statement above.
> 
>>
>>> +            origin = next_alert;
>>> +        }
>>> +    } while (!final);
>>> +}
>>> +
>>>   static void nullify_gisa(struct kvm_s390_gisa *gisa)
>>>   {
>>>       memset(gisa, 0, sizeof(struct kvm_s390_gisa));
>>>
>>
>> I think that avoiding to restore the IAM during the call to get_ipm 
>> inside __floating_airqs_kick() would good.

I still think tis assumption is right: We should not set the IAM during 
the kick.

>>
>> If you agree, with that:
>>
>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

Still OK with my R-B, as long as w do not set IAM during the kicking.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

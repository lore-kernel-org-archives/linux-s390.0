From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
Date: Tue, 19 Feb 2019 17:36:38 -0500
Message-ID: <e04f0c8b-2fd9-1846-334a-faa48e0e051e@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
 <4b21f059-1d37-f341-bac7-5b1fe0d06521@linux.ibm.com>
 <ee84fc90-e158-9c36-b56f-67fe7777f683@linux.ibm.com>
 <20190218234235.7d9f547c.cohuck@redhat.com>
 <74d812c6-bf83-0fb0-8fc3-af1341b0ae3c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74d812c6-bf83-0fb0-8fc3-af1341b0ae3c@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/19/19 2:50 PM, Pierre Morel wrote:
> On 18/02/2019 23:42, Cornelia Huck wrote:
>> On Mon, 18 Feb 2019 19:29:10 +0100
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 15/02/2019 23:02, Tony Krowiak wrote:
>>>> On 2/14/19 8:51 AM, Pierre Morel wrote:
>>
>>>>> +/*
>>>>> + * handle_pqap: Handling pqap interception
>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>> + *
>>>>> + * This callback only handles PQAP/AQIC instruction and
>>>>> + * calls a dedicated callback for this instruction if
>>>>> + * a driver did register one in the CRYPTO satellite of the
>>>>> + * SIE block.
>>>>> + *
>>>>> + * Do not change the behavior if, return -EOPNOTSUPP if:
>>>>> + * - the hook is not used do not change the behavior.
>>>>> + * - AP instructions are not available or not available to the guest
>>>>> + * - the instruction is not PQAP with function code indicating
>>>>> + *   AQIC do not change the previous behavior.
>>>>> + *
>>>>> + * For PQAP/AQIC instruction, verify privilege and specifications
>>>>> + *
>>>>> + * return the value returned by the callback.
>>>>> + */
>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>> +{
>>>>> +    uint8_t fc;
>>>>> +
>>>>> +    /* Verify that the hook callback is registered */
>>>>> +    if (!vcpu->kvm->arch.crypto.pqap_hook)
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the AP instruction are available */
>>>>> +    if (!ap_instructions_available())
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the function code is AQIC */
>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>> +    if (fc != 0x03)
>>>>> +        return -EOPNOTSUPP;
>>>>
>>>> This does not belong here. Function code 3 is one of 7 function codes
>>>> that can be sent with the PQAP instruction. This belongs in the PQAP
>>>> hook code.
>>>
>>> On one hand, effectively I would prefer to put the code in the VFIO
>>> driver code.
>>> On the other hand, doing this would lead to export the code for
>>> test_kvm_facility() and kvm_s390_inject_program_int() from the 
>>> kvm-s390.h
>>>
>>> I choose not to export these functions from the KVM code.
>>>
>>> Would like opinion from KVM maintainers?
>>
>> Looking at this (and without access to the specification...), I think
>> the check for problem state makes sense in here (if this applies to all
>> PQAP functions equally, which seems likely). The check for the facility
>> makes more sense in the handler. You can probably still inject the
>> specification exception here if you use a clever return code.
>>
> 
> If there is no objection on exporting the KVM functions... I can do this.

I do not understand why you would have to export KVM functions to place
the check for FC 0x03 in the pqap hook? What am I missing here? Maybe
you misunderstood my comment? The following is the only code I suggested
you move:

+    fc = vcpu->run->s.regs.gprs[0] >> 24;
+    if (fc != 0x03)
+        return -EOPNOTSUPP;

What does that have to do with test_kvm_facility() and
kvm_s390_inject_program_int()? Please explain.

> 
>> Another option: Provide a way to register a callback per function code;
>> this allows you to still do the check here and extend it later for
>> other function codes (which will probably be indicated by another
>> facility).
> 
> I like this option even better.
> 
> Regards,
> Pierre
> 
> 

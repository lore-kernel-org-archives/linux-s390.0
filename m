From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Tue, 19 Mar 2019 10:55:50 +0100
Message-ID: <fa584953-e0e9-2282-16c3-00a0b6e8db2f@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
 <20190315112032.13b259c2.cohuck@redhat.com>
 <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
 <9302bd83-44e6-eb60-3e39-dcb3fc33f280@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9302bd83-44e6-eb60-3e39-dcb3fc33f280@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/03/2019 15:10, Pierre Morel wrote:
> On 15/03/2019 14:26, Pierre Morel wrote:
>> On 15/03/2019 11:20, Cornelia Huck wrote:
>>> On Wed, 13 Mar 2019 17:04:58 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
>>>> +/*
>>>> + * handle_pqap: Handling pqap interception
>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>> + *
>>>> + * We now support PQAP/AQIC instructions and we need to correctly
>>>> + * answer the guest even if no dedicated driver's hook is available.
>>>> + *
>>>> + * The intercepting code calls a dedicated callback for this 
>>>> instruction
>>>> + * if a driver did register one in the CRYPTO satellite of the
>>>> + * SIE block.
>>>> + *
>>>> + * For PQAP/AQIC instructions only, verify privilege and 
>>>> specifications.
>>>> + *
>>>> + * If no callback available, the queues are not available, return 
>>>> this to
>>>> + * the caller.
>>>> + * Else return the value returned by the callback.
>>>> + */
>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    uint8_t fc;
>>>> +    struct ap_queue_status status = {};
>>>> +    int ret;
>>>> +    /* Verify that the AP instruction are available */
>>>> +    if (!ap_instructions_available())
>>>> +        return -EOPNOTSUPP;
>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>> +        return -EOPNOTSUPP;
>>>> +    /* Verify that the function code is AQIC */
>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>> +    /* We do not want to change the behavior we had before this 
>>>> patch*/
>>>> +    if (fc != 0x03)
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    /* PQAP instructions are allowed for guest kernel only */
>>>> +    if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>>>> +        return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>>> +    /* AQIC instruction is allowed only if facility 65 is available */
>>>> +    if (!test_kvm_facility(vcpu->kvm, 65))
>>>> +        return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>>>> +    /* Verify that the hook callback is registered and call it */
>>>> +    if (vcpu->kvm->arch.crypto.pqap_hook) {
>>>> +        if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
>>>> +            return -EOPNOTSUPP;
>>>> +        ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
>>>> +        module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
>>>> +        return ret;
>>>> +    }
>>>> +    /*
>>>> +     * It is the duty of the vfio_driver to register a hook
>>>> +     * If it does not and we get an exception on AQIC we must
>>>> +     * guess that there is no vfio_ap_driver at all and no one
>>>> +     * to handle the guests's CRYCB and the CRYCB is empty.
>>>> +     */
>>>> +    status.response_code = 0x01;
>>>
>>> I'm still confused here, sorry. From previous discussions I recall that
>>> this indicates "no crypto device" (please correct me if I'm wrong.)
>>>
>>> Before this patch, we had:
>>> - guest issues PQAP/AQIC -> drop to userspace
>>>
>>> With a correct implementation, we get:
>>> - guest issues PQAP/AQIC -> callback does what needs to be done
>>>
>>> With an incorrect implementation (no callback), we get:
>>> - guest issues PQAP/AQIC -> guest gets response code 0x01
>>>
>>> Why not drop to userspace in that case?
>>
>> This is what I had in the previous patches.
>> Hum, I do not remember which discussion lead me to modify this.
>>
>> Anyway, now that you put the finger on this problem, I think the 
>> problem is worse.
>>
>> The behavior with old / new Linux, vfio driver and qemu is:
>>
>> LINUX    VFIO_AP    QEMU    PGM
>> OLD    x    x    OPERATION
>> NEW    -    OLD    SPECIFICATION
>> NEW    -    NEW/aqic=off    SPECIFICATION
>> NEW    x    NEW/aqic=on    -
>>
>> x = whatever
>> - = absent/none
>>
>> So yes there is a change in behavior for the userland for the case 
>> QEMU do not set the AQIC facility 65, OLD QEMU or NEW QEMU wanting to 
>> behave like an older one.
>>
>> I fear we have the same problem with the privileged operation...
>>
>> For the last case, when the kvm_facility(65) is set, the explication 
>> is the following:
>>
>> This is related to the handling of PQAP AQIC which is now authorized 
>> by this patch series.
>> If we authorize PQAP AQIC, by setting the bit for facility 65, the 
>> guest can use this instruction.
>> If the instruction follows the specifications we must answer something 
>> realistic and since there is nothing in the CRYCB (no driver) we 
>> answer that there is no queue.
>>
>> Conclusion:  we must handle this in userland, it will have the benefit 
>> to keep old behavior when there is no callback.
>> OLD QEMU will not see change as they will not set aqic facility
>> NEW QEMU will handle this correctly.
>>
> 
> Sorry, wrong conclusion, handling this in userland will bring us much 
> too far if we want to answer correctly for the case the hook is not 
> there but QEMU accepted the facility for AQIC.

Sorry, forget it, I was tired.

Pierre

> 
> The alternative is easier, we just continue to respond with the 
> OPERATION exception here and only handle the specification and 
> privileged exception cases in QEMU and in the hook.
> 
> So, I think the discussion will go on until you come back :)
> 
> Regards,
> Pierre
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

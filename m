From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Wed, 27 Feb 2019 11:16:38 +0100
Message-ID: <72787866-b221-8f97-0078-621d1cf3894d@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <20190227101355.0e10dc38.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227101355.0e10dc38.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 27/02/2019 10:13, Cornelia Huck wrote:
> On Wed, 27 Feb 2019 09:09:09 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 26/02/2019 16:47, Tony Krowiak wrote:
>>> On 2/26/19 6:47 AM, Pierre Morel wrote:
>>>> On 25/02/2019 19:36, Tony Krowiak wrote:
>>>>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>>>>> We prepare the interception of the PQAP/AQIC instruction for
>>>>>> the case the AQIC facility is enabled in the guest.
>>>>>>
>>>>>> We add a callback inside the KVM arch structure for s390 for
>>>>>> a VFIO driver to handle a specific response to the PQAP
>>>>>> instruction with the AQIC command.
>>>>>>
>>>>>> We inject the correct exceptions from inside KVM for the case the
>>>>>> callback is not initialized, which happens when the vfio_ap driver
>>>>>> is not loaded.
>>>>>>
>>>>>> If the callback has been setup we call it.
>>>>>> If not we setup an answer considering that no queue is available
>>>>>> for the guest when no callback has been setup.
>>>>>>
>>>>>> We do consider the responsability of the driver to always initialize
>>>>>> the PQAP callback if it defines queues by initializing the CRYCB for
>>>>>> a guest.
>>>>>>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>
>>>> ...snip...
>>>>   
>>>>>> @@ -592,6 +593,55 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>>>>>        }
>>>>>>    }
>>>>>> +/*
>>>>>> + * handle_pqap: Handling pqap interception
>>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>>> + *
>>>>>> + * We now support PQAP/AQIC instructions and we need to correctly
>>>>>> + * answer the guest even if no dedicated driver's hook is available.
>>>>>> + *
>>>>>> + * The intercepting code calls a dedicated callback for this
>>>>>> instruction
>>>>>> + * if a driver did register one in the CRYPTO satellite of the
>>>>>> + * SIE block.
>>>>>> + *
>>>>>> + * For PQAP/AQIC instructions only, verify privilege and
>>>>>> specifications.
>>>>>> + *
>>>>>> + * If no callback available, the queues are not available, return
>>>>>> this to
>>>>>> + * the caller.
>>>>>> + * Else return the value returned by the callback.
>>>>>> + */
>>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>>> +{
>>>>>> +    uint8_t fc;
>>>>>> +    struct ap_queue_status status = {};
>>>>>> +
>>>>>> +    /* Verify that the AP instruction are available */
>>>>>> +    if (!ap_instructions_available())
>>>>>> +        return -EOPNOTSUPP;
>>>>>
>>>>> How can the guest even execute an AP instruction if the AP instructions
>>>>> are not available? If the AP instructions are not available on the host,
>>>>> they will not be available on the guest (i.e., CPU model feature
>>>>> S390_FEAT_AP will not be set). I suppose it doesn't hurt to check this
>>>>> here given QEMU may not be the only client.
>>>>>   
>>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>>> +        return -EOPNOTSUPP;
>>>>>> +    /* Verify that the function code is AQIC */
>>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>>> +    if (fc != 0x03)
>>>>>> +        return -EOPNOTSUPP;
>>>>>
>>>>> You must have missed my suggestion to move this to the
>>>>> vcpu->kvm->arch.crypto.pqap_hook(vcpu) in the following responses:
>>>>
>>>> Please consider what happen if the vfio_ap module is not loaded.
>>>
>>> I have considered it and even verified my expectations empirically. If
>>> the vfio_ap module is not loaded, you will not be able to create an mdev
>>> device.
>>
>> OK, now please consider that another userland tool, not QEMU uses KVM.
>>
>>> If you don't have an mdev device, you will not be able to
>>> start a guest with a vfio-ap device. If you start a guest without a
>>> vfio-ap device, but enable AP instructions for the guest, there will be
>>> no AP devices attached to the guest. Without any AP devices attached,
>>> the PQAP(AQIC) instructions will not ever get executed.
>>
>> This is not right. The instruction will be executed, eventually, after
>> decoding.
> 
> A sane guest will not issue PQAP(AQIC) if it doesn't have ap
> capabilities, but there's nothing that keeps a guest from issuing that
> instruction regardless.
> 
> However, is this instruction always intercepted and never handled by
> the SIE itself, even if the guest was not configured for ap? By which
> criteria do we enable interception?

It is always intercepted what ever ECA.28 is.
We enable the instruction is allowed through facility 65.

> 
>>
>>> Even if for some
>>> unknown reason the PQAP(AQIC) instruction is executed - for some unknown
>>> reason, it will fail with response code 0x01, AP-queue number not valid.
>>
>> No, before accessing the AP-queue the instruction will be decoded and
>> depending on the installed micro-code it will fail with
>> - OPERATION EXCEPTION if the micro-code is not installed
>> - PRIVILEDGE OPERATION if the instruction is issued from userland
>> (programm state)
>> - SPECIFICATION exception if the instruction do not respect the usage
>> specification
> 
> So, all of these happen prior to checking the function code?

Yes, this is the order of checks AFAIK

> 
>>
>> then it will be interpreted by the microcode and access the queue and
>> only then it will fail with RC 0x01, AP queue not valid.
>>
>> In the case of KVM, we intercept the instruction because it is issued by
>> the guest and we set the AQIC facility on to force interception.
> 
> Will we set that facility even if no vfio-ap device is configured?


Yes we do.


> 
>>
>> KVM do for us all the decode steps I mention here above, if there is or
>> not a pqap hook to be call to simulate the QP queue access.
>>
>> That done, the AP queue virtualisation can be called, this is done by
>> calling the hook.
>>
>>>
>>>    
>>>>   
>>>>>
>>>>> Message ID <342ffd56-b73a-b1f4-004d-de2c4aeef729@linux.ibm.com>
>>>>> Message ID <e04f0c8b-2fd9-1846-334a-faa48e0e051e@linux.ibm.com>
>>>>>
>>>>> You previously stated:
>>>>>
>>>>>      "QEMU and KVM can both accept PQAP/AQIC even if the vfio_ap
>>>>> driver is
>>>>>       not loaded. However now that the guest officially get the PQAP/AQIC
>>>>>       instruction we need to handle the specification and operation
>>>>>       exceptions inside KVM _before_ testing and even calling the driver
>>>>>       hook.
>>>>>
>>>>>       I will make the changes in the next iteration."
>>>>
>>>> Still seems right to me, and is done is this patch.
>>>> Isn't it?
>>>
>>> I don't think it's a matter of right and wrong, it's a matter of what
>>> makes sense. IMHO, you want to make things easy if other PQAP functions
>>> are intercepted at some time. In my opinion, there should be a switch
>>> statement in the pqap hook code with a case statement for each PQAP
>>> function supported by the hook. To plug in a new PQAP function handler,
>>> it will be a simple matter of writing the handler function and calling
>>> it from the case statement, like this:
>>>
>>> static int handle_pqap(struct kvm_vcpu *vcpu)
>>> {
>>>       int ret;
>>>       uint8_t fc;
>>>
>>>       fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>
>>>       switch (fc) {
>>>       case 0x03:
>>>           ret = handle_pqap_aqic(vcpu);
>>>       default:
>>>           ret = -EOPNOTSUPP;
>>>       }
>>>
>>>       return ret;
>>> }
>>>
>>> That function belongs in the pqap hook. I see no reaason whatsoever to
>>> check the function code here. If there is no hook, then you will fall
>>> through to the instruction below:
>>>
>>> status.response_code = 0x01;
>>
>> See answer above, what you are speaking about is the execution of the
>> instruction, but there can be exceptions during the decode of the
>> instruction.
> 
> If e.g. calling that instruction from userspace always creates a priv
> op exception, that should be checked prior to even looking at the
> function code. Same with other exceptions. From my no-docs point of
> view, it makes sense to have those common checks in handle_pqap() and
> use the switch/case to call handler functions for the individual
> function codes...
> 
>>
>>>    
>>>>   
>>>>>
>>>>> I don't know what any of the above has to do with checking FC=0x03? If
>>>>> that check is moved to the pqap handler hook, it can just as well return
>>>>> -EOPNOTSUPP. In fact, down below you do this:
>>>>>
>>>>>       return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
>>>>>
>>>>> If the RC=0x03 check fails in the hook, it will return -EOPNOTSUPP just
>>>>> like above. None of this is critical, but the parsing of the register
>>>>> values for the PQAP(AQIC) function ought to be done in the code that
>>>>> handles the PQAP instruction IMHO.
>>>>
>>>>
>>>> This interception code must handle the PQAP/AQIC instruction when the
>>>> hook is not used and should not modify the handling for other PQAP
>>>> instructions.
>>>> We can not move anything inside the hook that must be always done.
>>>
>>> What you are saying here makes no sense. If the check for the function
>>> code is moved into the pqap hook and fc != 0x03, the result will be
>>> exactly the same; the hook will return -EOPNOTSUPP.
>>
>> again please consider that the hook may not be initialized.
> 
> I agree.
> 

Thanks for the comments.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Fri, 1 Mar 2019 09:42:18 +0100
Message-ID: <e9e19cc7-8549-d92b-6db3-e58efc352a3c@de.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <27aae865-eaa7-dd2a-fa3e-7370b389d161@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27aae865-eaa7-dd2a-fa3e-7370b389d161@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, pmorel@linux.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 28.02.2019 16:35, Tony Krowiak wrote:
> On 2/28/19 4:42 AM, Christian Borntraeger wrote:
>>
>>
>> On 27.02.2019 19:00, Tony Krowiak wrote:
>>> On 2/27/19 3:09 AM, Pierre Morel wrote:
>>>> On 26/02/2019 16:47, Tony Krowiak wrote:
>>>>> On 2/26/19 6:47 AM, Pierre Morel wrote:
>>>>>> On 25/02/2019 19:36, Tony Krowiak wrote:
>>>>>>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>>>>>>> We prepare the interception of the PQAP/AQIC instruction for
>>>>>>>> the case the AQIC facility is enabled in the guest.
>>>>>>>>
>>>>>>>> We add a callback inside the KVM arch structure for s390 for
>>>>>>>> a VFIO driver to handle a specific response to the PQAP
>>>>>>>> instruction with the AQIC command.
>>>>>>>>
>>>>>>>> We inject the correct exceptions from inside KVM for the case the
>>>>>>>> callback is not initialized, which happens when the vfio_ap driver
>>>>>>>> is not loaded.
>>>>>>>>
>>>>>>>> If the callback has been setup we call it.
>>>>>>>> If not we setup an answer considering that no queue is available
>>>>>>>> for the guest when no callback has been setup.
>>>>>>>>
>>>>>>>> We do consider the responsability of the driver to always initialize
>>>>>>>> the PQAP callback if it defines queues by initializing the CRYCB for
>>>>>>>> a guest.
>>>>>>>>
>>>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>>
>>>>>> ...snip...
>>>>>>
>>>>>>>> @@ -592,6 +593,55 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>>>>>>>        }
>>>>>>>>    }
>>>>>>>> +/*
>>>>>>>> + * handle_pqap: Handling pqap interception
>>>>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>>>>> + *
>>>>>>>> + * We now support PQAP/AQIC instructions and we need to correctly
>>>>>>>> + * answer the guest even if no dedicated driver's hook is available.
>>>>>>>> + *
>>>>>>>> + * The intercepting code calls a dedicated callback for this instruction
>>>>>>>> + * if a driver did register one in the CRYPTO satellite of the
>>>>>>>> + * SIE block.
>>>>>>>> + *
>>>>>>>> + * For PQAP/AQIC instructions only, verify privilege and specifications.
>>>>>>>> + *
>>>>>>>> + * If no callback available, the queues are not available, return this to
>>>>>>>> + * the caller.
>>>>>>>> + * Else return the value returned by the callback.
>>>>>>>> + */
>>>>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>>>>> +{
>>>>>>>> +    uint8_t fc;
>>>>>>>> +    struct ap_queue_status status = {};
>>>>>>>> +
>>>>>>>> +    /* Verify that the AP instruction are available */
>>>>>>>> +    if (!ap_instructions_available())
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>
>>>>>>> How can the guest even execute an AP instruction if the AP instructions
>>>>>>> are not available? If the AP instructions are not available on the host,
>>>>>>> they will not be available on the guest (i.e., CPU model feature
>>>>>>> S390_FEAT_AP will not be set). I suppose it doesn't hurt to check this
>>>>>>> here given QEMU may not be the only client.
>>>>>>>
>>>>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>> +    /* Verify that the function code is AQIC */
>>>>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>>>>> +    if (fc != 0x03)
>>>>>>>> +        return -EOPNOTSUPP;
>>>>>>>
>>>>>>> You must have missed my suggestion to move this to the
>>>>>>> vcpu->kvm->arch.crypto.pqap_hook(vcpu) in the following responses:
>>>>>>
>>>>>> Please consider what happen if the vfio_ap module is not loaded.
>>>>>
>>>>> I have considered it and even verified my expectations empirically. If
>>>>> the vfio_ap module is not loaded, you will not be able to create an mdev device.
>>>>
>>>> OK, now please consider that another userland tool, not QEMU uses KVM.
>>>
>>> What does that have to do with loading the vfio_ap module? Without the
>>> vfio_ap module, there will be no AP devices for the guest. What are you
>>> suggesting here?
>>>
>>>>
>>>>> If you don't have an mdev device, you will not be able to
>>>>> start a guest with a vfio-ap device. If you start a guest without a
>>>>> vfio-ap device, but enable AP instructions for the guest, there will be
>>>>> no AP devices attached to the guest. Without any AP devices attached,
>>>>> the PQAP(AQIC) instructions will not ever get executed.
>>>>
>>>> This is not right. The instruction will be executed, eventually, after decoding.
>>>
>>> Please explain why the PQAP(AQIC) instruction will be executed on a
>>> guest without any devices? Point me to the code in the AP bus where
>>> PQAP(AQIC) is executed without a queue?
>>
>> The host must be prepared to handle malicous and broken guests. So if
>> a guest does PQAP, we must handle that gracefully (e.g. by injecting an
>> exception)
> 
> I agree, but the context of this discussion is whether it is
> more appropriate to check fc == 0x03 in this function or the pqap
> hook. If there is no vfio_ap module, which Pierre asked me to consider,
> then there will be no hook initialized. Again, nothing Pierre has
> stated has convinced me that the fc check belongs here, although there
> is no harm in doing so. In fact, a malicious guest can issue PQAP(AQIC)
> with fc=0x03, so none of the arguments above makes sense in this
> context.
> 
>>
>>>
>>>>
>>>>> Even if for some
>>>>> unknown reason the PQAP(AQIC) instruction is executed - for some unknown
>>>>> reason, it will fail with response code 0x01, AP-queue number not valid.
>>>>
>>>> No, before accessing the AP-queue the instruction will be decoded and depending on the installed micro-code it will fail with
>>>> - OPERATION EXCEPTION if the micro-code is not installed
>>>> - PRIVILEDGE OPERATION if the instruction is issued from userland (programm state)
>>>> - SPECIFICATION exception if the instruction do not respect the usage specification
>>>>
>>>> then it will be interpreted by the microcode and access the queue and only then it will fail with RC 0x01, AP queue not valid.
>>>>
>>>> In the case of KVM, we intercept the instruction because it is issued by the guest and we set the AQIC facility on to force interception.
>>>>
>>>> KVM do for us all the decode steps I mention here above, if there is or not a pqap hook to be call to simulate the QP queue access.
>>>>
>>>> That done, the AP queue virtualisation can be called, this is done by calling the hook.
>>>
>>> Okay, let's go back to the genesis of this discussion; namely, my
>>> suggestion about moving the fc == 0x03 check into the hook code. If
>>> the vfio_ap module is not loaded, there will be no hook code. In that
>>> case, the check for the hook will fail and ultimately response code
>>> 0x01 will be set in the status word (which may not be the right thing
>>> to do?). You have not stated a single good reason for keeping this
>>> check, but I'm done with this silly argument. It certainly doesn't
>>> hurt anything.
>>
>> The instruction handler must handle the basic checks for the
>> instruction itself as outlined above.
> 
> The pqap hook IS the instruction handler.

In the kvm sense handle_pqap is the instruction handler.
But can we stop that discussion NOW?
There is things that can be done in both places. As long as the overall code
produces the right result it really does not matter where we do the checks.

This discussion distracts the attention from more important issues, for example
the question about how do we guarantee the de-registration of the interrupt
indicator byte when the kvm guest goes away.

>> I think Pierre is talking about the the KVM instruction decoder.
>> (see handle_instruction in  intercept.c that will then call handle_b2
>> and then call handle_pqap).
> 
> I think this debate has gone on far too long for such a minor
> suggestion. If Pierre wants to keep the check for fc here, so be
> it. I've wasted waaaaaay to much time on it.

Absolutely. Lets stop here and focus on the real things. I think we are
pretty close but we need to tackle some issues.

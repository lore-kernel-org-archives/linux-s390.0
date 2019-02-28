From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Thu, 28 Feb 2019 10:43:04 -0500
Message-ID: <989c7330-8ac8-248e-9a12-23cf5456c9da@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <20190228133927.75de6849@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228133927.75de6849@oc2783563651>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: pmorel@linux.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/28/19 7:39 AM, Halil Pasic wrote:
> On Thu, 28 Feb 2019 10:42:23 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
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
>>>>>>>>        }
>>>>>>>>    }
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
>>
> 
> Nod.
> 
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
> Nod.
> 
>>
>> Do we want to allow QEMU to fully emulate everything (the  ECA_APIE case being off)?
>> The we should pass along everything to QEMU, but this is already done with the
>> ECA_APIE check, correct?
> 
> Nod.
> 
>>
>> Do we agree that when we are beyond the ECA_APIE check, that we do not emulate
>> in QEMU and we have enabled the AP instructions interpretion?
> 
> At least the intention is to not emulate. ECA_APIE is an effective
> control though...
> 
>> If yes then this has some implication:
>>
>> 1. ECA is on and we should only get PQAP interception for specific FC (namely 3).
> 
> Not necessarily true. TAPQ can be intercepted as well (APFT depends
> IC.3). But for now we don't care about that.
> 
>> 2. What we certainly should check is the facility bit of the guest (65) and reject fc==3
>> right away with a specification exception. I do not want the hook to mess with
>> the kvm cpu model. @Pierre would be good to actually check test_kvm_facility(vcpu->kvm, 65))
> 
> As far as I can tell he already does test_kvm_facility(vcpu->kvm, 65). I
> agree we need a spec exception if guest does not have facility 65, but
> does have ap instructions.
> 
>> 3. What shall we do when fc == 0x3? We can certainly do the check here OR in the
>> hook. As long as we have only fc==3 this does not matter.
>>
> 
> I guess Tony's point is that we may have fc == 0 that is TAPQ in the
> APFT flavor. IMHO we don't need to care about that at the moment.
> 
>> Correct?
> 
> IMHO mostly.
> 
> I also doing the facility checks in kvm is easier, and I think this is
> something we can change later if needed without any major trouble.
> 
> There are a couple of things I would do differently than Pierre does:
> 1) Do the PGM_PRIVILEGED_OP before the fc == 3 check.
> 
> 2) Do the test_kvm_facility(vcpu->kvm, 65) check in the context of fc ==
> 3. I.e. decide if this hook is about pqap or just about pqap aqic and
> make the code convey that decision to its reader.
> 
> 3) I would most probably test if the queue is available by looking at the
> masks in CRYCB here. If not AP_RESPONSE_Q_NOT_AVAIL is what we need.
> 
> 4) If we have APIE and queues authorized by the CRYCB (i.e. we have a
> vfio_ap module loaded an an mdev associated with the kvm) the callback
> not set (!(vcpu->kvm->arch.crypto.pqap_hook)) is a BUG! In that case
> lying that the queue is not available does not seem right. BTW this is
> something Pierre changed since the last version quietly (I can't recall
> a mention in the change log or somebody asking for this). If we want to
> be very pedantic about this bug scenario our best bet is probably
> response code 6.
> 

Agreed

> Regards,
> Halil
> 
> [..]
> 

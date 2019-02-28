From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Thu, 28 Feb 2019 10:36:09 -0500
Message-ID: <0051da1a-1834-8bb0-b277-ae434cb7d755@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, pmorel@linux.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/28/19 6:03 AM, Christian Borntraeger wrote:
> 
> 
> On 28.02.2019 10:42, Christian Borntraeger wrote:
> [...]
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
>>
>> Do we want to allow QEMU to fully emulate everything (the  ECA_APIE case being off)?
>> The we should pass along everything to QEMU, but this is already done with the
>> ECA_APIE check, correct?
>>
>> Do we agree that when we are beyond the ECA_APIE check, that we do not emulate
>> in QEMU and we have enabled the AP instructions interpretion?
>> If yes then this has some implication:
>>
>> 1. ECA is on and we should only get PQAP interception for specific FC (namely 3).
>> 2. What we certainly should check is the facility bit of the guest (65) and reject fc==3
>> right away with a specification exception. I do not want the hook to mess with
>> the kvm cpu model. @Pierre would be good to actually check test_kvm_facility(vcpu->kvm, 65))
>> 3. What shall we do when fc == 0x3? We can certainly do the check here OR in the
>> hook. As long as we have only fc==3 this does not matter.
>>
>> Correct?
> 
> Thinking more about that, I think we should inject a specification exception for all
> unknown FCc != 0x3. That would also qualify for keeping it in the instruction handler.

Sure, let's do it.

> 

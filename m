From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
Date: Wed, 22 Aug 2018 13:09:14 +0200
Message-ID: <a6a2aec1-33cf-6299-8219-ed5043ba07be@redhat.com>
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
 <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
 <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
 <f5261c1a-58f6-68f2-1736-eb13dce863b6@redhat.com>
 <0032fc9b-4328-1a09-66f5-65f485a8a42f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0032fc9b-4328-1a09-66f5-65f485a8a42f@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22.08.2018 12:42, Pierre Morel wrote:
> On 22/08/2018 10:44, David Hildenbrand wrote:
>> On 22.08.2018 10:41, Pierre Morel wrote:
>>> On 22/08/2018 10:25, David Hildenbrand wrote:
>>>> On 22.08.2018 10:08, Pierre Morel wrote:
>>>>> Currently when shadowing the CRYCB on SIE entrance, the validation
>>>>> tests the following:
>>>>> - accept only FORMAT1 or FORMAT2
>>>>> - test if MSAext facility (76) is installed
>>>>> - accept the CRYCB if no keys are used
>>>>> - verifies that the CRYCB format1 is inside a page
>>>>> - verifies that the CRYCB origin is not 0
>>>>>
>>>>> This is not following the architecture.
>>>> I have to trust you on that :)
>>>>
>>>>> On SIE entrance, the CRYCB must be validated before accepting
>>>>> any of its entries.
>>>>>
>>>>> Let's do the validation in the right order and also verify
>>>>> correctly the FORMAT2 CRYCB.
>>>> With which facility was FORMAT2 introduced?
>>> With APXA.
>>> KVM initialization setup CRYCB format according to the presence
>>> of APXA for FORMAT2 or FORMAT1
>> As our guest does not see APXA, why should it be allowed to make use of
>> FORMAT2 here already?
>>
>> In my opinion, the size check you are adding is in the current state not
>> correct.
> 
> The point is that the documentation states that bit 30 is ignored
> if the APXA facility is not installed in the **host** configuration.
> 

host here most probably means "we as a hypervisor that probe for APXA".
This is to differentiate it from "APXA installed in the guest
configuration" - e.g. via AP execution control. No AP, no APXA, no
FORMAT 2 accepted. -> Bit ignored.

Don't confuse it with "machine configuration". (mixing that in makes
things way too complicated)

> Which I understand as FORMAT2 may not be ignored if APXA is installed
> in the host configuration.
> 

"host" is used to differentiate from "guest". If we are at G1 level and
there is no APXA, the FORMAT2 bit is to be ignored.

> From the host, we control the guest1 and we start it without AP
> by not setting ECA.28.
> So that the guest1 can not know if APXA is installed or not since to know
> this it must use a AP instruction :)

No AP implies no APXA. On that logical level "host".

> 
> Now the guest1 is an hypervizor and wants to start a guest2.
> It can set ECA.28 to allow the guest2 AP instructions , just because it can,
> (even guest2 will not see any as it will be masked by the guest1 ECA.28
> that we did not set)

ECA.28 has no effect as G1 sees no AP facility. That is the real reason.

> 
> It can also set the FORMAT2 just because it can do it.
> The documentation explicitly says that FORMAT2 may be used
> without APXA and that in this case it will be handled as a FORMAT1
> 
> 
> The question is do we want to forbid this?
> It is not an error.
> Suppose that an hypervizor always set FORMAT2 to be able to not restart
> its guest if the host set ECA.28 a posteriori.
> 
> Anyway we have the choice:
> - we verify the CRYCB for FORMAT2
> or
> - we forbid FORMAT2
> 
> Since we will soon (I hope) be able to use AP instructions in AP
> but we are not able to do it today, we could forbid FORMAT2
> however in the current behavior we authorize FORMAT2...
> 
> What ever the choice is we must change the current implementation.
> 
> I prefer to keep the current interface but make sure that the
> host do not crash when scheduling a FORMAT2 SIE crossing
> a page boundary.
> 
> 
> What do you think we should do?

Keep it simple. Don't mix in machine configuration. Try to make each
layer look consistent.

If there is no AP/APXA on a level ("host"), FORMAT2 is ignored in SIE.
If there is no AP/APXA on a level ("host"), ECA.28 is ignored in SIE.
If there is no MSA3 on a level ("host"), ECB3_AES | ECB3_DEA is ignored
in SIE.

If there is no AP/APXA/MSA3 on a level ("host"), crycbd is completely
ignored in SIE. (that means, no validity intercepts to be injected).
Please double check that in the documentation.

If there is is AP/MSA3 and either ECA.28 | ECB3_AES | ECB3_DEA, what
should happen? (please verify in the documentation)

FORMAT2 should really only be allowed if there is APXA. As we cannot
fake abscence for guests (as of now), guest availability always matches
host availability if AP is enabled for a guest.

> 
> regards,
> 
> Pierre
> 
>>
> 
> -- 
> Pierre Morel
> Linux/KVM/QEMU in Böblingen - Germany
> 


-- 

Thanks,

David / dhildenb

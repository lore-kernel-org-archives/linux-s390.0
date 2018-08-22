From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
Date: Wed, 22 Aug 2018 14:51:54 +0200
Message-ID: <76fc3187-4e99-bd2f-5d3b-5de89ac641d1@redhat.com>
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
 <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
 <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
 <f5261c1a-58f6-68f2-1736-eb13dce863b6@redhat.com>
 <0032fc9b-4328-1a09-66f5-65f485a8a42f@linux.ibm.com>
 <a6a2aec1-33cf-6299-8219-ed5043ba07be@redhat.com>
 <8afefad7-d4a5-7e02-d5ea-9a355cbed332@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8afefad7-d4a5-7e02-d5ea-9a355cbed332@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

>>
>>>  From the host, we control the guest1 and we start it without AP
>>> by not setting ECA.28.
>>> So that the guest1 can not know if APXA is installed or not since to know
>>> this it must use a AP instruction :)
>> No AP implies no APXA. On that logical level "host".
> 
> hum.
> No seen, usable nor used APXA  on that level: yes.
> 
>>
>>> Now the guest1 is an hypervizor and wants to start a guest2.
>>> It can set ECA.28 to allow the guest2 AP instructions , just because it can,
>>> (even guest2 will not see any as it will be masked by the guest1 ECA.28
>>> that we did not set)
>> ECA.28 has no effect as G1 sees no AP facility. That is the real reason.
> 
> Not exactly, the ECA.28 field used for G2 is an effective field
> calculated from G1.ECA.28 & G2.ECA.28

That is one complexity on top, but it does not reflect what our guest
sees (see below)

> 
> G1 not having AP instructions is the consequence of G1.ECA.28=0
> 
> There is no AP Facility in the sense of STFL bits.

Yes, it is sensed differently by the guest. But the guest can detect it
by sensing instructions, right? (similar to CMM)

If AP instructions can be executed by the guest ("sense") -> "AP
facility available"

If "AP facility available" -> ECA.28 _may_ be used. It can still result
in an intercept.

If "AP facility not available" -> ECA.28 is ignored

So any user of ECA.28 _has to_ implement backup emulation code if he
wants to provide the AP facility to it's guests.

Where is that code in the current series? Imagine running nested under
z/VM where ECA.28 is not effective. Or later on nested under KVM once we
emulate devices in QEMU and have to restrict ECA.28 for our guest (which
might itself might want to make use of ECA.28)


IMHO, if ECA.28 is set, it is to be treated just like it _would be_ set
(e.g. perform checks), but it can effectively be disabled by us before
going into the SIE. But this is a small detail.

> 
>>
>>> It can also set the FORMAT2 just because it can do it.
>>> The documentation explicitly says that FORMAT2 may be used
>>> without APXA and that in this case it will be handled as a FORMAT1
>>>
>>>
>>> The question is do we want to forbid this?
>>> It is not an error.
>>> Suppose that an hypervizor always set FORMAT2 to be able to not restart
>>> its guest if the host set ECA.28 a posteriori.
>>>
>>> Anyway we have the choice:
>>> - we verify the CRYCB for FORMAT2
>>> or
>>> - we forbid FORMAT2
>>>
>>> Since we will soon (I hope) be able to use AP instructions in AP
>>> but we are not able to do it today, we could forbid FORMAT2
>>> however in the current behavior we authorize FORMAT2...
>>>
>>> What ever the choice is we must change the current implementation.
>>>
>>> I prefer to keep the current interface but make sure that the
>>> host do not crash when scheduling a FORMAT2 SIE crossing
>>> a page boundary.
>>>
>>>
>>> What do you think we should do?
>> Keep it simple. Don't mix in machine configuration. Try to make each
>> layer look consistent.
>>
>> If there is no AP/APXA on a level ("host"), FORMAT2 is ignored in SIE.
>> If there is no AP/APXA on a level ("host"), ECA.28 is ignored in SIE.
>> If there is no MSA3 on a level ("host"), ECB3_AES | ECB3_DEA is ignored
>> in SIE.
>>
>> If there is no AP/APXA/MSA3 on a level ("host"), crycbd is completely
>> ignored in SIE. (that means, no validity intercepts to be injected).
>> Please double check that in the documentation.
>>
>> If there is is AP/MSA3 and either ECA.28 | ECB3_AES | ECB3_DEA, what
>> should happen? (please verify in the documentation)
>>
>> FORMAT2 should really only be allowed if there is APXA. As we cannot
>> fake abscence for guests (as of now), guest availability always matches
>> host availability if AP is enabled for a guest.
> 
> I am not sure we can KIS.
> 
> For the SIE firmware a guest G1 or G2 or not distinguishable.
> 
> Using VSIE we let the G2 run inside a SIE Control Block installed by the 
> host.
> So if the host has AP/APXA and even if G1 has not AP/APXA
> then, if we take your first assumption, FORMAT2 is not ignored in the SIE.

That's why we sit in the middle and control what we give to HW.

We (as a hypervisor implementing nested virtualization), have to make
sure that what the guest sees and experiences is consistent.

E.g. if we fake away APXA (which can and should be supported, see my
other reply), the guest (who might be old and have no idea about APXA)
should see consistent results.

> 
> Since the test is done on SIE entry
> no need to run an instruction to get a validity interception,
> which is for me explained by the documentation stating that:
> 
> The check of APCB/CRYCB and APCB/CRYCB origin is performed
> only if any of the following is true:
> (a) ECA.28 is one
> (b) CRYCB format field (F) is one
> or
> (c) the AXPA facility is installed and the F field is three
> 
> If not having the AP instruction would be enough to avoid
> a validity interception, then there would be no need to
> have the point (c).
> 

Maybe it is really best to split this patch further up, then we can
discuss all details separately.

Having access to documentation would really be beneficial here :)

-- 

Thanks,

David / dhildenb

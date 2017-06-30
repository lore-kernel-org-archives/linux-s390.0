From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 9/9] KVM: s390: Inject machine check into the nested
 guest
Date: Fri, 30 Jun 2017 18:30:46 +0200
Message-ID: <5259ae43-f43f-915b-8b46-b601fc70344c@redhat.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
 <1498671044-81240-10-git-send-email-borntraeger@de.ibm.com>
 <9ec0f700-c686-44ce-c633-01f2b0ec46c0@redhat.com>
 <d4351d31-569e-4257-8b9d-b24c426fde58@de.ibm.com>
 <de970ef9-5fa4-1d58-b3d9-351c2a0ceb9e@redhat.com>
 <18e00d40-bdd4-84a9-f1b5-d4599aac74af@de.ibm.com>
 <19a95ab2-29d2-e7d9-f981-1e5c5c006e62@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <19a95ab2-29d2-e7d9-f981-1e5c5c006e62@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 29.06.2017 16:57, Christian Borntraeger wrote:
> On 06/28/2017 09:16 PM, Christian Borntraeger wrote:
>> On 06/28/2017 09:08 PM, David Hildenbrand wrote:
>>> On 28.06.2017 20:59, Christian Borntraeger wrote:
>>>> On 06/28/2017 08:06 PM, David Hildenbrand wrote:
>>>>> On 28.06.2017 19:30, Christian Borntraeger wrote:
>>>>>> From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>>>>>
>>>>>> With vsie feature enabled, kvm can support nested guests (guest-3).
>>>>>> So inject machine check to the guest-2 if it happens when the nested
>>>>>> guest is running. And guest-2 will detect the machine check belongs
>>>>>> to guest-3 and reinject it into guest-3.
>>>>>> The host (guest-1) tries to inject the machine check to the picked
>>>>>> destination vcpu if it's a floating machine check.
>>>>>
>>>>> The subject is confusing. We don't inject anything into the nested guest
>>>>> here. We just catch machine checks during vsie and inject it into the
>>>>> ordinary kvm guest.
>>>>
>>>> Agreed, it is confusing and maybe a leftover from an early rework due to internal
>>>> feedback. We inject in guest-2 and rely on guest-2 to reinject to guest-3 would
>>>> be a better wording.
>>>>
>>>>  
>>>>
>>>>
>>>>> Are there any SIE specific things to consider here, that may have to be
>>>>> translated?
>>>>
>>>> As HW exits SIE before delivering the machine check, the SIE control block 
>>>> contains all saved guest3 registers and the host (guest1) registers contain
>>>> the lazy registers (as we have already restored them) just like a normal exit.
>>>
>>> As mentioned in the other mail, e.g. vector register validity should
>>> only be set if vector registers are enabled for the nested guest
>>> (execution control enabled).
>>
>> Yes, but sInce we inject in the base guest (non-nested) we have to check the base guest
>> execution control. 
> 
> While we drag the vector validity along, it looks like __write_machine_check is already
> doing the right thing for vector and guarded storage before writing the mcic to the
> guest, no?

(sorry for the delay, I'm currently visiting a rural part of Slovakia)

Yes, perfect. So the only thing that could actually happen is an under
indication, which can be easily added later.

Thanks!


-- 

Thanks,

David

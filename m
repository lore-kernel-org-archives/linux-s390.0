From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/3] KVM: s390: Refactor host cmma and pfmfi
 interpretation controls
Date: Fri, 16 Feb 2018 10:46:42 +0100
Message-ID: <533546e5-8f4c-2086-a6dd-49bd7fab0636@redhat.com>
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
 <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518709402-91101-2-git-send-email-frankja@linux.vnet.ibm.com>
 <4b1638fd-c5d9-b265-861b-5065a83c0342@redhat.com>
 <208a30df-f8af-9f73-bffd-71c6f94cf0a0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <208a30df-f8af-9f73-bffd-71c6f94cf0a0@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 15.02.2018 17:42, Janosch Frank wrote:
> On 15.02.2018 17:08, David Hildenbrand wrote:
>> On 15.02.2018 16:43, Janosch Frank wrote:
>>> use_cmma in kvm_arch means that the vm is allowed to use cmma, whereas
>>> use_cmma in the mm context means it has been used before. Let's rename
>>> the kvm_arch one to has_cmma
>>
>> Unfortunately all naming related to CMM(A) is already screwed up.
>>
>> If the guest can issue the ESSA instruction, it has the CMM facility. We
>> used to provide it to him by enabling the CMMA control - the
>> "interpretation facility". We could right now fully emulate it (which is
>> what we do when we dirty track changes).
>>
>> At least in the CPU model we did it right. (the feature is called "cmm")
>>
>> But anyhow, we only provide the CMM facility to the guest right now if
>> we have CMMA, so keeping the name "cmma" here is not completely wrong.
>>
>>>
>>> Also let's introduce has_pfmfi, so we can remove the pfmfi disablement
>>
>> Mixed feelings. has_pfmfi sounds more like "this guest has the PFMFI
>> feature", which is something related to vSIE. It is really more
>> "use_pfmfi". Because we provide the PFMF instruction either way (by
>> emulating it - it belongs to edat1).
>>
>> Can we name this "use_cmma" and "use_pfmfi" and "use_skf", because that
>> is actually what we do?
> 
> As long as we have a difference between the arch and the context one and
> the implementation of the patches are not a problem, sure.
> 
> We could also invert them and use emulate_pfmf or intercept_* which is
> more specific about what we actually (don't) do.

I think "using the interpretation facility" is good enough. Because that
is exactly what we do, independent of availability of the instruction
towards the guest.

emulate_pfmf might be misleading, e.g. if the guest doesn't have EDAT1
and we fake it away - emulate_pfmf is set but we don't emulate it. We
inject an exception right away.

intercept_* would work, however the would then have to be intercept_essa
instead of cmma. Not sure if that is easier to read.

> 
>>
>> The thing in the mm context should rather be renamed to "uses_cmm(a)" or
>> "used_cmm(a)".
> 
> Yes, I like uses more, the rest of the gang likes used, now feel free to
> propose something entirely different :)
> 
> If there's not much that speaks against the first two patches, I'd spin
> them off to merge them earlier, the use_cmma cleanup has been on my list
> for a long time. Thoughts?
> 

Jup, please resend, they make sense on their own.


-- 

Thanks,

David / dhildenb

From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 06/11] KVM: s390: Multiple Epoch Facility support
Date: Tue, 29 Aug 2017 14:54:48 +0200
Message-ID: <cb6b6940-6733-cdf2-6ce9-716162c3faa5@redhat.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-3-git-send-email-borntraeger@de.ibm.com>
 <705f3223-ed61-e9da-814c-238d21322f6b@redhat.com>
 <a0a71df6-5a52-2237-e7fd-a705da4af83a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <a0a71df6-5a52-2237-e7fd-a705da4af83a@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 29.08.2017 14:46, Christian Borntraeger wrote:
> 
> 
> On 08/29/2017 02:24 PM, David Hildenbrand wrote:
>> On 28.08.2017 10:07, Christian Borntraeger wrote:
>>> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>>>
>>> Allow for the enablement of MEF and the support for the extended
>>> epoch in SIE and VSIE for the extended guest TOD-Clock.
>>>
>>> A new interface is used for getting/setting a guest's extended
>>> TOD-Clock that uses a single ioctl invocation, KVM_S390_VM_TOD_EXT.
>>> The old method of getting and setting the guest TOD-Clock is
>>> retained and is used when the old ioctls are called.
>>
>> After talking to Christian, I understand that we have to set it in "one
>> shot" as we can otherwise run into problems when getting/setting the TOD
>> as we are looking at a moving target. This should go into the cover letter.
> 
> You mean in the patch description or in the git tag description?

Patch description. But just my opinion.

> 
>>
>> I need some more info regarding the architecture change.
>>
>> For now, epoch was an unsigned value that is interpreted as an signed value.
> 
> It is always considered a signed value, (so the guest can be before or after the host)
> we just used u64 to make the wraparound defined (doing all the math in the unsigned realm
> as signed overflow is undefined)
> 
>>
>> a) Is that still true with multiple epoch?
>> b) What is the format of the epoch index? Can it also be "negative"?
> 
> The concatenation of both is considered a 72bit signed value.

Ah okay. So subtracting 1 from idx=0, epoch=0 will result in
idx=0xff epoch=0xffffff

> 
>>
>> Why I am asking: I can see comparison made with the epoch:
>>
>>> +	if (test_kvm_facility(vcpu->kvm, 139)) {
>>> +		scb_s->epdx += vcpu->kvm->arch.epdx;
>>> +		if (scb_s->epoch < vcpu->kvm->arch.epoch)
> 
> 	This checks for an overflow after the addition and
> 
>>> +			scb_s->epdx += 1;
> 
> 	corrects this. Since this is all unsigned math this is
> 	defined to wrap around and should work unless I missed 
> 	something

I just had in mind:

-1 < 0

but 0xffffffff is clearly > 0x0

I might be mistaking, but we could get both an overflow or an underflow
here.

But my brain has to consume new information first, so ignore the noise
for now :)


> 
>>> +	}
>>
>> or
>>
>>> +	if (kvm->arch.epoch > gtod->tod)
>>> +		kvm->arch.epdx -= 1;
>>
>>
>> If I remember correctly, such comparisons won't work correctly when
>> having this signed/unsigned duality. But I might be wrong.
> 
> As far as I can see we have unsigned data types everywhere.
> 

-- 

Thanks,

David

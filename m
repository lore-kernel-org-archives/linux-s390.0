From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Tue, 29 Aug 2017 09:18:43 +0200
Message-ID: <55b2a9e4-2b48-e19f-cc68-f26ab689dd5b@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
 <d72ff520-8fac-34d9-e71a-53697a59957c@redhat.com>
 <28c5c4be-d07a-a82d-916f-5771759f35f1@de.ibm.com>
 <ae6cf9ff-8820-1a63-47ea-b6a28046fc5e@de.ibm.com>
 <c2876d8a-f729-90a1-5d35-93a5b69e7bb9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c2876d8a-f729-90a1-5d35-93a5b69e7bb9@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/28/2017 09:42 PM, David Hildenbrand wrote:
> On 28.08.2017 21:38, Christian Borntraeger wrote:
>>
>>
>> On 08/28/2017 09:35 PM, Christian Borntraeger wrote:
>>>
>>>
>>> On 08/28/2017 09:27 PM, David Hildenbrand wrote:
>>>>
>>>>>  		rc = handle_sigp_dst(vcpu, order_code, cpu_addr,
>>>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>>>> index 025ea20..181db5b 100644
>>>>> --- a/arch/s390/tools/gen_facilities.c
>>>>> +++ b/arch/s390/tools/gen_facilities.c
>>>>> @@ -80,6 +80,7 @@ static struct facility_def facility_defs[] = {
>>>>>  			78, /* enhanced-DAT 2 */
>>>>>  			130, /* instruction-execution-protection */
>>>>>  			131, /* enhanced-SOP 2 and side-effect */
>>>>> +			138, /* configuration z/architecture mode (czam) */
>>>>>  			146, /* msa extension 8 */
>>>>>  			-1  /* END */
>>>>>  		}
>>>>>
>>>>
>>>> Thinking about it, this should be the right thing to do instead of the
>>>> last hunk:
>>>>
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index 84c069afc02f..39115f5a38df 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -1927,6 +1927,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned
>>>> long type)
>>>>         memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
>>>>                S390_ARCH_FAC_LIST_SIZE_BYTE);
>>>>
>>>> +       /* we are always in CZAM mode - even on pre z14 machines */
>>>> +       set_kvm_facility(kvm->arch.model.fac_mask, 138);
>>>> +       set_kvm_facility(kvm->arch.model.fac_list, 138);
>>>> +       /* we emulate STHYI in kvm */
>>>>         set_kvm_facility(kvm->arch.model.fac_mask, 74);
>>>>         set_kvm_facility(kvm->arch.model.fac_list, 74);
>>>>         if (MACHINE_HAS_TLB_GUEST) {
>>>>
>>>> That would produce consistent results for very old QEMU.
>>>>
>>>
>>> This should be identical as the initial fac_list is populated from the fac_mask,
>>> which is populated by the facility_defs structure.
>>>
>>> [..]
>>>        /* Populate the facility list initially. */
>>>         kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
>>> ---->   memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
>>>                S390_ARCH_FAC_LIST_SIZE_BYTE);
>>>
>>> [,..]
>>
>> Well not identical. The patch actually enables the czam facility only if the host
>> hardware while your variant enables it always. Interesting discussion if it matters
>> if we should enable it on z13, z12 and earlier or not
>>
> 
> This is also what we do on the QEMU side and what I meant by "consistent".

Yes, I agree. QEMU will always enable stfle.138. So should the kernel.
Shall I fixup the patch with your change proposal or do you want to send an on-top patch?

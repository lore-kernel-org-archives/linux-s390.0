From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 02/15] KVM: s390: coding style issue
 kvm_s390_gisa_init/clear()
Date: Mon, 7 Jan 2019 17:16:15 +0100
Message-ID: <951277df-bb77-4981-7ec6-bc271aa453a7@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-3-mimu@linux.ibm.com>
 <0c41bb2c-aa6c-ccbc-752b-c73f74fdd12b@linux.ibm.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c41bb2c-aa6c-ccbc-752b-c73f74fdd12b@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 02.01.19 17:50, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> The change hepls to reduce line length and
>> icreases code readability.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index fcb55b02990e..9a3aed608914 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2886,20 +2886,20 @@ int kvm_s390_get_irq_state(struct kvm_vcpu 
>> *vcpu, __u8 __user *buf, int len)
>>   void kvm_s390_gisa_clear(struct kvm *kvm)
>>   {
>> -    if (kvm->arch.gisa) {
>> -        memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
>> -        kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
>> -        VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>> -    }
>> +    if (!kvm->arch.gisa)
>> +        return;
>> +    memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
>> +    kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
>> +    VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>>   }
>>   void kvm_s390_gisa_init(struct kvm *kvm)
>>   {
>> -    if (css_general_characteristics.aiv) {
>> -        kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
>> -        VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
>> -        kvm_s390_gisa_clear(kvm);
>> -    }
>> +    if (!css_general_characteristics.aiv)
>> +        return;
>> +    kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
>> +    VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> 
> to be annoying, shouldn't the trace be done after the clear?

sure, I will address that

> 
>> +    kvm_s390_gisa_clear(kvm);
>>   }
>>   void kvm_s390_gisa_destroy(struct kvm *kvm)
>>
> 
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> 
> 

-- 

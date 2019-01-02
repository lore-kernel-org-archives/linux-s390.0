From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
Date: Wed, 2 Jan 2019 19:26:18 +0100
Message-ID: <78ce8dfa-1346-f133-de90-7ac5ed7fe008@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-11-mimu@linux.ibm.com>
 <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/01/2019 18:29, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> Add the IAM (Interruption Alert Mask) to the architecture specific
>> kvm struct. This mask in the GISA is used to define for which ISC
>> a GIB alert can be issued.
>>
>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
>> are used to (un)register a GISC (guest ISC) with a virtual machine and
>> its GISA.
>>
>> Upon successful completion, kvm_s390_gisc_register() returns the
>> ISC to be used for GIB alert interruptions. A negative return code
>> indicates an error during registration.
>>
>> Theses functions will be used by other adapter types like AP and PCI to
>> request pass-through interruption support.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  9 ++++++
>>   arch/s390/kvm/interrupt.c        | 66 
>> ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 75 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 0deba3ae8bc7..2c1259da3636 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -782,6 +782,9 @@ struct kvm_s390_gisa {
>>               u8  reserved03[11];
>>               u32 airq_count;
>>           } g1;
>> +        struct {
>> +            u64 word[4];
>> +        } u64;
>>       };
>>   };
>> @@ -849,6 +852,9 @@ struct kvm_arch{
>>       DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
>>       struct kvm_s390_gisa *gisa;
>>       int gib_in_use;
>> +    u8 iam;
>> +    u32 iam_ref_count[MAX_ISC + 1];
>> +    spinlock_t iam_ref_lock;
>>   };
>>   #define KVM_HVA_ERR_BAD        (-1UL)
>> @@ -882,6 +888,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, 
>> unsigned long *apm,
>>   extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>>   extern char sie_exit;
>> +extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
>> +extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
>> +
>>   static inline void kvm_arch_hardware_disable(void) {}
>>   static inline void kvm_arch_check_processor_compat(void *rtn) {}
>>   static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 5a54360cecfe..1cc3ad2e6c7e 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -229,6 +229,25 @@ static inline u8 int_word_to_isc(u32 int_word)
>>    */
>>   #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * 
>> BITS_PER_BYTE)
>> +static inline int set_iam(struct kvm_s390_gisa *gisa, u8 iam)
>> +{
>> +    u64 word0, _word0;
>> +
>> +    do {
>> +        word0 = READ_ONCE(gisa->u64.word[0]);
>> +        /* If the GISA is in the alert list, do nothing. */
>> +        if ((u64)gisa != word0 >> 32)
>> +            return -EBUSY;
> 
> In kvm_s390_gisa_clear() you do:
> 
> +        nullify_gisa(kvm->arch.gisa);
> +        set_iam(kvm->arch.gisa, kvm->arch.iam);
> 
> IIUC this call to set_iam() will always fail.

Hum, sorry, I oversaw a patch which corrected this problem.
Sorry for the noise.
(I should have seen it since I copied the right lines!)

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

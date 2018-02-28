From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 02/15] s390: vsie: implement AP support for second
 level guest
Date: Wed, 28 Feb 2018 11:03:52 +0100
Message-ID: <a01ab1ab-889e-6c50-7e1b-0f259190a789@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-3-git-send-email-akrowiak@linux.vnet.ibm.com>
 <0882e962-8ebb-2cea-0180-5cee9a0db1e4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0882e962-8ebb-2cea-0180-5cee9a0db1e4@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 28/02/2018 10:39, David Hildenbrand wrote:
> On 27.02.2018 15:28, Tony Krowiak wrote:
>> Set effective masks and CRYCB format in the shadow copy of the
>> guest level 2 CRYCB.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm-ap.h |    2 +
>>   arch/s390/kvm/kvm-ap.c         |    5 +++
>>   arch/s390/kvm/vsie.c           |   71 +++++++++++++++++++++++++++++++++-------
>>   3 files changed, 66 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
>> index 4e43117..ef749e7 100644
>> --- a/arch/s390/include/asm/kvm-ap.h
>> +++ b/arch/s390/include/asm/kvm-ap.h
>> @@ -13,4 +13,6 @@
>>   
>>   void kvm_ap_set_crycb_format(struct kvm *kvm, __u32 *crycbd);
>>   
>> +int kvm_ap_get_crycb_format(struct kvm *kvm);
>> +
>>   #endif /* _ASM_KVM_AP */
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> index 5305f4c..bafe63b 100644
>> --- a/arch/s390/kvm/kvm-ap.c
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -11,6 +11,11 @@
>>   
>>   #include "kvm-s390.h"
>>   
>> +int kvm_ap_get_crycb_format(struct kvm *kvm)
>> +{
>> +	return kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK;
>> +}
> Why exactly do we need this function? If there are no other users, just
> do it directly in the code below.
>
>> +
>>   static int kvm_ap_apxa_installed(void)
>>   {
>>   	int ret;
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 8961e39..93076ba 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -18,6 +18,7 @@
>>   #include <asm/sclp.h>
>>   #include <asm/nmi.h>
>>   #include <asm/dis.h>
>> +#include <asm/kvm-ap.h>
>>   #include "kvm-s390.h"
>>   #include "gaccess.h"
>>   
>> @@ -137,12 +138,56 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   }
>>   
>>   /*
>> + * Set up the effective masks for the shadow copy of the crycb. The effective
>> + * masks for guest 3 are set by performing a logical bitwise AND of the guest 3
>> + * masks with the guest 2 masks.
>> + */
>> +static void set_crycb_emasks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>> +{
>> +	int fmt = kvm_ap_get_crycb_format(vcpu->kvm);
>> +	unsigned long *mask1, *mask2;
>> +
>> +	switch (fmt) {
>> +	case CRYCB_FORMAT1:
>> +	case CRYCB_FORMAT2:
> Assume L2 gave us FORMAT0 and we are using FORMAT2. You would copy wrong
> bits. See below, maybe we need conversion.
+1
and in the case we have FORTMAT1 in L2 and/or L3, you also copy them 
from and/or to the wrong place.

>
>> +		mask1 = (unsigned long *)vsie_page->crycb.apcb1.apm;
>> +		mask2 = (unsigned long *)
>> +			vcpu->kvm->arch.crypto.crycb->apcb1.apm;
>> +		bitmap_and(mask1, mask1, mask2, APCB1_MASK_SIZE);
>> +
>> +		mask1 = (unsigned long *)vsie_page->crycb.apcb1.aqm;
>> +		mask2 = (unsigned long *)
>> +			vcpu->kvm->arch.crypto.crycb->apcb1.aqm;
>> +		bitmap_and(mask1, mask1, mask2, APCB1_MASK_SIZE);
>> +
>> +		mask1 = (unsigned long *)vsie_page->crycb.apcb1.adm;
>> +		mask2 = (unsigned long *)
>> +			vcpu->kvm->arch.crypto.crycb->apcb1.adm;
>> +		bitmap_and(mask1, mask1, mask2, APCB1_MASK_SIZE);
>> +		break;
>> +	default:
>> +		mask1 = (unsigned long *)vsie_page->crycb.apcb0.apm;
>> +		mask2 = (unsigned long *)
>> +			vcpu->kvm->arch.crypto.crycb->apcb1.apm;
>> +		bitmap_and(mask1, mask1, mask2, APCB0_MASK_SIZE);
>> +
>> +		mask1 = (unsigned long *)vsie_page->crycb.apcb0.aqm;
>> +		mask2 = (unsigned long *)
>> +			vcpu->kvm->arch.crypto.crycb->apcb1.aqm;
>> +		bitmap_and(mask1, mask1, mask2, APCB0_MASK_SIZE);
>> +
>> +		mask1 = (unsigned long *)vsie_page->crycb.apcb0.adm;
>> +		mask2 = (unsigned long *)
>> +			vcpu->kvm->arch.crypto.crycb->apcb1.adm;
>> +		bitmap_and(mask1, mask1, mask2, APCB0_MASK_SIZE);
>> +		break;
>> +	}
>> +}
>> +
>> +/*
>>    * Create a shadow copy of the crycb block and setup key wrapping, if
>>    * requested for guest 3 and enabled for guest 2.
>>    *
>> - * We only accept format-1 (no AP in g2), but convert it into format-2
>> - * There is nothing to do for format-0.
>> - *
>>    * Returns: - 0 if shadowed or nothing to do
>>    *          - > 0 if control has to be given to guest 2
>>    */
>> @@ -155,9 +200,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	unsigned long *b1, *b2;
>>   	u8 ecb3_flags;
>>   
>> -	scb_s->crycbd = 0;
>> -	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>> -		return 0;
>> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb);
>> +	kvm_ap_set_crycb_format(vcpu->kvm, &scb_s->crycbd);
>> +
>> +	/* copy the crycb */
>> +	if (read_guest_real(vcpu, crycb_addr, &vsie_page->crycb,
>> +			    sizeof(vsie_page->crycb)))
>> +		return set_validity_icpt(scb_s, 0x0035U);
> This looks wrong. You are always copying from L2, although L2 might not
> even set up a crycb for L3. You removed the important crycbd_o check.
>
> Don't we need the following?
>
> a) Determine the _allowed_ crycb format for L2 -> L3. (How can we tell
> which format L2 is allowed to use for L3)
> b) Determine the target crycb format. This is basically
> vm_ap_set_crycb_format afaics.
> c) Convert the given crycb to the target crycb format.
>
> So importantly, can you clarify (as I don't have access to documentation):
>
> - When is L2 allowed to use format-0? So when will the format not be
> ignored but is actually used?
>
> - When is L2 allowed to use fortma-2? So when will the format not be
> ignored but is actually used?
>
> - When does the SIE start interpreting AP instructions? So how can we
> hinder it from doing so? Empty masks? crycb format?
>
>> +
>> +	/* set up the effective masks */
>> +	set_crycb_emasks(vcpu, vsie_page);
>> +
>>   	/* format-1 is supported with message-security-assist extension 3 */
>>   	if (!test_kvm_facility(vcpu->kvm, 76))
>>   		return 0;
> You now already copied the wrapping keys. So they could be !0. Please
> add a comment why we don't care.
>
> /* wrapping keys are ignored without ECB3_AES / ECB3_DEA */
>
>> @@ -172,13 +225,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	else if (!crycb_addr)
>>   		return set_validity_icpt(scb_s, 0x0039U);
>>   
>> -	/* copy only the wrapping keys */
>> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
>> -		return set_validity_icpt(scb_s, 0x0035U);
>> -
>>   	scb_s->ecb3 |= ecb3_flags;
>> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
>> -			CRYCB_FORMAT2;
>>   
>>   	/* xor both blocks in one run */
>>   	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

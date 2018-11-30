From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:26:32 +0000
Subject: Re: [PATCH v3 08/12] KVM: s390: add function process_gib_alert_list()
Message-Id: <84a3cf3c-bb7b-1683-f2a6-fa7ee67fda1d@linux.ibm.com>
In-Reply-To: <c50ea6b8-33d5-50bf-0076-47881e506128@redhat.com>
References: <c50ea6b8-33d5-50bf-0076-47881e506128@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 29.11.18 14:14, David Hildenbrand wrote:
> On 28.11.18 11:19, Michael Mueller wrote:
>> This function processes the gib alert list. It is required to
>> run when either a gib alert interruption has been received or
>> a gisa that might be in the alert list is cleared or dropped.
>>
>> The GIB alert list contains all GISAs that have pending
>> adapter interruptions.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 251d01f1e9bf..37a5df4e8dac 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2900,6 +2900,56 @@ static void nullify_gisa(struct kvm_s390_gisa *gisa)
>>   	gisa->next_alert = (u32)(u64)gisa;
>>   }
>>   
>> +#define NULL_GISA_ADDR 0x00000000UL
>> +#define NONE_GISA_ADDR 0x00000001UL
>> +#define GISA_ADDR_MASK 0xfffff000UL
>> +
>> +static void __maybe_unused process_gib_alert_list(void)
>> +{
>> +	u32 final, next_alert, origin = 0UL;
>> +	struct kvm_s390_gisa *gisa;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm *kvm;
>> +
>> +	do {
>> +		/*
>> +		 * If the NONE_GISA_ADDR is still stored in the alert list
>> +		 * origin, we will leave the outer loop. No further GISA has
>> +		 * been added to the alert list by millicode while processing
>> +		 * the current alert list.
>> +		 */
>> +		final = (origin & NONE_GISA_ADDR);
>> +		/*
>> +		 * Cut off the alert list and store the NONE_GISA_ADDR in the
>> +		 * alert list origin to avoid further GAL interruptions.
>> +		 * A new alert list can be build up by millicode in parallel
>> +		 * for guests not in the yet cut-off alert list. When in the
>> +		 * final loop, store the NULL_GISA_ADDR instead. This will re-
>> +		 * enable GAL interruptions on the host again.
>> +		 */
>> +		for (origin = xchg(&gib->alert_list_origin,
>> +				   (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
>> +		     /* Loop through the just cut-off alert list. */
>> +		     origin & GISA_ADDR_MASK;
>> +		     origin = next_alert) {
>> +			gisa = (struct kvm_s390_gisa *)(u64)origin;
>> +			next_alert = gisa->next_alert;
>> +			/* Unlink the GISA from the alert list. */
>> +			gisa->next_alert = origin;
>> +			if (!kvm_s390_gisa_get_ipm(gisa))
>> +				continue;
>> +			/*
>> +			 * Wake-up an idle vcpu of the kvm this GISA
>> +			 * belongs to if available.
>> +			 */
>> +			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>> +			vcpu = __find_vcpu_for_floating_irq(kvm);
>> +			if (vcpu)
>> +				kvm_s390_vcpu_wakeup(vcpu);
>> +		}
>> +	} while (!final);
>> +}
>> +
>>   void kvm_s390_gisa_clear(struct kvm *kvm)
>>   {
>>   	if (kvm->arch.gisa) {
>>
> 
> I guess I would squash this into patch 10. More context there how/when
> this is called.
> 

I still want to keep it separate.

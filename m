From: Michael Mueller <mimu@linux.ibm.com>
Date: Tue, 27 Nov 2018 17:15:31 +0000
Subject: Re: [PATCH v2 09/12] KVM: s390: add function process_gib_alert_list()
Message-Id: <8deb99cd-d27a-37a4-0f24-29a038394d5e@linux.ibm.com>
In-Reply-To: <20181126165723.2618ff2b.cohuck@redhat.com>
References: <20181126165723.2618ff2b.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 26.11.18 16:57, Cornelia Huck wrote:
> On Mon, 19 Nov 2018 18:25:33 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> This function processes a gib alert list. It is required to
>> run when either a gib alert interruption has been received or
>> a gisa that might be in the alert list is cleared or dropped.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 8676596f6b5c..443d1804d611 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2910,6 +2910,34 @@ static void nullify_gisa(struct kvm_s390_gisa *gisa)
>>   	gisa->next_alert = (u32)(u64)gisa;
>>   }
>>   
>> +/*
>> + * Before processing, the gib alert list needs to be cut-off from
>> + * the gib by means of function unlink_gib_alert_list(). If non NULL,
>> + * the list is processed from its latest to oldest entry.
>> + *
>> + * Processing an gisa entry needs to wake-up a vcpu of the kvm this gisa
>> + * belongs to. Thus, the pending guest interruption will be processed
>> + * in SIE context.
>> + */
>> +static void __maybe_unused process_gib_alert_list(void)
>> +{
>> +	struct kvm_s390_gisa *gisa = unlink_gib_alert_list();
>> +	struct kvm_s390_gisa *next_alert;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm *kvm;
>> +
>> +	for (; gisa; gisa = next_alert) {
>> +		next_alert = (struct kvm_s390_gisa *)(u64)gisa->next_alert;
>> +		/* unlink from alert list */
>> +		gisa->next_alert = (u32)(u64)gisa;

The check goes here.

>> +		/* wake-up a vcpu of the kvm this gisa belongs to */
>> +		kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>> +		vcpu = __find_vcpu_for_floating_irq(kvm);
>> +		if (vcpu)
>> +			kvm_s390_vcpu_wakeup(vcpu);
> 
> Just to check if I understood correctly: This loop is where you'll add
> the extra check whether the interrupt has already been delivered, right?

That's correct!
> 
>> +	}
>> +}
>> +
>>   void kvm_s390_gisa_clear(struct kvm *kvm)
>>   {
>>   	if (kvm->arch.gisa) {
> 

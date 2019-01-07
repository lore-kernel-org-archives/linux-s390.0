From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function process_gib_alert_list()
Date: Mon, 7 Jan 2019 20:19:26 +0100
Message-ID: <ae479e60-d235-acf3-55cc-afd875644a19@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-14-mimu@linux.ibm.com>
 <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <645d74cf-7448-f143-c899-bdcf290dac59@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 03.01.19 15:43, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> This function processes the Gib Alert List (GAL). It is required
>> to run when either a gib alert interruption has been received or
>> a gisa that is in the alert list is cleared or dropped.
>>
>> The GAL is build up by millicode, when the respective ISC bit is
>> set in the Interruption Alert Mask (IAM) and an interruption of
>> that class is observed.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 140 
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 140 insertions(+)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 48a93f5e5333..03e7ba4f215a 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu 
>> *vcpu, __u8 __user *buf, int len)
>>       return n;
>>   }
>>   +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)
>
> static inline ?


will add


>
>> +{
>> +    struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
>> +    struct kvm_vcpu *vcpu = NULL, *kick_vcpu[MAX_ISC + 1];
>> +    int online_vcpus = atomic_read(&kvm->online_vcpus);
>> +    u8 ioint_mask, isc_mask, kick_mask = 0x00;
>> +    int vcpu_id, kicked = 0;
>> +
>> +    /* Loop over vcpus in WAIT state. */
>> +    for (vcpu_id = find_first_bit(fi->idle_mask, online_vcpus);
>> +         /* Until all pending ISCs have a vcpu open for airqs. */
>> +         (~kick_mask & ipm) && vcpu_id < online_vcpus;
>> +         vcpu_id = find_next_bit(fi->idle_mask, online_vcpus, 
>> vcpu_id)) {
>> +        vcpu = kvm_get_vcpu(kvm, vcpu_id);
>> +        if (psw_ioint_disabled(vcpu))
>> +            continue;
>> +        ioint_mask = (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
>> +        for (isc_mask = 0x80; isc_mask; isc_mask >>= 1) {
>> +            /* ISC pending in IPM ? */
>> +            if (!(ipm & isc_mask))
>> +                continue;
>> +            /* vcpu for this ISC already found ? */
>> +            if (kick_mask & isc_mask)
>> +                continue;
>> +            /* vcpu open for airq of this ISC ? */
>> +            if (!(ioint_mask & isc_mask))
>> +                continue;
>> +            /* use this vcpu (for all ISCs in ioint_mask) */
>> +            kick_mask |= ioint_mask; > + kick_vcpu[kicked++] = vcpu;
>> +        }
>> +    }
>> +
>> +    if (vcpu && ~kick_mask & ipm)
>> +        VM_EVENT(kvm, 4, "gib alert undeliverable isc mask 0x%02x",
>> +             ~kick_mask & ipm);
>> +
>> +    for (vcpu_id = 0; vcpu_id < kicked; vcpu_id++)
>> +        kvm_s390_vcpu_wakeup(kick_vcpu[vcpu_id]);
>> +
>> +    return (online_vcpus != 0) ? kicked : -ENODEV;
>> +}
>> +
>> +static void __floating_airqs_kick(struct kvm *kvm)
> static inline ?


and here as well


>
>> +{
>> +    struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
>> +    int online_vcpus, kicked;
>> +    u8 ipm_t0, ipm;
>> +
>> +    /* Get IPM and return if clean, IAM has been restored. */
>> +    ipm = get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM);
>
> If we do not get an IPM here, it must have been stolen by the firmware 
> for delivery to the guest.
> Then why restoring the IAM?
>
> Or do I miss something?
>
>> +    if (!ipm)
>> +        return;
>> +retry:
>> +    ipm_t0 = ipm;
>> +
>> +    /* Try to kick some vcpus in WAIT state. */
>> +    kicked = __try_airqs_kick(kvm, ipm);
>> +    if (kicked < 0)
>> +        return;
>> +
>> +    /* Get IPM and return if clean, IAM has been restored. */
>> +    ipm = get_ipm(kvm->arch.gisa, IRQ_FLAG_IAM);
>> +    if (!ipm)
>> +        return;
>> +
>> +    /* Start over, if new ISC bits are pending in IPM. */
>> +    if ((ipm_t0 ^ ipm) & ~ipm_t0)
>> +        goto retry;
>> +
>> +    /*
>> +     * Return as we just kicked at least one vcpu in WAIT state
>> +     * open for airqs. The IAM will be restored latest when one
>> +     * of them goes into WAIT or STOP state.
>> +     */
>> +    if (kicked > 0)
>> +        return;
>> +
>> +    /*
>> +     * No vcpu was kicked either because no vcpu was in WAIT state
>> +     * or none of the vcpus in WAIT state are open for airqs.
>> +     * Return immediately if no vcpus are in WAIT state.
>> +     * There are vcpus in RUN state. They will process the airqs
>> +     * if not closed for airqs as well. In that case the system will
>> +     * delay airqs until a vcpu decides to take airqs again.
>> +     */
>> +    online_vcpus = atomic_read(&kvm->online_vcpus);
>> +    if (!bitmap_weight(fi->idle_mask, online_vcpus))
>> +        return;
>> +
>> +    /*
>> +     * None of the vcpus in WAIT state take airqs and we might
>> +     * have no running vcpus as at least one vcpu is in WAIT state
>> +     * and IPM is dirty.
>> +     */
>> +    set_iam(kvm->arch.gisa, kvm->arch.iam);
>
> I do not understand why we need to set IAM here.
> The interrupt will be delivered by the firmware as soon as the PSW or 
> CR6 is changed by any vCPU.
> ...and if this does not happen we can not deliver the interrupt anyway.
>
>> +}
>> +
>> +#define NULL_GISA_ADDR 0x00000000UL
>> +#define NONE_GISA_ADDR 0x00000001UL
>> +#define GISA_ADDR_MASK 0xfffff000UL
>> +
>> +static void __maybe_unused process_gib_alert_list(void)
>> +{
>> +    u32 final, next_alert, origin = 0UL;
>> +    struct kvm_s390_gisa *gisa;
>> +    struct kvm *kvm;
>> +
>> +    do {
>> +        /*
>> +         * If the NONE_GISA_ADDR is still stored in the alert list
>> +         * origin, we will leave the outer loop. No further GISA has
>> +         * been added to the alert list by millicode while processing
>> +         * the current alert list.
>> +         */
>> +        final = (origin & NONE_GISA_ADDR);
>> +        /*
>> +         * Cut off the alert list and store the NONE_GISA_ADDR in the
>> +         * alert list origin to avoid further GAL interruptions.
>> +         * A new alert list can be build up by millicode in parallel
>> +         * for guests not in the yet cut-off alert list. When in the
>> +         * final loop, store the NULL_GISA_ADDR instead. This will re-
>> +         * enable GAL interruptions on the host again.
>> +         */
>> +        origin = xchg(&gib->alert_list_origin,
>> +                  (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
>> +        /* Loop through the just cut-off alert list. */
>> +        while (origin & GISA_ADDR_MASK) {
>> +            gisa = (struct kvm_s390_gisa *)(u64)origin;
>> +            next_alert = gisa->next_alert;
>> +            /* Unlink the GISA from the alert list. */
>> +            gisa->next_alert = origin;
>
> AFAIU this enable GISA interrupt for the guest...
>
>> +            kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>> +            /* Kick suitable vcpus */
>> +            __floating_airqs_kick(kvm);
>
> ...and here we kick a VCPU for the guest.
>
> Logically I would do it in the otherway, first kicking the vCPU then 
> enabling the GISA interruption again.
>
> If the IPM bit is cleared by the firmware during delivering the 
> interrupt to the guest before we enter get_ipm() called by 
> __floating_airqs_kick() we will set the IAM despite we have a running 
> CPU handling the IRQ.
> In the worst case we can also set the IAM with the GISA in the alert 
> list.
> Or we must accept that the firmware can deliver the IPM as soon as we 
> reset the GISA next field.
>
>> +            origin = next_alert;
>> +        }
>> +    } while (!final);
>> +}
>> +
>>   static void nullify_gisa(struct kvm_s390_gisa *gisa)
>>   {
>>       memset(gisa, 0, sizeof(struct kvm_s390_gisa));
>>
>
> I think that avoiding to restore the IAM during the call to get_ipm 
> inside __floating_airqs_kick() would good.
>
> If you agree, with that:
>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>
>
-- 
Mit freundlichen Grüßen / Kind regards
Michael Müller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

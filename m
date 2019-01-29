From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v6 12/13] KVM: s390: add gib_alert_irq_handler()
Date: Tue, 29 Jan 2019 16:29:40 +0100
Message-ID: <3819a46e-b2cf-96e3-b3b8-6cdf35eeb616@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-13-mimu@linux.ibm.com>
 <20190129142642.3a94a5f1@oc2783563651>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129142642.3a94a5f1@oc2783563651>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 29.01.19 14:26, Halil Pasic wrote:
> On Thu, 24 Jan 2019 13:59:38 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> The patch implements a handler for GIB alert interruptions
>> on the host. Its task is to alert guests that interrupts are
>> pending for them.
>>
>> A GIB alert interrupt statistic counter is added as well:
>>
>> $ cat /proc/interrupts
>>            CPU0       CPU1
>>    ...
>>    GAL:      23         37   [I/O] GIB Alert
>>    ...
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> [..]
>> +/**
>> + * gisa_get_ipm_or_restore_iam - return IPM or restore GISA IAM
>> + *
>> + * @gi: gisa interrupt struct to work on
>> + *
>> + * Atomically restores the interruption alert mask if none of the
>> + * relevant ISCs are pending and return the IPM.
> 
> The word 'relevant' probably reflects some previous state. It does not
> bother me too much.

"relevant" refers to the ISCs handled by the GAL mechanism, i.e those
registered in the kvm->arch.gisa_int.alert.mask.

> 
> [..]
> 
>>   
>> +static void __airqs_kick_single_vcpu(struct kvm *kvm, u8 deliverable_mask)
>> +{
>> +	int vcpu_id, online_vcpus = atomic_read(&kvm->online_vcpus);
>> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	for_each_set_bit(vcpu_id, kvm->arch.idle_mask, online_vcpus) {
>> +		vcpu = kvm_get_vcpu(kvm, vcpu_id);
>> +		if (psw_ioint_disabled(vcpu))
>> +			continue;
>> +		deliverable_mask &= (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
>> +		if (deliverable_mask) {
>> +			/* lately kicked but not yet running */
> 
> How about /* was kicked but didn't run yet */?

what is the difference here...

> 
>> +			if (test_and_set_bit(vcpu_id, gi->kicked_mask))
>> +				return;
>> +			kvm_s390_vcpu_wakeup(vcpu);
>> +			return;
>> +		}
>> +	}
>> +}
>> +
> 
> [..]
> 
>> +static void process_gib_alert_list(void)
>> +{
>> +	struct kvm_s390_gisa_interrupt *gi;
>> +	struct kvm_s390_gisa *gisa;
>> +	struct kvm *kvm;
>> +	u32 final, origin = 0UL;
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
>> +		origin = xchg(&gib->alert_list_origin,
>> +			      (!final) ? NONE_GISA_ADDR : NULL_GISA_ADDR);
>> +		/*
>> +		 * Loop through the just cut-off alert list and start the
>> +		 * gisa timers to kick idle vcpus to consume the pending
>> +		 * interruptions asap.
>> +		 */
>> +		while (origin & GISA_ADDR_MASK) {
>> +			gisa = (struct kvm_s390_gisa *)(u64)origin;
>> +			origin = gisa->next_alert;
>> +			gisa->next_alert = (u32)(u64)gisa;
>> +			kvm = container_of(gisa, struct sie_page2, gisa)->kvm;
>> +			gi = &kvm->arch.gisa_int;
>> +			if (hrtimer_active(&gi->timer))
>> +				hrtimer_cancel(&gi->timer);
>> +			hrtimer_start(&gi->timer, 0, HRTIMER_MODE_REL);
>> +		}
>> +	} while (!final);
>> +
>> +}
>> +
>>   void kvm_s390_gisa_clear(struct kvm *kvm)
>>   {
>>   	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>>   
>>   	if (!gi->origin)
>>   		return;
>> -	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>> -	gi->origin->next_alert = (u32)(u64)gi->origin;
>> +	gisa_clear_ipm(gi->origin);
> 
> This could be a separate patch. I would like little more explanation
> to this.

I can break at out as I had before... ;)

> 
>>   	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
>>   }
>>   
>> @@ -2940,13 +3078,25 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>>   	gi->origin = &kvm->arch.sie_page2->gisa;
>>   	gi->alert.mask = 0;
>>   	spin_lock_init(&gi->alert.ref_lock);
>> -	kvm_s390_gisa_clear(kvm);
>> +	gi->expires = 50 * 1000; /* 50 usec */
> 
> I blindly trust your choice here ;)

You know I will increase it to 1 ms together with the change that I
proposed. (gisa_get_ipm_or_restore_iam() in kvm_s390_handle_wait()).

> 
>> +	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +	gi->timer.function = gisa_vcpu_kicker;
>> +	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>> +	gi->origin->next_alert = (u32)(u64)gi->origin;
>>   	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>>   }
>>   
>>   void kvm_s390_gisa_destroy(struct kvm *kvm)
>>   {
>> -	kvm->arch.gisa_int.origin = NULL;
>> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>> +
>> +	if (!gi->origin)
>> +		return;
>> +	hrtimer_cancel(&gi->timer);
> 
> I'm not sure this cancel here is sufficient.
> 
>> +	WRITE_ONCE(gi->alert.mask, 0);
>> +	while (gisa_in_alert_list(gi->origin))
>> +		cpu_relax();
> 
> If you end up waiting here, I guess, it's likely that a new
> timer is going to get set up right after we do
> gisa->next_alert = (u32)(u64)gisa;
> in  process_gib_alert_list().

There will be no vcpus available anymore at this time, whence
none will be kicked by the timer function. Thus canceling the
timer will be sufficient after the loop.

I have addressed the message as well, but will write it into
the KVM trace.

  void kvm_s390_gisa_destroy(struct kvm *kvm)
  {
-       kvm->arch.gisa_int.origin = NULL;
+       struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
+
+       if (!gi->origin)
+               return;
+       if (gi->alert.mask)
+               KVM_EVENT(3, "vm 0x%pK has unexpected iam 0x%02x",
+                         kvm, gi->alert.mask);
+       while (gisa_in_alert_list(gi->origin))
+               cpu_relax();
+       hrtimer_cancel(&gi->timer);
+       gi->origin = NULL;
  }


> 
>> +	gi->origin = NULL;
>>   }
>>   
>>   /**
>> @@ -3037,11 +3187,23 @@ int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
>>   }
>>   EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
>>   
> 
> 
> Overall, there are couple of things I would prefer done differently,
> but better something working today that something prefect in 6 months.
> In that sense, provided my comment regarding destroy is addressed:
> 
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> 

Michael

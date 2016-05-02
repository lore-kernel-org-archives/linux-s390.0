From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Mon, 2 May 2016 16:30:33 +0200
Message-ID: <57276489.2050902@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <20160502133428.GA30059@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160502133428.GA30059@potion>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/02/2016 03:34 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2016-05-02 12:42+0200, Christian Borntraeger:
>> Radim, Paolo,
>>
>> can you have a look at this patch? If you are ok with it, I want to
>> submit this patch with my next s390 pull request. It touches KVM com=
mon
>> code, but I tried to make it a nop for everything but s390.
>=20
> (I have few questions and will ack the solution if you stand behind i=
t.)
>=20
>> Christian
>>
>> ----snip----
>>
>>
>> Some wakeups should not be considered a sucessful poll. For example =
on
>> s390 I/O interrupts are usually floating, which means that _ALL_ CPU=
s
>> would be considered runnable - letting all vCPUs poll all the time f=
or
>> transactional like workload, even if one vCPU would be enough.
>>
>> This can result in huge CPU usage for large guests.
>> This patch lets architectures provide a way to qualify wakeups if th=
ey
>> should be considered a good/bad wakeups in regard to polls.
>>
>> For s390 the implementation will fence of halt polling for anything =
but
>> known good, single vCPU events. The s390 implementation for floating
>> interrupts does a wakeup for one vCPU, but the interrupt will be del=
ivered
>> by whatever CPU comes first. To limit the halt polling we only mark =
the
>> woken up CPU as a valid poll. This code will also cover several othe=
r
>> wakeup reasons like IPI or expired timers. This will of course also =
mark
>> some events as not sucessful. As  KVM on z runs always as a 2nd leve=
l
>> hypervisor, we prefer to not poll, unless we are really sure, though=
=2E
>>
>> So we start with a minimal set and will provide additional patches i=
n
>> the future that mark additional code paths as valid wakeups, if that
>> turns out to be necessary.
>>
>> This patch successfully limits the CPU usage for cases like uperf 1b=
yte
>> transactional ping pong workload or wakeup heavy workload like OLTP
>> while still providing a proper speedup.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> @@ -976,6 +976,14 @@ no_timer:
>> =20
>>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
>>  {
>> +	/*
>> +	 * This is outside of the if because we want to mark the wakeup
>> +	 * as valid for vCPUs that
>> +	 * a: do polling right now
>> +	 * b: do sleep right now
>> +	 * otherwise we would never grow the poll interval properly
>> +	 */
>> +	vcpu_set_valid_wakeup(vcpu);
>>  	if (waitqueue_active(&vcpu->wq)) {
>=20
> (Can't kvm_s390_vcpu_wakeup() be called when the vcpu isn't in
>  kvm_vcpu_block()?  Either this condition is useless or we'd the set
>  vcpu_set_valid_wakeup() for any future wakeup.)

Yes, for example a timer might expire (see  kvm_s390_idle_wakeup) AND t=
he
vcpu was already woken up by an I/O interrupt and we are in the process=
 of
leaving kvm_vcpu_block. And yes, we might overindicate and set valid wa=
keup
in that case, but this is fine as this is jut a heuristics which will r=
ecover.
=20
The problem is, that I cannot move vcpu_set_valid_wakeup inside the if,
because then a VCPU can be inside kvm_vcpu_block (polling) but the wait=
queue
is not yet active. (in other words, the poll interval will be 0, or gro=
w
once just to be reset to 0 afterwards.)

>=20
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> @@ -224,6 +224,7 @@ struct kvm_vcpu {
>>  	sigset_t sigset;
>>  	struct kvm_vcpu_stat stat;
>>  	unsigned int halt_poll_ns;
>> +	bool valid_wakeup;
>> =20
>>  #ifdef CONFIG_HAS_IOMEM
>>  	int mmio_needed;
>> @@ -1178,4 +1179,37 @@ int kvm_arch_update_irqfd_routing(struct kvm =
*kvm, unsigned int host_irq,
>>  				  uint32_t guest_irq, bool set);
>>  #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
>> =20
>> +#ifdef CONFIG_HAVE_KVM_INVALID_POLLS
>> +/* If we wakeup during the poll time, was it a sucessful poll? */
>> +static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
>=20
> (smp barriers?)

Not sure. Do we need to order valid_wakeup against other stores/reads?
To me it looks like the order of stores/fetches for the different value=
s
should not matter.
I can certainly add smp_rmb/wmb to getters/setters, but I can not see a
problematic case right now and barriers require comments. Can you elabo=
rate
what you see as potential issue?

>=20
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> @@ -41,6 +41,10 @@ config KVM_VFIO
>> +config HAVE_KVM_INVALID_POLLS
>> +       bool
>> +
>> +
>=20
> (One newline is enough.)

sure.
>=20

>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> @@ -2008,7 +2008,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>  			 * arrives.
>>  			 */
>>  			if (kvm_vcpu_check_block(vcpu) < 0) {
>> -				++vcpu->stat.halt_successful_poll;
>> +				if (vcpu_valid_wakeup(vcpu))
>> +					++vcpu->stat.halt_successful_poll;
>=20
> KVM didn't call schedule(), so it's still a successful poll, IMO, jus=
t
> invalid.

so just always do ++vcpu->stat.halt_successful_poll; and add another co=
unter=20
that counts polls that will not be used for growing/shrinking?
like
			++vcpu->stat.halt_successful_poll;
			if (!vcpu_valid_wakeup(vcpu))
				++vcpu->stat.halt_poll_no_tuning;=20

?



>=20
>>  				goto out;
>>  			}
>>  			cur =3D ktime_get();
>> @@ -2038,14 +2039,16 @@ out:
>>  		if (block_ns <=3D vcpu->halt_poll_ns)
>>  			;
>>  		/* we had a long block, shrink polling */
>> -		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
>> +		else if (!vcpu_valid_wakeup(vcpu) ||
>> +			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
>>  			shrink_halt_poll_ns(vcpu);
>=20
> Is the shrinking important?
>=20
>>  		/* we had a short halt and our poll time is too small */
>>  		else if (vcpu->halt_poll_ns < halt_poll_ns &&
>> -			block_ns < halt_poll_ns)
>> +			block_ns < halt_poll_ns && vcpu_valid_wakeup(vcpu))
>>  			grow_halt_poll_ns(vcpu);
>=20
> IIUC, the problem comes from overgrown halt_poll_ns, so couldn't we j=
ust
> ignore all invalid wakeups?

I have some pathological cases where I can easily get all CPUs to poll =
all
the time without the shrinking part of the patch. (e.g. guest with 16 C=
PUs,
8 null block devices and 64 dd reading small blocks with O_DIRECT from =
these disks)
which cause permanent exits which consumes all 16 host CPUs. Limiting t=
he grow
did not seem to be enough in my testing, but when I also made shrinking=
 more
aggressive things improved.

But I am certainly open for other ideas how to tune this.



>=20
> It would make more sense to me, because we are not interested in late=
ncy
> of invalid wakeups, so they shouldn't affect valid ones.
>=20
>>  	} else
>>  		vcpu->halt_poll_ns =3D 0;
>> +	vcpu_reset_wakeup(vcpu);
>> =20
>>  	trace_kvm_vcpu_wakeup(block_ns, waited);
>=20
> (Tracing valid/invalid wakeups could be useful.)

As an extension of the old trace events?

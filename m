From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Mon, 2 May 2016 17:25:18 +0200
Message-ID: <20160502152517.GB30059@potion>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <20160502133428.GA30059@potion>
 <57276489.2050902@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57276489.2050902@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

2016-05-02 16:30+0200, Christian Borntraeger:
> On 05/02/2016 03:34 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
>> 2016-05-02 12:42+0200, Christian Borntraeger:
>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>> @@ -976,6 +976,14 @@ no_timer:
>>> =20
>>>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
>>>  {
>>> +	/*
>>> +	 * This is outside of the if because we want to mark the wakeup
>>> +	 * as valid for vCPUs that
>>> +	 * a: do polling right now
>>> +	 * b: do sleep right now
>>> +	 * otherwise we would never grow the poll interval properly
>>> +	 */
>>> +	vcpu_set_valid_wakeup(vcpu);
>>>  	if (waitqueue_active(&vcpu->wq)) {
>>=20
>> (Can't kvm_s390_vcpu_wakeup() be called when the vcpu isn't in
>>  kvm_vcpu_block()?  Either this condition is useless or we'd the set
>>  vcpu_set_valid_wakeup() for any future wakeup.)
>=20
> Yes, for example a timer might expire (see  kvm_s390_idle_wakeup) AND=
 the
> vcpu was already woken up by an I/O interrupt and we are in the proce=
ss of
> leaving kvm_vcpu_block. And yes, we might overindicate and set valid =
wakeup
> in that case, but this is fine as this is jut a heuristics which will=
 recover.
> =20
> The problem is, that I cannot move vcpu_set_valid_wakeup inside the i=
f,
> because then a VCPU can be inside kvm_vcpu_block (polling) but the wa=
itqueue
> is not yet active. (in other words, the poll interval will be 0, or g=
row
> once just to be reset to 0 afterwards.)

I see, thanks.

>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>> @@ -224,6 +224,7 @@ struct kvm_vcpu {
>>>  	sigset_t sigset;
>>>  	struct kvm_vcpu_stat stat;
>>>  	unsigned int halt_poll_ns;
>>> +	bool valid_wakeup;
>>> =20
>>>  #ifdef CONFIG_HAS_IOMEM
>>>  	int mmio_needed;
>>> @@ -1178,4 +1179,37 @@ int kvm_arch_update_irqfd_routing(struct kvm=
 *kvm, unsigned int host_irq,
>>>  				  uint32_t guest_irq, bool set);
>>>  #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
>>> =20
>>> +#ifdef CONFIG_HAVE_KVM_INVALID_POLLS
>>> +/* If we wakeup during the poll time, was it a sucessful poll? */
>>> +static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
>>=20
>> (smp barriers?)
>=20
> Not sure. Do we need to order valid_wakeup against other stores/reads=
?
> To me it looks like the order of stores/fetches for the different val=
ues
> should not matter.

Yeah, I was forgetting that polling doesn't need to be perfect.

> I can certainly add smp_rmb/wmb to getters/setters, but I can not see=
 a
> problematic case right now and barriers require comments. Can you ela=
borate
> what you see as potential issue?

I agree that it's fine to believe in GCC and CPU, because it is just a
heuristic.

To the ignorable issue itself: The proper protocol for wakeup is
  1) set valid_wakeup to true
  2) set wakeup condition for kvm_vcpu_check_block().
  3) potentially wake up the vcpu
because we never check valid_wakeup without kvm_vcpu_check_block(),
hence we shouldn't allow read-ahead of valid_wakeup or late-setting of
valid_wakeup to avoid treating valid wakeups as invalid.

>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> @@ -2008,7 +2008,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>>>  			 * arrives.
>>>  			 */
>>>  			if (kvm_vcpu_check_block(vcpu) < 0) {
>>> -				++vcpu->stat.halt_successful_poll;
>>> +				if (vcpu_valid_wakeup(vcpu))
>>> +					++vcpu->stat.halt_successful_poll;
>>=20
>> KVM didn't call schedule(), so it's still a successful poll, IMO, ju=
st
>> invalid.
>=20
> so just always do ++vcpu->stat.halt_successful_poll; and add another =
counter=20
> that counts polls that will not be used for growing/shrinking?
> like
> 			++vcpu->stat.halt_successful_poll;
> 			if (!vcpu_valid_wakeup(vcpu))
> 				++vcpu->stat.halt_poll_no_tuning;=20
>=20
> ?

Looks good.  Large numbers in halt_poll_no_tuning relative to
halt_successful_poll is a clearer warning flag.

>>=20
>>>  				goto out;
>>>  			}
>>>  			cur =3D ktime_get();
>>> @@ -2038,14 +2039,16 @@ out:
>>>  		if (block_ns <=3D vcpu->halt_poll_ns)
>>>  			;
>>>  		/* we had a long block, shrink polling */
>>> -		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
>>> +		else if (!vcpu_valid_wakeup(vcpu) ||
>>> +			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
>>>  			shrink_halt_poll_ns(vcpu);
>>=20
>> Is the shrinking important?
>>=20
>>>  		/* we had a short halt and our poll time is too small */
>>>  		else if (vcpu->halt_poll_ns < halt_poll_ns &&
>>> -			block_ns < halt_poll_ns)
>>> +			block_ns < halt_poll_ns && vcpu_valid_wakeup(vcpu))
>>>  			grow_halt_poll_ns(vcpu);
>>=20
>> IIUC, the problem comes from overgrown halt_poll_ns, so couldn't we =
just
>> ignore all invalid wakeups?
>=20
> I have some pathological cases where I can easily get all CPUs to pol=
l all
> the time without the shrinking part of the patch. (e.g. guest with 16=
 CPUs,
> 8 null block devices and 64 dd reading small blocks with O_DIRECT fro=
m these disks)
> which cause permanent exits which consumes all 16 host CPUs. Limiting=
 the grow
> did not seem to be enough in my testing, but when I also made shrinki=
ng more
> aggressive things improved.

So the problem is that a large number of VCPUs and devices will often
have a floating irq and the polling always succeeds unless halt_poll_ns
is very small.  Poll window doesn't change if the poll succeds,
therefore we need a very agressive shrinker in order to avoid polling?

> But I am certainly open for other ideas how to tune this.

I don't see good improvements ... the problem seems to lie elsewhere:
Couldn't we exclude floating irqs from kvm_vcpu_check_block()?

(A VCPU running for other reasons could still handle a floating irq and
 we always kick one VCPU, so VM won't starve and other VCPUs won't be
 prevented from sleeping.)

>> It would make more sense to me, because we are not interested in lat=
ency
>> of invalid wakeups, so they shouldn't affect valid ones.
>>=20
>>>  	} else
>>>  		vcpu->halt_poll_ns =3D 0;
>>> +	vcpu_reset_wakeup(vcpu);
>>> =20
>>>  	trace_kvm_vcpu_wakeup(block_ns, waited);
>>=20
>> (Tracing valid/invalid wakeups could be useful.)
>=20
> As an extension of the old trace events?

Yes.

From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 05 Dec 2018 12:45:48 +0000
Subject: Re: [PATCH v4 09/10] KVM: s390: add and wire function gib_alert_irq_handler()
Message-Id: <20181205134548.29423eac@oc2783563651>
In-Reply-To: <44dbd563-c1e2-eaf9-a959-eae55abf2e85@linux.ibm.com>
References: <44dbd563-c1e2-eaf9-a959-eae55abf2e85@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 5 Dec 2018 11:26:18 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> 
> 
> On 05.12.18 10:35, Halil Pasic wrote:
> > On Fri, 30 Nov 2018 15:32:14 +0100
> > Michael Mueller <mimu@linux.ibm.com> wrote:
> > 
> >> The patch implements a handler for GIB alert interruptions
> >> on the host. Its task is to alert storage backed guests that
> >> interrupts are pending for them.
> >>
> >> A GIB alert interrupt statistic counter is added as well:
> >>
> >> $ cat /proc/interrupts
> >>            CPU0       CPU1
> >>    ...
> >>    GAL:      23         37   [I/O] GIB Alert
> >>    ...
> >>
> >> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >> ---
> > [..]
> >> @@ -1099,6 +1100,17 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
> >>   	if (kvm_arch_vcpu_runnable(vcpu))
> >>   		return 0;
> >>   
> >> +	/*
> >> +	 * This could be the single vcpu of the guest or the last vcpu
> >> +	 * open for I/O interruptons going into wait state.
> >> +	 */
> >> +	if (vcpu->kvm->arch.gib_in_use &&
> >> +	    !in_alert_list(vcpu->kvm->arch.gisa)) {
> >> +		if (unlikely(kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa)))
> >> +			return 0;
> > 
> > I don't agree with this condition. If I read this correctly, this makes
> > the vcpu go back into SIE if we have GISA interrupts pending. This can
> > basically happen in two ways. First way: we got a new bit in the IPM set
> > between the call to kvm_arch_vcpu_runnable() and here, and there is a
> > hope that the newly set (ISC) is not masked. Second way: there is no new
> > bit in IPM since kvm_arch_vcpu_runnable(). In this case we are certain
> > that the vCPU can not take the GISA interrupts pending. Second way seems
> > more likely to happen to me.
> 
> You know already that I'm introducing a change like:
> 

Yes I knew you are working on some changes based on our
off-line conversations yesterday. Yesterday I was very uncertain, today
I think, I have more clarity. So I decided to bring my point here, so
others are included and can add their insights.

> +
> +static inline u8 __again_runnable(struct kvm_vcpu *vcpu)
> +{
> +       return kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) &
> +               (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
> +}
> +
>   int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
>   {
>          u64 sltime;
> @@ -1109,7 +1116,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
>           */
>          if (vcpu->kvm->arch.gib_in_use &&
>              !in_alert_list(vcpu->kvm->arch.gisa)) {
> -               if (unlikely(kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa)))
> +               if (unlikely(__again_runnable(vcpu)))
>                          return 0;
>                  vcpu->kvm->arch.gisa->iam = vcpu->kvm->arch.iam;
> 
> 
> That will reduce a *short time window* where an not masked interruption
> might be made pending in addition to a *very short time window*. As
> *shortness* is a very relative expression, the second test will not
> be of relevance and thus be skipped.

I'm confused.

> 
> > 
> >> +		vcpu->kvm->arch.gisa->iam = vcpu->kvm->arch.iam;
> > 
> > Even without the condition above, I'm struggling with understanding your
> > algorithm that controls alerting. For instance, I don't quite understand
> > the !in_alert_list() condition either -- I'm under the impression this
> > is the only place where gisa->iam is set to non-zero. Maybe explaining
> > are the invariants you seek to maintain would help me getting it.
> 
> In opposition to the above, the test !in_alert_list() is relevant. It
> means that the host currently has the control to process the alert list
> as at least this gisa is in the alert list but has not been processed yet.

How does this prevent us form missing an alert. AFAIR the alert list
processing does not set gisa->iam.

> 
> What do you mean with your very last sentence?
>

Hm. I mean the goal of the patches is probably to ensure that the guest
is going to get its GISA interrupt if it can be delivered (not relying
on the timer based wakeup mechanism). I.e. the guest won't lose
initiative. That would an invariant. Another invariant could be no
alerts for guests with all vCPUs in SIE (since alerts are only useful
if at least one vCPU is in a wait state). To put it differently, we
are adding code so the system has certain properties. If I have a good
understanding of what properties are we aiming for, I have a chance to
spot mistakes that prevent us from reaching our goal. I know it's tough.

Regards,
Halil

 
> > 
> > Regards,
> > Halil
> > 
> >> +	}
> >> +
> >>   	if (psw_interrupts_disabled(vcpu)) {
> >>   		VCPU_EVENT(vcpu, 3, "%s", "disabled wait");
> >>   		return -EOPNOTSUPP; /* disabled wait */
> 

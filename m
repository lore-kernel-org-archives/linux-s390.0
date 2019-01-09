From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 13/15] KVM: s390: add function
 process_gib_alert_list()
Date: Wed, 9 Jan 2019 14:10:15 +0100
Message-ID: <20190109141015.3023fb55@oc2783563651>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-14-mimu@linux.ibm.com>
        <20190108135919.18048dd4@oc2783563651>
        <7e4a5077-00f0-3a0f-e21a-5bbc2fa14b70@linux.ibm.com>
        <01566362-d452-c04b-0509-cdcc758bc1e1@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01566362-d452-c04b-0509-cdcc758bc1e1@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: mimu@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 9 Jan 2019 13:14:17 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 08/01/2019 16:21, Michael Mueller wrote:
> > 
> > 
> > On 08.01.19 13:59, Halil Pasic wrote:
> >> On Wed, 19 Dec 2018 20:17:54 +0100
> >> Michael Mueller <mimu@linux.ibm.com> wrote:
> >>
> >>> This function processes the Gib Alert List (GAL). It is required
> >>> to run when either a gib alert interruption has been received or
> >>> a gisa that is in the alert list is cleared or dropped.
> >>>
> >>> The GAL is build up by millicode, when the respective ISC bit is
> >>> set in the Interruption Alert Mask (IAM) and an interruption of
> >>> that class is observed.
> >>>
> >>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >>> ---
> >>>   arch/s390/kvm/interrupt.c | 140 
> >>> ++++++++++++++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 140 insertions(+)
> >>>
> >>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> >>> index 48a93f5e5333..03e7ba4f215a 100644
> >>> --- a/arch/s390/kvm/interrupt.c
> >>> +++ b/arch/s390/kvm/interrupt.c
> >>> @@ -2941,6 +2941,146 @@ int kvm_s390_get_irq_state(struct kvm_vcpu 
> >>> *vcpu, __u8 __user *buf, int len)
> >>>       return n;
> >>>   }
> >>> +static int __try_airqs_kick(struct kvm *kvm, u8 ipm)
> >>> +{
> >>> +    struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
> >>> +    struct kvm_vcpu *vcpu = NULL, *kick_vcpu[MAX_ISC + 1];
> >>> +    int online_vcpus = atomic_read(&kvm->online_vcpus);
> >>> +    u8 ioint_mask, isc_mask, kick_mask = 0x00;
> >>> +    int vcpu_id, kicked = 0;
> >>> +
> >>> +    /* Loop over vcpus in WAIT state. */
> >>> +    for (vcpu_id = find_first_bit(fi->idle_mask, online_vcpus);
> >>> +         /* Until all pending ISCs have a vcpu open for airqs. */
> >>> +         (~kick_mask & ipm) && vcpu_id < online_vcpus;
> >>> +         vcpu_id = find_next_bit(fi->idle_mask, online_vcpus, 
> >>> vcpu_id)) {
> >>> +        vcpu = kvm_get_vcpu(kvm, vcpu_id);
> >>> +        if (psw_ioint_disabled(vcpu))
> >>> +            continue;
> >>> +        ioint_mask = (u8)(vcpu->arch.sie_block->gcr[6] >> 24);
> >>> +        for (isc_mask = 0x80; isc_mask; isc_mask >>= 1) {
> >>> +            /* ISC pending in IPM ? */
> >>> +            if (!(ipm & isc_mask))
> >>> +                continue;
> >>> +            /* vcpu for this ISC already found ? */
> >>> +            if (kick_mask & isc_mask)
> >>> +                continue;
> >>> +            /* vcpu open for airq of this ISC ? */
> >>> +            if (!(ioint_mask & isc_mask))
> >>> +                continue;
> >>> +            /* use this vcpu (for all ISCs in ioint_mask) */
> >>> +            kick_mask |= ioint_mask;
> >>> +            kick_vcpu[kicked++] = vcpu;
> >>
> >> Assuming that the vcpu can/will take all ISCs it's currently open for
> >> does not seem right. We kind of rely on this assumption here, or?
> 
> why does it not seem right?
> 

When an interrupt is delivered a psw-swap takes place. The new-psw
may fence IO interrupts. Thus for example if we have the vcpu open for
all ISCs and 0, 1 and 2 pending, we may end up only delivering 0, if the
psw-swap corresponding to delivering 0 closes the vcpu for IO
interrupts. After guest has control, we don't have control over the rest
of the story. 

> > 
> > My latest version of this routine already follows a different strategy.
> > It looks for a horizontal distribution of pending ISCs among idle vcpus.
> > 
> 
> May be you should separate the GAL IRQ handling and the algorithm of the 
> vCPU to kick in different patches to ease the review.
> 
> 

No strong opinion here. I found it convenient to have the most of the
logic in one patch/email.

Regards,
Halil

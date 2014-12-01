From: Jens Freimann <jfrei@linux.vnet.ibm.com>
Subject: Re: [GIT PULL 10/11] KVM: s390: handle pending local interrupts via bitmap
Date: Mon, 01 Dec 2014 10:46:29 +0100
Message-ID: <1417427055-sup-1503@linux.vnet.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com> <1417181139-25623-11-git-send-email-borntraeger@de.ibm.com> <20141201081916.GA4074@osiris>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-reply-to: <20141201081916.GA4074@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Excerpts from Heiko Carstens's message of 2014-12-01 09:19:16 +0100:
> On Fri, Nov 28, 2014 at 02:25:38PM +0100, Christian Borntraeger wrote:
> > +static int __must_check __deliver_mchk_floating(struct kvm_vcpu *vcpu,
> > +                       struct kvm_s390_interrupt_info *inti)
> > +{
> > +    struct kvm_s390_mchk_info *mchk = &inti->mchk;
> > +    int rc;
> > +
> > +    VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
> > +           mchk->mcic);
> > +    trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_MCHK,
> > +                     mchk->cr14, mchk->mcic);
> > +
> > +    rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
> > +    rc |= put_guest_lc(vcpu, mchk->mcic,
> > +            (u64 __user *) __LC_MCCK_CODE);
> > +    rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
> > +            (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
> > +    rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
> > +                 &mchk->fixed_logout, sizeof(mchk->fixed_logout));
> > +    rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
> > +                 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> > +    rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
> > +                &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> > +    return rc;
> > +}
> 
> FWIW, rc handling seems to be a bit fragile.
> The usual return statement for such a pattern is
>     return rc ? -EWHATEVER : 0;
> so we don't get random or'ed return values.

Ok, I'll change this to return -EFAULT (need to double check) if rc is set.

> 
> > -static int __inject_prog_irq(struct kvm_vcpu *vcpu,
> > -                 struct kvm_s390_interrupt_info *inti)
> > +static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
> >  {
> >      struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
> >  
> > -    list_add(&inti->list, &li->list);
> > -    atomic_set(&li->active, 1);
> > +    li->irq.pgm = irq->u.pgm;
> > +    __set_bit(IRQ_PEND_PROG, &li->pending_irqs);
> 
>         ^^^^^^^^^
> 
> > +static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
> >  {
> >      struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
> >  
> > -    inti->ext.ext_params2 = s390int->parm64;
> > -    list_add_tail(&inti->list, &li->list);
> > -    atomic_set(&li->active, 1);
> > +    VCPU_EVENT(vcpu, 3, "inject: external irq params:%x, params2:%llx",
> > +           irq->u.ext.ext_params, irq->u.ext.ext_params2);
> > +    trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_PFAULT_INIT,
> > +                   irq->u.ext.ext_params,
> > +                   irq->u.ext.ext_params2, 2);
> > +
> > +    li->irq.ext = irq->u.ext;
> > +    set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
> 
>         ^^^^^^^
> 
> You're using atomic and non-atomic bitops all over the place on the same
> object(s). It would be very good to have some consistency here.
> And as far as I remember the non-atomic variant is good enough anyway.

I think you are right. The non-atomic bitops are sufficient here. I'll fix this.

Paolo, is a follow-up patch good enough or should we fix this one?


regards
Jens

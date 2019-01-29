From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
Date: Tue, 29 Jan 2019 14:22:20 +0100
Message-ID: <20190129142220.3f08a1e9.cohuck@redhat.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-8-mimu@linux.ibm.com>
        <20190128175054.67979549@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128175054.67979549@oc2783563651>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Jan 2019 17:50:54 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 24 Jan 2019 13:59:33 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > Use this struct analog to the kvm interruption structs
> > for kvm emulated floating and local interruptions.
> > Further fields will be added with this series as
> > required.
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>  
> 
> While looking at this I was asking myself what guards against invalid
> gisa pointer dereference e.g. when pending_irqs() is called (see below).
> 
> AFAIU we set up gisa_int.origin only if we have
> css_general_characteristics.aiv. Opinions?

I think you're right that this is a (pre-existing) problem.

> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> > index 942cc7d33766..ee91d1de0036 100644
> > --- a/arch/s390/kvm/interrupt.c
> > +++ b/arch/s390/kvm/interrupt.c
> > @@ -246,7 +246,8 @@ static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
> >  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
> >  {
> >  	return pending_irqs_no_gisa(vcpu) |
> > -		gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
> > +		gisa_get_ipm(vcpu->kvm->arch.gisa_int.origin) <<  
> 
> Unconditional call to gisa_get_ipm(), and get ipm just accesses ->ipm.

All other callers of this function check for gisa != NULL first, so
either we should check here as well or move the check into the
gisa_get_ipm() function.

> 
> > +			IRQ_PEND_IO_ISC_7;
> >  }
> >    

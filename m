From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
Date: Thu, 20 Dec 2018 13:15:35 +0100
Message-ID: <20181220131535.0bd61b5c@oc2783563651>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-6-mimu@linux.ibm.com>
        <20181220120614.65acacac.cohuck@redhat.com>
        <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 20 Dec 2018 12:49:56 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> 
> 
> On 20.12.18 12:06, Cornelia Huck wrote:
> > On Wed, 19 Dec 2018 20:17:46 +0100
> > Michael Mueller <mimu@linux.ibm.com> wrote:
> > 
> >> Use a single function with parameter irq_flags to differentiate
> >> between cases.
> >>
> >> New irq flag:
> >>     IRQ_FLAG_LOCAL: include vcpu local interruptions pending
> >>     IRQ_FLAG_FLOATING: include vcpu floating interruptions pending
> >>     IRQ_FLAG_GISA: include GISA interruptions pending in IPM
> > 
> > I presume that means that irqs may be in more than one set? Or are gisa
> > irqs not considered floating irqs, because they use a different
> > mechanism?
> 
> Currently, the interruptions managed in GISA are floating only. But
> that might change in future. 

I don't think GISA can be used for non-floating interrupts.

Regards,
Halil

> The idea is not to subsume IRQ_FLAG_GISA
> in IRQ_FLAG_FLOATING but to be able to address the right set of 
> procedures to determine the irq pending set for a given subset of irq
> types that have different implementations.
> 
> There might be a better name for IRQ_FLAG_FLOATING then?
> 

[..]

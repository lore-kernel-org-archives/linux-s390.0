From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 5/5] KVM: s390: clear_io_irq() requests are not expected
 for adapter interrupts
Date: Mon, 13 Nov 2017 13:25:24 +0100
Message-ID: <20171113132524.459358f3.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
        <20171108084143.78654-6-borntraeger@de.ibm.com>
        <20171108101905.0b5dabb4.cohuck@redhat.com>
        <b26a3bf9-d5c9-7c34-f6d9-d9b410e9e740@de.ibm.com>
        <20171108120925.3dc136cf.cohuck@redhat.com>
        <1e96b9b8-7f70-9ef8-2c2b-0b030f348196@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1e96b9b8-7f70-9ef8-2c2b-0b030f348196@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 Nov 2017 13:14:01 +0100
Michael Mueller <mimu@linux.vnet.ibm.com> wrote:

> On 08.11.17 12:09, Cornelia Huck wrote:
> > On Wed, 8 Nov 2017 12:04:22 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >  
> >> On 11/08/2017 10:19 AM, Cornelia Huck wrote:  
> >>> On Wed,  8 Nov 2017 09:41:43 +0100
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>      
> >>>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> >>>>
> >>>> There is a chance to delete not yet delivered I/O interrupts if an
> >>>> exploiter uses the subsystem identification word 0x0000 while
> >>>> processing a KVM_DEV_FLIC_CLEAR_IO_IRQ ioctl. -EINVAL will be returned
> >>>> now instead in that case.
> >>>>
> >>>> Classic interrupts will always have bit 0x10000 set in the schid while
> >>>> adapter interrupts have a zero schid. The clear_io_irq interface is
> >>>> only useful for classic interrupts (as adapter interrupts belong to
> >>>> many devices). Let's make this interface more strict and forbid a schid
> >>>> of 0.  
> >>> I'm wondering: Is there any possible use case to clear adapter
> >>> interrupts? This interface was introduced to handle the case where a
> >>> CRW was made pending for a subchannel (which implies any pending
> >>> interrupt needs to be cleared.)  
> >> The problem with clearing adapter interrupts is that is actually a summary
> >> interrupt for every potential device. So I somewhat consider an adapter interrupt
> >> pending when the summary indicator went from 0 to 1. So I dont think clearing
> >> a single one makes not much sense. (And this interface would be wrong for
> >> that I think)  
> > Yes, this interface would be problematic. I'm not sure what's supposed
> > to happen with crws vs. pending adapter interrupts, though.  
> They will be delivered based on ISC priority and the traditional first 
> when both have the same class.

I'm just wondering what is supposed to happen when all devices
associated with a summary indicator go away. The OS will hopefully
deregister the indicator if needed; the hypervisor might still set the
indicator and trigger an adapter interrupt before that happens (and
hopefully the OS can deal with that.)

Likely we don't have a problem, but I'm curious if there is anything
architected for the cases where real hardware exists (like qdio).

> >  
> >> The only use cases I can imagine for clearing adapter interrupts (e.g. reset)
> >> is already covered by KVM_DEV_FLIC_CLEAR_IRQS
> >>  
> >>> Alas, I cannot check the adapter interrupt question myself, as the
> >>> public doc is lacking :( But qdio as another adapter interrupt user
> >>> comes to mind (not that we support it in qemu, but still...)

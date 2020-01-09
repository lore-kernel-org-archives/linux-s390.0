Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53006 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727738AbgAIQtR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 11:49:17 -0500
Date: Thu, 9 Jan 2020 17:49:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: check if kernel irqchip is actually enabled
Message-ID: <20200109174905.138269ca.cohuck@redhat.com>
In-Reply-To: <dd1ea7ee-d848-63ae-8b4d-857185e32b44@de.ibm.com>
References: <20200109134713.14755-1-cohuck@redhat.com>
        <dd1ea7ee-d848-63ae-8b4d-857185e32b44@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, 9 Jan 2020 15:06:22 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09.01.20 14:47, Cornelia Huck wrote:
> > On s390, we only allow userspace to create an in-kernel irqchip
> > if it has first enabled the KVM_CAP_S390_IRQCHIP vm capability.
> > Let's assume that a userspace that enabled that capability has
> > created an irqchip as well.
> > 
> > Fixes: 84223598778b ("KVM: s390: irq routing for adapter interrupts.")
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > A more precise check would be to add a field in kvm_arch that tracks
> > whether an irqchip has actually been created; not sure if that is
> > really needed.  
> 
> I think this is semantically wrong. We always have in-kernel irq handling.
> It is actually not possible to not use it. So I understand where you are coming
> from but this feels kind of wrong. 

You cannot actually call create_irqchip if not enabled, though... as I
said in my other reply, the intended semantics here are a bit unclear.

> 
> > 
> > Found while trying to hunt down QEMU crashes with kvm-irqchip=off;
> > this is not sufficient, though. I *think* everything but irqfds
> > should work without kvm-irqchip as well, but have not found the problem
> > yet.
> > 
> > ---
> >  arch/s390/kvm/irq.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
> > index 484608c71dd0..30e13d031379 100644
> > --- a/arch/s390/kvm/irq.h
> > +++ b/arch/s390/kvm/irq.h
> > @@ -13,7 +13,7 @@
> >  
> >  static inline int irqchip_in_kernel(struct kvm *kvm)
> >  {
> > -	return 1;
> > +	return !!kvm->arch.use_irqchip;
> >  }
> >  
> >  #endif
> >   
> 

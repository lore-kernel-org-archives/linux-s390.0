Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731390AbgAIQq0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 11:46:26 -0500
Date: Thu, 9 Jan 2020 17:46:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: check if kernel irqchip is actually enabled
Message-ID: <20200109174615.5eeebab8.cohuck@redhat.com>
In-Reply-To: <6020c443-a5b4-8064-87b6-a61e1b0b7c40@redhat.com>
References: <20200109134713.14755-1-cohuck@redhat.com>
        <6020c443-a5b4-8064-87b6-a61e1b0b7c40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, 9 Jan 2020 14:57:43 +0100
David Hildenbrand <david@redhat.com> wrote:

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
> This function is used on s390x/common code only in
> 
> virt/kvm/irqchip.c:kvm_send_userspace_msi()
> 
> That function is only used with CONFIG_HAVE_KVM_MSI. That is not
> selected for s390x.
> 
> What does this patch fix?

Currently, only future callers... but maybe this should be an optional
function instead that is only defined by the architectures that can
actually do something useful here? TBH, I'm not completely sure what
this function is actually supposed to indicate...

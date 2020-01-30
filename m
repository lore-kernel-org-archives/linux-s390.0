Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgA3Kjy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 05:39:54 -0500
Date: Thu, 30 Jan 2020 11:39:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH/FIXUP FOR STABLE BEFORE THIS SERIES] KVM: s390: do not
 clobber user space fpc during guest reset
Message-ID: <20200130113941.78e4bf2e.cohuck@redhat.com>
In-Reply-To: <7b40856d-8153-ad3f-bea8-110fa6e1aea6@redhat.com>
References: <20200129200312.3200-2-frankja@linux.ibm.com>
        <1580374500-31247-1-git-send-email-borntraeger@de.ibm.com>
        <7b40856d-8153-ad3f-bea8-110fa6e1aea6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, frankja@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, stable@kernel.org

On Thu, 30 Jan 2020 10:49:35 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 30.01.20 09:55, Christian Borntraeger wrote:
> > The initial CPU reset currently clobbers the userspace fpc. This was an
> > oversight during a fixup for the lazy fpu reloading rework.  The reset
> > calls are only done from userspace ioctls. No CPU context is loaded, so
> > we can (and must) act directly on the sync regs, not on the thread
> > context. Otherwise the fpu restore call will restore the zeroes fpc to
> > userspace.
> > 
> > Cc: stable@kernel.org
> > Fixes: 9abc2a08a7d6 ("KVM: s390: fix memory overwrites when vx is disabled")
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index c059b86..eb789cd 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2824,8 +2824,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
> >  	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
> >  					CR14_UNUSED_33 |
> >  					CR14_EXTERNAL_DAMAGE_SUBMASK;
> > -	/* make sure the new fpc will be lazily loaded */
> > -	save_fpu_regs();
> > +	vcpu->run->s.regs.fpc = 0;
> >  	current->thread.fpu.fpc = 0;
> >  	vcpu->arch.sie_block->gbea = 1;
> >  	vcpu->arch.sie_block->pp = 0;
> >   
> 
> kvm_arch_vcpu_ioctl() does a vcpu_load(vcpu), followed by the call to
> kvm_arch_vcpu_ioctl_initial_reset(), followed by a vcpu_put().
> 
> What am I missing?

I have been staring at this patch for some time now, and I fear I'm
missing something as well. Can we please get more explanation?

> 
> (we could get rid of the kvm_arch_vcpu_ioctl_initial_reset() wrapper)
> 

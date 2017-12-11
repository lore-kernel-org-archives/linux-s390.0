From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
Date: Mon, 11 Dec 2017 10:19:21 +0100
Message-ID: <20171211091921.GE910@cbox>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-8-cdall@kernel.org>
 <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mips@linux-mips.org, Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 08, 2017 at 05:26:02PM +0100, David Hildenbrand wrote:
> 
> >  
> >  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index f647e121070e..cdf0be02c95a 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -1632,18 +1632,25 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> >  {
> >  	int ret;
> >  
> > +	vcpu_load(vcpu);
> > +
> > +	ret = -EINVAL;
> 
> you can initialize this directly.
> 
> >  	if (vcpu->arch.pvr != sregs->pvr)
> > -		return -EINVAL;
> > +		goto out;
> >  
> >  	ret = set_sregs_base(vcpu, sregs);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out;
> >  
> >  	ret = set_sregs_arch206(vcpu, sregs);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out;
> > +
> > +	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
> >  
> > -	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
> > +out:
> > +	vcpu_put(vcpu);
> > +	return ret;
> >  }
> >  
> >  int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 18011fc4ac49..d95b4f15e52b 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2729,8 +2729,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> >  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> >  				  struct kvm_sregs *sregs)
> >  {
> > +	vcpu_load(vcpu);
> > +
> >  	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
> >  	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
> > +
> > +	vcpu_put(vcpu);
> >  	return 0;
> >  }
> >  
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 20a5f6776eea..a31a80aee0b9 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7500,15 +7500,19 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> >  	int mmu_reset_needed = 0;
> >  	int pending_vec, max_bits, idx;
> >  	struct desc_ptr dt;
> > +	int ret;
> > +
> > +	vcpu_load(vcpu);
> >  
> > +	ret = -EINVAL;
> 
> dito

Sure.

> 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks for the review!
-Christoffer

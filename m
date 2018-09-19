From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 19 Sep 2018 18:54:48 +0000
Subject: Re: [PATCH 2/3] s390/kvm: handle diagnose 318 instruction call
Message-Id: <20180919205448.12e75f06.cohuck@redhat.com>
In-Reply-To: <1f2f77f2-0aac-0f8b-51ed-87fc6d21553d@linux.ibm.com>
References: <1f2f77f2-0aac-0f8b-51ed-87fc6d21553d@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Sep 2018 12:56:53 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 09/19/2018 05:37 AM, Cornelia Huck wrote:
> > On Fri, 31 Aug 2018 12:51:18 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> The diagnose 318 instruction is a privileged instruction that must be
> >> interpreted by SIE and handled via KVM.
> >>
> >> The control program name and version codes (CPNC and CPVC) set by this
> >> instruction are saved to the kvm->arch struct. The CPNC is also set in
> >> the SIE control block of all VCPUs. The new kvm_s390_set_misc interface
> >> is introduced for migration.
> >>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> >> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  arch/s390/include/asm/kvm_host.h       |  6 ++-
> >>  arch/s390/include/uapi/asm/kvm.h       |  5 ++
> >>  arch/s390/kvm/diag.c                   | 16 ++++++
> >>  arch/s390/kvm/kvm-s390.c               | 90 ++++++++++++++++++++++++++++++++++
> >>  arch/s390/kvm/kvm-s390.h               |  1 +
> >>  tools/arch/s390/include/uapi/asm/kvm.h |  1 +
> >>  6 files changed, 118 insertions(+), 1 deletion(-)
> >>  
> >   
> >> @@ -2568,6 +2655,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
> >>  	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
> >>  	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
> >>  	preempt_enable();
> >> +
> >> +	vcpu->arch.sie_block->cpnc = vcpu->kvm->arch.cpnc;  
> > 
> > Any reason why you set this _after_ the preempt_enable()?
> >   
> 
> I didn't consider setting this value as time-critical as the TOD-Clock values. I guess
> it doesn't hurt to throw the cpnc in there, too?

_postcreate is probably not time-critical at all... just keep setting
up all of the fields in one place?

> 
> >> +
> >>  	mutex_unlock(&vcpu->kvm->lock);
> >>  	if (!kvm_is_ucontrol(vcpu->kvm)) {
> >>  		vcpu->arch.gmap = vcpu->kvm->arch.gmap;  
> >   
> 
> 

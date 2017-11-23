From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 19:32:14 +0100
Message-ID: <20171123183214.GC28855@cbox>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
 <20171123174804.GB28855@cbox>
 <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 23, 2017 at 07:16:32PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 18:48, Christoffer Dall wrote:
> >>> That doesn't solve my need as I want to *only* do the arch vcpu_load for
> >>> KVM_RUN, I should have been more clear in the commit message.
> >>
> >> That's what you want to do, but it might not be what you need to do.
> > 
> > Well, why would we want to do a lot of work when there's absolutely no
> > need to?
> > 
> > I see that this patch is invasive, and that's why I originally proposed
> > the other approach of recording the ioctl number.
> 
> Because we need to balance performance and maintainability.  The
> following observation is the important one:
> 

Sure.  So I'm curious...  Is it easier to maintain and simpler for other
architectures (x86 in particular) to call vcpu_load for the non-KVM_RUN
ioctl?

I have a vague notion that this may be related to always being able to
do things like VMREAD no matter the context, but I couldn't easily tell
from the code.

It would have been similar for some parts of the ARM code if we only
supported VHE, but since we don't, we anyway have to check if actually
loaded stuff on the CPU or not, any time we access state, so there is no
win there.

> > While it may be possible to call kvm_arch_vcpu_load() for a number of
> > non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult to reason
> > about, especially after my optimization series, because a lot of things
> > can now happen, where we have to consider if we're really in the process
> > of running a vcpu or not.
> 
> ... because outside ARM I couldn't see any maintainability drawback.
> Now I understand (or at least, I understand enough to believe you!).

I'm happy to hear that I don't need stronger evidence to earn some level
of trust :)

> 
> The idea of this patch then is okay, but:
> 
> * x86 can use __vcpu_load/__vcpu_put, because the calls outside the lock
> are all in the destruction path where no one can concurrently take the
> lock.  So the lock+load and put+unlock variants are not necessary.
> 

ok, that simplifies things.

> * Just make a huge series that, one ioctl at a time, pushes down the
> load/put to the arch-specific functions.  No need to figure out where
> it's actually needed, or at least you can leave it to the architecture
> maintainers.
> 

ok, that makes sense.

And just to be clear, you prefer that over storing the ioctl on the vcpu
struct, like this:

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a2b804e10c95..4c1390f1da88 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9491,7 +9491,7 @@ static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
        struct vcpu_vmx *vmx = to_vmx(vcpu);
        int r;
 
-       r = vcpu_load(vcpu);
+       r = vcpu_load(vcpu, 0);
        BUG_ON(r);
        vmx_switch_vmcs(vcpu, &vmx->vmcs01);
        free_nested(vmx);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 03869eb7fcd6..22c7ef2cc699 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7723,7 +7723,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	int r;
 
 	kvm_vcpu_mtrr_init(vcpu);
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, 0);
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
@@ -7739,7 +7739,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 	kvm_hv_vcpu_postcreate(vcpu);
 
-	if (vcpu_load(vcpu))
+	if (vcpu_load(vcpu, 0))
 		return;
 	msr.data = 0x0;
 	msr.index = MSR_IA32_TSC;
@@ -7759,7 +7759,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	int r;
 	vcpu->arch.apf.msr_val = 0;
 
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, 0);
 	BUG_ON(r);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
@@ -8116,7 +8116,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 {
 	int r;
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, 0);
 	BUG_ON(r);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..da0acc02d338 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -274,6 +274,7 @@ struct kvm_vcpu {
 	bool preempted;
 	struct kvm_vcpu_arch arch;
 	struct dentry *debugfs_dentry;
+	unsigned int ioctl; /* ioctl currently executing or 0 */
 };
 
 static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
@@ -533,7 +534,7 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 
-int __must_check vcpu_load(struct kvm_vcpu *vcpu);
+int __must_check vcpu_load(struct kvm_vcpu *vcpu, unsigned int ioctl);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a245b83..12bc019077a7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -147,12 +147,13 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-int vcpu_load(struct kvm_vcpu *vcpu)
+int vcpu_load(struct kvm_vcpu *vcpu, unsigned int ioctl)
 {
 	int cpu;
 
 	if (mutex_lock_killable(&vcpu->mutex))
 		return -EINTR;
+	vcpu->ioctl = ioctl;
 	cpu = get_cpu();
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -167,6 +168,7 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
 	preempt_enable();
+	vcpu->ioctl = 0;
 	mutex_unlock(&vcpu->mutex);
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
@@ -2529,7 +2531,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 #endif
 
 
-	r = vcpu_load(vcpu);
+	r = vcpu_load(vcpu, ioctl);
 	if (r)
 		return r;
 	switch (ioctl) {


Thanks,
-Christoffer

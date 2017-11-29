From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH v2 01/16] KVM: Take vcpu->mutex outside vcpu_load
Date: Wed, 29 Nov 2017 17:41:01 +0100
Message-ID: <20171129164116.16167-2-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
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
To: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

As we're about to call vcpu_load() from architecture-specific
implementations of the KVM vcpu ioctls, but yet we access data
structures protected by the vcpu->mutex in the generic code, factor
this logic out from vcpu_load().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/x86/kvm/vmx.c       |  4 +---
 arch/x86/kvm/x86.c       | 20 +++++++-------------
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 17 ++++++-----------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 714a067..e7c46d2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9559,10 +9559,8 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
 {
        struct vcpu_vmx *vmx = to_vmx(vcpu);
-       int r;
 
-       r = vcpu_load(vcpu);
-       BUG_ON(r);
+       vcpu_load(vcpu);
        vmx_switch_vmcs(vcpu, &vmx->vmcs01);
        free_nested(vmx);
        vcpu_put(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 34c85aa..9b8f864 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7747,16 +7747,12 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	int r;
-
 	kvm_vcpu_mtrr_init(vcpu);
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
-	return r;
+	return 0;
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
@@ -7766,13 +7762,15 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 	kvm_hv_vcpu_postcreate(vcpu);
 
-	if (vcpu_load(vcpu))
+	if (mutex_lock_killable(&vcpu->mutex))
 		return;
+	vcpu_load(vcpu);
 	msr.data = 0x0;
 	msr.index = MSR_IA32_TSC;
 	msr.host_initiated = true;
 	kvm_write_tsc(vcpu, &msr);
 	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 
 	if (!kvmclock_periodic_sync)
 		return;
@@ -7783,11 +7781,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	int r;
 	vcpu->arch.apf.msr_val = 0;
 
-	r = vcpu_load(vcpu);
-	BUG_ON(r);
+	vcpu_load(vcpu);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 
@@ -8155,9 +8151,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 {
-	int r;
-	r = vcpu_load(vcpu);
-	BUG_ON(r);
+	vcpu_load(vcpu);
 	kvm_mmu_unload(vcpu);
 	vcpu_put(vcpu);
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2e754b7..a000dd8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -533,7 +533,7 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 
-int __must_check vcpu_load(struct kvm_vcpu *vcpu);
+void vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f169ecc..39961fb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -146,17 +146,12 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
  */
-int vcpu_load(struct kvm_vcpu *vcpu)
+void vcpu_load(struct kvm_vcpu *vcpu)
 {
-	int cpu;
-
-	if (mutex_lock_killable(&vcpu->mutex))
-		return -EINTR;
-	cpu = get_cpu();
+	int cpu = get_cpu();
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
 	put_cpu();
-	return 0;
 }
 EXPORT_SYMBOL_GPL(vcpu_load);
 
@@ -166,7 +161,6 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
 	preempt_enable();
-	mutex_unlock(&vcpu->mutex);
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
 
@@ -2529,9 +2523,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 #endif
 
 
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
+	vcpu_load(vcpu);
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
@@ -2704,6 +2698,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	}
 out:
 	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	kfree(fpu);
 	kfree(kvm_sregs);
 	return r;
-- 
2.7.4

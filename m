From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RFC 2/2] KVM: RCU protected dynamic vcpus array
Date: Wed, 16 Aug 2017 21:40:37 +0200
Message-ID: <20170816194037.9460-3-rkrcmar@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816194037.9460-1-rkrcmar@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

This is a prototype with many TODO comments to give a better idea of
what would be needed.

The main missing piece a rework of every kvm_for_each_vcpu() into a less
inefficient loop, but RCU readers cannot block, so the rewrite cannot be
scripted.   Is there a more suitable protection scheme?

I didn't test it much ... I am still leaning towards the internally
simpler version, (1), even if it requires userspace changes.
---
 arch/mips/kvm/mips.c       |  8 +++---
 arch/powerpc/kvm/powerpc.c |  6 +++--
 arch/s390/kvm/kvm-s390.c   | 27 ++++++++++++++------
 arch/x86/kvm/hyperv.c      |  3 +--
 arch/x86/kvm/vmx.c         |  3 ++-
 arch/x86/kvm/x86.c         |  5 ++--
 include/linux/kvm_host.h   | 61 ++++++++++++++++++++++++++++++++++------------
 virt/kvm/arm/arm.c         | 10 +++-----
 virt/kvm/kvm_main.c        | 58 +++++++++++++++++++++++++++++++++++--------
 9 files changed, 132 insertions(+), 49 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index bce2a6431430..4c9d383babe7 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -164,6 +164,7 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
+	struct kvm_vcpus *vcpus;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_arch_vcpu_free(vcpu);
@@ -171,8 +172,9 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 
 	mutex_lock(&kvm->lock);
 
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
+	// TODO: resetting online vcpus shouldn't be needed
+	vcpus = rcu_dereference_protected(kvm->vcpus, lockdep_is_held(&kvm->lock));
+	vcpus->online = 0;
 
 	atomic_set(&kvm->online_vcpus, 0);
 
@@ -499,7 +501,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 	if (irq->cpu == -1)
 		dvcpu = vcpu;
 	else
-		dvcpu = vcpu->kvm->vcpus[irq->cpu];
+		dvcpu = kvm_get_vcpu(vcpu->kvm, irq->cpu);
 
 	if (intr == 2 || intr == 3 || intr == 4) {
 		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3480faaf1ef8..9d1a16fd629f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -460,6 +460,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
+	struct kvm_vcpus *vcpus;
 
 #ifdef CONFIG_KVM_XICS
 	/*
@@ -475,8 +476,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		kvm_arch_vcpu_free(vcpu);
 
 	mutex_lock(&kvm->lock);
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
+
+	vcpus = rcu_dereference_protected(kvm->vcpus, lockdep_is_held(&kvm->lock));
+	vcpus->online = 0;
 
 	atomic_set(&kvm->online_vcpus, 0);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9f23a9e81a91..dd8592c67ef4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1945,15 +1945,16 @@ static void kvm_free_vcpus(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
+	struct kvm_vcpus *vcpus;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_arch_vcpu_destroy(vcpu);
 
 	mutex_lock(&kvm->lock);
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
 
-	atomic_set(&kvm->online_vcpus, 0);
+	vcpus = rcu_dereference_protected(kvm->vcpus, lockdep_is_held(&kvm->lock));
+	vcpus->online = 0;
+
 	mutex_unlock(&kvm->lock);
 }
 
@@ -3415,6 +3416,7 @@ static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
 	int i, online_vcpus, started_vcpus = 0;
+	struct kvm_vcpus *vcpus;
 
 	if (!is_vcpu_stopped(vcpu))
 		return;
@@ -3422,12 +3424,16 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
 	/* Only one cpu at a time may enter/leave the STOPPED state. */
 	spin_lock(&vcpu->kvm->arch.start_stop_lock);
-	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
-	for (i = 0; i < online_vcpus; i++) {
-		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
+	rcu_read_lock();
+	vcpus = rcu_dereference(vcpu->kvm->vcpus);
+	// TODO: this pattern is kvm_for_each_vcpu
+	for (i = 0; i < vcpus->online; i++) {
+		if (!is_vcpu_stopped(vcpus->array[i]))
 			started_vcpus++;
+		// TODO: if (started_vcpus > 1) break;
 	}
+	rcu_read_unlock();
 
 	if (started_vcpus == 0) {
 		/* we're the only active VCPU -> speed it up */
@@ -3455,6 +3461,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 {
 	int i, online_vcpus, started_vcpus = 0;
 	struct kvm_vcpu *started_vcpu = NULL;
+	struct kvm_vcpus *vcpus;
 
 	if (is_vcpu_stopped(vcpu))
 		return;
@@ -3470,12 +3477,16 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 	__disable_ibs_on_vcpu(vcpu);
 
+	rcu_read_lock();
+	vcpus = rcu_dereference(vcpu->kvm->vcpus);
+	// TODO: use kvm_for_each_vcpu
 	for (i = 0; i < online_vcpus; i++) {
-		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i])) {
+		if (!is_vcpu_stopped(vcpus->array[i])) {
 			started_vcpus++;
-			started_vcpu = vcpu->kvm->vcpus[i];
+			started_vcpu = vcpus->array[i];
 		}
 	}
+	rcu_read_unlock();
 
 	if (started_vcpus == 1) {
 		/*
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index dc97f2544b6f..bf4037344729 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -111,8 +111,7 @@ static struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm, u32 vpidx)
 	struct kvm_vcpu *vcpu = NULL;
 	int i;
 
-	if (vpidx < KVM_MAX_VCPUS)
-		vcpu = kvm_get_vcpu(kvm, vpidx);
+	vcpu = kvm_get_vcpu(kvm, vpidx);
 	if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
 		return vcpu;
 	kvm_for_each_vcpu(i, vcpu, kvm)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index df8d2f127508..1f492a1b64e9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11742,7 +11742,8 @@ static int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 
 	if (!kvm_arch_has_assigned_device(kvm) ||
 		!irq_remapping_cap(IRQ_POSTING_CAP) ||
-		!kvm_vcpu_apicv_active(kvm->vcpus[0]))
+		// TODO: make apicv state accessible directly from struct kvm
+		!kvm_vcpu_apicv_active(kvm_get_vcpu(kvm, 0)))
 		return 0;
 
 	idx = srcu_read_lock(&kvm->irq_srcu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e10eda86bc7b..5d8af3e4eab1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8081,6 +8081,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
+	struct kvm_vcpus *vcpus;
 
 	/*
 	 * Unpin any mmu pages first.
@@ -8093,8 +8094,8 @@ static void kvm_free_vcpus(struct kvm *kvm)
 		kvm_arch_vcpu_free(vcpu);
 
 	mutex_lock(&kvm->lock);
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
+	vcpus = rcu_dereference_protected(kvm->vcpus, lockdep_is_held(&kvm->lock));
+	vcpus->online = 0;
 
 	atomic_set(&kvm->online_vcpus, 0);
 	mutex_unlock(&kvm->lock);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c8df733eed41..eb9fb5b493ac 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -386,12 +386,17 @@ struct kvm_memslots {
 	int used_slots;
 };
 
+struct kvm_vcpus {
+	u32 online;
+	struct kvm_vcpu *array[];
+};
+
 struct kvm {
 	spinlock_t mmu_lock;
 	struct mutex slots_lock;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
-	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	struct kvm_vcpus *vcpus;
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
@@ -483,45 +488,71 @@ static inline struct kvm_io_bus *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
 
 static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 {
-	/* Pairs with smp_wmb() in kvm_vm_ioctl_create_vcpu, in case
-	 * the caller has read kvm->online_vcpus before (as is the case
-	 * for kvm_for_each_vcpu, for example).
-	 */
-	smp_rmb();
-	return kvm->vcpus[i];
+	struct kvm_vcpu *r = NULL;
+	struct kvm_vcpus *vcpus;
+
+	rcu_read_lock();
+	vcpus = rcu_dereference(kvm->vcpus);
+	if (i < vcpus->online)
+		r = vcpus->array[i];
+	// TODO: check for bounds & return NULL in that case?
+	rcu_read_unlock();
+
+	return r;
 }
 
+// This is unacceptably inefficient implementation, but rcu critical section
+// imposes limitations on preemption and we'll have to check all users before
+// converting them.
 #define kvm_for_each_vcpu(idx, vcpup, kvm) \
 	for (idx = 0; \
-	     idx < atomic_read(&kvm->online_vcpus) && \
-	     (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
+	     ({struct kvm_vcpus *__vcpus; \
+	       rcu_read_lock(); \
+	       __vcpus = rcu_dereference(kvm->vcpus); \
+	       vcpup = idx < __vcpus->online ? __vcpus->array[idx] : NULL; \
+	       rcu_read_unlock(); \
+	       vcpup;}); \
 	     idx++)
 
+#define kvm_for_each_vcpu_rcu(idx, vcpup, vcpus, kvm) \
+	for (vcpus = rcu_dereference(kvm->vcpus), idx = 0; \
+	     idx < vcpus->online && (vcpup = vcpus->array[idx]); \
+	     idx++) \
+
 static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 {
 	struct kvm_vcpu *vcpu = NULL;
+	struct kvm_vcpus *vcpus;
 	int i;
 
 	if (id < 0)
 		return NULL;
-	if (id < KVM_MAX_VCPUS)
-		vcpu = kvm_get_vcpu(kvm, id);
+	vcpu = kvm_get_vcpu(kvm, id);
 	if (vcpu && vcpu->vcpu_id == id)
 		return vcpu;
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		if (vcpu->vcpu_id == id)
+	rcu_read_lock();
+	kvm_for_each_vcpu_rcu(i, vcpu, vcpus, kvm)
+		if (vcpu->vcpu_id == id) {
+			rcu_read_unlock();
 			return vcpu;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 
 static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *tmp;
+	struct kvm_vcpus *vcpus;
 	int idx;
 
-	kvm_for_each_vcpu(idx, tmp, vcpu->kvm)
-		if (tmp == vcpu)
+	rcu_read_lock();
+	kvm_for_each_vcpu_rcu(idx, tmp, vcpus, vcpu->kvm)
+		if (tmp == vcpu) {
+			rcu_read_unlock();
 			return idx;
+		}
+	rcu_read_unlock();
 	BUG();
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index b9f68e4add71..f0774a08083d 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -174,16 +174,14 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	int i;
+	struct kvm_vcpu *vcpu;
 
 	free_percpu(kvm->arch.last_vcpu_ran);
 	kvm->arch.last_vcpu_ran = NULL;
 
-	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
-		if (kvm->vcpus[i]) {
-			kvm_arch_vcpu_free(kvm->vcpus[i]);
-			kvm->vcpus[i] = NULL;
-		}
-	}
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_arch_vcpu_free(vcpu);
+	// other arches zeroed online here, for no apparent reason :)
 
 	kvm_vgic_destroy(kvm);
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2eac2c62795f..578285ff74a4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -640,13 +640,31 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 	return 0;
 }
 
+// TODO: preallocate some VCPUs
 static inline struct kvm *kvm_alloc_vm(void)
 {
-	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
+	struct kvm *kvm;
+	struct kvm_vcpus *vcpus;
+
+	kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
+	if (!kvm)
+		return NULL;
+
+	vcpus = kvzalloc(sizeof(*vcpus), GFP_KERNEL);
+	if (!vcpus) {
+		kfree(kvm);
+		return NULL;
+	}
+	vcpus->online = 0;
+	rcu_assign_pointer(kvm->vcpus, vcpus);
+
+	return kvm;
 }
 
 static inline void kvm_free_vm(struct kvm *kvm)
 {
+	if (kvm)
+		kvfree(rcu_dereference_protected(kvm->vcpus, 1));
 	kfree(kvm);
 }
 
@@ -2473,6 +2491,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 {
 	int r;
 	struct kvm_vcpu *vcpu;
+	struct kvm_vcpus *old, *new = NULL;
 
 	if (id >= KVM_MAX_VCPU_ID)
 		return -EINVAL;
@@ -2508,7 +2527,22 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 		goto unlock_vcpu_destroy;
 	}
 
-	BUG_ON(kvm->vcpus[atomic_read(&kvm->online_vcpus)]);
+	old = rcu_dereference_protected(kvm->vcpus, lockdep_is_held(&kvm->lock));
+
+	// TODO: make it a function for it that returns new/NULL
+	{
+		// OPTIMIZE: do not allocate every time.  Requires atomic online
+		// counter.
+		u32 size = old->online + 1;
+
+		new = kvzalloc(sizeof(*new) + size * sizeof(*new->array), GFP_KERNEL);
+		if (!new) {
+			r = -ENOMEM;
+			goto unlock_vcpu_destroy;
+		}
+		new->online = size;
+		memcpy(new->array, old->array, old->online * sizeof(*old->array));
+	}
 
 	/* Now it's all set up, let userspace reach it */
 	kvm_get_kvm(kvm);
@@ -2518,20 +2552,24 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 		goto unlock_vcpu_destroy;
 	}
 
-	kvm->vcpus[atomic_read(&kvm->online_vcpus)] = vcpu;
-
-	/*
-	 * Pairs with smp_rmb() in kvm_get_vcpu.  Write kvm->vcpus
-	 * before kvm->online_vcpu's incremented value.
-	 */
-	smp_wmb();
-	atomic_inc(&kvm->online_vcpus);
+	new->array[old->online] = vcpu;
+	rcu_assign_pointer(kvm->vcpus, new);
 
 	mutex_unlock(&kvm->lock);
+
+	// we could schedule a callback instead
+	synchronize_rcu();
+	kfree(old);
+
+	// TODO: No longer synchronizes anything in the common code.
+	// Remove if the arch-specific uses were mostly hacks.
+	atomic_inc(&kvm->online_vcpus);
+
 	kvm_arch_vcpu_postcreate(vcpu);
 	return r;
 
 unlock_vcpu_destroy:
+	kvfree(new);
 	mutex_unlock(&kvm->lock);
 	debugfs_remove_recursive(vcpu->debugfs_dentry);
 vcpu_destroy:
-- 
2.13.3

From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RFC v3 7/9] KVM: add kvm_free_vcpus and kvm_arch_free_vcpus
Date: Mon, 21 Aug 2017 22:35:28 +0200
Message-ID: <20170821203530.9266-8-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821203530.9266-1-rkrcmar@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Generalize clearing of kvm->vcpus.  This should not be needed at all as
all accesses to VCPUs in the destruction path are bugs, but maybe helps
to catch them.  The call path crosses arch/common code way too much, so
extra untangling patch is welcome.  Doing the clearing later seems be
ok.

I don't see a reason for the locking the mutex, so there definitely is
a room for improvements.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/mips/kvm/mips.c       | 13 ++-----------
 arch/powerpc/kvm/powerpc.c | 17 +++++++++--------
 arch/s390/kvm/kvm-s390.c   |  9 +--------
 arch/x86/kvm/x86.c         |  9 +--------
 include/linux/kvm_host.h   |  2 ++
 virt/kvm/arm/arm.c         | 17 +++++++++--------
 virt/kvm/kvm_main.c        | 17 +++++++++++++++++
 7 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index bce2a6431430..770c40b9df37 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -160,7 +160,7 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-void kvm_mips_free_vcpus(struct kvm *kvm)
+void kvm_arch_free_vcpus(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
@@ -168,15 +168,6 @@ void kvm_mips_free_vcpus(struct kvm *kvm)
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_arch_vcpu_free(vcpu);
 	}
-
-	mutex_lock(&kvm->lock);
-
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
-
-	atomic_set(&kvm->online_vcpus, 0);
-
-	mutex_unlock(&kvm->lock);
 }
 
 static void kvm_mips_free_gpa_pt(struct kvm *kvm)
@@ -188,7 +179,7 @@ static void kvm_mips_free_gpa_pt(struct kvm *kvm)
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
-	kvm_mips_free_vcpus(kvm);
+	kvm_free_vcpus(kvm);
 	kvm_mips_free_gpa_pt(kvm);
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3480faaf1ef8..1c563545473c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -456,11 +456,17 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-void kvm_arch_destroy_vm(struct kvm *kvm)
+void kvm_arch_free_vcpus(struct kvm *kvm)
 {
-	unsigned int i;
+	int i;
 	struct kvm_vcpu *vcpu;
 
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_arch_vcpu_free(vcpu);
+}
+
+void kvm_arch_destroy_vm(struct kvm *kvm)
+{
 #ifdef CONFIG_KVM_XICS
 	/*
 	 * We call kick_all_cpus_sync() to ensure that all
@@ -471,14 +477,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		kick_all_cpus_sync();
 #endif
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_arch_vcpu_free(vcpu);
+	kvm_free_vcpus(kvm);
 
 	mutex_lock(&kvm->lock);
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
-
-	atomic_set(&kvm->online_vcpus, 0);
 
 	kvmppc_core_destroy_vm(kvm);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1534778a3c66..bb6278d45a25 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1941,20 +1941,13 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
-static void kvm_free_vcpus(struct kvm *kvm)
+void kvm_arch_free_vcpus(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_arch_vcpu_destroy(vcpu);
-
-	mutex_lock(&kvm->lock);
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
-
-	atomic_set(&kvm->online_vcpus, 0);
-	mutex_unlock(&kvm->lock);
 }
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e10eda86bc7b..d021746f1fdf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8077,7 +8077,7 @@ static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 	vcpu_put(vcpu);
 }
 
-static void kvm_free_vcpus(struct kvm *kvm)
+void kvm_arch_free_vcpus(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
@@ -8091,13 +8091,6 @@ static void kvm_free_vcpus(struct kvm *kvm)
 	}
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_arch_vcpu_free(vcpu);
-
-	mutex_lock(&kvm->lock);
-	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
-		kvm->vcpus[i] = NULL;
-
-	atomic_set(&kvm->online_vcpus, 0);
-	mutex_unlock(&kvm->lock);
 }
 
 void kvm_arch_sync_events(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cfb3c0efdd51..a8b9aa563834 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -874,6 +874,8 @@ static inline bool kvm_arch_intc_initialized(struct kvm *kvm)
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type);
 void kvm_arch_destroy_vm(struct kvm *kvm);
 void kvm_arch_sync_events(struct kvm *kvm);
+void kvm_free_vcpus(struct kvm *kvm);
+void kvm_arch_free_vcpus(struct kvm *kvm);
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu);
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index b9f68e4add71..d63aa1107fdb 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -166,6 +166,14 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+void kvm_arch_free_vcpus(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	for_each_online_vcpu(i, vcpu, kvm)
+		kvm_arch_vcpu_free(vcpu);
+}
 
 /**
  * kvm_arch_destroy_vm - destroy the VM data structure
@@ -173,17 +181,10 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
  */
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
-	int i;
-
 	free_percpu(kvm->arch.last_vcpu_ran);
 	kvm->arch.last_vcpu_ran = NULL;
 
-	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
-		if (kvm->vcpus[i]) {
-			kvm_arch_vcpu_free(kvm->vcpus[i]);
-			kvm->vcpus[i] = NULL;
-		}
-	}
+	kvm_free_vcpus(kvm);
 
 	kvm_vgic_destroy(kvm);
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 33a15e176927..0d2d8b0c785c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -750,6 +750,23 @@ static void kvm_destroy_devices(struct kvm *kvm)
 	}
 }
 
+void kvm_free_vcpus(struct kvm *kvm)
+{
+	int i;
+
+	kvm_arch_free_vcpus(kvm);
+
+	mutex_lock(&kvm->lock);
+
+	i = atomic_read(&kvm->online_vcpus);
+	atomic_set(&kvm->online_vcpus, 0);
+
+	while (i--)
+		kvm->vcpus[i] = NULL;
+
+	mutex_unlock(&kvm->lock);
+}
+
 static void kvm_destroy_vm(struct kvm *kvm)
 {
 	int i;
-- 
2.13.3

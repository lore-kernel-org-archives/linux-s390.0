From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: KVM: fix S390/IA-64 build failures introduced by memslot changes
Date: Mon, 11 Jan 2010 15:23:09 -0200
Message-ID: <20100111172309.GA13797@amt.cnet>
References: <20100111194431.c103db9b.sfr@canb.auug.org.au>
 <4B4AFA45.8000004@in.ibm.com>
 <4B4AFE26.5080503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B4AFE26.5080503@redhat.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Fix build failures introduced by memslot changes.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
index b10f2ef..e6ac549 100644
--- a/arch/ia64/kvm/kvm-ia64.c
+++ b/arch/ia64/kvm/kvm-ia64.c
@@ -1374,12 +1374,14 @@ static void free_kvm(struct kvm *kvm)
 
 static void kvm_release_vm_pages(struct kvm *kvm)
 {
+	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
 	int i, j;
 	unsigned long base_gfn;
 
-	for (i = 0; i < kvm->nmemslots; i++) {
-		memslot = &kvm->memslots[i];
+	slots = rcu_dereference(kvm->memslots);
+	for (i = 0; i < slots->nmemslots; i++) {
+		memslot = &slots->memslots[i];
 		base_gfn = memslot->base_gfn;
 
 		for (j = 0; j < memslot->npages; j++) {
@@ -1576,6 +1578,7 @@ out:
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		struct kvm_memory_slot *memslot,
 		struct kvm_memory_slot old,
+		struct kvm_userspace_memory_region *mem,
 		int user_alloc)
 {
 	unsigned long i;
@@ -1806,7 +1809,7 @@ static int kvm_ia64_sync_dirty_log(struct kvm *kvm,
 	if (log->slot >= KVM_MEMORY_SLOTS)
 		goto out;
 
-	memslot = &kvm->memslots[log->slot];
+	memslot = &kvm->memslots->memslots[log->slot];
 	r = -ENOENT;
 	if (!memslot->dirty_bitmap)
 		goto out;
@@ -1845,7 +1848,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 	/* If nothing is dirty, don't bother messing with page tables. */
 	if (is_dirty) {
 		kvm_flush_remote_tlbs(kvm);
-		memslot = &kvm->memslots[log->slot];
+		memslot = &kvm->memslots->memslots[log->slot];
 		n = ALIGN(memslot->npages, BITS_PER_LONG) / 8;
 		memset(memslot->dirty_bitmap, 0, n);
 	}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 5ba1865..4633e78 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -168,6 +168,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
                                    struct kvm_memory_slot *memslot,
                                    struct kvm_memory_slot old,
+                                   struct kvm_userspace_memory_region *mem,
                                    int user_alloc)
 {
 	return 0;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6bbd45..8bedd31 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -690,13 +690,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 /* Section: memory related */
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				   struct kvm_userspace_memory_region *mem,
+				   struct kvm_memory_slot *memslot,
 				   struct kvm_memory_slot old,
+				   struct kvm_userspace_memory_region *mem,
 				   int user_alloc)
 {
-	int i;
-	struct kvm_vcpu *vcpu;
-
 	/* A few sanity checks. We can have exactly one memory slot which has
 	   to start at guest virtual zero and which has to be located at a
 	   page boundary in userland and which has to end at a page boundary.
@@ -722,11 +720,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	return 0;
 }
 
-int kvm_arch_commit_memory_region(struct kvm *kvm,
+void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem,
 				struct kvm_memory_slot old,
 				int user_alloc)
 {
+	int i;
+	struct kvm_vcpu *vcpu;
+
 	/* request update of sie control block for all available vcpus */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (test_and_set_bit(KVM_REQ_MMU_RELOAD, &vcpu->requests))
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 46777ff..60f09ab 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -69,7 +69,7 @@ static inline void kvm_s390_vcpu_set_mem(struct kvm_vcpu *vcpu)
 {
 	int idx;
 	struct kvm_memory_slot *mem;
-	struct kvm_memory_slots *memslots;
+	struct kvm_memslots *memslots;
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	memslots = rcu_dereference(vcpu->kvm->memslots);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6811e5e..915a826 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5313,6 +5313,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
 				struct kvm_memory_slot old,
+				struct kvm_userspace_memory_region *mem,
 				int user_alloc)
 {
 	int npages = memslot->npages;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 600baf0..bb0314e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -258,6 +258,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
 				struct kvm_memory_slot old,
+				struct kvm_userspace_memory_region *mem,
 				int user_alloc);
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e0a591d..9843f3d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -440,11 +440,8 @@ static struct kvm *kvm_create_vm(void)
 out:
 	return kvm;
 
-#if defined(KVM_COALESCED_MMIO_PAGE_OFFSET) || \
-    (defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER))
 out_err:
 	hardware_disable_all();
-#endif
 out_err_nodisable:
 	for (i = 0; i < KVM_NR_BUSES; i++)
 		kfree(kvm->buses[i]);
@@ -708,7 +705,7 @@ skip_lpage:
 		kfree(old_memslots);
 	}
 
-	r = kvm_arch_prepare_memory_region(kvm, &new, old, user_alloc);
+	r = kvm_arch_prepare_memory_region(kvm, &new, old, mem, user_alloc);
 	if (r)
 		goto out_free;
 

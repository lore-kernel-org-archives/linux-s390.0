From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] KVM: Clean up vm creation and release
Date: Tue, 09 Nov 2010 15:58:29 +0100
Message-ID: <4CD96195.2000708@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>, "kvm-ia64@vger.kernel.org" <kvm-ia64@vger.kernel.org>, Alexander Graf <agraf@suse.de>, "Zhang, Xiantao" <xiantao.zhang@intel.com>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

IA64 support forces us to abstract the allocation of the kvm structure.
But instead of mixing this up with arch-specific initialization and
doing the same on destruction, split both steps. This allows to move
generic destruction calls into generic code.

It also fixes error clean-up on failures of kvm_create_vm for IA64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Tested on x86 only. Please check carefully.

 arch/ia64/include/asm/kvm_host.h |    4 ++++
 arch/ia64/kvm/kvm-ia64.c         |   29 +++++++----------------------
 arch/powerpc/kvm/powerpc.c       |   20 +++-----------------
 arch/s390/kvm/kvm-s390.c         |   23 ++++++-----------------
 arch/x86/kvm/x86.c               |   12 ++----------
 include/linux/kvm_host.h         |   14 +++++++++++++-
 virt/kvm/kvm_main.c              |   19 +++++++++++++------
 7 files changed, 48 insertions(+), 73 deletions(-)

diff --git a/arch/ia64/include/asm/kvm_host.h b/arch/ia64/include/asm/kvm_host.h
index 2f229e5..2689ee5 100644
--- a/arch/ia64/include/asm/kvm_host.h
+++ b/arch/ia64/include/asm/kvm_host.h
@@ -590,6 +590,10 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu);
 int kvm_pal_emul(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run);
 void kvm_sal_emul(struct kvm_vcpu *vcpu);
 
+#define __KVM_HAVE_ARCH_VM_ALLOC 1
+struct kvm *kvm_arch_alloc_vm(void);
+void kvm_arch_free_vm(struct kvm *kvm);
+
 #endif /* __ASSEMBLY__*/
 
 #endif
diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
index f56a631..cab6722 100644
--- a/arch/ia64/kvm/kvm-ia64.c
+++ b/arch/ia64/kvm/kvm-ia64.c
@@ -749,9 +749,8 @@ out:
 	return r;
 }
 
-static struct kvm *kvm_alloc_kvm(void)
+struct kvm *kvm_arch_alloc_vm(void)
 {
-
 	struct kvm *kvm;
 	uint64_t  vm_base;
 
@@ -760,7 +759,7 @@ static struct kvm *kvm_alloc_kvm(void)
 	vm_base = __get_free_pages(GFP_KERNEL, get_order(KVM_VM_DATA_SIZE));
 
 	if (!vm_base)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	memset((void *)vm_base, 0, KVM_VM_DATA_SIZE);
 	kvm = (struct kvm *)(vm_base +
@@ -806,10 +805,12 @@ static void kvm_build_io_pmt(struct kvm *kvm)
 #define GUEST_PHYSICAL_RR4	0x2739
 #define VMM_INIT_RR		0x1660
 
-static void kvm_init_vm(struct kvm *kvm)
+int kvm_arch_init_vm(struct kvm *kvm)
 {
 	BUG_ON(!kvm);
 
+	kvm->arch.is_sn2 = ia64_platform_is("sn2");
+
 	kvm->arch.metaphysical_rr0 = GUEST_PHYSICAL_RR0;
 	kvm->arch.metaphysical_rr4 = GUEST_PHYSICAL_RR4;
 	kvm->arch.vmm_init_rr = VMM_INIT_RR;
@@ -823,21 +824,8 @@ static void kvm_init_vm(struct kvm *kvm)
 
 	/* Reserve bit 0 of irq_sources_bitmap for userspace irq source */
 	set_bit(KVM_USERSPACE_IRQ_SOURCE_ID, &kvm->arch.irq_sources_bitmap);
-}
-
-struct  kvm *kvm_arch_create_vm(void)
-{
-	struct kvm *kvm = kvm_alloc_kvm();
-
-	if (IS_ERR(kvm))
-		return ERR_PTR(-ENOMEM);
-
-	kvm->arch.is_sn2 = ia64_platform_is("sn2");
-
-	kvm_init_vm(kvm);
-
-	return kvm;
 
+	return 0;
 }
 
 static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm,
@@ -1357,7 +1345,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
-static void free_kvm(struct kvm *kvm)
+void kvm_arch_free_vm(struct kvm *kvm)
 {
 	unsigned long vm_base = kvm->arch.vm_base;
 
@@ -1399,9 +1387,6 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 #endif
 	kfree(kvm->arch.vioapic);
 	kvm_release_vm_pages(kvm);
-	kvm_free_physmem(kvm);
-	cleanup_srcu_struct(&kvm->srcu);
-	free_kvm(kvm);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 38f756f..ce3dd65 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -145,18 +145,12 @@ void kvm_arch_check_processor_compat(void *rtn)
 	*(int *)rtn = kvmppc_core_check_processor_compat();
 }
 
-struct kvm *kvm_arch_create_vm(void)
+int kvm_arch_init_vm(struct kvm *)
 {
-	struct kvm *kvm;
-
-	kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
-	if (!kvm)
-		return ERR_PTR(-ENOMEM);
-
-	return kvm;
+	return 0;
 }
 
-static void kvmppc_free_vcpus(struct kvm *kvm)
+void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	unsigned int i;
 	struct kvm_vcpu *vcpu;
@@ -176,14 +170,6 @@ void kvm_arch_sync_events(struct kvm *kvm)
 {
 }
 
-void kvm_arch_destroy_vm(struct kvm *kvm)
-{
-	kvmppc_free_vcpus(kvm);
-	kvm_free_physmem(kvm);
-	cleanup_srcu_struct(&kvm->srcu);
-	kfree(kvm);
-}
-
 int kvm_dev_ioctl_check_extension(long ext)
 {
 	int r;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 985d825..d8d1877 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -164,24 +164,18 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	return r;
 }
 
-struct kvm *kvm_arch_create_vm(void)
+int kvm_arch_create_vm(struct kvm *kvm)
 {
-	struct kvm *kvm;
 	int rc;
 	char debug_name[16];
 
 	rc = s390_enable_sie();
 	if (rc)
-		goto out_nokvm;
-
-	rc = -ENOMEM;
-	kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
-	if (!kvm)
-		goto out_nokvm;
+		goto out_err;
 
 	kvm->arch.sca = (struct sca_block *) get_zeroed_page(GFP_KERNEL);
 	if (!kvm->arch.sca)
-		goto out_nosca;
+		goto out_err;
 
 	sprintf(debug_name, "kvm-%u", current->pid);
 
@@ -195,13 +189,11 @@ struct kvm *kvm_arch_create_vm(void)
 	debug_register_view(kvm->arch.dbf, &debug_sprintf_view);
 	VM_EVENT(kvm, 3, "%s", "vm created");
 
-	return kvm;
+	return 0;
 out_nodbf:
 	free_page((unsigned long)(kvm->arch.sca));
-out_nosca:
-	kfree(kvm);
-out_nokvm:
-	return ERR_PTR(rc);
+out_err:
+	return rc;
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
@@ -240,11 +232,8 @@ void kvm_arch_sync_events(struct kvm *kvm)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_free_vcpus(kvm);
-	kvm_free_physmem(kvm);
 	free_page((unsigned long)(kvm->arch.sca));
 	debug_unregister(kvm->arch.dbf);
-	cleanup_srcu_struct(&kvm->srcu);
-	kfree(kvm);
 }
 
 /* Section: vcpu related */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2044302..fc29223 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5962,13 +5962,8 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 	free_page((unsigned long)vcpu->arch.pio_data);
 }
 
-struct  kvm *kvm_arch_create_vm(void)
+int kvm_arch_init_vm(struct kvm *kvm)
 {
-	struct kvm *kvm = kzalloc(sizeof(struct kvm), GFP_KERNEL);
-
-	if (!kvm)
-		return ERR_PTR(-ENOMEM);
-
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
 	INIT_LIST_HEAD(&kvm->arch.assigned_dev_head);
 
@@ -5977,7 +5972,7 @@ struct  kvm *kvm_arch_create_vm(void)
 
 	spin_lock_init(&kvm->arch.tsc_write_lock);
 
-	return kvm;
+	return 0;
 }
 
 static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
@@ -6022,13 +6017,10 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kfree(kvm->arch.vpic);
 	kfree(kvm->arch.vioapic);
 	kvm_free_vcpus(kvm);
-	kvm_free_physmem(kvm);
 	if (kvm->arch.apic_access_page)
 		put_page(kvm->arch.apic_access_page);
 	if (kvm->arch.ept_identity_pagetable)
 		put_page(kvm->arch.ept_identity_pagetable);
-	cleanup_srcu_struct(&kvm->srcu);
-	kfree(kvm);
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bcf71c7..76d3269 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -441,7 +441,19 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 
 void kvm_free_physmem(struct kvm *kvm);
 
-struct  kvm *kvm_arch_create_vm(void);
+#ifndef __KVM_HAVE_ARCH_VM_ALLOC
+static inline struct kvm *kvm_arch_alloc_vm(void)
+{
+	return kzalloc(sizeof(struct kvm), GFP_KERNEL);
+}
+
+static inline void kvm_arch_free_vm(struct kvm *kvm)
+{
+	kfree(kvm);
+}
+#endif
+
+int kvm_arch_init_vm(struct kvm *kvm);
 void kvm_arch_destroy_vm(struct kvm *kvm);
 void kvm_free_all_assigned_devices(struct kvm *kvm);
 void kvm_arch_sync_events(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f7aa0e8..339dd43 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -383,11 +383,15 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 static struct kvm *kvm_create_vm(void)
 {
-	int r = 0, i;
-	struct kvm *kvm = kvm_arch_create_vm();
+	int r, i;
+	struct kvm *kvm = kvm_arch_alloc_vm();
 
-	if (IS_ERR(kvm))
-		goto out;
+	if (!kvm)
+		return ERR_PTR(-ENOMEM);
+
+	r = kvm_arch_init_vm(kvm);
+	if (r)
+		goto out_err_nodisable;
 
 	r = hardware_enable_all();
 	if (r)
@@ -427,7 +431,7 @@ static struct kvm *kvm_create_vm(void)
 	spin_lock(&kvm_lock);
 	list_add(&kvm->vm_list, &vm_list);
 	spin_unlock(&kvm_lock);
-out:
+
 	return kvm;
 
 out_err:
@@ -438,7 +442,7 @@ out_err_nodisable:
 	for (i = 0; i < KVM_NR_BUSES; i++)
 		kfree(kvm->buses[i]);
 	kfree(kvm->memslots);
-	kfree(kvm);
+	kvm_arch_free_vm(kvm);
 	return ERR_PTR(r);
 }
 
@@ -512,6 +516,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	kvm_arch_flush_shadow(kvm);
 #endif
 	kvm_arch_destroy_vm(kvm);
+	kvm_free_physmem(kvm);
+	cleanup_srcu_struct(&kvm->srcu);
+	kvm_arch_free_vm(kvm);
 	hardware_disable_all();
 	mmdrop(mm);
 }
-- 
1.7.1

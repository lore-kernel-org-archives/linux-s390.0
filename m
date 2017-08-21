From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RFC v3 8/9] KVM: implement kvm_for_each_vcpu with a list
Date: Mon, 21 Aug 2017 22:35:29 +0200
Message-ID: <20170821203530.9266-9-rkrcmar@redhat.com>
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

Going through all VCPUs is more natural with a list and the RCU list can
work as lockless with our constraints.

This makes kvm->vcpus lose most users, so it will be easier to make
something out of it.

A nice side-effect is that the first argument to the macro is gone.
ARM code was changed a bit to cope with the loss when working with a
range 0-n and most other places switched to vcpu->vcpus_idx.

Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/mips/kvm/mips.c                |  4 +---
 arch/powerpc/kvm/book3s_32_mmu.c    |  3 +--
 arch/powerpc/kvm/book3s_64_mmu.c    |  3 +--
 arch/powerpc/kvm/book3s_hv.c        |  7 +++----
 arch/powerpc/kvm/book3s_pr.c        |  5 ++---
 arch/powerpc/kvm/book3s_xics.c      |  2 +-
 arch/powerpc/kvm/book3s_xics.h      |  3 +--
 arch/powerpc/kvm/book3s_xive.c      | 18 ++++++++----------
 arch/powerpc/kvm/book3s_xive.h      |  3 +--
 arch/powerpc/kvm/e500_emulate.c     |  3 +--
 arch/powerpc/kvm/powerpc.c          |  3 +--
 arch/s390/kvm/interrupt.c           |  3 +--
 arch/s390/kvm/kvm-s390.c            | 31 ++++++++++---------------------
 arch/s390/kvm/kvm-s390.h            |  6 ++----
 arch/s390/kvm/sigp.c                |  3 +--
 arch/x86/kvm/hyperv.c               |  3 +--
 arch/x86/kvm/i8254.c                |  3 +--
 arch/x86/kvm/i8259.c                |  7 +++----
 arch/x86/kvm/ioapic.c               |  3 +--
 arch/x86/kvm/irq_comm.c             | 10 +++++-----
 arch/x86/kvm/lapic.c                |  5 ++---
 arch/x86/kvm/svm.c                  |  3 +--
 arch/x86/kvm/vmx.c                  |  3 +--
 arch/x86/kvm/x86.c                  | 25 ++++++++++---------------
 include/linux/kvm_host.h            | 30 +++++++++++++-----------------
 virt/kvm/arm/arch_timer.c           | 10 ++++------
 virt/kvm/arm/arm.c                  | 12 ++++--------
 virt/kvm/arm/pmu.c                  |  3 +--
 virt/kvm/arm/psci.c                 |  7 +++----
 virt/kvm/arm/vgic/vgic-init.c       | 11 +++++------
 virt/kvm/arm/vgic/vgic-kvm-device.c | 28 ++++++++++++++++------------
 virt/kvm/arm/vgic/vgic-mmio-v2.c    |  5 ++---
 virt/kvm/arm/vgic/vgic-mmio-v3.c    | 19 +++++++++++--------
 virt/kvm/arm/vgic/vgic.c            |  3 +--
 virt/kvm/kvm_main.c                 | 22 +++++++++++-----------
 35 files changed, 131 insertions(+), 178 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 770c40b9df37..c841cb434486 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -162,12 +162,10 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 
 void kvm_arch_free_vcpus(struct kvm *kvm)
 {
-	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_arch_vcpu_free(vcpu);
-	}
 }
 
 static void kvm_mips_free_gpa_pt(struct kvm *kvm)
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 1992676c7a94..1ac7cace49fc 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -353,11 +353,10 @@ static void kvmppc_mmu_book3s_32_mtsrin(struct kvm_vcpu *vcpu, u32 srnum,
 
 static void kvmppc_mmu_book3s_32_tlbie(struct kvm_vcpu *vcpu, ulong ea, bool large)
 {
-	int i;
 	struct kvm_vcpu *v;
 
 	/* flush this VA on all cpus */
-	kvm_for_each_vcpu(i, v, vcpu->kvm)
+	kvm_for_each_vcpu(v, vcpu->kvm)
 		kvmppc_mmu_pte_flush(v, ea, 0x0FFFF000);
 }
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 29ebe2fd5867..7b043fcc8c88 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -534,7 +534,6 @@ static void kvmppc_mmu_book3s_64_tlbie(struct kvm_vcpu *vcpu, ulong va,
 				       bool large)
 {
 	u64 mask = 0xFFFFFFFFFULL;
-	long i;
 	struct kvm_vcpu *v;
 
 	dprintk("KVM MMU: tlbie(0x%lx)\n", va);
@@ -559,7 +558,7 @@ static void kvmppc_mmu_book3s_64_tlbie(struct kvm_vcpu *vcpu, ulong va,
 			mask = 0xFFFFFF000ULL;
 	}
 	/* flush this VA on all vcpus */
-	kvm_for_each_vcpu(i, v, vcpu->kvm)
+	kvm_for_each_vcpu(v, vcpu->kvm)
 		kvmppc_mmu_pte_vflush(v, va >> 12, mask);
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 359c79cdf0cc..4d40537fad20 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1253,9 +1253,8 @@ static void kvmppc_set_lpcr(struct kvm_vcpu *vcpu, u64 new_lpcr,
 	 */
 	if ((new_lpcr & LPCR_ILE) != (vc->lpcr & LPCR_ILE)) {
 		struct kvm_vcpu *vcpu;
-		int i;
 
-		kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_for_each_vcpu(vcpu, kvm) {
 			if (vcpu->arch.vcore != vc)
 				continue;
 			if (new_lpcr & LPCR_ILE)
@@ -3347,7 +3346,7 @@ static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
-	int i, r;
+	int r;
 	unsigned long n;
 	unsigned long *buf;
 	struct kvm_vcpu *vcpu;
@@ -3381,7 +3380,7 @@ static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
 
 	/* Harvest dirty bits from VPA and DTL updates */
 	/* Note: we never modify the SLB shadow buffer areas */
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		spin_lock(&vcpu->arch.vpa_update_lock);
 		kvmppc_harvest_vpa_dirty(&vcpu->arch.vpa, memslot, buf);
 		kvmppc_harvest_vpa_dirty(&vcpu->arch.dtl, memslot, buf);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 69a09444d46e..9ef1b9b7e48a 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -251,7 +251,6 @@ static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
 static void do_kvm_unmap_hva(struct kvm *kvm, unsigned long start,
 			     unsigned long end)
 {
-	long i;
 	struct kvm_vcpu *vcpu;
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
@@ -272,7 +271,7 @@ static void do_kvm_unmap_hva(struct kvm *kvm, unsigned long start,
 		 */
 		gfn = hva_to_gfn_memslot(hva_start, memslot);
 		gfn_end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, memslot);
-		kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_for_each_vcpu(vcpu, kvm)
 			kvmppc_mmu_pte_pflush(vcpu, gfn << PAGE_SHIFT,
 					      gfn_end << PAGE_SHIFT);
 	}
@@ -1593,7 +1592,7 @@ static int kvm_vm_ioctl_get_dirty_log_pr(struct kvm *kvm,
 		ga = memslot->base_gfn << PAGE_SHIFT;
 		ga_end = ga + (memslot->npages << PAGE_SHIFT);
 
-		kvm_for_each_vcpu(n, vcpu, kvm)
+		kvm_for_each_vcpu(vcpu, kvm)
 			kvmppc_mmu_pte_pflush(vcpu, ga, ga_end);
 
 		n = kvm_dirty_bitmap_bytes(memslot);
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index d329b2add7e2..9871b76368bd 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -966,7 +966,7 @@ static int xics_debug_show(struct seq_file *m, void *private)
 
 	seq_printf(m, "=========\nICP state\n=========\n");
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		struct kvmppc_icp *icp = vcpu->arch.icp;
 		union kvmppc_icp_state state;
 
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index 453c9e518c19..71e33af1e119 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -119,9 +119,8 @@ static inline struct kvmppc_icp *kvmppc_xics_find_server(struct kvm *kvm,
 							 u32 nr)
 {
 	struct kvm_vcpu *vcpu = NULL;
-	int i;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (vcpu->arch.icp && nr == vcpu->arch.icp->server_num)
 			return vcpu->arch.icp;
 	}
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 08b200a0bbce..22222a540439 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -182,7 +182,7 @@ static int xive_check_provisioning(struct kvm *kvm, u8 prio)
 {
 	struct kvmppc_xive *xive = kvm->arch.xive;
 	struct kvm_vcpu *vcpu;
-	int i, rc;
+	int rc;
 
 	lockdep_assert_held(&kvm->lock);
 
@@ -193,7 +193,7 @@ static int xive_check_provisioning(struct kvm *kvm, u8 prio)
 	pr_devel("Provisioning prio... %d\n", prio);
 
 	/* Provision each VCPU and enable escalations */
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (!vcpu->arch.xive_vcpu)
 			continue;
 		rc = xive_provision_queue(vcpu, prio);
@@ -252,7 +252,7 @@ static int xive_try_pick_queue(struct kvm_vcpu *vcpu, u8 prio)
 static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 {
 	struct kvm_vcpu *vcpu;
-	int i, rc;
+	int rc;
 
 	/* Locate target server */
 	vcpu = kvmppc_xive_find_server(kvm, *server);
@@ -271,7 +271,7 @@ static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
 	pr_devel(" .. failed, looking up candidate...\n");
 
 	/* Failed, pick another VCPU */
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (!vcpu->arch.xive_vcpu)
 			continue;
 		rc = xive_try_pick_queue(vcpu, prio);
@@ -1237,7 +1237,7 @@ static void xive_pre_save_queue(struct kvmppc_xive *xive, struct xive_q *q)
 static void xive_pre_save_scan(struct kvmppc_xive *xive)
 {
 	struct kvm_vcpu *vcpu = NULL;
-	int i, j;
+	int j;
 
 	/*
 	 * See comment in xive_get_source() about how this
@@ -1252,7 +1252,7 @@ static void xive_pre_save_scan(struct kvmppc_xive *xive)
 	}
 
 	/* Then scan the queues and update the "in_queue" flag */
-	kvm_for_each_vcpu(i, vcpu, xive->kvm) {
+	kvm_for_each_vcpu(vcpu, xive->kvm) {
 		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 		if (!xc)
 			continue;
@@ -1418,9 +1418,8 @@ static bool xive_check_delayed_irq(struct kvmppc_xive *xive, u32 irq)
 {
 	struct kvm *kvm = xive->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-	int i;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 
 		if (!xc)
@@ -1787,14 +1786,13 @@ static int xive_debug_show(struct seq_file *m, void *private)
 	u64 t_vm_h_cppr = 0;
 	u64 t_vm_h_eoi = 0;
 	u64 t_vm_h_ipi = 0;
-	unsigned int i;
 
 	if (!kvm)
 		return 0;
 
 	seq_printf(m, "=========\nVCPU state\n=========\n");
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
 
 		if (!xc)
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 5938f7644dc1..5bc33db0924c 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -175,9 +175,8 @@ struct kvmppc_xive_vcpu {
 static inline struct kvm_vcpu *kvmppc_xive_find_server(struct kvm *kvm, u32 nr)
 {
 	struct kvm_vcpu *vcpu = NULL;
-	int i;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (vcpu->arch.xive_vcpu && nr == vcpu->arch.xive_vcpu->server_num)
 			return vcpu;
 	}
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 990db69a1d0b..56151681afcc 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -68,13 +68,12 @@ static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
 	ulong param = vcpu->arch.gpr[rb];
 	int prio = dbell2prio(rb);
 	int pir = param & PPC_DBELL_PIR_MASK;
-	int i;
 	struct kvm_vcpu *cvcpu;
 
 	if (prio < 0)
 		return EMULATE_FAIL;
 
-	kvm_for_each_vcpu(i, cvcpu, vcpu->kvm) {
+	kvm_for_each_vcpu(cvcpu, vcpu->kvm) {
 		int cpir = cvcpu->arch.shared->pir;
 		if ((param & PPC_DBELL_MSG_BRDCAST) || (cpir == pir)) {
 			set_bit(prio, &cvcpu->arch.pending_exceptions);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1c563545473c..633d3bb501c1 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -458,10 +458,9 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 
 void kvm_arch_free_vcpus(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_arch_vcpu_free(vcpu);
 }
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a619ddae610d..d503b25638af 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2287,7 +2287,6 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
 static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = 0;
-	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
 	switch (attr->group) {
@@ -2308,7 +2307,7 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		 * about late coming workers.
 		 */
 		synchronize_srcu(&dev->kvm->srcu);
-		kvm_for_each_vcpu(i, vcpu, dev->kvm)
+		kvm_for_each_vcpu(vcpu, dev->kvm)
 			kvm_clear_async_pf_completion_queue(vcpu);
 		break;
 	case KVM_DEV_FLIC_ADAPTER_REGISTER:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bb6278d45a25..3e64e3eb2a63 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -174,12 +174,11 @@ static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
 {
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
-	int i;
 	unsigned long long *delta = v;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
 		kvm->arch.epoch -= *delta;
-		kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_for_each_vcpu(vcpu, kvm) {
 			vcpu->arch.sie_block->epoch -= *delta;
 			if (vcpu->arch.cputm_enabled)
 				vcpu->arch.cputm_start += *delta;
@@ -491,12 +490,10 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 
 static void icpt_operexc_on_all_vcpus(struct kvm *kvm)
 {
-	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_s390_sync_request(KVM_REQ_ICPT_OPEREXC, vcpu);
-	}
 }
 
 static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
@@ -705,7 +702,6 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
 static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	if (!test_kvm_facility(kvm, 76))
 		return -EINVAL;
@@ -743,7 +739,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -ENXIO;
 	}
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		kvm_s390_vcpu_crypto_setup(vcpu);
 		exit_sie(vcpu);
 	}
@@ -753,10 +749,9 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
 
 static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
 {
-	int cx;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(cx, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_s390_sync_request(req, vcpu);
 }
 
@@ -1943,10 +1938,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 void kvm_arch_free_vcpus(struct kvm *kvm)
 {
-	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_arch_vcpu_destroy(vcpu);
 }
 
@@ -2050,7 +2044,6 @@ static int sca_switch_to_extended(struct kvm *kvm)
 	struct bsca_block *old_sca = kvm->arch.sca;
 	struct esca_block *new_sca;
 	struct kvm_vcpu *vcpu;
-	unsigned int vcpu_idx;
 	u32 scaol, scaoh;
 
 	new_sca = alloc_pages_exact(sizeof(*new_sca), GFP_KERNEL|__GFP_ZERO);
@@ -2065,7 +2058,7 @@ static int sca_switch_to_extended(struct kvm *kvm)
 
 	sca_copy_b_to_e(new_sca, old_sca);
 
-	kvm_for_each_vcpu(vcpu_idx, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		vcpu->arch.sie_block->scaoh = scaoh;
 		vcpu->arch.sie_block->scaol = scaol;
 		vcpu->arch.sie_block->ecb2 |= ECB2_ESCA;
@@ -2491,14 +2484,13 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 	struct kvm *kvm = gmap->private;
 	struct kvm_vcpu *vcpu;
 	unsigned long prefix;
-	int i;
 
 	if (gmap_is_shadow(gmap))
 		return;
 	if (start >= 1UL << 31)
 		/* We are only interested in prefix pages */
 		return;
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		/* match against both prefix pages */
 		prefix = kvm_s390_get_prefix(vcpu);
 		if (prefix <= end && start <= prefix + 2*PAGE_SIZE - 1) {
@@ -2856,13 +2848,12 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod)
 {
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	mutex_lock(&kvm->lock);
 	preempt_disable();
 	kvm->arch.epoch = tod - get_tod_clock();
 	kvm_s390_vcpu_block_all(kvm);
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		vcpu->arch.sie_block->epoch = kvm->arch.epoch;
 	kvm_s390_vcpu_unblock_all(kvm);
 	preempt_enable();
@@ -3389,12 +3380,10 @@ static void __disable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 
 static void __disable_ibs_on_all_vcpus(struct kvm *kvm)
 {
-	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm)
 		__disable_ibs_on_vcpu(vcpu);
-	}
 }
 
 static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
@@ -3462,7 +3451,7 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 		 * As we only have one VCPU left, we want to enable the IBS
 		 * facility for that VCPU to speed it up.
 		 */
-		kvm_for_each_vcpu(i, started_vcpu, vcpu->kvm)
+		kvm_for_each_vcpu(started_vcpu, vcpu->kvm)
 			if (!is_vcpu_stopped(started_vcpu)) {
 				__enable_ibs_on_vcpu(started_vcpu);
 				break;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6fedc8bc7a37..6077a724630c 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -294,20 +294,18 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 
 static inline void kvm_s390_vcpu_block_all(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
 	WARN_ON(!mutex_is_locked(&kvm->lock));
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_s390_vcpu_block(vcpu);
 }
 
 static inline void kvm_s390_vcpu_unblock_all(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_s390_vcpu_unblock(vcpu);
 }
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 1a252f537081..a31e1c2a994d 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -158,7 +158,6 @@ static int __sigp_stop_and_store_status(struct kvm_vcpu *vcpu,
 static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 {
 	int rc;
-	unsigned int i;
 	struct kvm_vcpu *v;
 
 	switch (parameter & 0xff) {
@@ -167,7 +166,7 @@ static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 		break;
 	case 1:
 	case 2:
-		kvm_for_each_vcpu(i, v, vcpu->kvm) {
+		kvm_for_each_vcpu(v, vcpu->kvm) {
 			v->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 			kvm_clear_async_pf_completion_queue(v);
 		}
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index dc97f2544b6f..b43cb27bf783 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -109,13 +109,12 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 static struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm, u32 vpidx)
 {
 	struct kvm_vcpu *vcpu = NULL;
-	int i;
 
 	if (vpidx < KVM_MAX_VCPUS)
 		vcpu = kvm_get_vcpu(kvm, vpidx);
 	if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
 		return vcpu;
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		if (vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
 			return vcpu;
 	return NULL;
diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index af192895b1fc..fdd3bff598f3 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -241,7 +241,6 @@ static void pit_do_work(struct kthread_work *work)
 	struct kvm_pit *pit = container_of(work, struct kvm_pit, expired);
 	struct kvm *kvm = pit->kvm;
 	struct kvm_vcpu *vcpu;
-	int i;
 	struct kvm_kpit_state *ps = &pit->pit_state;
 
 	if (atomic_read(&ps->reinject) && !atomic_xchg(&ps->irq_ack, 0))
@@ -260,7 +259,7 @@ static void pit_do_work(struct kthread_work *work)
 	 * also be simultaneously delivered through PIC and IOAPIC.
 	 */
 	if (atomic_read(&kvm->arch.vapics_in_nmi_mode) > 0)
-		kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_for_each_vcpu(vcpu, kvm)
 			kvm_apic_nmi_wd_deliver(vcpu);
 }
 
diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index bdcd4139eca9..c4f57fbd7316 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -50,14 +50,13 @@ static void pic_unlock(struct kvm_pic *s)
 {
 	bool wakeup = s->wakeup_needed;
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	s->wakeup_needed = false;
 
 	spin_unlock(&s->lock);
 
 	if (wakeup) {
-		kvm_for_each_vcpu(i, vcpu, s->kvm) {
+		kvm_for_each_vcpu(vcpu, s->kvm) {
 			if (kvm_apic_accept_pic_intr(vcpu)) {
 				kvm_make_request(KVM_REQ_EVENT, vcpu);
 				kvm_vcpu_kick(vcpu);
@@ -270,7 +269,7 @@ int kvm_pic_read_irq(struct kvm *kvm)
 
 static void kvm_pic_reset(struct kvm_kpic_state *s)
 {
-	int irq, i;
+	int irq;
 	struct kvm_vcpu *vcpu;
 	u8 edge_irr = s->irr & ~s->elcr;
 	bool found = false;
@@ -287,7 +286,7 @@ static void kvm_pic_reset(struct kvm_kpic_state *s)
 	}
 	s->init_state = 1;
 
-	kvm_for_each_vcpu(i, vcpu, s->pics_state->kvm)
+	kvm_for_each_vcpu(vcpu, s->pics_state->kvm)
 		if (kvm_apic_accept_pic_intr(vcpu)) {
 			found = true;
 			break;
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 1a29da6c0558..2216e6d34fb7 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -146,13 +146,12 @@ void kvm_rtc_eoi_tracking_restore_one(struct kvm_vcpu *vcpu)
 static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic)
 {
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	if (RTC_GSI >= IOAPIC_NUM_PINS)
 		return;
 
 	rtc_irq_eoi_tracking_reset(ioapic);
-	kvm_for_each_vcpu(i, vcpu, ioapic->kvm)
+	kvm_for_each_vcpu(vcpu, ioapic->kvm)
 	    __rtc_irq_eoi_tracking_restore_one(vcpu);
 }
 
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 3cc3b2d130a0..a8f777f2b0e6 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -58,7 +58,7 @@ static int kvm_set_ioapic_irq(struct kvm_kernel_irq_routing_entry *e,
 int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, struct dest_map *dest_map)
 {
-	int i, r = -1;
+	int r = -1;
 	struct kvm_vcpu *vcpu, *lowest = NULL;
 	unsigned long dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 	unsigned int dest_vcpus = 0;
@@ -74,7 +74,7 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 
 	memset(dest_vcpu_bitmap, 0, sizeof(dest_vcpu_bitmap));
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (!kvm_apic_present(vcpu))
 			continue;
 
@@ -93,7 +93,7 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 				else if (kvm_apic_compare_prio(vcpu, lowest) < 0)
 					lowest = vcpu;
 			} else {
-				__set_bit(i, dest_vcpu_bitmap);
+				__set_bit(vcpu->vcpus_idx, dest_vcpu_bitmap);
 				dest_vcpus++;
 			}
 		}
@@ -335,13 +335,13 @@ int kvm_set_routing_entry(struct kvm *kvm,
 bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
 			     struct kvm_vcpu **dest_vcpu)
 {
-	int i, r = 0;
+	int r = 0;
 	struct kvm_vcpu *vcpu;
 
 	if (kvm_intr_is_single_vcpu_fast(kvm, irq, dest_vcpu))
 		return true;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (!kvm_apic_present(vcpu))
 			continue;
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4f38818db929..a7cdd6baa38b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -166,12 +166,11 @@ static void recalculate_apic_map(struct kvm *kvm)
 {
 	struct kvm_apic_map *new, *old = NULL;
 	struct kvm_vcpu *vcpu;
-	int i;
 	u32 max_id = 255; /* enough space for any xAPIC ID */
 
 	mutex_lock(&kvm->arch.apic_map_lock);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		if (kvm_apic_present(vcpu))
 			max_id = max(max_id, kvm_x2apic_id(vcpu->arch.apic));
 
@@ -183,7 +182,7 @@ static void recalculate_apic_map(struct kvm *kvm)
 
 	new->max_apic_id = max_id;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		struct kvm_lapic *apic = vcpu->arch.apic;
 		struct kvm_lapic **cluster;
 		u16 mask;
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1fa9ee5660f4..605c18003f55 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3807,7 +3807,6 @@ static int avic_incomplete_ipi_interception(struct vcpu_svm *svm)
 		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING: {
-		int i;
 		struct kvm_vcpu *vcpu;
 		struct kvm *kvm = svm->vcpu.kvm;
 		struct kvm_lapic *apic = svm->vcpu.arch.apic;
@@ -3817,7 +3816,7 @@ static int avic_incomplete_ipi_interception(struct vcpu_svm *svm)
 		 * set the appropriate IRR bits on the valid target
 		 * vcpus. So, we just need to kick the appropriate vcpu.
 		 */
-		kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_for_each_vcpu(vcpu, kvm) {
 			bool m = kvm_apic_match_dest(vcpu, apic,
 						     icrl & KVM_APIC_SHORT_MASK,
 						     GET_APIC_DEST_FIELD(icrh),
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index df8d2f127508..ae0f04e26fec 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8472,7 +8472,6 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
  */
 static void kvm_flush_pml_buffers(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 	/*
 	 * We only need to kick vcpu out of guest mode here, as PML buffer
@@ -8480,7 +8479,7 @@ static void kvm_flush_pml_buffers(struct kvm *kvm)
 	 * vcpus running in guest are possible to have unflushed GPAs in PML
 	 * buffer.
 	 */
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_vcpu_kick(vcpu);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d021746f1fdf..caea24d3ddb0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1734,7 +1734,6 @@ void kvm_make_mclock_inprogress_request(struct kvm *kvm)
 static void kvm_gen_update_masterclock(struct kvm *kvm)
 {
 #ifdef CONFIG_X86_64
-	int i;
 	struct kvm_vcpu *vcpu;
 	struct kvm_arch *ka = &kvm->arch;
 
@@ -1743,11 +1742,11 @@ static void kvm_gen_update_masterclock(struct kvm *kvm)
 	/* no guest entries from this point */
 	pvclock_update_vm_gtod_copy(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 
 	/* guest entries allowed */
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
 
 	spin_unlock(&ka->pvclock_gtod_sync_lock);
@@ -1945,14 +1944,13 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 
 static void kvmclock_update_fn(struct work_struct *work)
 {
-	int i;
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct kvm_arch *ka = container_of(dwork, struct kvm_arch,
 					   kvmclock_update_work);
 	struct kvm *kvm = container_of(ka, struct kvm, arch);
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		kvm_vcpu_kick(vcpu);
 	}
@@ -5844,7 +5842,7 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
 	struct cpufreq_freqs *freq = data;
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
-	int i, send_ipi = 0;
+	int send_ipi = 0;
 
 	/*
 	 * We allow guests to temporarily run on slowing clocks,
@@ -5894,7 +5892,7 @@ static int kvmclock_cpufreq_notifier(struct notifier_block *nb, unsigned long va
 
 	spin_lock(&kvm_lock);
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_for_each_vcpu(vcpu, kvm) {
 			if (vcpu->cpu != freq->cpu)
 				continue;
 			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
@@ -6035,11 +6033,10 @@ static void pvclock_gtod_update_fn(struct work_struct *work)
 	struct kvm *kvm;
 
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	spin_lock(&kvm_lock);
 	list_for_each_entry(kvm, &vm_list, vm_list)
-		kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_for_each_vcpu(vcpu, kvm)
 			kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 	atomic_set(&kvm_guest_has_master_clock, 0);
 	spin_unlock(&kvm_lock);
@@ -7783,7 +7780,6 @@ int kvm_arch_hardware_enable(void)
 {
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
-	int i;
 	int ret;
 	u64 local_tsc;
 	u64 max_tsc = 0;
@@ -7797,7 +7793,7 @@ int kvm_arch_hardware_enable(void)
 	local_tsc = rdtsc();
 	stable = !check_tsc_unstable();
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm_for_each_vcpu(i, vcpu, kvm) {
+		kvm_for_each_vcpu(vcpu, kvm) {
 			if (!stable && vcpu->cpu == smp_processor_id())
 				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 			if (stable && vcpu->arch.last_host_tsc > local_tsc) {
@@ -7850,7 +7846,7 @@ int kvm_arch_hardware_enable(void)
 		u64 delta_cyc = max_tsc - local_tsc;
 		list_for_each_entry(kvm, &vm_list, vm_list) {
 			kvm->arch.backwards_tsc_observed = true;
-			kvm_for_each_vcpu(i, vcpu, kvm) {
+			kvm_for_each_vcpu(vcpu, kvm) {
 				vcpu->arch.tsc_offset_adjustment += delta_cyc;
 				vcpu->arch.last_host_tsc = local_tsc;
 				kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
@@ -8079,17 +8075,16 @@ static void kvm_unload_vcpu_mmu(struct kvm_vcpu *vcpu)
 
 void kvm_arch_free_vcpus(struct kvm *kvm)
 {
-	unsigned int i;
 	struct kvm_vcpu *vcpu;
 
 	/*
 	 * Unpin any mmu pages first.
 	 */
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_unload_vcpu_mmu(vcpu);
 	}
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_arch_vcpu_free(vcpu);
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a8b9aa563834..5417dac55272 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -216,6 +216,7 @@ struct kvm_mmio_fragment {
 
 struct kvm_vcpu {
 	struct kvm *kvm;
+	struct list_head vcpu_list;
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	struct preempt_notifier preempt_notifier;
 #endif
@@ -393,6 +394,7 @@ struct kvm {
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	struct list_head vcpu_list;
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
@@ -402,7 +404,7 @@ struct kvm {
 	 */
 	atomic_t online_vcpus;
 	int created_vcpus;
-	int last_boosted_vcpu;
+	struct kvm_vcpu *last_boosted_vcpu;
 	struct list_head vm_list;
 	struct mutex lock;
 	struct kvm_io_bus __rcu *buses[KVM_NR_BUSES];
@@ -492,29 +494,23 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 	return kvm->vcpus[i];
 }
 
-#define kvm_for_each_vcpu(idx, vcpup, kvm) \
-	for (idx = 0; \
-	     idx < atomic_read(&kvm->online_vcpus) && \
-	     (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
-	     idx++)
+#define kvm_for_each_vcpu(vcpup, kvm) \
+	list_for_each_entry_rcu(vcpup, &kvm->vcpu_list, vcpu_list)
 
-#define kvm_for_each_vcpu_from(idx, vcpup, from, kvm) \
-	for (idx = from, vcpup = kvm_get_vcpu(kvm, idx); \
+#define kvm_for_each_vcpu_from(vcpup, from, kvm) \
+	for (vcpup = from; \
 	     vcpup; \
 	     ({ \
-		idx++; \
-		if (idx >= atomic_read(&kvm->online_vcpus)) \
-			idx = 0; \
-		if (idx == from) \
+		vcpup = list_entry_rcu(vcpup->vcpu_list.next, typeof(*vcpup), vcpu_list); \
+		if (&vcpup->vcpu_list == &kvm->vcpu_list) \
+			vcpup = list_entry_rcu(kvm->vcpu_list.next, typeof(*vcpup), vcpu_list); \
+		if (vcpup == from) \
 			vcpup = NULL; \
-		else \
-			vcpup = kvm_get_vcpu(kvm, idx); \
-	      }))
+	     }))
 
 static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 {
 	struct kvm_vcpu *vcpu = NULL;
-	int i;
 
 	if (id < 0)
 		return NULL;
@@ -522,7 +518,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 		vcpu = kvm_get_vcpu(kvm, id);
 	if (vcpu && vcpu->vcpu_id == id)
 		return vcpu;
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		if (vcpu->vcpu_id == id)
 			return vcpu;
 	return NULL;
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 8e89d63005c7..3e311fa5c7a1 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -478,12 +478,11 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
 /* Make the updates of cntvoff for all vtimer contexts atomic */
 static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
 {
-	int i;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tmp;
 
 	mutex_lock(&kvm->lock);
-	kvm_for_each_vcpu(i, tmp, kvm)
+	kvm_for_each_vcpu(tmp, kvm)
 		vcpu_vtimer(tmp)->cntvoff = cntvoff;
 
 	/*
@@ -622,7 +621,7 @@ void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
 {
 	int vtimer_irq, ptimer_irq;
-	int i, ret;
+	int ret;
 
 	vtimer_irq = vcpu_vtimer(vcpu)->irq.irq;
 	ret = kvm_vgic_set_owner(vcpu, vtimer_irq, vcpu_vtimer(vcpu));
@@ -634,7 +633,7 @@ static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
 	if (ret)
 		return false;
 
-	kvm_for_each_vcpu(i, vcpu, vcpu->kvm) {
+	kvm_for_each_vcpu(vcpu, vcpu->kvm) {
 		if (vcpu_vtimer(vcpu)->irq.irq != vtimer_irq ||
 		    vcpu_ptimer(vcpu)->irq.irq != ptimer_irq)
 			return false;
@@ -720,9 +719,8 @@ void kvm_timer_init_vhe(void)
 static void set_timer_irqs(struct kvm *kvm, int vtimer_irq, int ptimer_irq)
 {
 	struct kvm_vcpu *vcpu;
-	int i;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		vcpu_vtimer(vcpu)->irq.irq = vtimer_irq;
 		vcpu_ptimer(vcpu)->irq.irq = ptimer_irq;
 	}
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index d63aa1107fdb..e105f6b307cc 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -168,10 +168,9 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 
 void kvm_arch_free_vcpus(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
-	for_each_online_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_arch_vcpu_free(vcpu);
 }
 
@@ -548,20 +547,18 @@ bool kvm_arch_intc_initialized(struct kvm *kvm)
 
 void kvm_arm_halt_guest(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		vcpu->arch.pause = true;
 	kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
 }
 
 void kvm_arm_resume_guest(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		vcpu->arch.pause = false;
 		swake_up(kvm_arch_vcpu_wq(vcpu));
 	}
@@ -1440,10 +1437,9 @@ static void check_kvm_target_cpu(void *ret)
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
 {
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	mpidr &= MPIDR_HWID_BITMASK;
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (mpidr == kvm_vcpu_get_mpidr_aff(vcpu))
 			return vcpu;
 	}
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 8a9c42366db7..84f526cfdb35 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -512,10 +512,9 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
  */
 static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 {
-	int i;
 	struct kvm_vcpu *vcpu;
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (!kvm_arm_pmu_irq_initialized(vcpu))
 			continue;
 
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index f1e363bab5e8..876c965e0886 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -129,7 +129,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 
 static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 {
-	int i, matching_cpus = 0;
+	int matching_cpus = 0;
 	unsigned long mpidr;
 	unsigned long target_affinity;
 	unsigned long target_affinity_mask;
@@ -152,7 +152,7 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	 * If one or more VCPU matching target affinity are running
 	 * then ON else OFF
 	 */
-	kvm_for_each_vcpu(i, tmp, kvm) {
+	kvm_for_each_vcpu(tmp, kvm) {
 		mpidr = kvm_vcpu_get_mpidr_aff(tmp);
 		if ((mpidr & target_affinity_mask) == target_affinity) {
 			matching_cpus++;
@@ -169,7 +169,6 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 
 static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 {
-	int i;
 	struct kvm_vcpu *tmp;
 
 	/*
@@ -181,7 +180,7 @@ static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
 	 * after this call is handled and before the VCPUs have been
 	 * re-initialized.
 	 */
-	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
+	kvm_for_each_vcpu(tmp, vcpu->kvm)
 		tmp->arch.power_off = true;
 	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
 
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index feb766f74c34..c926d7b30149 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -119,7 +119,7 @@ void kvm_vgic_vcpu_early_init(struct kvm_vcpu *vcpu)
  */
 int kvm_vgic_create(struct kvm *kvm, u32 type)
 {
-	int i, ret;
+	int ret;
 	struct kvm_vcpu *vcpu;
 
 	if (irqchip_in_kernel(kvm))
@@ -143,7 +143,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 	if (!lock_all_vcpus(kvm))
 		return -EBUSY;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		if (vcpu->arch.has_run_once) {
 			ret = -EBUSY;
 			goto out_unlock;
@@ -266,7 +266,7 @@ int vgic_init(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct kvm_vcpu *vcpu;
-	int ret = 0, i;
+	int ret = 0;
 
 	if (vgic_initialized(kvm))
 		return 0;
@@ -279,7 +279,7 @@ int vgic_init(struct kvm *kvm)
 	if (ret)
 		goto out;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_vgic_vcpu_enable(vcpu);
 
 	ret = kvm_vgic_setup_default_irq_routing(kvm);
@@ -327,13 +327,12 @@ void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
 static void __kvm_vgic_destroy(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
-	int i;
 
 	vgic_debug_destroy(kvm);
 
 	kvm_vgic_dist_destroy(kvm);
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
+	kvm_for_each_vcpu(vcpu, kvm)
 		kvm_vgic_vcpu_destroy(vcpu);
 }
 
diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index c5124737c7fc..3c3e865dc98b 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -257,31 +257,33 @@ int vgic_v2_parse_attr(struct kvm_device *dev, struct kvm_device_attr *attr,
 	return 0;
 }
 
-/* unlocks vcpus from @vcpu_lock_idx and smaller */
-static void unlock_vcpus(struct kvm *kvm, int vcpu_lock_idx)
+/* unlocks vcpus from up to @last_locked */
+static void unlock_vcpus(struct kvm *kvm, struct kvm_vcpu *last_locked)
 {
-	struct kvm_vcpu *tmp_vcpu;
+	if (last_locked) {
+		struct kvm_vcpu *tmp_vcpu;
 
-	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
-		tmp_vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
-		mutex_unlock(&tmp_vcpu->mutex);
+		kvm_for_each_vcpu(tmp_vcpu, kvm) {
+			mutex_unlock(&tmp_vcpu->mutex);
+
+			if (tmp_vcpu == last_locked)
+				return;
+		}
 	}
 }
 
 void unlock_all_vcpus(struct kvm *kvm)
 {
-	int i;
 	struct kvm_vcpu *tmp_vcpu;
 
-	kvm_for_each_vcpu(i, tmp_vcpu, kvm)
+	kvm_for_each_vcpu(tmp_vcpu, kvm)
 		mutex_unlock(&tmp_vcpu->mutex);
 }
 
 /* Returns true if all vcpus were locked, false otherwise */
 bool lock_all_vcpus(struct kvm *kvm)
 {
-	struct kvm_vcpu *tmp_vcpu;
-	int c;
+	struct kvm_vcpu *tmp_vcpu, *last_locked = NULL;
 
 	/*
 	 * Any time a vcpu is run, vcpu_load is called which tries to grab the
@@ -289,11 +291,13 @@ bool lock_all_vcpus(struct kvm *kvm)
 	 * that no other VCPUs are run and fiddle with the vgic state while we
 	 * access it.
 	 */
-	kvm_for_each_vcpu(c, tmp_vcpu, kvm) {
+	kvm_for_each_vcpu(tmp_vcpu, kvm) {
 		if (!mutex_trylock(&tmp_vcpu->mutex)) {
-			unlock_vcpus(kvm, c - 1);
+			unlock_vcpus(kvm, last_locked);
 			return false;
 		}
+
+		last_locked = tmp_vcpu;
 	}
 
 	return true;
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v2.c b/virt/kvm/arm/vgic/vgic-mmio-v2.c
index 37522e65eb53..bc5f5124be74 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v2.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v2.c
@@ -72,7 +72,6 @@ static void vgic_mmio_write_sgir(struct kvm_vcpu *source_vcpu,
 	int intid = val & 0xf;
 	int targets = (val >> 16) & 0xff;
 	int mode = (val >> 24) & 0x03;
-	int c;
 	struct kvm_vcpu *vcpu;
 
 	switch (mode) {
@@ -89,10 +88,10 @@ static void vgic_mmio_write_sgir(struct kvm_vcpu *source_vcpu,
 		return;
 	}
 
-	kvm_for_each_vcpu(c, vcpu, source_vcpu->kvm) {
+	kvm_for_each_vcpu(vcpu, source_vcpu->kvm) {
 		struct vgic_irq *irq;
 
-		if (!(targets & (1U << c)))
+		if (!(targets & (1U << vcpu->vcpus_idx)))
 			continue;
 
 		irq = vgic_get_irq(source_vcpu->kvm, vcpu, intid);
diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 9d4b69b766ec..62fd24431619 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -641,21 +641,24 @@ static void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 
 static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 {
-	struct kvm_vcpu *vcpu;
-	int c, ret = 0;
+	struct kvm_vcpu *vcpu, *last_registered = NULL;
+	int ret = 0;
 
-	kvm_for_each_vcpu(c, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		ret = vgic_register_redist_iodev(vcpu);
 		if (ret)
 			break;
+
+		last_registered = vcpu;
 	}
 
-	if (ret) {
+	if (ret && last_registered) {
 		/* The current c failed, so we start with the previous one. */
 		mutex_lock(&kvm->slots_lock);
-		for (c--; c >= 0; c--) {
-			vcpu = kvm_get_vcpu(kvm, c);
+		kvm_for_each_vcpu(vcpu, kvm) {
 			vgic_unregister_redist_iodev(vcpu);
+			if (vcpu == last_registered)
+				break;
 		}
 		mutex_unlock(&kvm->slots_lock);
 	}
@@ -796,7 +799,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
 	struct kvm_vcpu *c_vcpu;
 	u16 target_cpus;
 	u64 mpidr;
-	int sgi, c;
+	int sgi;
 	bool broadcast;
 
 	sgi = (reg & ICC_SGI1R_SGI_ID_MASK) >> ICC_SGI1R_SGI_ID_SHIFT;
@@ -812,7 +815,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
 	 * if we are already finished. This avoids iterating through all
 	 * VCPUs when most of the times we just signal a single VCPU.
 	 */
-	kvm_for_each_vcpu(c, c_vcpu, kvm) {
+	kvm_for_each_vcpu(c_vcpu, kvm) {
 		struct vgic_irq *irq;
 
 		/* Exit early if we have dealt with all requested CPUs */
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index fed717e07938..08662cd66e8d 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -758,13 +758,12 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
 void vgic_kick_vcpus(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu;
-	int c;
 
 	/*
 	 * We've injected an interrupt, time to find out who deserves
 	 * a good kick...
 	 */
-	kvm_for_each_vcpu(c, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		if (kvm_vgic_vcpu_pending_irq(vcpu)) {
 			kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 			kvm_vcpu_kick(vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0d2d8b0c785c..6cec58cad6c7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -207,7 +207,7 @@ static inline bool kvm_kick_many_cpus(const struct cpumask *cpus, bool wait)
 
 bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 {
-	int i, cpu, me;
+	int cpu, me;
 	cpumask_var_t cpus;
 	bool called;
 	struct kvm_vcpu *vcpu;
@@ -215,7 +215,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
 
 	me = get_cpu();
-	kvm_for_each_vcpu(i, vcpu, kvm) {
+	kvm_for_each_vcpu(vcpu, kvm) {
 		kvm_make_request(req, vcpu);
 		cpu = vcpu->cpu;
 
@@ -667,6 +667,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	mutex_init(&kvm->slots_lock);
 	refcount_set(&kvm->users_count, 1);
 	INIT_LIST_HEAD(&kvm->devices);
+	INIT_LIST_HEAD(&kvm->vcpu_list);
 
 	r = kvm_arch_init_vm(kvm, type);
 	if (r)
@@ -2348,10 +2349,9 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 {
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
-	int last_boosted_vcpu = me->kvm->last_boosted_vcpu;
-	int yielded = 0;
+	struct kvm_vcpu *last_boosted_vcpu = READ_ONCE(kvm->last_boosted_vcpu);
+	int yielded;
 	int try = 2;
-	int i;
 
 	kvm_vcpu_set_in_spin_loop(me, true);
 	/*
@@ -2361,7 +2361,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 	 * VCPU is holding the lock that we need and will release it.
 	 * We approximate round-robin by starting at the last boosted VCPU.
 	 */
-	kvm_for_each_vcpu_from(i, vcpu, last_boosted_vcpu, kvm) {
+	kvm_for_each_vcpu_from(vcpu, last_boosted_vcpu, kvm) {
 		if (!ACCESS_ONCE(vcpu->preempted))
 			continue;
 		if (vcpu == me)
@@ -2375,11 +2375,12 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 
 		yielded = kvm_vcpu_yield_to(vcpu);
 		if (yielded > 0) {
-			kvm->last_boosted_vcpu = i;
+			WRITE_ONCE(kvm->last_boosted_vcpu, vcpu);
 			break;
 		} else if (yielded < 0 && !try--)
 			break;
 	}
+
 	kvm_vcpu_set_in_spin_loop(me, false);
 
 	/* Ensure vcpu is not eligible during next spinloop */
@@ -2528,6 +2529,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 	}
 
 	kvm->vcpus[atomic_read(&kvm->online_vcpus)] = vcpu;
+	list_add_tail_rcu(&vcpu->vcpu_list, &kvm->vcpu_list);
 
 	/*
 	 * Pairs with smp_rmb() in kvm_get_vcpu.  Write kvm->vcpus
@@ -3766,13 +3768,12 @@ static const struct file_operations vm_stat_get_per_vm_fops = {
 
 static int vcpu_stat_get_per_vm(void *data, u64 *val)
 {
-	int i;
 	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
 	struct kvm_vcpu *vcpu;
 
 	*val = 0;
 
-	kvm_for_each_vcpu(i, vcpu, stat_data->kvm)
+	kvm_for_each_vcpu(vcpu, stat_data->kvm)
 		*val += *(u64 *)((void *)vcpu + stat_data->offset);
 
 	return 0;
@@ -3780,14 +3781,13 @@ static int vcpu_stat_get_per_vm(void *data, u64 *val)
 
 static int vcpu_stat_clear_per_vm(void *data, u64 val)
 {
-	int i;
 	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
 	struct kvm_vcpu *vcpu;
 
 	if (val)
 		return -EINVAL;
 
-	kvm_for_each_vcpu(i, vcpu, stat_data->kvm)
+	kvm_for_each_vcpu(vcpu, stat_data->kvm)
 		*(u64 *)((void *)vcpu + stat_data->offset) = 0;
 
 	return 0;
-- 
2.13.3

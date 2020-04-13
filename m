Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730248AbgDMOEA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Apr 2020 10:04:00 -0400
Received: by mail-wr1-f72.google.com with SMTP id o12so3677124wra.14
        for <linux-s390@vger.kernel.org>; Mon, 13 Apr 2020 07:03:55 -0700 (PDT)
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH] kvm_host: unify VM_STAT and VCPU_STAT definitions in a single place
Date: Mon, 13 Apr 2020 16:03:32 +0200
Message-Id: <20200413140332.22896-1-eesposit@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Emanuele Giuseppe Esposito <eesposit@redhat.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

The macros VM_STAT and VCPU_STAT are redundantly implemented in multiple
files, each used by a different architecure to initialize the debugfs
entries for statistics. Since they all have the same purpose, they can be
unified in a single common definition in include/linux/kvm_host.h

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/arm64/kvm/guest.c    | 23 +++++++--------
 arch/mips/kvm/mips.c      | 61 +++++++++++++++++++--------------------
 arch/powerpc/kvm/book3s.c |  3 --
 arch/powerpc/kvm/booke.c  |  3 --
 arch/s390/kvm/kvm-s390.c  |  3 --
 arch/x86/kvm/x86.c        |  3 --
 include/linux/kvm_host.h  |  3 ++
 7 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 23ebe51410f0..3e3aee8b37c0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -29,20 +29,17 @@
 
 #include "trace.h"
 
-#define VM_STAT(x) { #x, offsetof(struct kvm, stat.x), KVM_STAT_VM }
-#define VCPU_STAT(x) { #x, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU }
-
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT(halt_successful_poll),
-	VCPU_STAT(halt_attempted_poll),
-	VCPU_STAT(halt_poll_invalid),
-	VCPU_STAT(halt_wakeup),
-	VCPU_STAT(hvc_exit_stat),
-	VCPU_STAT(wfe_exit_stat),
-	VCPU_STAT(wfi_exit_stat),
-	VCPU_STAT(mmio_exit_user),
-	VCPU_STAT(mmio_exit_kernel),
-	VCPU_STAT(exits),
+	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
+	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
+	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
+	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
+	{ "hvc_exit_stat", VCPU_STAT(hvc_exit_stat) },
+	{ "wfe_exit_stat", VCPU_STAT(wfe_exit_stat) },
+	{ "wfi_exit_stat", VCPU_STAT(wfi_exit_stat) },
+	{ "mmio_exit_user", VCPU_STAT(mmio_exit_user) },
+	{ "mmio_exit_kernel", VCPU_STAT(mmio_exit_kernel) },
+	{ "exits", VCPU_STAT(exits) },
 	{ NULL }
 };
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 8f05dd0a0f4e..f14b93d02f02 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -39,40 +39,39 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
-#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x)
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	{ "wait",	  VCPU_STAT(wait_exits),	 KVM_STAT_VCPU },
-	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
-	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
-	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
-	{ "cop_unusable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
-	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
-	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
-	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },
-	{ "addrerr_st",	  VCPU_STAT(addrerr_st_exits),	 KVM_STAT_VCPU },
-	{ "addrerr_ld",	  VCPU_STAT(addrerr_ld_exits),	 KVM_STAT_VCPU },
-	{ "syscall",	  VCPU_STAT(syscall_exits),	 KVM_STAT_VCPU },
-	{ "resvd_inst",	  VCPU_STAT(resvd_inst_exits),	 KVM_STAT_VCPU },
-	{ "break_inst",	  VCPU_STAT(break_inst_exits),	 KVM_STAT_VCPU },
-	{ "trap_inst",	  VCPU_STAT(trap_inst_exits),	 KVM_STAT_VCPU },
-	{ "msa_fpe",	  VCPU_STAT(msa_fpe_exits),	 KVM_STAT_VCPU },
-	{ "fpe",	  VCPU_STAT(fpe_exits),		 KVM_STAT_VCPU },
-	{ "msa_disabled", VCPU_STAT(msa_disabled_exits), KVM_STAT_VCPU },
-	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
+	{ "wait",	  VCPU_STAT(wait_exits) },
+	{ "cache",	  VCPU_STAT(cache_exits) },
+	{ "signal",	  VCPU_STAT(signal_exits) },
+	{ "interrupt",	  VCPU_STAT(int_exits) },
+	{ "cop_unusable", VCPU_STAT(cop_unusable_exits) },
+	{ "tlbmod",	  VCPU_STAT(tlbmod_exits) },
+	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits) },
+	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits) },
+	{ "addrerr_st",	  VCPU_STAT(addrerr_st_exits) },
+	{ "addrerr_ld",	  VCPU_STAT(addrerr_ld_exits) },
+	{ "syscall",	  VCPU_STAT(syscall_exits) },
+	{ "resvd_inst",	  VCPU_STAT(resvd_inst_exits) },
+	{ "break_inst",	  VCPU_STAT(break_inst_exits) },
+	{ "trap_inst",	  VCPU_STAT(trap_inst_exits) },
+	{ "msa_fpe",	  VCPU_STAT(msa_fpe_exits) },
+	{ "fpe",	  VCPU_STAT(fpe_exits) },
+	{ "msa_disabled", VCPU_STAT(msa_disabled_exits) },
+	{ "flush_dcache", VCPU_STAT(flush_dcache_exits) },
 #ifdef CONFIG_KVM_MIPS_VZ
-	{ "vz_gpsi",	  VCPU_STAT(vz_gpsi_exits),	 KVM_STAT_VCPU },
-	{ "vz_gsfc",	  VCPU_STAT(vz_gsfc_exits),	 KVM_STAT_VCPU },
-	{ "vz_hc",	  VCPU_STAT(vz_hc_exits),	 KVM_STAT_VCPU },
-	{ "vz_grr",	  VCPU_STAT(vz_grr_exits),	 KVM_STAT_VCPU },
-	{ "vz_gva",	  VCPU_STAT(vz_gva_exits),	 KVM_STAT_VCPU },
-	{ "vz_ghfc",	  VCPU_STAT(vz_ghfc_exits),	 KVM_STAT_VCPU },
-	{ "vz_gpa",	  VCPU_STAT(vz_gpa_exits),	 KVM_STAT_VCPU },
-	{ "vz_resvd",	  VCPU_STAT(vz_resvd_exits),	 KVM_STAT_VCPU },
+	{ "vz_gpsi",	  VCPU_STAT(vz_gpsi_exits) },
+	{ "vz_gsfc",	  VCPU_STAT(vz_gsfc_exits) },
+	{ "vz_hc",	  VCPU_STAT(vz_hc_exits) },
+	{ "vz_grr",	  VCPU_STAT(vz_grr_exits) },
+	{ "vz_gva",	  VCPU_STAT(vz_gva_exits) },
+	{ "vz_ghfc",	  VCPU_STAT(vz_ghfc_exits) },
+	{ "vz_gpa",	  VCPU_STAT(vz_gpa_exits) },
+	{ "vz_resvd",	  VCPU_STAT(vz_resvd_exits) },
 #endif
-	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
-	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), KVM_STAT_VCPU },
-	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid), KVM_STAT_VCPU },
-	{ "halt_wakeup",  VCPU_STAT(halt_wakeup),	 KVM_STAT_VCPU },
+	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
+	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
+	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
+	{ "halt_wakeup",  VCPU_STAT(halt_wakeup) },
 	{NULL}
 };
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 5690a1f9b976..55cb728ba06e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -36,9 +36,6 @@
 #include "book3s.h"
 #include "trace.h"
 
-#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
-#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__
-
 /* #define EXIT_DEBUG */
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 6c18ea88fd25..fb8fa7060804 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -35,9 +35,6 @@
 
 unsigned long kvmppc_booke_handlers;
 
-#define VM_STAT(x) offsetof(struct kvm, stat.x), KVM_STAT_VM
-#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
-
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "mmio",       VCPU_STAT(mmio_exits) },
 	{ "sig",        VCPU_STAT(signal_exits) },
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 19a81024fe16..1a7bf8759750 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -57,9 +57,6 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
-#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
-#define VM_STAT(x) offsetof(struct kvm, stat.x), KVM_STAT_VM
-
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "userspace_handled", VCPU_STAT(exit_userspace) },
 	{ "exit_null", VCPU_STAT(exit_null) },
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b8124b562dea..fb035d304004 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -97,9 +97,6 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 
 static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
-#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
-#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__
-
 #define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
                                     KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6d58beb65454..e02d38c7fff1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1130,6 +1130,9 @@ struct kvm_stats_debugfs_item {
 #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
 	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
 
+#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
+#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__
+
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
 
-- 
2.17.1

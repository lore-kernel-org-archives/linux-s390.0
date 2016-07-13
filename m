From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu statistics
Date: Wed, 13 Jul 2016 18:53:35 +1000
Message-ID: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, pbonzini@redhat.com, rkrcmar@redhat.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, james.hogan@imgtec.com, agraf@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

vms and vcpus have statistics associated with them which can be viewed
within the debugfs. Currently it is assumed within the vcpu_stat_get() and
vm_stat_get() functions that all of these statistics are represented as
u32s, however the next patch adds some u64 statistics.

Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
that they expect u64 statistics and update vm and vcpu statistics to u64s
accordingly.

---
Change Log:

V1 -> V2:
	- Nothing
V2 -> V3:
	- Instead of implementing separate u32 and u64 functions keep the
	  generic functions and modify them to expect u64s. Thus update all
	  vm and vcpu statistics to u64s accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/arm/include/asm/kvm_host.h     |  12 ++--
 arch/arm64/include/asm/kvm_host.h   |  12 ++--
 arch/mips/include/asm/kvm_host.h    |  46 ++++++-------
 arch/powerpc/include/asm/kvm_host.h |  60 ++++++++---------
 arch/s390/include/asm/kvm_host.h    | 128 ++++++++++++++++++------------------
 arch/x86/include/asm/kvm_host.h     |  72 ++++++++++----------
 virt/kvm/kvm_main.c                 |  12 ++--
 7 files changed, 171 insertions(+), 171 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 96387d4..93757c9 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -183,15 +183,15 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	u64 remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 hvc_exit_stat;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 hvc_exit_stat;
 	u64 wfe_exit_stat;
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 49095fc..86bb1e1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -291,15 +291,15 @@ struct kvm_vcpu_arch {
 #endif
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	u64 remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 hvc_exit_stat;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 hvc_exit_stat;
 	u64 wfe_exit_stat;
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 36a391d..4e6d654 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -98,32 +98,32 @@ extern void (*kvm_mips_release_pfn_clean)(kvm_pfn_t pfn);
 extern bool (*kvm_mips_is_error_pfn)(kvm_pfn_t pfn);
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	u64 remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 wait_exits;
-	u32 cache_exits;
-	u32 signal_exits;
-	u32 int_exits;
-	u32 cop_unusable_exits;
-	u32 tlbmod_exits;
-	u32 tlbmiss_ld_exits;
-	u32 tlbmiss_st_exits;
-	u32 addrerr_st_exits;
-	u32 addrerr_ld_exits;
-	u32 syscall_exits;
-	u32 resvd_inst_exits;
-	u32 break_inst_exits;
-	u32 trap_inst_exits;
-	u32 msa_fpe_exits;
-	u32 fpe_exits;
-	u32 msa_disabled_exits;
-	u32 flush_dcache_exits;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
+	u64 wait_exits;
+	u64 cache_exits;
+	u64 signal_exits;
+	u64 int_exits;
+	u64 cop_unusable_exits;
+	u64 tlbmod_exits;
+	u64 tlbmiss_ld_exits;
+	u64 tlbmiss_st_exits;
+	u64 addrerr_st_exits;
+	u64 addrerr_ld_exits;
+	u64 syscall_exits;
+	u64 resvd_inst_exits;
+	u64 break_inst_exits;
+	u64 trap_inst_exits;
+	u64 msa_fpe_exits;
+	u64 fpe_exits;
+	u64 msa_disabled_exits;
+	u64 flush_dcache_exits;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
 };
 
 enum kvm_mips_exit_types {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 610f393..5c52a9f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -95,41 +95,41 @@ struct kvmppc_vcpu_book3s;
 struct kvmppc_book3s_shadow_vcpu;
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	u64 remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 sum_exits;
-	u32 mmio_exits;
-	u32 signal_exits;
-	u32 light_exits;
+	u64 sum_exits;
+	u64 mmio_exits;
+	u64 signal_exits;
+	u64 light_exits;
 	/* Account for special types of light exits: */
-	u32 itlb_real_miss_exits;
-	u32 itlb_virt_miss_exits;
-	u32 dtlb_real_miss_exits;
-	u32 dtlb_virt_miss_exits;
-	u32 syscall_exits;
-	u32 isi_exits;
-	u32 dsi_exits;
-	u32 emulated_inst_exits;
-	u32 dec_exits;
-	u32 ext_intr_exits;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 dbell_exits;
-	u32 gdbell_exits;
-	u32 ld;
-	u32 st;
+	u64 itlb_real_miss_exits;
+	u64 itlb_virt_miss_exits;
+	u64 dtlb_real_miss_exits;
+	u64 dtlb_virt_miss_exits;
+	u64 syscall_exits;
+	u64 isi_exits;
+	u64 dsi_exits;
+	u64 emulated_inst_exits;
+	u64 dec_exits;
+	u64 ext_intr_exits;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 dbell_exits;
+	u64 gdbell_exits;
+	u64 ld;
+	u64 st;
 #ifdef CONFIG_PPC_BOOK3S
-	u32 pf_storage;
-	u32 pf_instruc;
-	u32 sp_storage;
-	u32 sp_instruc;
-	u32 queue_intr;
-	u32 ld_slow;
-	u32 st_slow;
+	u64 pf_storage;
+	u64 pf_instruc;
+	u64 sp_storage;
+	u64 sp_instruc;
+	u64 queue_intr;
+	u64 ld_slow;
+	u64 st_slow;
 #endif
 };
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index ac82e8e..ae127b4 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -238,69 +238,69 @@ struct sie_page {
 } __packed;
 
 struct kvm_vcpu_stat {
-	u32 exit_userspace;
-	u32 exit_null;
-	u32 exit_external_request;
-	u32 exit_external_interrupt;
-	u32 exit_stop_request;
-	u32 exit_validity;
-	u32 exit_instruction;
-	u32 exit_pei;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 instruction_lctl;
-	u32 instruction_lctlg;
-	u32 instruction_stctl;
-	u32 instruction_stctg;
-	u32 exit_program_interruption;
-	u32 exit_instr_and_program;
-	u32 deliver_external_call;
-	u32 deliver_emergency_signal;
-	u32 deliver_service_signal;
-	u32 deliver_virtio_interrupt;
-	u32 deliver_stop_signal;
-	u32 deliver_prefix_signal;
-	u32 deliver_restart_signal;
-	u32 deliver_program_int;
-	u32 deliver_io_int;
-	u32 exit_wait_state;
-	u32 instruction_pfmf;
-	u32 instruction_stidp;
-	u32 instruction_spx;
-	u32 instruction_stpx;
-	u32 instruction_stap;
-	u32 instruction_storage_key;
-	u32 instruction_ipte_interlock;
-	u32 instruction_stsch;
-	u32 instruction_chsc;
-	u32 instruction_stsi;
-	u32 instruction_stfl;
-	u32 instruction_tprot;
-	u32 instruction_essa;
-	u32 instruction_sigp_sense;
-	u32 instruction_sigp_sense_running;
-	u32 instruction_sigp_external_call;
-	u32 instruction_sigp_emergency;
-	u32 instruction_sigp_cond_emergency;
-	u32 instruction_sigp_start;
-	u32 instruction_sigp_stop;
-	u32 instruction_sigp_stop_store_status;
-	u32 instruction_sigp_store_status;
-	u32 instruction_sigp_store_adtl_status;
-	u32 instruction_sigp_arch;
-	u32 instruction_sigp_prefix;
-	u32 instruction_sigp_restart;
-	u32 instruction_sigp_init_cpu_reset;
-	u32 instruction_sigp_cpu_reset;
-	u32 instruction_sigp_unknown;
-	u32 diagnose_10;
-	u32 diagnose_44;
-	u32 diagnose_9c;
-	u32 diagnose_258;
-	u32 diagnose_308;
-	u32 diagnose_500;
+	u64 exit_userspace;
+	u64 exit_null;
+	u64 exit_external_request;
+	u64 exit_external_interrupt;
+	u64 exit_stop_request;
+	u64 exit_validity;
+	u64 exit_instruction;
+	u64 exit_pei;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 instruction_lctl;
+	u64 instruction_lctlg;
+	u64 instruction_stctl;
+	u64 instruction_stctg;
+	u64 exit_program_interruption;
+	u64 exit_instr_and_program;
+	u64 deliver_external_call;
+	u64 deliver_emergency_signal;
+	u64 deliver_service_signal;
+	u64 deliver_virtio_interrupt;
+	u64 deliver_stop_signal;
+	u64 deliver_prefix_signal;
+	u64 deliver_restart_signal;
+	u64 deliver_program_int;
+	u64 deliver_io_int;
+	u64 exit_wait_state;
+	u64 instruction_pfmf;
+	u64 instruction_stidp;
+	u64 instruction_spx;
+	u64 instruction_stpx;
+	u64 instruction_stap;
+	u64 instruction_storage_key;
+	u64 instruction_ipte_interlock;
+	u64 instruction_stsch;
+	u64 instruction_chsc;
+	u64 instruction_stsi;
+	u64 instruction_stfl;
+	u64 instruction_tprot;
+	u64 instruction_essa;
+	u64 instruction_sigp_sense;
+	u64 instruction_sigp_sense_running;
+	u64 instruction_sigp_external_call;
+	u64 instruction_sigp_emergency;
+	u64 instruction_sigp_cond_emergency;
+	u64 instruction_sigp_start;
+	u64 instruction_sigp_stop;
+	u64 instruction_sigp_stop_store_status;
+	u64 instruction_sigp_store_status;
+	u64 instruction_sigp_store_adtl_status;
+	u64 instruction_sigp_arch;
+	u64 instruction_sigp_prefix;
+	u64 instruction_sigp_restart;
+	u64 instruction_sigp_init_cpu_reset;
+	u64 instruction_sigp_cpu_reset;
+	u64 instruction_sigp_unknown;
+	u64 diagnose_10;
+	u64 diagnose_44;
+	u64 diagnose_9c;
+	u64 diagnose_258;
+	u64 diagnose_308;
+	u64 diagnose_500;
 };
 
 #define PGM_OPERATION			0x01
@@ -563,7 +563,7 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	u64 remote_tlb_flush;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 69e62862..7322f50 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -782,45 +782,45 @@ struct kvm_arch {
 };
 
 struct kvm_vm_stat {
-	u32 mmu_shadow_zapped;
-	u32 mmu_pte_write;
-	u32 mmu_pte_updated;
-	u32 mmu_pde_zapped;
-	u32 mmu_flooded;
-	u32 mmu_recycled;
-	u32 mmu_cache_miss;
-	u32 mmu_unsync;
-	u32 remote_tlb_flush;
-	u32 lpages;
+	u64 mmu_shadow_zapped;
+	u64 mmu_pte_write;
+	u64 mmu_pte_updated;
+	u64 mmu_pde_zapped;
+	u64 mmu_flooded;
+	u64 mmu_recycled;
+	u64 mmu_cache_miss;
+	u64 mmu_unsync;
+	u64 remote_tlb_flush;
+	u64 lpages;
 };
 
 struct kvm_vcpu_stat {
-	u32 pf_fixed;
-	u32 pf_guest;
-	u32 tlb_flush;
-	u32 invlpg;
-
-	u32 exits;
-	u32 io_exits;
-	u32 mmio_exits;
-	u32 signal_exits;
-	u32 irq_window_exits;
-	u32 nmi_window_exits;
-	u32 halt_exits;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 request_irq_exits;
-	u32 irq_exits;
-	u32 host_state_reload;
-	u32 efer_reload;
-	u32 fpu_reload;
-	u32 insn_emulation;
-	u32 insn_emulation_fail;
-	u32 hypercalls;
-	u32 irq_injections;
-	u32 nmi_injections;
+	u64 pf_fixed;
+	u64 pf_guest;
+	u64 tlb_flush;
+	u64 invlpg;
+
+	u64 exits;
+	u64 io_exits;
+	u64 mmio_exits;
+	u64 signal_exits;
+	u64 irq_window_exits;
+	u64 nmi_window_exits;
+	u64 halt_exits;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 request_irq_exits;
+	u64 irq_exits;
+	u64 host_state_reload;
+	u64 efer_reload;
+	u64 fpu_reload;
+	u64 insn_emulation;
+	u64 insn_emulation_fail;
+	u64 hypercalls;
+	u64 irq_injections;
+	u64 nmi_injections;
 };
 
 struct x86_instruction_info;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 48bd520..d9d7e41 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3531,7 +3531,7 @@ static int vm_stat_get_per_vm(void *data, u64 *val)
 {
 	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
 
-	*val = *(u32 *)((void *)stat_data->kvm + stat_data->offset);
+	*val = *(u64 *)((void *)stat_data->kvm + stat_data->offset);
 
 	return 0;
 }
@@ -3561,7 +3561,7 @@ static int vcpu_stat_get_per_vm(void *data, u64 *val)
 	*val = 0;
 
 	kvm_for_each_vcpu(i, vcpu, stat_data->kvm)
-		*val += *(u32 *)((void *)vcpu + stat_data->offset);
+		*val += *(u64 *)((void *)vcpu + stat_data->offset);
 
 	return 0;
 }
@@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
 };
 
 static const struct file_operations *stat_fops_per_vm[] = {
-	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
-	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
+	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
+	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
 };
 
 static int vm_stat_get(void *_offset, u64 *val)
@@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
 
 static const struct file_operations *stat_fops[] = {
-	[KVM_STAT_VCPU] = &vcpu_stat_fops,
-	[KVM_STAT_VM]   = &vm_stat_fops,
+	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
+	[KVM_STAT_VM]		= &vm_stat_fops,
 };
 
 static int kvm_init_debug(void)
-- 
2.5.5

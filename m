From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] KVM: s390: add vcpu stat counters for many instruction
Date: Wed, 24 Jan 2018 16:50:54 +0100
Message-ID: <20180124155054.9477-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The overall instruction counter is larger than the sum of the
single counters. We should try to catch all instruction handlers
to make this match the summary counter.
Let us add sck,tb,sske,iske,rrbe,tb,tpi,tsch,lpsw,pswe....
and remove other unused ones.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 21 +++++++++++++++++----
 arch/s390/kvm/diag.c             |  1 +
 arch/s390/kvm/kvm-s390.c         | 21 +++++++++++++++++----
 arch/s390/kvm/priv.c             | 32 ++++++++++++++++++++++++++++++--
 4 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e16a9f2a44ad6..029e8144c6ecc 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -2,7 +2,7 @@
 /*
  * definition for kernel virtual machines on s390
  *
- * Copyright IBM Corp. 2008, 2009
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
@@ -316,18 +316,30 @@ struct kvm_vcpu_stat {
 	u64 deliver_program_int;
 	u64 deliver_io_int;
 	u64 exit_wait_state;
+	u64 instruction_epsw;
+	u64 instruction_gs;
+	u64 instruction_io_other;
+	u64 instruction_lpsw;
+	u64 instruction_lpswe;
 	u64 instruction_pfmf;
+	u64 instruction_ptff;
+	u64 instruction_sck;
+	u64 instruction_sckpf;
 	u64 instruction_stidp;
 	u64 instruction_spx;
 	u64 instruction_stpx;
 	u64 instruction_stap;
-	u64 instruction_storage_key;
+	u64 instruction_iske;
+	u64 instruction_ri;
+	u64 instruction_rrbe;
+	u64 instruction_sske;
 	u64 instruction_ipte_interlock;
-	u64 instruction_stsch;
-	u64 instruction_chsc;
 	u64 instruction_stsi;
 	u64 instruction_stfl;
+	u64 instruction_tb;
+	u64 instruction_tpi;
 	u64 instruction_tprot;
+	u64 instruction_tsch;
 	u64 instruction_sie;
 	u64 instruction_essa;
 	u64 instruction_sthyi;
@@ -353,6 +365,7 @@ struct kvm_vcpu_stat {
 	u64 diagnose_258;
 	u64 diagnose_308;
 	u64 diagnose_500;
+	u64 diagnose_other;
 };
 
 #define PGM_OPERATION			0x01
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 89aa114a2cbad..45634b3d2e0ae 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -257,6 +257,7 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 	case 0x500:
 		return __diag_virtio_hypercall(vcpu);
 	default:
+		vcpu->stat.diagnose_other++;
 		return -EOPNOTSUPP;
 	}
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ce8ea8b94478e..8a3a1d50ef99d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2,7 +2,7 @@
 /*
  * hosting IBM Z kernel virtual machines (s390x)
  *
- * Copyright IBM Corp. 2008, 2017
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -87,19 +87,31 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
 	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
 	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
+	{ "instruction_epsw", VCPU_STAT(instruction_epsw) },
+	{ "instruction_gs", VCPU_STAT(instruction_gs) },
+	{ "instruction_io_other", VCPU_STAT(instruction_io_other) },
+	{ "instruction_lpsw", VCPU_STAT(instruction_lpsw) },
+	{ "instruction_lpswe", VCPU_STAT(instruction_lpswe) },
 	{ "instruction_pfmf", VCPU_STAT(instruction_pfmf) },
+	{ "instruction_ptff", VCPU_STAT(instruction_ptff) },
 	{ "instruction_stidp", VCPU_STAT(instruction_stidp) },
+	{ "instruction_sck", VCPU_STAT(instruction_sck) },
+	{ "instruction_sckpf", VCPU_STAT(instruction_sckpf) },
 	{ "instruction_spx", VCPU_STAT(instruction_spx) },
 	{ "instruction_stpx", VCPU_STAT(instruction_stpx) },
 	{ "instruction_stap", VCPU_STAT(instruction_stap) },
-	{ "instruction_storage_key", VCPU_STAT(instruction_storage_key) },
+	{ "instruction_iske", VCPU_STAT(instruction_iske) },
+	{ "instruction_ri", VCPU_STAT(instruction_ri) },
+	{ "instruction_rrbe", VCPU_STAT(instruction_rrbe) },
+	{ "instruction_sske", VCPU_STAT(instruction_sske) },
 	{ "instruction_ipte_interlock", VCPU_STAT(instruction_ipte_interlock) },
-	{ "instruction_stsch", VCPU_STAT(instruction_stsch) },
-	{ "instruction_chsc", VCPU_STAT(instruction_chsc) },
 	{ "instruction_essa", VCPU_STAT(instruction_essa) },
 	{ "instruction_stsi", VCPU_STAT(instruction_stsi) },
 	{ "instruction_stfl", VCPU_STAT(instruction_stfl) },
+	{ "instruction_tb", VCPU_STAT(instruction_tb) },
+	{ "instruction_tpi", VCPU_STAT(instruction_tpi) },
 	{ "instruction_tprot", VCPU_STAT(instruction_tprot) },
+	{ "instruction_tsch", VCPU_STAT(instruction_tsch) },
 	{ "instruction_sthyi", VCPU_STAT(instruction_sthyi) },
 	{ "instruction_sie", VCPU_STAT(instruction_sie) },
 	{ "instruction_sigp_sense", VCPU_STAT(instruction_sigp_sense) },
@@ -124,6 +136,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
 	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
 	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
+	{ "instruction_diag_other", VCPU_STAT(diagnose_other) },
 	{ NULL }
 };
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 572496c688cc0..dea0217922d6f 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -2,7 +2,7 @@
 /*
  * handling privileged instructions
  *
- * Copyright IBM Corp. 2008, 2013
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -34,6 +34,8 @@
 
 static int handle_ri(struct kvm_vcpu *vcpu)
 {
+	vcpu->stat.instruction_ri++;
+
 	if (test_kvm_facility(vcpu->kvm, 64)) {
 		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: RI (lazy)");
 		vcpu->arch.sie_block->ecb3 |= ECB3_RI;
@@ -53,6 +55,8 @@ int kvm_s390_handle_aa(struct kvm_vcpu *vcpu)
 
 static int handle_gs(struct kvm_vcpu *vcpu)
 {
+	vcpu->stat.instruction_gs++;
+
 	if (test_kvm_facility(vcpu->kvm, 133)) {
 		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: GS (lazy)");
 		preempt_disable();
@@ -85,6 +89,8 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 	u8 ar;
 	u64 op2, val;
 
+	vcpu->stat.instruction_sck++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -222,7 +228,6 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
-	vcpu->stat.instruction_storage_key++;
 	rc = kvm_s390_skey_check_enable(vcpu);
 	if (rc)
 		return rc;
@@ -242,6 +247,8 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 	int reg1, reg2;
 	int rc;
 
+	vcpu->stat.instruction_iske++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -274,6 +281,8 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
 	int reg1, reg2;
 	int rc;
 
+	vcpu->stat.instruction_rrbe++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -312,6 +321,8 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 	int reg1, reg2;
 	int rc;
 
+	vcpu->stat.instruction_sske++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -392,6 +403,8 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 	gpa_t addr;
 	int reg2;
 
+	vcpu->stat.instruction_tb++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -424,6 +437,8 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	u64 addr;
 	u8 ar;
 
+	vcpu->stat.instruction_tpi++;
+
 	addr = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (addr & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -484,6 +499,8 @@ static int handle_tsch(struct kvm_vcpu *vcpu)
 	struct kvm_s390_interrupt_info *inti = NULL;
 	const u64 isc_mask = 0xffUL << 24; /* all iscs set */
 
+	vcpu->stat.instruction_tsch++;
+
 	/* a valid schid has at least one bit set */
 	if (vcpu->run->s.regs.gprs[1])
 		inti = kvm_s390_get_io_int(vcpu->kvm, isc_mask,
@@ -527,6 +544,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.sie_block->ipa == 0xb235)
 			return handle_tsch(vcpu);
 		/* Handle in userspace. */
+		vcpu->stat.instruction_io_other++;
 		return -EOPNOTSUPP;
 	} else {
 		/*
@@ -592,6 +610,8 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	int rc;
 	u8 ar;
 
+	vcpu->stat.instruction_lpsw++;
+
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -619,6 +639,8 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	int rc;
 	u8 ar;
 
+	vcpu->stat.instruction_lpswe++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -828,6 +850,8 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 {
 	int reg1, reg2;
 
+	vcpu->stat.instruction_epsw++;
+
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
 	/* This basically extracts the mask half of the psw. */
@@ -1332,6 +1356,8 @@ static int handle_sckpf(struct kvm_vcpu *vcpu)
 {
 	u32 value;
 
+	vcpu->stat.instruction_sckpf++;
+
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -1347,6 +1373,8 @@ static int handle_sckpf(struct kvm_vcpu *vcpu)
 
 static int handle_ptff(struct kvm_vcpu *vcpu)
 {
+	vcpu->stat.instruction_ptff++;
+
 	/* we don't emulate any control instructions yet */
 	kvm_s390_set_psw_cc(vcpu, 3);
 	return 0;
-- 
2.13.4

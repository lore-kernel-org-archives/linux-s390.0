From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/11] KVM: s390: Guest's memory access functions get access registers
Date: Wed, 18 Mar 2015 12:44:02 +0100
Message-ID: <1426679049-37696-5-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

In access register mode, the write_guest() read_guest() and other
functions will invoke the access register translation, which
requires an ar, designated by one of the instruction fields.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/diag.c      |  4 +--
 arch/s390/kvm/gaccess.c   |  4 +--
 arch/s390/kvm/gaccess.h   | 14 +++++----
 arch/s390/kvm/intercept.c |  4 +--
 arch/s390/kvm/kvm-s390.c  |  2 +-
 arch/s390/kvm/kvm-s390.h  | 25 +++++++++++++---
 arch/s390/kvm/priv.c      | 72 ++++++++++++++++++++++++++++-------------------
 arch/s390/kvm/sigp.c      |  4 +--
 8 files changed, 81 insertions(+), 48 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 9254aff..89140dd 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -77,7 +77,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 
 	if (vcpu->run->s.regs.gprs[rx] & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], &parm, sizeof(parm));
+	rc = read_guest(vcpu, vcpu->run->s.regs.gprs[rx], rx, &parm, sizeof(parm));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
@@ -230,7 +230,7 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
-	int code = kvm_s390_get_base_disp_rs(vcpu) & 0xffff;
+	int code = kvm_s390_get_base_disp_rs(vcpu, NULL) & 0xffff;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c230904..494131e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -578,7 +578,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 	return 0;
 }
 
-int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 		 unsigned long len, int write)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -652,7 +652,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  * Note: The IPTE lock is not taken during this function, so the caller
  * has to take care of this.
  */
-int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
+int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 			    unsigned long *gpa, int write)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 20de77e..7c2866b 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -156,9 +156,9 @@ int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 }
 
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
-			    unsigned long *gpa, int write);
+			    ar_t ar, unsigned long *gpa, int write);
 
-int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 		 unsigned long len, int write);
 
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
@@ -168,6 +168,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  * write_guest - copy data from kernel space to guest space
  * @vcpu: virtual cpu
  * @ga: guest address
+ * @ar: access register
  * @data: source address in kernel space
  * @len: number of bytes to copy
  *
@@ -210,16 +211,17 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  *	 if data has been changed in guest space in case of an exception.
  */
 static inline __must_check
-int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 		unsigned long len)
 {
-	return access_guest(vcpu, ga, data, len, 1);
+	return access_guest(vcpu, ga, ar, data, len, 1);
 }
 
 /**
  * read_guest - copy data from guest space to kernel space
  * @vcpu: virtual cpu
  * @ga: guest address
+ * @ar: access register
  * @data: destination address in kernel space
  * @len: number of bytes to copy
  *
@@ -229,10 +231,10 @@ int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
  * data will be copied from guest space to kernel space.
  */
 static inline __must_check
-int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
+int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 	       unsigned long len)
 {
-	return access_guest(vcpu, ga, data, len, 0);
+	return access_guest(vcpu, ga, ar, data, len, 0);
 }
 
 /**
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 08ae10a..9e3779e 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -320,7 +320,7 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 
 	/* Make sure that the source is paged-in */
 	rc = guest_translate_address(vcpu, vcpu->run->s.regs.gprs[reg2],
-				     &srcaddr, 0);
+				     reg2, &srcaddr, 0);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	rc = kvm_arch_fault_in_page(vcpu, srcaddr, 0);
@@ -329,7 +329,7 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 
 	/* Make sure that the destination is paged-in */
 	rc = guest_translate_address(vcpu, vcpu->run->s.regs.gprs[reg1],
-				     &dstaddr, 1);
+				     reg1, &dstaddr, 1);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	rc = kvm_arch_fault_in_page(vcpu, dstaddr, 1);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4075acb..610e90a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1776,7 +1776,7 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 	 * to look up the current opcode to get the length of the instruction
 	 * to be able to forward the PSW.
 	 */
-	rc = read_guest(vcpu, psw->addr, &opcode, 1);
+	rc = read_guest(vcpu, psw->addr, 0, &opcode, 1);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	psw->addr = __rewind_psw(*psw, -insn_length(opcode));
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 83f32a1..5d54191 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -70,16 +70,22 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 	kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 }
 
-static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu)
+typedef u8 __bitwise ar_t;
+
+static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu, ar_t *ar)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
 	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 
+	if (ar)
+		*ar = base2;
+
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
 
 static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
-					      u64 *address1, u64 *address2)
+					      u64 *address1, u64 *address2,
+					      ar_t *ar_b1, ar_t *ar_b2)
 {
 	u32 base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
 	u32 disp1 = (vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16;
@@ -88,6 +94,11 @@ static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
 
 	*address1 = (base1 ? vcpu->run->s.regs.gprs[base1] : 0) + disp1;
 	*address2 = (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
+
+	if (ar_b1)
+		*ar_b1 = base1;
+	if (ar_b2)
+		*ar_b2 = base2;
 }
 
 static inline void kvm_s390_get_regs_rre(struct kvm_vcpu *vcpu, int *r1, int *r2)
@@ -98,7 +109,7 @@ static inline void kvm_s390_get_regs_rre(struct kvm_vcpu *vcpu, int *r1, int *r2
 		*r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
 }
 
-static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu)
+static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu, ar_t *ar)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
 	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
@@ -107,14 +118,20 @@ static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu)
 	if (disp2 & 0x80000)
 		disp2+=0xfff00000;
 
+	if (ar)
+		*ar = base2;
+
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + (long)(int)disp2;
 }
 
-static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu)
+static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu, ar_t *ar)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
 	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
 
+	if (ar)
+		*ar = base2;
+
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 5f26425..f4fe02e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -36,15 +36,16 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu *cpup;
 	s64 hostclk, val;
 	int i, rc;
+	ar_t ar;
 	u64 op2;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	op2 = kvm_s390_get_base_disp_s(vcpu);
+	op2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (op2 & 7)	/* Operand must be on a doubleword boundary */
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, op2, &val, sizeof(val));
+	rc = read_guest(vcpu, op2, ar, &val, sizeof(val));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
@@ -68,20 +69,21 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	u64 operand2;
 	u32 address;
 	int rc;
+	ar_t ar;
 
 	vcpu->stat.instruction_spx++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	operand2 = kvm_s390_get_base_disp_s(vcpu);
+	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 
 	/* must be word boundary */
 	if (operand2 & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* get the value */
-	rc = read_guest(vcpu, operand2, &address, sizeof(address));
+	rc = read_guest(vcpu, operand2, ar, &address, sizeof(address));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
@@ -107,13 +109,14 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	u64 operand2;
 	u32 address;
 	int rc;
+	ar_t ar;
 
 	vcpu->stat.instruction_stpx++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	operand2 = kvm_s390_get_base_disp_s(vcpu);
+	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 
 	/* must be word boundary */
 	if (operand2 & 3)
@@ -122,7 +125,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	address = kvm_s390_get_prefix(vcpu);
 
 	/* get the value */
-	rc = write_guest(vcpu, operand2, &address, sizeof(address));
+	rc = write_guest(vcpu, operand2, ar, &address, sizeof(address));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
@@ -136,18 +139,19 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	u16 vcpu_id = vcpu->vcpu_id;
 	u64 ga;
 	int rc;
+	ar_t ar;
 
 	vcpu->stat.instruction_stap++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	ga = kvm_s390_get_base_disp_s(vcpu);
+	ga = kvm_s390_get_base_disp_s(vcpu, &ar);
 
 	if (ga & 1)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	rc = write_guest(vcpu, ga, &vcpu_id, sizeof(vcpu_id));
+	rc = write_guest(vcpu, ga, ar, &vcpu_id, sizeof(vcpu_id));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
@@ -231,8 +235,9 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	u32 tpi_data[3];
 	int rc;
 	u64 addr;
+	ar_t ar;
 
-	addr = kvm_s390_get_base_disp_s(vcpu);
+	addr = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (addr & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
@@ -251,7 +256,7 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 		 * provided area.
 		 */
 		len = sizeof(tpi_data) - 4;
-		rc = write_guest(vcpu, addr, &tpi_data, len);
+		rc = write_guest(vcpu, addr, ar, &tpi_data, len);
 		if (rc) {
 			rc = kvm_s390_inject_prog_cond(vcpu, rc);
 			goto reinject_interrupt;
@@ -395,15 +400,16 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	psw_compat_t new_psw;
 	u64 addr;
 	int rc;
+	ar_t ar;
 
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	addr = kvm_s390_get_base_disp_s(vcpu);
+	addr = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	rc = read_guest(vcpu, addr, &new_psw, sizeof(new_psw));
+	rc = read_guest(vcpu, addr, ar, &new_psw, sizeof(new_psw));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	if (!(new_psw.mask & PSW32_MASK_BASE))
@@ -421,14 +427,15 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	psw_t new_psw;
 	u64 addr;
 	int rc;
+	ar_t ar;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	addr = kvm_s390_get_base_disp_s(vcpu);
+	addr = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (addr & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, addr, &new_psw, sizeof(new_psw));
+	rc = read_guest(vcpu, addr, ar, &new_psw, sizeof(new_psw));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	vcpu->arch.sie_block->gpsw = new_psw;
@@ -442,18 +449,19 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 	u64 stidp_data = vcpu->arch.stidp_data;
 	u64 operand2;
 	int rc;
+	ar_t ar;
 
 	vcpu->stat.instruction_stidp++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	operand2 = kvm_s390_get_base_disp_s(vcpu);
+	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 
 	if (operand2 & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	rc = write_guest(vcpu, operand2, &stidp_data, sizeof(stidp_data));
+	rc = write_guest(vcpu, operand2, ar, &stidp_data, sizeof(stidp_data));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
@@ -496,6 +504,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	unsigned long mem = 0;
 	u64 operand2;
 	int rc = 0;
+	ar_t ar;
 
 	vcpu->stat.instruction_stsi++;
 	VCPU_EVENT(vcpu, 4, "stsi: fc: %x sel1: %x sel2: %x", fc, sel1, sel2);
@@ -518,7 +527,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	operand2 = kvm_s390_get_base_disp_s(vcpu);
+	operand2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 
 	if (operand2 & 0xfff)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -542,7 +551,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		break;
 	}
 
-	rc = write_guest(vcpu, operand2, (void *)mem, PAGE_SIZE);
+	rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
 	if (rc) {
 		rc = kvm_s390_inject_prog_cond(vcpu, rc);
 		goto out;
@@ -786,13 +795,14 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u32 ctl_array[16];
 	u64 ga;
+	ar_t ar;
 
 	vcpu->stat.instruction_lctl++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	ga = kvm_s390_get_base_disp_rs(vcpu);
+	ga = kvm_s390_get_base_disp_rs(vcpu, &ar);
 
 	if (ga & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -801,7 +811,7 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, ga);
 
 	nr_regs = ((reg3 - reg1) & 0xf) + 1;
-	rc = read_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u32));
+	rc = read_guest(vcpu, ga, ar, ctl_array, nr_regs * sizeof(u32));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	reg = reg1;
@@ -824,13 +834,14 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u32 ctl_array[16];
 	u64 ga;
+	ar_t ar;
 
 	vcpu->stat.instruction_stctl++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	ga = kvm_s390_get_base_disp_rs(vcpu);
+	ga = kvm_s390_get_base_disp_rs(vcpu, &ar);
 
 	if (ga & 3)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -846,7 +857,7 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
 			break;
 		reg = (reg + 1) % 16;
 	} while (1);
-	rc = write_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u32));
+	rc = write_guest(vcpu, ga, ar, ctl_array, nr_regs * sizeof(u32));
 	return rc ? kvm_s390_inject_prog_cond(vcpu, rc) : 0;
 }
 
@@ -857,13 +868,14 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u64 ctl_array[16];
 	u64 ga;
+	ar_t ar;
 
 	vcpu->stat.instruction_lctlg++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	ga = kvm_s390_get_base_disp_rsy(vcpu);
+	ga = kvm_s390_get_base_disp_rsy(vcpu, &ar);
 
 	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -872,7 +884,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, ga);
 
 	nr_regs = ((reg3 - reg1) & 0xf) + 1;
-	rc = read_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u64));
+	rc = read_guest(vcpu, ga, ar, ctl_array, nr_regs * sizeof(u64));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 	reg = reg1;
@@ -894,13 +906,14 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u64 ctl_array[16];
 	u64 ga;
+	ar_t ar;
 
 	vcpu->stat.instruction_stctg++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	ga = kvm_s390_get_base_disp_rsy(vcpu);
+	ga = kvm_s390_get_base_disp_rsy(vcpu, &ar);
 
 	if (ga & 7)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
@@ -916,7 +929,7 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 			break;
 		reg = (reg + 1) % 16;
 	} while (1);
-	rc = write_guest(vcpu, ga, ctl_array, nr_regs * sizeof(u64));
+	rc = write_guest(vcpu, ga, ar, ctl_array, nr_regs * sizeof(u64));
 	return rc ? kvm_s390_inject_prog_cond(vcpu, rc) : 0;
 }
 
@@ -941,13 +954,14 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 	unsigned long hva, gpa;
 	int ret = 0, cc = 0;
 	bool writable;
+	ar_t ar;
 
 	vcpu->stat.instruction_tprot++;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	kvm_s390_get_base_disp_sse(vcpu, &address1, &address2);
+	kvm_s390_get_base_disp_sse(vcpu, &address1, &address2, &ar, NULL);
 
 	/* we only handle the Linux memory detection case:
 	 * access key == 0
@@ -956,11 +970,11 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
 		ipte_lock(vcpu);
-	ret = guest_translate_address(vcpu, address1, &gpa, 1);
+	ret = guest_translate_address(vcpu, address1, ar, &gpa, 1);
 	if (ret == PGM_PROTECTION) {
 		/* Write protected? Try again with read-only... */
 		cc = 1;
-		ret = guest_translate_address(vcpu, address1, &gpa, 0);
+		ret = guest_translate_address(vcpu, address1, ar, &gpa, 0);
 	}
 	if (ret) {
 		if (ret == PGM_ADDRESSING || ret == PGM_TRANSLATION_SPEC) {
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 755a733..72e58bd 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -434,7 +434,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	order_code = kvm_s390_get_base_disp_rs(vcpu);
+	order_code = kvm_s390_get_base_disp_rs(vcpu, NULL);
 	if (handle_sigp_order_in_user_space(vcpu, order_code))
 		return -EOPNOTSUPP;
 
@@ -476,7 +476,7 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu)
 	int r3 = vcpu->arch.sie_block->ipa & 0x000f;
 	u16 cpu_addr = vcpu->run->s.regs.gprs[r3];
 	struct kvm_vcpu *dest_vcpu;
-	u8 order_code = kvm_s390_get_base_disp_rs(vcpu);
+	u8 order_code = kvm_s390_get_base_disp_rs(vcpu, NULL);
 
 	trace_kvm_s390_handle_sigp_pei(vcpu, order_code, cpu_addr);
 
-- 
2.3.0

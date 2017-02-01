From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/12] KVM: s390: Get rid of ar_t
Date: Wed,  1 Feb 2017 12:38:07 +0100
Message-ID: <1485949094-138708-6-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

sparse with __CHECK_ENDIAN__ shows that ar_t was never properly
used across KVM on s390. We can now:
- fix all places
- do not make ar_t special
Since ar_t is just used as a register number (no endianness issues
for u8), and all other register numbers are also just plain int
variables, let's just use u8, which matches the __u8 in the userspace
ABI for the memop ioctl.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/gaccess.c  | 14 +++++++-------
 arch/s390/kvm/gaccess.h  | 10 +++++-----
 arch/s390/kvm/kvm-s390.h | 10 ++++------
 arch/s390/kvm/priv.c     | 30 +++++++++++++++---------------
 4 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6e94705..4492c93 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -373,7 +373,7 @@ void ipte_unlock(struct kvm_vcpu *vcpu)
 		ipte_unlock_simple(vcpu);
 }
 
-static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, ar_t ar,
+static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, u8 ar,
 			  enum gacc_mode mode)
 {
 	union alet alet;
@@ -487,7 +487,7 @@ enum prot_type {
 };
 
 static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
-		     ar_t ar, enum gacc_mode mode, enum prot_type prot)
+		     u8 ar, enum gacc_mode mode, enum prot_type prot)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	struct trans_exc_code_bits *tec;
@@ -545,7 +545,7 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 }
 
 static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
-			 unsigned long ga, ar_t ar, enum gacc_mode mode)
+			 unsigned long ga, u8 ar, enum gacc_mode mode)
 {
 	int rc;
 	struct psw_bits psw = psw_bits(vcpu->arch.sie_block->gpsw);
@@ -777,7 +777,7 @@ static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar,
+static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 			    unsigned long *pages, unsigned long nr_pages,
 			    const union asce asce, enum gacc_mode mode)
 {
@@ -809,7 +809,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar,
 	return 0;
 }
 
-int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
+int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		 unsigned long len, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -883,7 +883,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  * Note: The IPTE lock is not taken during this function, so the caller
  * has to take care of this.
  */
-int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
+int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 			    unsigned long *gpa, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
@@ -916,7 +916,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 /**
  * check_gva_range - test a range of guest virtual addresses for accessibility
  */
-int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
+int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 		    unsigned long length, enum gacc_mode mode)
 {
 	unsigned long gpa;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 8756569..5c9cc18 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -162,11 +162,11 @@ enum gacc_mode {
 };
 
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
-			    ar_t ar, unsigned long *gpa, enum gacc_mode mode);
-int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
+			    u8 ar, unsigned long *gpa, enum gacc_mode mode);
+int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 		    unsigned long length, enum gacc_mode mode);
 
-int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
+int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		 unsigned long len, enum gacc_mode mode);
 
 int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
@@ -218,7 +218,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  *	 if data has been changed in guest space in case of an exception.
  */
 static inline __must_check
-int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
+int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 		unsigned long len)
 {
 	return access_guest(vcpu, ga, ar, data, len, GACC_STORE);
@@ -238,7 +238,7 @@ int write_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
  * data will be copied from guest space to kernel space.
  */
 static inline __must_check
-int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
+int read_guest(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar, void *data,
 	       unsigned long len)
 {
 	return access_guest(vcpu, ga, ar, data, len, GACC_FETCH);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 3a4e97f..22a0a7c 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -86,9 +86,7 @@ static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 	kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 }
 
-typedef u8 __bitwise ar_t;
-
-static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu, ar_t *ar)
+static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu, u8 *ar)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
 	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
@@ -101,7 +99,7 @@ static inline u64 kvm_s390_get_base_disp_s(struct kvm_vcpu *vcpu, ar_t *ar)
 
 static inline void kvm_s390_get_base_disp_sse(struct kvm_vcpu *vcpu,
 					      u64 *address1, u64 *address2,
-					      ar_t *ar_b1, ar_t *ar_b2)
+					      u8 *ar_b1, u8 *ar_b2)
 {
 	u32 base1 = (vcpu->arch.sie_block->ipb & 0xf0000000) >> 28;
 	u32 disp1 = (vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16;
@@ -125,7 +123,7 @@ static inline void kvm_s390_get_regs_rre(struct kvm_vcpu *vcpu, int *r1, int *r2
 		*r2 = (vcpu->arch.sie_block->ipb & 0x000f0000) >> 16;
 }
 
-static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu, ar_t *ar)
+static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu, u8 *ar)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
 	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
@@ -140,7 +138,7 @@ static inline u64 kvm_s390_get_base_disp_rsy(struct kvm_vcpu *vcpu, ar_t *ar)
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + (long)(int)disp2;
 }
 
-static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu, ar_t *ar)
+static inline u64 kvm_s390_get_base_disp_rs(struct kvm_vcpu *vcpu, u8 *ar)
 {
 	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
 	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index e184353..1ecc1cf 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -54,7 +54,7 @@ int kvm_s390_handle_aa(struct kvm_vcpu *vcpu)
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
 	int rc;
-	ar_t ar;
+	u8 ar;
 	u64 op2, val;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
@@ -79,7 +79,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	u64 operand2;
 	u32 address;
 	int rc;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_spx++;
 
@@ -117,7 +117,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	u64 operand2;
 	u32 address;
 	int rc;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_stpx++;
 
@@ -147,7 +147,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	u16 vcpu_id = vcpu->vcpu_id;
 	u64 ga;
 	int rc;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_stap++;
 
@@ -380,7 +380,7 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	u32 tpi_data[3];
 	int rc;
 	u64 addr;
-	ar_t ar;
+	u8 ar;
 
 	addr = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (addr & 3)
@@ -548,7 +548,7 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	psw_compat_t new_psw;
 	u64 addr;
 	int rc;
-	ar_t ar;
+	u8 ar;
 
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -575,7 +575,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	psw_t new_psw;
 	u64 addr;
 	int rc;
-	ar_t ar;
+	u8 ar;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -597,7 +597,7 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 	u64 stidp_data = vcpu->kvm->arch.model.cpuid;
 	u64 operand2;
 	int rc;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_stidp++;
 
@@ -644,7 +644,7 @@ static void handle_stsi_3_2_2(struct kvm_vcpu *vcpu, struct sysinfo_3_2_2 *mem)
 	ASCEBC(mem->vm[0].cpi, 16);
 }
 
-static void insert_stsi_usr_data(struct kvm_vcpu *vcpu, u64 addr, ar_t ar,
+static void insert_stsi_usr_data(struct kvm_vcpu *vcpu, u64 addr, u8 ar,
 				 u8 fc, u8 sel1, u16 sel2)
 {
 	vcpu->run->exit_reason = KVM_EXIT_S390_STSI;
@@ -663,7 +663,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	unsigned long mem = 0;
 	u64 operand2;
 	int rc = 0;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_stsi++;
 	VCPU_EVENT(vcpu, 3, "STSI: fc: %u sel1: %u sel2: %u", fc, sel1, sel2);
@@ -970,7 +970,7 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u32 ctl_array[16];
 	u64 ga;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_lctl++;
 
@@ -1009,7 +1009,7 @@ int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u32 ctl_array[16];
 	u64 ga;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_stctl++;
 
@@ -1043,7 +1043,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u64 ctl_array[16];
 	u64 ga;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_lctlg++;
 
@@ -1081,7 +1081,7 @@ static int handle_stctg(struct kvm_vcpu *vcpu)
 	int reg, rc, nr_regs;
 	u64 ctl_array[16];
 	u64 ga;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_stctg++;
 
@@ -1132,7 +1132,7 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 	unsigned long hva, gpa;
 	int ret = 0, cc = 0;
 	bool writable;
-	ar_t ar;
+	u8 ar;
 
 	vcpu->stat.instruction_tprot++;
 
-- 
2.7.4

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 52/52] KVM: s390: handle missing storage-key facility
Date: Tue, 14 Jun 2016 20:57:29 +0200
Message-ID: <1465930649-181383-53-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Without the storage-key facility, SIE won't interpret SSKE, ISKE and
RRBE for us. So let's add proper interception handlers that will be called
if lazy sske cannot be enabled.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/page.h    |   7 +-
 arch/s390/include/asm/pgtable.h |   1 +
 arch/s390/kvm/priv.c            | 150 +++++++++++++++++++++++++++++++++++++---
 arch/s390/mm/pgtable.c          |  37 ++++++++++
 4 files changed, 184 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 53eacbd..f874e7d5 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -109,13 +109,14 @@ static inline unsigned char page_get_storage_key(unsigned long addr)
 
 static inline int page_reset_referenced(unsigned long addr)
 {
-	unsigned int ipm;
+	int cc;
 
 	asm volatile(
 		"	rrbe	0,%1\n"
 		"	ipm	%0\n"
-		: "=d" (ipm) : "a" (addr) : "cc");
-	return !!(ipm & 0x20000000);
+		"	srl	%0,28\n"
+		: "=d" (cc) : "a" (addr) : "cc");
+	return cc;
 }
 
 /* Bits int the storage key */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2f6702e..9951e7e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -896,6 +896,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 int cond_set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			       unsigned char key, unsigned char *oldkey,
 			       bool nq, bool mr, bool mc);
+int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr);
 int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char *key);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 6745c2a..3db3be1 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -27,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/ptrace.h>
 #include <asm/compat.h>
+#include <asm/sclp.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
 #include "trace.h"
@@ -164,8 +165,7 @@ static int __skey_check_enable(struct kvm_vcpu *vcpu)
 	return rc;
 }
 
-
-static int handle_skey(struct kvm_vcpu *vcpu)
+static int try_handle_skey(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
@@ -173,12 +173,146 @@ static int handle_skey(struct kvm_vcpu *vcpu)
 	rc = __skey_check_enable(vcpu);
 	if (rc)
 		return rc;
-
+	if (sclp.has_skey) {
+		/* with storage-key facility, SIE interprets it for us */
+		kvm_s390_retry_instr(vcpu);
+		VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
+		return -EAGAIN;
+	}
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+	return 0;
+}
 
-	kvm_s390_retry_instr(vcpu);
-	VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
+static int handle_iske(struct kvm_vcpu *vcpu)
+{
+	unsigned long addr;
+	unsigned char key;
+	int reg1, reg2;
+	int rc;
+
+	rc = try_handle_skey(vcpu);
+	if (rc)
+		return rc != -EAGAIN ? rc : 0;
+
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+
+	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	addr = kvm_s390_logical_to_effective(vcpu, addr);
+	addr = kvm_s390_real_to_abs(vcpu, addr);
+	addr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(addr));
+	if (kvm_is_error_hva(addr))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+	down_read(&current->mm->mmap_sem);
+	rc = get_guest_storage_key(current->mm, addr, &key);
+	up_read(&current->mm->mmap_sem);
+	if (rc)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	vcpu->run->s.regs.gprs[reg1] &= ~0xff;
+	vcpu->run->s.regs.gprs[reg1] |= key;
+	return 0;
+}
+
+static int handle_rrbe(struct kvm_vcpu *vcpu)
+{
+	unsigned long addr;
+	int reg1, reg2;
+	int rc;
+
+	rc = try_handle_skey(vcpu);
+	if (rc)
+		return rc != -EAGAIN ? rc : 0;
+
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+
+	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	addr = kvm_s390_logical_to_effective(vcpu, addr);
+	addr = kvm_s390_real_to_abs(vcpu, addr);
+	addr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(addr));
+	if (kvm_is_error_hva(addr))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+	down_read(&current->mm->mmap_sem);
+	rc = reset_guest_reference_bit(current->mm, addr);
+	up_read(&current->mm->mmap_sem);
+	if (rc < 0)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+	kvm_s390_set_psw_cc(vcpu, rc);
+	return 0;
+}
+
+#define SSKE_NQ 0x8
+#define SSKE_MR 0x4
+#define SSKE_MC 0x2
+#define SSKE_MB 0x1
+static int handle_sske(struct kvm_vcpu *vcpu)
+{
+	unsigned char m3 = vcpu->arch.sie_block->ipb >> 28;
+	unsigned long start, end;
+	unsigned char key, oldkey;
+	int reg1, reg2;
+	int rc;
+
+	rc = try_handle_skey(vcpu);
+	if (rc)
+		return rc != -EAGAIN ? rc : 0;
+
+	if (!test_kvm_facility(vcpu->kvm, 8))
+		m3 &= ~SSKE_MB;
+	if (!test_kvm_facility(vcpu->kvm, 10))
+		m3 &= ~(SSKE_MC | SSKE_MR);
+	if (!test_kvm_facility(vcpu->kvm, 14))
+		m3 &= ~SSKE_NQ;
+
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+
+	key = vcpu->run->s.regs.gprs[reg1] & 0xfe;
+	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	start = kvm_s390_logical_to_effective(vcpu, start);
+	if (m3 & SSKE_MB) {
+		/* start already designates an absolute address */
+		end = (start + (1UL << 20)) & ~((1UL << 20) - 1);
+	} else {
+		start = kvm_s390_real_to_abs(vcpu, start);
+		end = start + PAGE_SIZE;
+	}
+
+	while (start != end) {
+		unsigned long addr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(start));
+
+		if (kvm_is_error_hva(addr))
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+		down_read(&current->mm->mmap_sem);
+		rc = cond_set_guest_storage_key(current->mm, addr, key, &oldkey,
+						m3 & SSKE_NQ, m3 & SSKE_MR,
+						m3 & SSKE_MC);
+		up_read(&current->mm->mmap_sem);
+		if (rc < 0)
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		start += PAGE_SIZE;
+	};
+
+	if (m3 & (SSKE_MC | SSKE_MR)) {
+		if (m3 & SSKE_MB) {
+			/* skey in reg1 is unpredictable */
+			kvm_s390_set_psw_cc(vcpu, 3);
+		} else {
+			kvm_s390_set_psw_cc(vcpu, rc);
+			vcpu->run->s.regs.gprs[reg1] &= ~0xff00UL;
+			vcpu->run->s.regs.gprs[reg1] |= (u64) oldkey << 8;
+		}
+	}
+	if (m3 & SSKE_MB) {
+		if (psw_bits(vcpu->arch.sie_block->gpsw).eaba == PSW_AMODE_64BIT)
+			vcpu->run->s.regs.gprs[reg2] &= ~PAGE_MASK;
+		else
+			vcpu->run->s.regs.gprs[reg2] &= ~0xfffff000UL;
+		end = kvm_s390_logical_to_effective(vcpu, end);
+		vcpu->run->s.regs.gprs[reg2] |= end;
+	}
 	return 0;
 }
 
@@ -586,9 +720,9 @@ static const intercept_handler_t b2_handlers[256] = {
 	[0x11] = handle_store_prefix,
 	[0x12] = handle_store_cpu_address,
 	[0x21] = handle_ipte_interlock,
-	[0x29] = handle_skey,
-	[0x2a] = handle_skey,
-	[0x2b] = handle_skey,
+	[0x29] = handle_iske,
+	[0x2a] = handle_rrbe,
+	[0x2b] = handle_sske,
 	[0x2c] = handle_test_block,
 	[0x30] = handle_io_inst,
 	[0x31] = handle_io_inst,
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index e791e8b..fa286d0 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -572,6 +572,43 @@ int cond_set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(cond_set_guest_storage_key);
 
+/**
+ * Reset a guest reference bit (rrbe), returning the reference and changed bit.
+ *
+ * Returns < 0 in case of error, otherwise the cc to be reported to the guest.
+ */
+int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
+{
+	spinlock_t *ptl;
+	pgste_t old, new;
+	pte_t *ptep;
+	int cc = 0;
+
+	ptep = get_locked_pte(mm, addr, &ptl);
+	if (unlikely(!ptep))
+		return -EFAULT;
+
+	new = old = pgste_get_lock(ptep);
+	/* Reset guest reference bit only */
+	pgste_val(new) &= ~PGSTE_GR_BIT;
+
+	if (!(pte_val(*ptep) & _PAGE_INVALID)) {
+		cc = page_reset_referenced(pte_val(*ptep) & PAGE_MASK);
+		/* Merge real referenced bit into host-set */
+		pgste_val(new) |= ((unsigned long) cc << 53) & PGSTE_HR_BIT;
+	}
+	/* Reflect guest's logical view, not physical */
+	cc |= (pgste_val(old) & (PGSTE_GR_BIT | PGSTE_GC_BIT)) >> 49;
+	/* Changing the guest storage key is considered a change of the page */
+	if ((pgste_val(new) ^ pgste_val(old)) & PGSTE_GR_BIT)
+		pgste_val(new) |= PGSTE_UC_BIT;
+
+	pgste_set_unlock(ptep, new);
+	pte_unmap_unlock(ptep, ptl);
+	return 0;
+}
+EXPORT_SYMBOL(reset_guest_reference_bit);
+
 int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char *key)
 {
-- 
2.5.5

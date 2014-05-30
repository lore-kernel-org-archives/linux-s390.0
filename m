From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/6] KVM: s390: Add a generic function for translating guest addresses
Date: Fri, 30 May 2014 11:00:07 +0200
Message-ID: <1401440412-20472-2-git-send-email-borntraeger@de.ibm.com>
References: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

This patch adds a function for translating logical guest addresses into
physical guest addresses without touching the memory at the given location.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gaccess.h |  3 +++
 2 files changed, 56 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index db608c3..5f73826 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -645,6 +645,59 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 }
 
 /**
+ * guest_translate_address - translate guest logical into guest absolute address
+ *
+ * Parameter semantics are the same as the ones from guest_translate.
+ * The memory contents at the guest address are not changed.
+ *
+ * Note: The IPTE lock is not taken during this function, so the caller
+ * has to take care of this.
+ */
+int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
+			    unsigned long *gpa, int write)
+{
+	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	struct trans_exc_code_bits *tec;
+	union asce asce;
+	int rc;
+
+	/* Access register mode is not supported yet. */
+	if (psw_bits(*psw).t && psw_bits(*psw).as == PSW_AS_ACCREG)
+		return -EOPNOTSUPP;
+
+	gva = kvm_s390_logical_to_effective(vcpu, gva);
+	memset(pgm, 0, sizeof(*pgm));
+	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
+	tec->as = psw_bits(*psw).as;
+	tec->fsi = write ? FSI_STORE : FSI_FETCH;
+	tec->addr = gva >> PAGE_SHIFT;
+	if (is_low_address(gva) && low_address_protection_enabled(vcpu)) {
+		if (write) {
+			rc = pgm->code = PGM_PROTECTION;
+			return rc;
+		}
+	}
+
+	asce.val = get_vcpu_asce(vcpu);
+	if (psw_bits(*psw).t && !asce.r) {	/* Use DAT? */
+		rc = guest_translate(vcpu, gva, gpa, write);
+		if (rc > 0) {
+			if (rc == PGM_PROTECTION)
+				tec->b61 = 1;
+			pgm->code = rc;
+		}
+	} else {
+		rc = 0;
+		*gpa = kvm_s390_real_to_abs(vcpu, gva);
+		if (kvm_is_error_gpa(vcpu->kvm, *gpa))
+			rc = pgm->code = PGM_ADDRESSING;
+	}
+
+	return rc;
+}
+
+/**
  * kvm_s390_check_low_addr_protection - check for low-address protection
  * @ga: Guest address
  *
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index a07ee08..2d37a46 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -155,6 +155,9 @@ int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 	return kvm_read_guest(vcpu->kvm, gpa, data, len);
 }
 
+int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
+			    unsigned long *gpa, int write);
+
 int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, void *data,
 		 unsigned long len, int write);
 
-- 
1.8.4.2

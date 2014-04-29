From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/6] KVM: s390: Add a function for checking the low-address protection
Date: Tue, 29 Apr 2014 15:36:44 +0200
Message-ID: <1398778608-3887-3-git-send-email-borntraeger@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The s390 architecture has a special protection mechanism that can
be used to prevent write access to the vital data in the low-core
memory area. This patch adds a new helper function that can be used
to check for such write accesses and in case of protection, it also
sets up the exception data accordingly.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 28 ++++++++++++++++++++++++++++
 arch/s390/kvm/gaccess.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 691fdb7..db608c3 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -643,3 +643,31 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 	}
 	return rc;
 }
+
+/**
+ * kvm_s390_check_low_addr_protection - check for low-address protection
+ * @ga: Guest address
+ *
+ * Checks whether an address is subject to low-address protection and set
+ * up vcpu->arch.pgm accordingly if necessary.
+ *
+ * Return: 0 if no protection exception, or PGM_PROTECTION if protected.
+ */
+int kvm_s390_check_low_addr_protection(struct kvm_vcpu *vcpu, unsigned long ga)
+{
+	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	struct trans_exc_code_bits *tec_bits;
+
+	if (!is_low_address(ga) || !low_address_protection_enabled(vcpu))
+		return 0;
+
+	memset(pgm, 0, sizeof(*pgm));
+	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
+	tec_bits->fsi = FSI_STORE;
+	tec_bits->as = psw_bits(*psw).as;
+	tec_bits->addr = ga >> PAGE_SHIFT;
+	pgm->code = PGM_PROTECTION;
+
+	return pgm->code;
+}
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 1079c8f..68db43e 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -325,5 +325,6 @@ int read_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 }
 
 int ipte_lock_held(struct kvm_vcpu *vcpu);
+int kvm_s390_check_low_addr_protection(struct kvm_vcpu *vcpu, unsigned long ga);
 
 #endif /* __KVM_S390_GACCESS_H */
-- 
1.8.4.2

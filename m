From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/11] KVM: s390: Fix low-address protection for real addresses
Date: Wed, 18 Mar 2015 12:44:01 +0100
Message-ID: <1426679049-37696-4-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

The kvm_s390_check_low_addr_protection() function is used only with real
addresses. According to the POP (the "Low-Address Protection"
paragraph in chapter 3), if the effective address is real or absolute,
the low-address protection procedure should raise a PROTECTION exception
only when the low-address protection is enabled in the control register
0 and the address is low.
This patch removes ASCE checks from the function and renames it to
better reflect its behavior.

Cc: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 11 ++++++-----
 arch/s390/kvm/gaccess.h |  2 +-
 arch/s390/kvm/priv.c    |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 633fe9b..c230904 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -697,28 +697,29 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva,
 }
 
 /**
- * kvm_s390_check_low_addr_protection - check for low-address protection
- * @ga: Guest address
+ * kvm_s390_check_low_addr_prot_real - check for low-address protection
+ * @gra: Guest real address
  *
  * Checks whether an address is subject to low-address protection and set
  * up vcpu->arch.pgm accordingly if necessary.
  *
  * Return: 0 if no protection exception, or PGM_PROTECTION if protected.
  */
-int kvm_s390_check_low_addr_protection(struct kvm_vcpu *vcpu, unsigned long ga)
+int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra)
 {
 	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
 	struct trans_exc_code_bits *tec_bits;
+	union ctlreg0 ctlreg0 = {.val = vcpu->arch.sie_block->gcr[0]};
 
-	if (!is_low_address(ga) || !low_address_protection_enabled(vcpu))
+	if (!ctlreg0.lap || !is_low_address(gra))
 		return 0;
 
 	memset(pgm, 0, sizeof(*pgm));
 	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
 	tec_bits->fsi = FSI_STORE;
 	tec_bits->as = psw_bits(*psw).as;
-	tec_bits->addr = ga >> PAGE_SHIFT;
+	tec_bits->addr = gra >> PAGE_SHIFT;
 	pgm->code = PGM_PROTECTION;
 
 	return pgm->code;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 0149cf1..20de77e 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -330,6 +330,6 @@ int read_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 void ipte_lock(struct kvm_vcpu *vcpu);
 void ipte_unlock(struct kvm_vcpu *vcpu);
 int ipte_lock_held(struct kvm_vcpu *vcpu);
-int kvm_s390_check_low_addr_protection(struct kvm_vcpu *vcpu, unsigned long ga);
+int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra);
 
 #endif /* __KVM_S390_GACCESS_H */
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index b982fbc..5f26425 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -207,7 +207,7 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 	kvm_s390_get_regs_rre(vcpu, NULL, &reg2);
 	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
 	addr = kvm_s390_logical_to_effective(vcpu, addr);
-	if (kvm_s390_check_low_addr_protection(vcpu, addr))
+	if (kvm_s390_check_low_addr_prot_real(vcpu, addr))
 		return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 	addr = kvm_s390_real_to_abs(vcpu, addr);
 
@@ -680,7 +680,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	}
 
 	if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
-		if (kvm_s390_check_low_addr_protection(vcpu, start))
+		if (kvm_s390_check_low_addr_prot_real(vcpu, start))
 			return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 	}
 
-- 
2.3.0

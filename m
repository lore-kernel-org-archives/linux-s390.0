From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/52] KVM: s390: gaccess: convert kvm_s390_check_low_addr_prot_real()
Date: Tue, 14 Jun 2016 20:56:50 +0200
Message-ID: <1465930649-181383-14-git-send-email-borntraeger@de.ibm.com>
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

Let's use our new function for preparing translation exceptions.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index b6ccb26..61dc45e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -979,20 +979,9 @@ int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
  */
 int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra)
 {
-	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
-	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	struct trans_exc_code_bits *tec_bits;
 	union ctlreg0 ctlreg0 = {.val = vcpu->arch.sie_block->gcr[0]};
 
 	if (!ctlreg0.lap || !is_low_address(gra))
 		return 0;
-
-	memset(pgm, 0, sizeof(*pgm));
-	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	tec_bits->fsi = FSI_STORE;
-	tec_bits->as = psw_bits(*psw).as;
-	tec_bits->addr = gra >> PAGE_SHIFT;
-	pgm->code = PGM_PROTECTION;
-
-	return pgm->code;
+	return trans_exc(vcpu, PGM_PROTECTION, gra, 0, GACC_STORE, PROT_TYPE_LA);
 }
-- 
2.5.5

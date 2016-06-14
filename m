From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/52] KVM: s390: gaccess: convert guest_page_range()
Date: Tue, 14 Jun 2016 20:56:52 +0200
Message-ID: <1465930649-181383-16-git-send-email-borntraeger@de.ibm.com>
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

Let's use our new function for preparing translation exceptions. As we will
need the correct ar, let's pass that to guest_page_range().

This will also make sure that the guest address is stored in the tec
for applicable excptions.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index ae9f9e8..ec6c91e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -792,40 +792,31 @@ static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
+static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar,
 			    unsigned long *pages, unsigned long nr_pages,
 			    const union asce asce, enum gacc_mode mode)
 {
-	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	struct trans_exc_code_bits *tec_bits;
-	int lap_enabled, rc;
+	int lap_enabled, rc = 0;
 
-	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
 	lap_enabled = low_address_protection_enabled(vcpu, asce);
 	while (nr_pages) {
 		ga = kvm_s390_logical_to_effective(vcpu, ga);
-		tec_bits->addr = ga >> PAGE_SHIFT;
-		if (mode == GACC_STORE && lap_enabled && is_low_address(ga)) {
-			pgm->code = PGM_PROTECTION;
-			return pgm->code;
-		}
+		if (mode == GACC_STORE && lap_enabled && is_low_address(ga))
+			return trans_exc(vcpu, PGM_PROTECTION, ga, ar, mode,
+					 PROT_TYPE_LA);
 		ga &= PAGE_MASK;
 		if (psw_bits(*psw).t) {
 			rc = guest_translate(vcpu, ga, pages, asce, mode);
 			if (rc < 0)
 				return rc;
-			if (rc == PGM_PROTECTION)
-				tec_bits->b61 = 1;
-			if (rc)
-				pgm->code = rc;
 		} else {
 			*pages = kvm_s390_real_to_abs(vcpu, ga);
 			if (kvm_is_error_gpa(vcpu->kvm, *pages))
-				pgm->code = PGM_ADDRESSING;
+				rc = PGM_ADDRESSING;
 		}
-		if (pgm->code)
-			return pgm->code;
+		if (rc)
+			return trans_exc(vcpu, rc, ga, ar, mode, PROT_TYPE_DAT);
 		ga += PAGE_SIZE;
 		pages++;
 		nr_pages--;
@@ -859,7 +850,7 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 	need_ipte_lock = psw_bits(*psw).t && !asce.r;
 	if (need_ipte_lock)
 		ipte_lock(vcpu);
-	rc = guest_page_range(vcpu, ga, pages, nr_pages, asce, mode);
+	rc = guest_page_range(vcpu, ga, ar, pages, nr_pages, asce, mode);
 	for (idx = 0; idx < nr_pages && !rc; idx++) {
 		gpa = *(pages + idx) + (ga & ~PAGE_MASK);
 		_len = min(PAGE_SIZE - (gpa & ~PAGE_MASK), len);
-- 
2.5.5

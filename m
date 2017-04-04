From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: remove change-recording override support
Date: Tue,  4 Apr 2017 10:51:10 +0200
Message-ID: <1491295870-7152-2-git-send-email-borntraeger@de.ibm.com>
References: <1491295870-7152-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491295870-7152-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Change-recording override (CO) was never implemented in any
machine. According to the architecture it is unpredictable if a
translation-specification exception will be recognized if the bit is
set and EDAT1 does not apply.
Therefore the easiest solution is to simply ignore the bit.

This also fixes commit cd1836f583d7 ("KVM: s390:
instruction-execution-protection support"). A guest may enable
instruction-execution-protection (IEP) but not EDAT1. In such a case
the guest_translate() function (arch/s390/kvm/gaccess.c) will report a
specification exception on pages that have the IEP bit set while it
should not.

It might make sense to add full IEP support to guest_translate() and
the GACC_IFETCH case. However, as far as I can tell the GACC_IFETCH
case is currently only used after an instruction was executed in order
to fetch the failing instruction. So there is no additional problem
*currently*.

Fixes: cd1836f583d7 ("KVM: s390: instruction-execution-protection support")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index d55c829..ddbffb7 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -168,8 +168,7 @@ union page_table_entry {
 		unsigned long z  : 1; /* Zero Bit */
 		unsigned long i  : 1; /* Page-Invalid Bit */
 		unsigned long p  : 1; /* DAT-Protection Bit */
-		unsigned long co : 1; /* Change-Recording Override */
-		unsigned long	 : 8;
+		unsigned long	 : 9;
 	};
 };
 
@@ -745,8 +744,6 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		return PGM_PAGE_TRANSLATION;
 	if (pte.z)
 		return PGM_TRANSLATION_SPEC;
-	if (pte.co && !edat1)
-		return PGM_TRANSLATION_SPEC;
 	dat_protection |= pte.p;
 	raddr.pfra = pte.pfra;
 real_address:
@@ -1182,7 +1179,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
 	if (!rc && pte.i)
 		rc = PGM_PAGE_TRANSLATION;
-	if (!rc && (pte.z || (pte.co && sg->edat_level < 1)))
+	if (!rc && pte.z)
 		rc = PGM_TRANSLATION_SPEC;
 shadow_page:
 	pte.p |= dat_protection;
-- 
2.7.4

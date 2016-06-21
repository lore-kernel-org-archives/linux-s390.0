From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/51] s390/mm: take the mmap_sem in kvm_s390_shadow_fault()
Date: Tue, 21 Jun 2016 15:12:49 +0200
Message-ID: <1466514809-146638-12-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Instead of doing it in the caller, let's just take the mmap_sem
in kvm_s390_shadow_fault(). By taking it as read, we allow parallel
faulting on shadow page tables, gmap shadow code is prepared for that.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c5f79c1..5b5eee2 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1091,26 +1091,24 @@ int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr, int write)
 	int dat_protection;
 	int rc;
 
+	down_read(&sg->mm->mmap_sem);
+
 	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection);
-	if (rc) {
+	if (rc)
 		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection);
-		if (rc)
-			return rc;
-	}
 
 	vaddr.addr = saddr;
-	rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
-	if (rc)
-		return rc;
-	if (pte.i)
-		return PGM_PAGE_TRANSLATION;
-	if (pte.z || pte.co)
-		return PGM_TRANSLATION_SPEC;
+	if (!rc)
+		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
+	if (!rc && pte.i)
+		rc = PGM_PAGE_TRANSLATION;
+	if (!rc && (pte.z || pte.co))
+		rc = PGM_TRANSLATION_SPEC;
 	dat_protection |= pte.p;
-	if (write && dat_protection)
-		return PGM_PROTECTION;
-	rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
-	if (rc)
-		return rc;
-	return 0;
+	if (!rc && write && dat_protection)
+		rc = PGM_PROTECTION;
+	if (!rc)
+		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
+	up_read(&sg->mm->mmap_sem);
+	return rc;
 }
-- 
2.5.5

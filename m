From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 42/52] s390/mm: simplify get_guest_storage_key
Date: Tue, 14 Jun 2016 20:57:19 +0200
Message-ID: <1465930649-181383-43-git-send-email-borntraeger@de.ibm.com>
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

We can safe a few LOC and make that function easier to understand
by rewriting existing code.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/pgtable.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7612a7c..4c8d572 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -551,20 +551,11 @@ unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
 		return -EFAULT;
 
 	pgste = pgste_get_lock(ptep);
-	if (pte_val(*ptep) & _PAGE_INVALID) {
-		key  = (pgste_val(pgste) & PGSTE_ACC_BITS) >> 56;
-		key |= (pgste_val(pgste) & PGSTE_FP_BIT) >> 56;
-		key |= (pgste_val(pgste) & PGSTE_GR_BIT) >> 48;
-		key |= (pgste_val(pgste) & PGSTE_GC_BIT) >> 48;
-	} else {
+	key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
+	if (!(pte_val(*ptep) & _PAGE_INVALID))
 		key = page_get_storage_key(pte_val(*ptep) & PAGE_MASK);
-
-		/* Reflect guest's logical view, not physical */
-		if (pgste_val(pgste) & PGSTE_GR_BIT)
-			key |= _PAGE_REFERENCED;
-		if (pgste_val(pgste) & PGSTE_GC_BIT)
-			key |= _PAGE_CHANGED;
-	}
+	/* Reflect guest's logical view, not physical */
+	key |= (pgste_val(pgste) & (PGSTE_GR_BIT | PGSTE_GC_BIT)) >> 48;
 	pgste_set_unlock(ptep, pgste);
 	pte_unmap_unlock(ptep, ptl);
 	return key;
-- 
2.5.5

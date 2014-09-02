From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390/mm: Fix storage key corruption during swapping
Date: Tue,  2 Sep 2014 10:58:44 +0200
Message-ID: <1409648325-2926-2-git-send-email-borntraeger@de.ibm.com>
References: <1409648325-2926-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1409648325-2926-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v3.12+@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Since 3.12 or more precisely  commit 0944fe3f4a32 ("s390/mm:
implement software referenced bits") guest storage keys get
corrupted during paging. This commit added another valid->invalid
translation for page tables - namely ptep_test_and_clear_young.
We have to transfer the storage key into the pgste in that case.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: stable@vger.kernel.org # v3.12+
---
 arch/s390/include/asm/pgtable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index b76317c..32686e8 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1127,7 +1127,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep)
 {
 	pgste_t pgste;
-	pte_t pte;
+	pte_t pte, oldpte;
 	int young;
 
 	if (mm_has_pgste(vma->vm_mm)) {
@@ -1135,12 +1135,13 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 		pgste = pgste_ipte_notify(vma->vm_mm, ptep, pgste);
 	}
 
-	pte = *ptep;
+	oldpte = pte = *ptep;
 	ptep_flush_direct(vma->vm_mm, addr, ptep);
 	young = pte_young(pte);
 	pte = pte_mkold(pte);
 
 	if (mm_has_pgste(vma->vm_mm)) {
+		pgste = pgste_update_all(&oldpte, pgste, vma->vm_mm);
 		pgste = pgste_set_pte(ptep, pgste, pte);
 		pgste_set_unlock(ptep, pgste);
 	} else
-- 
1.8.4.2

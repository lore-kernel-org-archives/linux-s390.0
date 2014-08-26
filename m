From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/15] KVM: s390/mm: readd address parameter to gmap_do_ipte_notify
Date: Tue, 26 Aug 2014 10:28:23 +0200
Message-ID: <1409041707-39938-12-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Revert git commit c3a23b9874c1 ("remove unnecessary parameter from
gmap_do_ipte_notify").

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 arch/s390/mm/pgtable.c          | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 4a64988..4cd91ac 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -856,7 +856,7 @@ bool gmap_test_and_clear_dirty(unsigned long address, struct gmap *);
 void gmap_register_ipte_notifier(struct gmap_notifier *);
 void gmap_unregister_ipte_notifier(struct gmap_notifier *);
 int gmap_ipte_notify(struct gmap *, unsigned long start, unsigned long len);
-void gmap_do_ipte_notify(struct mm_struct *, pte_t *);
+void gmap_do_ipte_notify(struct mm_struct *, unsigned long addr, pte_t *);
 
 static inline pgste_t pgste_ipte_notify(struct mm_struct *mm,
 					unsigned long addr,
@@ -865,7 +865,7 @@ static inline pgste_t pgste_ipte_notify(struct mm_struct *mm,
 #ifdef CONFIG_PGSTE
 	if (pgste_val(pgste) & PGSTE_IN_BIT) {
 		pgste_val(pgste) &= ~PGSTE_IN_BIT;
-		gmap_do_ipte_notify(mm, ptep);
+		gmap_do_ipte_notify(mm, addr, ptep);
 	}
 #endif
 	return pgste;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5404a62..c09820d 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -809,12 +809,13 @@ EXPORT_SYMBOL_GPL(gmap_ipte_notify);
 /**
  * gmap_do_ipte_notify - call all invalidation callbacks for a specific pte.
  * @mm: pointer to the process mm_struct
+ * @addr: virtual address in the process address space
  * @pte: pointer to the page table entry
  *
  * This function is assumed to be called with the page table lock held
  * for the pte to notify.
  */
-void gmap_do_ipte_notify(struct mm_struct *mm, pte_t *pte)
+void gmap_do_ipte_notify(struct mm_struct *mm, unsigned long addr, pte_t *pte)
 {
 	unsigned long segment_offset;
 	struct gmap_notifier *nb;
-- 
1.8.4.2

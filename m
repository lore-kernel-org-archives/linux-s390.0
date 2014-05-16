From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/12] KVM: s390: correct locking for s390_enable_skey
Date: Fri, 16 May 2014 16:09:37 +0200
Message-ID: <1400249388-3969-2-git-send-email-borntraeger@de.ibm.com>
References: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Use the mm semaphore to serialize multiple invocations of s390_enable_skey.
The second CPU faulting on a storage key operation needs to wait for the
completion of the page table update. Taking the mm semaphore writable
has the positive side-effect that it prevents any host faults from
taking place which does have implications on keys vs PGSTE.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/pgtable.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index ea4a31b..66ba60c 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -958,8 +958,10 @@ void page_table_reset_pgste(struct mm_struct *mm, unsigned long start,
 	unsigned long addr, next;
 	pgd_t *pgd;
 
+	down_write(&mm->mmap_sem);
+	if (init_skey && mm_use_skey(mm))
+		goto out_up;
 	addr = start;
-	down_read(&mm->mmap_sem);
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
@@ -967,7 +969,10 @@ void page_table_reset_pgste(struct mm_struct *mm, unsigned long start,
 			continue;
 		next = page_table_reset_pud(mm, pgd, addr, next, init_skey);
 	} while (pgd++, addr = next, addr != end);
-	up_read(&mm->mmap_sem);
+	if (init_skey)
+		current->mm->context.use_skey = 1;
+out_up:
+	up_write(&mm->mmap_sem);
 }
 EXPORT_SYMBOL(page_table_reset_pgste);
 
@@ -1384,19 +1389,6 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
  */
 void s390_enable_skey(void)
 {
-	/*
-	 * To avoid races between multiple vcpus, ending in calling
-	 * page_table_reset twice or more,
-	 * the page_table_lock is taken for serialization.
-	 */
-	spin_lock(&current->mm->page_table_lock);
-	if (mm_use_skey(current->mm)) {
-		spin_unlock(&current->mm->page_table_lock);
-		return;
-	}
-
-	current->mm->context.use_skey = 1;
-	spin_unlock(&current->mm->page_table_lock);
 	page_table_reset_pgste(current->mm, 0, TASK_SIZE, true);
 }
 EXPORT_SYMBOL_GPL(s390_enable_skey);
-- 
1.8.4.2

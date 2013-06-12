From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/6] KVM: s390: Provide function for setting the guest storage key
Date: Wed, 12 Jun 2013 13:54:52 +0200
Message-ID: <1371038097-28577-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

From time to time we need to set the guest storage key. Lets
provide a helper function that handles the changes with all the
right locking and checking.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/pgalloc.h |  3 +++
 arch/s390/mm/pgtable.c          | 48 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 590c321..e1408dd 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -22,6 +22,9 @@ unsigned long *page_table_alloc(struct mm_struct *, unsigned long);
 void page_table_free(struct mm_struct *, unsigned long *);
 void page_table_free_rcu(struct mmu_gather *, unsigned long *);
 
+int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
+			  unsigned long key, bool nq);
+
 static inline void clear_table(unsigned long *s, unsigned long val, size_t n)
 {
 	typedef struct { char _[n]; } addrtype;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 1e0c438..44b1450 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -771,6 +771,54 @@ static inline void page_table_free_pgste(unsigned long *table)
 	__free_page(page);
 }
 
+int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
+			  unsigned long key, bool nq)
+{
+	spinlock_t *ptl;
+	pgste_t old, new;
+	pte_t *ptep;
+
+	down_read(&mm->mmap_sem);
+	ptep = get_locked_pte(current->mm, addr, &ptl);
+	if (unlikely(!ptep)) {
+		up_read(&mm->mmap_sem);
+		return -EFAULT;
+	}
+
+	new = old = pgste_get_lock(ptep);
+	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
+			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
+	pgste_val(new) |= (key & (_PAGE_CHANGED | _PAGE_REFERENCED)) << 48;
+	pgste_val(new) |= (key & (_PAGE_ACC_BITS | _PAGE_FP_BIT)) << 56;
+	if (!(pte_val(*ptep) & _PAGE_INVALID)) {
+		unsigned long address, bits;
+		unsigned char skey;
+
+		address = pte_val(*ptep) & PAGE_MASK;
+		skey = page_get_storage_key(address);
+		bits = skey & (_PAGE_CHANGED | _PAGE_REFERENCED);
+		/* Set storage key ACC and FP */
+		page_set_storage_key(address,
+				(key & (_PAGE_ACC_BITS | _PAGE_FP_BIT)),
+				!nq);
+
+		/* Merge host changed & referenced into pgste  */
+		pgste_val(new) |= bits << 52;
+		/* Transfer skey changed & referenced bit to kvm user bits */
+		pgste_val(new) |= bits << 45;	/* PGSTE_UR_BIT & PGSTE_UC_BIT */
+	}
+	/* changing the guest storage key is considered a change of the page */
+	if ((pgste_val(new) ^ pgste_val(old)) &
+	    (PGSTE_ACC_BITS | PGSTE_FP_BIT | PGSTE_GR_BIT | PGSTE_GC_BIT))
+		pgste_val(new) |= PGSTE_UC_BIT;
+
+	pgste_set_unlock(ptep, new);
+	pte_unmap_unlock(*ptep, ptl);
+	up_read(&mm->mmap_sem);
+	return 0;
+}
+EXPORT_SYMBOL(set_guest_storage_key);
+
 #else /* CONFIG_PGSTE */
 
 static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
-- 
1.8.1.6

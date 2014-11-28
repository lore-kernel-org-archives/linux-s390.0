From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/11] KVM: S390: Create helper function get_guest_storage_key
Date: Fri, 28 Nov 2014 14:25:32 +0100
Message-ID: <1417181139-25623-5-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Define get_guest_storage_key which can be used to get the value of a guest
storage key. This compliments the functionality provided by the helper function
set_guest_storage_key. Both functions are needed for live migration of s390
guests that use storage keys.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgalloc.h |  1 +
 arch/s390/mm/pgtable.c          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index d39a31c..ede2eab 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -26,6 +26,7 @@ void page_table_reset_pgste(struct mm_struct *, unsigned long, unsigned long,
 			    bool init_skey);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned long key, bool nq);
+unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr);
 
 static inline void clear_table(unsigned long *s, unsigned long val, size_t n)
 {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index cfecc24..0b18585 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -980,6 +980,45 @@ retry:
 }
 EXPORT_SYMBOL(set_guest_storage_key);
 
+unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
+{
+	spinlock_t *ptl;
+	pgste_t pgste;
+	pte_t *ptep;
+	uint64_t physaddr;
+	unsigned long key = 0;
+
+	down_read(&mm->mmap_sem);
+	ptep = get_locked_pte(mm, addr, &ptl);
+	if (unlikely(!ptep)) {
+		up_read(&mm->mmap_sem);
+		return -EFAULT;
+	}
+	pgste = pgste_get_lock(ptep);
+
+	if (pte_val(*ptep) & _PAGE_INVALID) {
+		key |= (pgste_val(pgste) & PGSTE_ACC_BITS) >> 56;
+		key |= (pgste_val(pgste) & PGSTE_FP_BIT) >> 56;
+		key |= (pgste_val(pgste) & PGSTE_GR_BIT) >> 48;
+		key |= (pgste_val(pgste) & PGSTE_GC_BIT) >> 48;
+	} else {
+		physaddr = pte_val(*ptep) & PAGE_MASK;
+		key = page_get_storage_key(physaddr);
+
+		/* Reflect guest's logical view, not physical */
+		if (pgste_val(pgste) & PGSTE_GR_BIT)
+			key |= _PAGE_REFERENCED;
+		if (pgste_val(pgste) & PGSTE_GC_BIT)
+			key |= _PAGE_CHANGED;
+	}
+
+	pgste_set_unlock(ptep, pgste);
+	pte_unmap_unlock(ptep, ptl);
+	up_read(&mm->mmap_sem);
+	return key;
+}
+EXPORT_SYMBOL(get_guest_storage_key);
+
 #else /* CONFIG_PGSTE */
 
 static inline int page_table_with_pgste(struct page *page)
-- 
1.9.3

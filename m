From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 43/52] s390/mm: return key via pointer in get_guest_storage_key
Date: Tue, 14 Jun 2016 20:57:20 +0200
Message-ID: <1465930649-181383-44-git-send-email-borntraeger@de.ibm.com>
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

Let's just split returning the key and reporting errors. This makes calling
code easier and avoids bugs as happened already.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  3 ++-
 arch/s390/kvm/kvm-s390.c        |  8 ++------
 arch/s390/mm/pgtable.c          | 12 ++++++------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 42b968a8..91f0e7b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -893,7 +893,8 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq);
-unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr);
+int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
+			  unsigned char *key);
 
 /*
  * Certain architectures need to do special things when PTEs
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d0156d7..ad166c6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1029,7 +1029,6 @@ static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 {
 	uint8_t *keys;
 	uint64_t hva;
-	unsigned long curkey;
 	int i, r = 0;
 
 	if (args->flags != 0)
@@ -1058,12 +1057,9 @@ static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 			break;
 		}
 
-		curkey = get_guest_storage_key(current->mm, hva);
-		if (IS_ERR_VALUE(curkey)) {
-			r = curkey;
+		r = get_guest_storage_key(current->mm, hva, &keys[i]);
+		if (r)
 			break;
-		}
-		keys[i] = curkey;
 	}
 	up_read(&current->mm->mmap_sem);
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4c8d572..3e35298 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -539,9 +539,9 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(set_guest_storage_key);
 
-unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
+int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
+			  unsigned char *key)
 {
-	unsigned char key;
 	spinlock_t *ptl;
 	pgste_t pgste;
 	pte_t *ptep;
@@ -551,14 +551,14 @@ unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
 		return -EFAULT;
 
 	pgste = pgste_get_lock(ptep);
-	key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
+	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
 	if (!(pte_val(*ptep) & _PAGE_INVALID))
-		key = page_get_storage_key(pte_val(*ptep) & PAGE_MASK);
+		*key = page_get_storage_key(pte_val(*ptep) & PAGE_MASK);
 	/* Reflect guest's logical view, not physical */
-	key |= (pgste_val(pgste) & (PGSTE_GR_BIT | PGSTE_GC_BIT)) >> 48;
+	*key |= (pgste_val(pgste) & (PGSTE_GR_BIT | PGSTE_GC_BIT)) >> 48;
 	pgste_set_unlock(ptep, pgste);
 	pte_unmap_unlock(ptep, ptl);
-	return key;
+	return 0;
 }
 EXPORT_SYMBOL(get_guest_storage_key);
 #endif
-- 
2.5.5

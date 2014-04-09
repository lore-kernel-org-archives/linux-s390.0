From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 4/8] KVM: s390: Allow skeys to be enabled for the current process
Date: Wed,  9 Apr 2014 12:44:54 +0200
Message-ID: <1397040298-59306-5-git-send-email-borntraeger@de.ibm.com>
References: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Introduce a new function s390_enable_skey(), which enables storage key
handling via setting the use_skey flag in the mmu context.

This function is only useful within the context of kvm.

Note that enabling storage keys will cause a one-time hickup when
walking the page table; however, it saves us special effort for cases
like clear reset while making it possible for us to be architecture
conform.

s390_enable_skey() takes the page table lock to prevent resetting
storage keys triggered from multiple vcpus.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/mm/pgtable.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 818ab0f..bc4eb35 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1691,6 +1691,7 @@ static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 extern int vmem_add_mapping(unsigned long start, unsigned long size);
 extern int vmem_remove_mapping(unsigned long start, unsigned long size);
 extern int s390_enable_sie(void);
+extern void s390_enable_skey(void);
 
 /*
  * No page table caches to initialise
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5f5d643..25e4a2a 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -1368,6 +1368,29 @@ int s390_enable_sie(void)
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
+/*
+ * Enable storage key handling from now on and initialize the storage
+ * keys with the default key.
+ */
+void s390_enable_skey(void)
+{
+	/*
+	 * To avoid races between multiple vcpus, ending in calling
+	 * page_table_reset twice or more,
+	 * the page_table_lock is taken for serialization.
+	 */
+	spin_lock(&current->mm->page_table_lock);
+	if (mm_use_skey(current->mm)) {
+		spin_unlock(&current->mm->page_table_lock);
+		return;
+	}
+
+	current->mm->context.use_skey = 1;
+	spin_unlock(&current->mm->page_table_lock);
+	page_table_reset_pgste(current->mm, 0, TASK_SIZE, true);
+}
+EXPORT_SYMBOL_GPL(s390_enable_skey);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int pmdp_clear_flush_young(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmdp)
-- 
1.8.4.2

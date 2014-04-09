From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 7/8] KVM: s390/mm: new gmap_test_and_clear_dirty function
Date: Wed,  9 Apr 2014 12:44:57 +0200
Message-ID: <1397040298-59306-8-git-send-email-borntraeger@de.ibm.com>
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

For live migration kvm needs to test and clear the dirty bit of guest pages.

Lets provide ptep_test_and_clear_user_dirty in architecture specific
memory management code, since we need proper locking.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  2 ++
 arch/s390/mm/pgtable.c          | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index d75eb76..ab65035 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -838,6 +838,8 @@ unsigned long __gmap_fault(unsigned long address, struct gmap *);
 unsigned long gmap_fault(unsigned long address, struct gmap *);
 void gmap_discard(unsigned long from, unsigned long to, struct gmap *);
 void __gmap_zap(unsigned long address, struct gmap *);
+bool gmap_test_and_clear_dirty(unsigned long address, struct gmap *);
+
 
 void gmap_register_ipte_notifier(struct gmap_notifier *);
 void gmap_unregister_ipte_notifier(struct gmap_notifier *);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 442a266..8979847 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -1391,6 +1391,27 @@ void s390_enable_skey(void)
 }
 EXPORT_SYMBOL_GPL(s390_enable_skey);
 
+/*
+ * Test and reset if a guest page is dirty
+ */
+bool gmap_test_and_clear_dirty(unsigned long address, struct gmap *gmap)
+{
+	pte_t *pte;
+	spinlock_t *ptl;
+	bool dirty = false;
+
+	pte = get_locked_pte(gmap->mm, address, &ptl);
+	if (unlikely(!pte))
+		return false;
+
+	if (ptep_test_and_clear_user_dirty(gmap->mm, address, pte))
+		dirty = true;
+
+	spin_unlock(ptl);
+	return dirty;
+}
+EXPORT_SYMBOL_GPL(gmap_test_and_clear_dirty);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int pmdp_clear_flush_young(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmdp)
-- 
1.8.4.2

From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 09/22] s390/mm: clear huge page storage keys on enable_skey
Date: Mon,  6 Nov 2017 23:29:47 +0100
Message-ID: <1510007400-42493-10-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

When a guest starts using storage keys, we trap and set a default one
for its whole valid address space. With this patch we are now able to
do that for large pages.

To speed up the storage key insertion, we use
__storage_key_init_range, which in-turn will use sske_frame to set
multiple storage keys with one instruction. As it has been previously
used for debuging we have to get rid of the default key check and make
it quiescing.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
[replaced page_set_storage_key loop with __storage_key_init_range]
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/gmap.c     | 26 +++++++++++++++++++++++---
 arch/s390/mm/pageattr.c |  6 ++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bebf83f..5f0e696 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2676,17 +2676,37 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
  * Enable storage key handling from now on and initialize the storage
  * keys with the default key.
  */
-static int __s390_enable_skey(pte_t *pte, unsigned long addr,
-			      unsigned long next, struct mm_walk *walk)
+static int __s390_enable_skey_pte(pte_t *pte, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
 {
 	/* Clear storage key */
 	ptep_zap_key(walk->mm, addr, pte);
 	return 0;
 }
 
+static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
+				      unsigned long hmask, unsigned long next,
+				      struct mm_walk *walk)
+{
+	pmd_t *pmd = (pmd_t *)pte;
+	unsigned long start, end;
+
+	if (pmd_val(*pmd) & _SEGMENT_ENTRY_INVALID
+	    || !(pmd_val(*pmd) & _SEGMENT_ENTRY_WRITE))
+		return 0;
+
+	start = pmd_val(*pmd) & HPAGE_MASK;
+	end = start + HPAGE_SIZE - 1;
+	__storage_key_init_range(start, end);
+	return 0;
+}
+
 int s390_enable_skey(void)
 {
-	struct mm_walk walk = { .pte_entry = __s390_enable_skey };
+	struct mm_walk walk = {
+		.hugetlb_entry = __s390_enable_skey_hugetlb,
+		.pte_entry = __s390_enable_skey_pte,
+	};
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int rc = 0;
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 552f898..cf05681 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -13,7 +13,7 @@
 
 static inline unsigned long sske_frame(unsigned long addr, unsigned char skey)
 {
-	asm volatile(".insn rrf,0xb22b0000,%[skey],%[addr],9,0"
+	asm volatile(".insn rrf,0xb22b0000,%[skey],%[addr],1,0"
 		     : [addr] "+a" (addr) : [skey] "d" (skey));
 	return addr;
 }
@@ -22,8 +22,6 @@ void __storage_key_init_range(unsigned long start, unsigned long end)
 {
 	unsigned long boundary, size;
 
-	if (!PAGE_DEFAULT_KEY)
-		return;
 	while (start < end) {
 		if (MACHINE_HAS_EDAT1) {
 			/* set storage keys for a 1MB frame */
@@ -36,7 +34,7 @@ void __storage_key_init_range(unsigned long start, unsigned long end)
 				continue;
 			}
 		}
-		page_set_storage_key(start, PAGE_DEFAULT_KEY, 0);
+		page_set_storage_key(start, PAGE_DEFAULT_KEY, 1);
 		start += PAGE_SIZE;
 	}
 }
-- 
2.7.4

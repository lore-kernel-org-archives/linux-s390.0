From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
Date: Tue, 26 Jan 2016 10:18:24 +0100
Message-ID: <1453799905-10941-3-git-send-email-borntraeger@de.ibm.com>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We can use debug_pagealloc_enabled() to check if we can map
the identity mapping with 2MB pages. We can also add the state
into the dump_stack output.

The patch does not touch the code for the 1GB pages, which ignored
CONFIG_DEBUG_PAGEALLOC. Do we need to fence this as well?

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/x86/kernel/dumpstack.c |  4 +++-
 arch/x86/mm/init.c          |  7 ++++---
 arch/x86/mm/pageattr.c      | 14 ++++----------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 9c30acf..7971638 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -266,7 +266,9 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	printk("SMP ");
 #endif
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC ");
+	printk("DEBUG_PAGEALLOC(%s) ",
+		debug_pagealloc_enabled() ? "enabled" : "disabled");
+
 #endif
 #ifdef CONFIG_KASAN
 	printk("KASAN");
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 493f541..39823fd 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -150,13 +150,14 @@ static int page_size_mask;
 
 static void __init probe_page_size_mask(void)
 {
-#if !defined(CONFIG_DEBUG_PAGEALLOC) && !defined(CONFIG_KMEMCHECK)
+#if !defined(CONFIG_KMEMCHECK)
 	/*
-	 * For CONFIG_DEBUG_PAGEALLOC, identity mapping will use small pages.
+	 * For CONFIG_KMEMCHECK or pagealloc debugging, identity mapping will
+	 * use small pages.
 	 * This will simplify cpa(), which otherwise needs to support splitting
 	 * large pages into small in interrupt context, etc.
 	 */
-	if (cpu_has_pse)
+	if (cpu_has_pse && !debug_pagealloc_enabled())
 		page_size_mask |= 1 << PG_LEVEL_2M;
 #endif
 
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index a3137a4..a49c8fd 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -103,12 +103,6 @@ static inline unsigned long highmap_end_pfn(void)
 
 #endif
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-# define debug_pagealloc 1
-#else
-# define debug_pagealloc 0
-#endif
-
 static inline int
 within(unsigned long addr, unsigned long start, unsigned long end)
 {
@@ -703,10 +697,10 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 {
 	struct page *base;
 
-	if (!debug_pagealloc)
+	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
 	base = alloc_pages(GFP_KERNEL | __GFP_NOTRACK, 0);
-	if (!debug_pagealloc)
+	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
 	if (!base)
 		return -ENOMEM;
@@ -1326,10 +1320,10 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 		if (cpa->flags & (CPA_ARRAY | CPA_PAGES_ARRAY))
 			cpa->numpages = 1;
 
-		if (!debug_pagealloc)
+		if (!debug_pagealloc_enabled())
 			spin_lock(&cpa_lock);
 		ret = __change_page_attr(cpa, checkalias);
-		if (!debug_pagealloc)
+		if (!debug_pagealloc_enabled())
 			spin_unlock(&cpa_lock);
 		if (ret)
 			return ret;
-- 
2.3.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

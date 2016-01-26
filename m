From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 1/3] mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
Date: Tue, 26 Jan 2016 10:18:23 +0100
Message-ID: <1453799905-10941-2-git-send-email-borntraeger@de.ibm.com>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We can provide debug_pagealloc_enabled() also if CONFIG_DEBUG_PAGEALLOC
is not set. It will return false in that case.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7783073..fbc5354 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2148,6 +2148,10 @@ kernel_map_pages(struct page *page, int numpages, int enable)
 extern bool kernel_page_present(struct page *page);
 #endif /* CONFIG_HIBERNATION */
 #else
+static inline bool debug_pagealloc_enabled(void)
+{
+	return false;
+}
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 #ifdef CONFIG_HIBERNATION
-- 
2.3.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

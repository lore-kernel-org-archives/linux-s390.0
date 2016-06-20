From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] mm/page_ref: introduce page_ref_inc_return
Date: Mon, 20 Jun 2016 12:38:13 +0200
Message-ID: <1466419093-114348-2-git-send-email-borntraeger@de.ibm.com>
References: <1466419093-114348-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1466419093-114348-1-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's introduce that helper.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/page_ref.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 8b5e0a9..610e132 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -124,6 +124,15 @@ static inline int page_ref_sub_and_test(struct page *page, int nr)
 	return ret;
 }
 
+static inline int page_ref_inc_return(struct page *page)
+{
+	int ret = atomic_inc_return(&page->_refcount);
+
+	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, 1, ret);
+	return ret;
+}
+
 static inline int page_ref_dec_and_test(struct page *page)
 {
 	int ret = atomic_dec_and_test(&page->_refcount);
-- 
2.5.5

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

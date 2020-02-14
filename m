Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbgBNW1r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:47 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 40/42] example for future extension: mm:gup/writeback: add callbacks for inaccessible pages: source indication
Date: Fri, 14 Feb 2020 17:26:56 -0500
Message-Id: <20200214222658.12946-41-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

We might want to do different things depending on where we are coming
from.

Cc: Will Deacon <will@kernel.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
[borntraeger@de.ibm.com: patch description]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/gfp.h | 8 +++++++-
 mm/gup.c            | 4 ++--
 mm/page-writeback.c | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index be2754841369..a15fcb361e7c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -485,8 +485,14 @@ static inline void arch_free_page(struct page *page, int order) { }
 #ifndef HAVE_ARCH_ALLOC_PAGE
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
+enum access_type {
+	MAKE_ACCESSIBLE_GENERIC,
+	MAKE_ACCESSIBLE_GET,
+	MAKE_ACCESSIBLE_GET_FAST,
+	MAKE_ACCESSIBLE_WRITEBACK
+};
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
-static inline int arch_make_page_accessible(struct page *page)
+static inline int arch_make_page_accessible(struct page *page, int where)
 {
 	return 0;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 354bcfbd844b..ce962c155724 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -274,7 +274,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			page = ERR_PTR(-ENOMEM);
 			goto out;
 		}
-		ret = arch_make_page_accessible(page);
+		ret = arch_make_page_accessible(page, MAKE_ACCESSIBLE_GET);
 		if (ret) {
 			put_page(page);
 			page = ERR_PTR(ret);
@@ -1923,7 +1923,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 		VM_BUG_ON_PAGE(compound_head(page) != head, page);
 
-		ret = arch_make_page_accessible(page);
+		ret = arch_make_page_accessible(page, MAKE_ACCESSIBLE_GET_FAST);
 		if (ret) {
 			put_page(head);
 			goto pte_unmap;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 558d7063c117..f85148e59800 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2811,7 +2811,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 	 * If writeback has been triggered on a page that cannot be made
 	 * accessible, it is too late.
 	 */
-	WARN_ON(arch_make_page_accessible(page));
+	WARN_ON(arch_make_page_accessible(page, MAKE_ACCESSIBLE_WRITEBACK));
 	return ret;
 
 }
-- 
2.25.0

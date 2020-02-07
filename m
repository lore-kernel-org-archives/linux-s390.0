Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbgBGLkG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:06 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible pages
Date: Fri,  7 Feb 2020 06:39:24 -0500
Message-Id: <20200207113958.7320-2-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

With the introduction of protected KVM guests on s390 there is now a
concept of inaccessible pages. These pages need to be made accessible
before the host can access them.

While cpu accesses will trigger a fault that can be resolved, I/O
accesses will just fail.  We need to add a callback into architecture
code for places that will do I/O, namely when writeback is started or
when a page reference is taken.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/gfp.h | 6 ++++++
 mm/gup.c            | 2 ++
 mm/page-writeback.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..be2754841369 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -485,6 +485,12 @@ static inline void arch_free_page(struct page *page, int order) { }
 #ifndef HAVE_ARCH_ALLOC_PAGE
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
+#ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
+static inline int arch_make_page_accessible(struct page *page)
+{
+	return 0;
+}
+#endif
 
 struct page *
 __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
diff --git a/mm/gup.c b/mm/gup.c
index 7646bf993b25..a01262cd2821 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -257,6 +257,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			page = ERR_PTR(-ENOMEM);
 			goto out;
 		}
+		arch_make_page_accessible(page);
 	}
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) &&
@@ -1870,6 +1871,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 
 		VM_BUG_ON_PAGE(compound_head(page) != head, page);
 
+		arch_make_page_accessible(page);
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		(*nr)++;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2caf780a42e7..0f0bd14571b1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2806,6 +2806,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 		inc_lruvec_page_state(page, NR_WRITEBACK);
 		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 	}
+	arch_make_page_accessible(page);
 	unlock_page_memcg(page);
 	return ret;
 
-- 
2.24.0

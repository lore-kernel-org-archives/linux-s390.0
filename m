Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728178AbgBNW1p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:45 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 41/42] potential fixup for "s390/mm: provide memory management functions for protected KVM guests"
Date: Fri, 14 Feb 2020 17:26:57 -0500
Message-Id: <20200214222658.12946-42-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Needed when "example for future extension: mm:gup/writeback: add
callbacks for inaccessible pages: source indication" is applied.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/page.h | 2 +-
 arch/s390/kernel/uv.c        | 2 +-
 arch/s390/mm/fault.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 4ebcf891ff3c..a658487fe8e7 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -154,7 +154,7 @@ static inline int devmem_is_allowed(unsigned long pfn)
 #define HAVE_ARCH_ALLOC_PAGE
 
 #if IS_ENABLED(CONFIG_PGSTE)
-int arch_make_page_accessible(struct page *page);
+int arch_make_page_accessible(struct page *page, int where);
 #define HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 #endif
 
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index fb606b171f42..5ace77694ed3 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -287,7 +287,7 @@ EXPORT_SYMBOL_GPL(gmap_convert_to_secure);
 /**
  * To be called with the page locked or with an extra reference!
  */
-int arch_make_page_accessible(struct page *page)
+int arch_make_page_accessible(struct page *page, int where)
 {
 	int rc = 0;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 7bd86ebc882f..1f31025bc2cf 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -842,7 +842,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 			up_read(&mm->mmap_sem);
 			break;
 		}
-		if (arch_make_page_accessible(page))
+		if (arch_make_page_accessible(page, MAKE_ACCESSIBLE_GENERIC))
 			send_sig(SIGSEGV, current, 0);
 		put_page(page);
 		up_read(&mm->mmap_sem);
@@ -851,7 +851,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 		page = phys_to_page(addr);
 		if (unlikely(!try_get_page(page)))
 			break;
-		rc = arch_make_page_accessible(page);
+		rc = arch_make_page_accessible(page, MAKE_ACCESSIBLE_GENERIC);
 		put_page(page);
 		if (rc)
 			BUG();
-- 
2.25.0

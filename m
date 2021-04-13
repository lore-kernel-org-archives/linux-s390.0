Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C1C43461
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D0861242
	for <linux-s390@archiver.kernel.org>; Tue, 13 Apr 2021 21:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhDMVY4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 17:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhDMVY4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Apr 2021 17:24:56 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3891C061756;
        Tue, 13 Apr 2021 14:24:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t23so9144204pjy.3;
        Tue, 13 Apr 2021 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuh9Sc/RYtjXzBdNTFFbp+DaukNGNDhP3A6BK4PLHbk=;
        b=dpLkJ6XbI5rtIYwpPZ5jv/8lwJfdyhUYeCwj2FZJPh8vQWTUyx1Cj0VkUxQqhmyKvC
         2LrwJ/pMyonHoxs0eUl6RhEwpI8uC7CtSIJQv8YxYdfoCMLDMPX2kh8f5NroHFFhaT1U
         ZgQ0k16qMgrIZsgyTtcCaG7Y4ghw5qqboqx3JkV+adetlRoig8h5Qf4dfAZ9LX+m8/h+
         Ura50H4N3vsvrjycz6vAA/IuYPMGl/lNnNk3MkNEkw+uODxvzK1fXMtKDxwUUzCoAywW
         xP/ENH3qoKHGvP5/+2Tr97/Qwa6v3d6VgAZHDRvOIYjEWcnWmtmaa1WQFDD7awn5pcuf
         ymeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuh9Sc/RYtjXzBdNTFFbp+DaukNGNDhP3A6BK4PLHbk=;
        b=Jij7y9kM02t79cOBmTiWnoq8OGrMRrDIq5XJe0ZfEVLOHS1W6/KsUpyED7iPxdZAjQ
         1exmbsqUBcr5r1ZNa5YFflQl2QM/DoeESP4WoGI9pY/ohE5LIRPuDieXMSUQUR3EJg2p
         QJKhdkPS3zZI2GaES2k/Kf7idVCvxrjg2b74c/wHoDNz1VOaOSLyVvxtH34rYZiBrWlF
         YM8L+afXw60Eo+kP0bamWf3Qaox9TlCLTjhAfQgYDNtr4tyVi+FwXt9v1kxj7C1gnyao
         JZSCBAAPUzMhAW2XSO7/mM4xp/sVQsDQsDS5C22BvG0vE/cBWVpYvYohuDkW2TDpG6xh
         KY/Q==
X-Gm-Message-State: AOAM532OGaCysDibKVZ8vK8nnPMFSzhdbOe9lyyuCGdgG1SlRQyNUUFR
        PDCH+DYzayJPxP2Qw1sv3zk=
X-Google-Smtp-Source: ABdhPJx8OUOYf9GPNdWTjI/X/v0JsVtCMatdMAanmAaAygiQFqXEXQgpSt7VOkgjdOY3WSiVDAbjFA==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr2035635pjt.173.1618349070963;
        Tue, 13 Apr 2021 14:24:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw24sm3069345pjb.21.2021.04.13.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 14:24:30 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/7] mm: memory: add orig_pmd to struct vm_fault
Date:   Tue, 13 Apr 2021 14:24:10 -0700
Message-Id: <20210413212416.3273-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413212416.3273-1-shy828301@gmail.com>
References: <20210413212416.3273-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add orig_pmd to struct vm_fault so the "orig_pmd" parameter used by huge page
fault could be removed, just like its PTE counterpart does.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h |  9 ++++-----
 include/linux/mm.h      |  3 +++
 mm/huge_memory.c        |  9 ++++++---
 mm/memory.c             | 26 +++++++++++++-------------
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9626fda5efce..3b38070f4337 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -11,7 +11,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *vma);
-void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
+void huge_pmd_set_accessed(struct vm_fault *vmf);
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma);
@@ -24,7 +24,7 @@ static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif
 
-vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
@@ -283,7 +283,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
+vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct page *huge_zero_page;
 
@@ -429,8 +429,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	return NULL;
 }
 
-static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf,
-		pmd_t orig_pmd)
+static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b9041f9925..9c5856f8cc81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -547,6 +547,9 @@ struct vm_fault {
 					 * the 'address'
 					 */
 	pte_t orig_pte;			/* Value of PTE at the time of fault */
+	pmd_t orig_pmd;			/* Value of PMD at the time of fault,
+					 * used by PMD fault only.
+					 */
 
 	struct page *cow_page;		/* Page handler may use for COW fault */
 	struct page *page;		/* ->fault handlers should return a
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..35cac4aeaf68 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1251,11 +1251,12 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
+void huge_pmd_set_accessed(struct vm_fault *vmf)
 {
 	pmd_t entry;
 	unsigned long haddr;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	pmd_t orig_pmd = vmf->orig_pmd;
 
 	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
@@ -1272,11 +1273,12 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
 	spin_unlock(vmf->ptl);
 }
 
-vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	pmd_t orig_pmd = vmf->orig_pmd;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
@@ -1412,9 +1414,10 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 }
 
 /* NUMA hinting page fault entry point for trans huge pmds */
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
+vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	pmd_t pmd = vmf->orig_pmd;
 	struct anon_vma *anon_vma = NULL;
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
diff --git a/mm/memory.c b/mm/memory.c
index 4e358601c5d6..e0cbffeceb0b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4232,12 +4232,12 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 }
 
 /* `inline' is required to avoid gcc 4.1.2 build error */
-static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
+static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
+		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
-		return do_huge_pmd_wp_page(vmf, orig_pmd);
+		return do_huge_pmd_wp_page(vmf);
 	}
 	if (vmf->vma->vm_ops->huge_fault) {
 		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
@@ -4464,26 +4464,26 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	} else {
-		pmd_t orig_pmd = *vmf.pmd;
+		vmf.orig_pmd = *vmf.pmd;
 
 		barrier();
-		if (unlikely(is_swap_pmd(orig_pmd))) {
+		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					  !is_pmd_migration_entry(orig_pmd));
-			if (is_pmd_migration_entry(orig_pmd))
+					  !is_pmd_migration_entry(vmf.orig_pmd));
+			if (is_pmd_migration_entry(vmf.orig_pmd))
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(orig_pmd) || pmd_devmap(orig_pmd)) {
-			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf, orig_pmd);
+		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+				return do_huge_pmd_numa_page(&vmf);
 
-			if (dirty && !pmd_write(orig_pmd)) {
-				ret = wp_huge_pmd(&vmf, orig_pmd);
+			if (dirty && !pmd_write(vmf.orig_pmd)) {
+				ret = wp_huge_pmd(&vmf);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
 			} else {
-				huge_pmd_set_accessed(&vmf, orig_pmd);
+				huge_pmd_set_accessed(&vmf);
 				return 0;
 			}
 		}
-- 
2.26.2


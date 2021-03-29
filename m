Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D73C433E0
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A166191F
	for <linux-s390@archiver.kernel.org>; Mon, 29 Mar 2021 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC2SeA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhC2Sdn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Mar 2021 14:33:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F9DC061574;
        Mon, 29 Mar 2021 11:33:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v186so9965332pgv.7;
        Mon, 29 Mar 2021 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9Q4QKqwcQMAORneAc/Zw6kgnKaiAUowUeYEWr15KRM=;
        b=OwnJ6tOZBwLlHpc0ebDRWyjRqOe5wlOc68rT6DL8EwIgfliEEOsx4kr7+6437Hq5Cy
         TqAw24Pdz7TJMOe6YrvLFKX/HljM3xppnXc3zeXw4aVYh3tm9AgnsDRjgdeRteXfC4Oo
         RsihUS7WyDfnFGd67ev834X86ylza1ofNEvZXAatEgYqt5yS/JDuhEgfN0fM72Pc0LY1
         OuPT7TCaOkp12UbmKjchy4kfGgIi5y6v/8drmWp3RsYA/9ZKhtCnVGHxcpxadBFA2ccF
         9dglr+vZIq9gCf8VT/vv1d1WYcaMOwmRIQrY1VhbgjZ604t/UohxrDA6WWj2pIJWcB+M
         ikMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9Q4QKqwcQMAORneAc/Zw6kgnKaiAUowUeYEWr15KRM=;
        b=kcDGrzMIBbvhF4EKTDvKz6kTS+1UDfKsUxlVwlrWIWWzdZW4kljHDW/5Om9mpWoOFY
         JLwv/4UIy75YvougRqDMT2k8QSZki625vcmJNRZ9B/QBaybcpVri5sxb5OEpIBwAisHF
         ygmGKwuqFl3WESK2T0mG+Ng2AtE4iK7eH+Xi/DWbaglGdy3SV6cNu+Av4slOrh+ECR0Y
         WUsTo3n93uPmFliYH8KZGBjkmndRrfwN7Z06wR6KtkzYlgBGwb/moqJcNtxh0Uj5pCSI
         8ltoZXGPOAcRtYO5+S0ThDdeFRuN4saE+jXZqR18K7EsMlvbOuLQq/95MYXFs+uydOIu
         bXFg==
X-Gm-Message-State: AOAM531NlWB278v/FCyiEQlsRKt1UNKiwvOsiO3SNFq87Pk44AS+v9bZ
        sg6dHAXSH3LofTubrETFxD10EQ9yV5v3MA==
X-Google-Smtp-Source: ABdhPJzhvTRzixfphyZwE7maKYPzou0OjZIKCuU+hpHgC+xpcrBruTrZjEbYxwVb/7idZkqemxbmfQ==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr24897581pgv.77.1617042822827;
        Mon, 29 Mar 2021 11:33:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x11sm1151158pjh.0.2021.03.29.11.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:33:41 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, ying.huang@intel.com, hughd@google.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm: memory: add orig_pmd to struct vm_fault
Date:   Mon, 29 Mar 2021 11:33:07 -0700
Message-Id: <20210329183312.178266-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329183312.178266-1-shy828301@gmail.com>
References: <20210329183312.178266-1-shy828301@gmail.com>
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
 include/linux/mm.h      |  1 +
 mm/huge_memory.c        |  9 ++++++---
 mm/memory.c             | 26 +++++++++++++-------------
 4 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ba973efcd369..5650db25a49d 100644
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
@@ -286,7 +286,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
+vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct page *huge_zero_page;
 
@@ -432,8 +432,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	return NULL;
 }
 
-static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf,
-		pmd_t orig_pmd)
+static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..899f55d46fba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -528,6 +528,7 @@ struct vm_fault {
 					 * the 'address'
 					 */
 	pte_t orig_pte;			/* Value of PTE at the time of fault */
+	pmd_t orig_pmd;			/* Value of PMD at the time of fault */
 
 	struct page *cow_page;		/* Page handler may use for COW fault */
 	struct page *page;		/* ->fault handlers should return a
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ae907a9c2050..53f3843ce72a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1252,11 +1252,12 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
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
@@ -1273,11 +1274,12 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
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
@@ -1413,9 +1415,10 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
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
index 5efa07fb6cdc..33be5811ac65 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4193,12 +4193,12 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
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
@@ -4425,26 +4425,26 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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


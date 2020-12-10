Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387518AbgLJOyM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 09:54:12 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/4] s390/gmap: make gmap memcg aware
Date: Thu, 10 Dec 2020 15:25:57 +0100
Message-Id: <20201210142600.6771-3-borntraeger@de.ibm.com>
In-Reply-To: <20201210142600.6771-1-borntraeger@de.ibm.com>
References: <20201210142600.6771-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

gmap allocations can be attributed to a process.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/mm/gmap.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index cfb0017f33a7..0160ac97a27d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2,7 +2,7 @@
 /*
  *  KVM guest address space mapping code
  *
- *    Copyright IBM Corp. 2007, 2016, 2018
+ *    Copyright IBM Corp. 2007, 2020
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  *		 David Hildenbrand <david@redhat.com>
  *		 Janosch Frank <frankja@linux.vnet.ibm.com>
@@ -56,19 +56,19 @@ static struct gmap *gmap_alloc(unsigned long limit)
 		atype = _ASCE_TYPE_REGION1;
 		etype = _REGION1_ENTRY_EMPTY;
 	}
-	gmap = kzalloc(sizeof(struct gmap), GFP_KERNEL);
+	gmap = kzalloc(sizeof(struct gmap), GFP_KERNEL_ACCOUNT);
 	if (!gmap)
 		goto out;
 	INIT_LIST_HEAD(&gmap->crst_list);
 	INIT_LIST_HEAD(&gmap->children);
 	INIT_LIST_HEAD(&gmap->pt_list);
-	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL);
-	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC);
-	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
+	INIT_RADIX_TREE(&gmap->guest_to_host, GFP_KERNEL_ACCOUNT);
+	INIT_RADIX_TREE(&gmap->host_to_guest, GFP_ATOMIC | __GFP_ACCOUNT);
+	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC | __GFP_ACCOUNT);
 	spin_lock_init(&gmap->guest_table_lock);
 	spin_lock_init(&gmap->shadow_lock);
 	refcount_set(&gmap->ref_count, 1);
-	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		goto out_free;
 	page->index = 0;
@@ -309,7 +309,7 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 	unsigned long *new;
 
 	/* since we dont free the gmap table until gmap_free we can unlock */
-	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
 	new = (unsigned long *) page_to_phys(page);
@@ -594,7 +594,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	if (pmd_large(*pmd) && !gmap->mm->context.allow_gmap_hpage_1m)
 		return -EFAULT;
 	/* Link gmap segment table entry location to page table. */
-	rc = radix_tree_preload(GFP_KERNEL);
+	rc = radix_tree_preload(GFP_KERNEL_ACCOUNT);
 	if (rc)
 		return rc;
 	ptl = pmd_lock(mm, pmd);
@@ -1218,11 +1218,11 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		vmaddr = __gmap_translate(parent, paddr);
 		if (IS_ERR_VALUE(vmaddr))
 			return vmaddr;
-		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
+		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL_ACCOUNT);
 		if (!rmap)
 			return -ENOMEM;
 		rmap->raddr = raddr;
-		rc = radix_tree_preload(GFP_KERNEL);
+		rc = radix_tree_preload(GFP_KERNEL_ACCOUNT);
 		if (rc) {
 			kfree(rmap);
 			return rc;
@@ -1741,7 +1741,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 
 	BUG_ON(!gmap_is_shadow(sg));
 	/* Allocate a shadow region second table */
-	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
 	page->index = r2t & _REGION_ENTRY_ORIGIN;
@@ -1825,7 +1825,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 
 	BUG_ON(!gmap_is_shadow(sg));
 	/* Allocate a shadow region second table */
-	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
 	page->index = r3t & _REGION_ENTRY_ORIGIN;
@@ -1909,7 +1909,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 
 	BUG_ON(!gmap_is_shadow(sg) || (sgt & _REGION3_ENTRY_LARGE));
 	/* Allocate a shadow segment table */
-	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
 	page->index = sgt & _REGION_ENTRY_ORIGIN;
@@ -2116,7 +2116,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 	parent = sg->parent;
 	prot = (pte_val(pte) & _PAGE_PROTECT) ? PROT_READ : PROT_WRITE;
 
-	rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
+	rmap = kzalloc(sizeof(*rmap), GFP_KERNEL_ACCOUNT);
 	if (!rmap)
 		return -ENOMEM;
 	rmap->raddr = (saddr & PAGE_MASK) | _SHADOW_RMAP_PGTABLE;
@@ -2128,7 +2128,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 			rc = vmaddr;
 			break;
 		}
-		rc = radix_tree_preload(GFP_KERNEL);
+		rc = radix_tree_preload(GFP_KERNEL_ACCOUNT);
 		if (rc)
 			break;
 		rc = -EAGAIN;
-- 
2.28.0

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727356AbhAMJmX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:23 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 07/14] s390/mm: factor out idte global flush into gmap_idte_global
Date: Wed, 13 Jan 2021 09:41:06 +0000
Message-Id: <20210113094113.133668-8-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Introduce a function to do a idte global flush on a gmap pmd and
remove some code duplication.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b7199c55f98a..f89e710c31af 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1009,6 +1009,18 @@ static pte_t *gmap_pte_from_pmd(struct gmap *gmap, pmd_t *pmdp,
 	return pte_offset_map(pmdp, addr);
 }
 
+static inline void gmap_idte_global(unsigned long asce, pmd_t *pmdp,
+				    unsigned long gaddr)
+{
+	if (MACHINE_HAS_TLB_GUEST)
+		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, asce,
+			    IDTE_GLOBAL);
+	else if (MACHINE_HAS_IDTE)
+		__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
+	else
+		__pmdp_csp(pmdp);
+}
+
 /**
  * gmap_pmd_split_free - Free a split pmd's page table
  * @pmdp The split pmd that we free of its page table
@@ -2468,13 +2480,7 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 	pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
 	if (pmd_large(new))
 		pmd_val(new) &= ~GMAP_SEGMENT_NOTIFY_BITS;
-	if (MACHINE_HAS_TLB_GUEST)
-		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, gmap->asce,
-			    IDTE_GLOBAL);
-	else if (MACHINE_HAS_IDTE)
-		__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
-	else
-		__pmdp_csp(pmdp);
+	gmap_idte_global(gmap->asce, pmdp, gaddr);
 	*pmdp = new;
 }
 
@@ -2587,13 +2593,7 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 			pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
 			if (pmd_large(*pmdp))
 				WARN_ON(*entry & GMAP_SEGMENT_NOTIFY_BITS);
-			if (MACHINE_HAS_TLB_GUEST)
-				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
-					    gmap->asce, IDTE_GLOBAL);
-			else if (MACHINE_HAS_IDTE)
-				__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
-			else
-				__pmdp_csp(pmdp);
+			gmap_idte_global(gmap->asce, pmdp, gaddr);
 			gmap_pmd_split_free(gmap, pmdp);
 			*entry = _SEGMENT_ENTRY_EMPTY;
 		}
-- 
2.27.0

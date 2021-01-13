Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727345AbhAMJmZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:25 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 13/14] s390/mm: Pull pmd invalid check in gmap_pmd_op_walk
Date: Wed, 13 Jan 2021 09:41:12 +0000
Message-Id: <20210113094113.133668-14-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Not yet sure if I'll keep this.

The walk should only walk and not check I, but then it looks way
nicer.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bc89fb974367..c4778ded8450 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -956,7 +956,8 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr,
 	}
 
 	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
-	if (!pmdp || pmd_none(*pmdp)) {
+	if (!pmdp || pmd_none(*pmdp) ||
+	    pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID) {
 		if (*ptl)
 			spin_unlock(*ptl);
 		pmdp = NULL;
@@ -1165,7 +1166,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			return vmaddr;
 		vmaddr |= gaddr & ~PMD_MASK;
 		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
-		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr,
 							 &ptl_pte);
@@ -1274,7 +1275,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 		if (IS_ERR_VALUE(vmaddr))
 			return vmaddr;
 		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
-		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				ptep = gmap_pte_from_pmd(gmap, pmdp, vmaddr, &ptl_pte);
 				if (ptep) {
@@ -1388,7 +1389,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			return vmaddr;
 		vmaddr |= paddr & ~PMD_MASK;
 		pmdp = gmap_pmd_op_walk(parent, paddr, vmaddr, &ptl_pmd);
-		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				ptl_pte = NULL;
 				ptep = gmap_pte_from_pmd(parent, pmdp, paddr,
@@ -2378,8 +2379,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 				break;
 			}
 			spmd = *spmdp;
-			if (!(pmd_val(spmd) & _SEGMENT_ENTRY_INVALID) &&
-			    !((pmd_val(spmd) & _SEGMENT_ENTRY_PROTECT) &&
+			if (!((pmd_val(spmd) & _SEGMENT_ENTRY_PROTECT) &&
 			      !(pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT))) {
 
 				pmd_val(*spmdp) |= _SEGMENT_ENTRY_GMAP_VSIE;
@@ -2452,7 +2452,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 			break;
 		rc = -EAGAIN;
 		spmdp = gmap_pmd_op_walk(parent, paddr, vmaddr, &ptl_pmd);
-		if (spmdp && !(pmd_val(*spmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (spmdp) {
 			/* Get page table pointer */
 			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
 			if (!tptep) {
@@ -2886,9 +2886,6 @@ static bool gmap_test_and_clear_dirty_pmd(struct gmap *gmap, pmd_t *pmdp,
 					  unsigned long gaddr,
 					  unsigned long vmaddr)
 {
-	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
-		return false;
-
 	/* Already protected memory, which did not change is clean */
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT &&
 	    !(pmd_val(*pmdp) & _SEGMENT_ENTRY_GMAP_UC))
-- 
2.27.0

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727366AbhAMJmX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:23 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 03/14] s390/mm: Take locking out of gmap_protect_pte
Date: Wed, 13 Jan 2021 09:41:02 +0000
Message-Id: <20210113094113.133668-4-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Locking outside of the function gives us the freedom of ordering
locks, which will be important to not get locking issues for
gmap_protect_rmap.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 650c51749f4d..c38f49dedf35 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1017,25 +1017,15 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
  * Expected to be called with sg->mm->mmap_lock in read
  */
 static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
-			    pmd_t *pmdp, int prot, unsigned long bits)
+			    pte_t *ptep, int prot, unsigned long bits)
 {
 	int rc;
-	pte_t *ptep;
-	spinlock_t *ptl = NULL;
 	unsigned long pbits = 0;
 
-	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
-		return -EAGAIN;
-
-	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
-	if (!ptep)
-		return -ENOMEM;
-
 	pbits |= (bits & GMAP_NOTIFY_MPROT) ? PGSTE_IN_BIT : 0;
 	pbits |= (bits & GMAP_NOTIFY_SHADOW) ? PGSTE_VSIE_BIT : 0;
 	/* Protect and unlock. */
 	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
-	gmap_pte_op_end(ptl);
 	return rc;
 }
 
@@ -1056,18 +1046,26 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
 	unsigned long vmaddr, dist;
-	spinlock_t *ptl = NULL;
+	spinlock_t *ptl_pmd = NULL, *ptl_pte = NULL;
 	pmd_t *pmdp;
+	pte_t *ptep;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
 	while (len) {
 		rc = -EAGAIN;
-		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl);
+		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl_pmd);
 		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
-				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-						      bits);
+				ptl_pte = NULL;
+				ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr,
+							  &ptl_pte);
+				if (ptep)
+					rc = gmap_protect_pte(gmap, gaddr,
+							      ptep, prot, bits);
+				else
+					rc = -ENOMEM;
+				gmap_pte_op_end(ptl_pte);
 				if (!rc) {
 					len -= PAGE_SIZE;
 					gaddr += PAGE_SIZE;
@@ -1081,7 +1079,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
 				}
 			}
-			gmap_pmd_op_end(ptl);
+			gmap_pmd_op_end(ptl_pmd);
 		}
 		if (rc) {
 			if (rc == -EINVAL)
-- 
2.27.0

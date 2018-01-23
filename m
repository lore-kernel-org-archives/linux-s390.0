From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] s390x/mm: simplify gmap_protect_rmap()
Date: Tue, 23 Jan 2018 22:26:18 +0100
Message-ID: <20180123212618.32611-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

We never call it with anything but PROT_READ. This is a left over from
an old prototype. For creation of shadow page tables, we always only
have to protect the original table in guest memory from write accesses,
so we can properly invalidate the shadow on writes. Other protections
are not needed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 54cfd51a5a27..a7e05c5dea70 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1021,18 +1021,17 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 }
 
 /**
- * gmap_protect_rmap - modify access rights to memory and create an rmap
+ * gmap_protect_rmap - restrict access rights to memory (RO) and create an rmap
  * @sg: pointer to the shadow guest address space structure
  * @raddr: rmap address in the shadow gmap
  * @paddr: address in the parent guest address space
  * @len: length of the memory area to protect
- * @prot: indicates access rights: none, read-only or read-write
  *
  * Returns 0 if successfully protected and the rmap was created, -ENOMEM
  * if out of memory and -EFAULT if paddr is invalid.
  */
 static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
-			     unsigned long paddr, unsigned long len, int prot)
+			     unsigned long paddr, unsigned long len)
 {
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
@@ -1060,7 +1059,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		ptep = gmap_pte_op_walk(parent, paddr, &ptl);
 		if (ptep) {
 			spin_lock(&sg->guest_table_lock);
-			rc = ptep_force_prot(parent->mm, paddr, ptep, prot,
+			rc = ptep_force_prot(parent->mm, paddr, ptep, PROT_READ,
 					     PGSTE_VSIE_BIT);
 			if (!rc)
 				gmap_insert_rmap(sg, vmaddr, rmap);
@@ -1070,7 +1069,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		radix_tree_preload_end();
 		if (rc) {
 			kfree(rmap);
-			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
+			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, PROT_READ);
 			if (rc)
 				return rc;
 			continue;
@@ -1609,7 +1608,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	origin = r2t & _REGION_ENTRY_ORIGIN;
 	offset = ((r2t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r2t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
-	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
+	rc = gmap_protect_rmap(sg, raddr, origin + offset, len);
 	spin_lock(&sg->guest_table_lock);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 4);
@@ -1692,7 +1691,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	origin = r3t & _REGION_ENTRY_ORIGIN;
 	offset = ((r3t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((r3t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
-	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
+	rc = gmap_protect_rmap(sg, raddr, origin + offset, len);
 	spin_lock(&sg->guest_table_lock);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 3);
@@ -1776,7 +1775,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	origin = sgt & _REGION_ENTRY_ORIGIN;
 	offset = ((sgt & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
 	len = ((sgt & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
-	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
+	rc = gmap_protect_rmap(sg, raddr, origin + offset, len);
 	spin_lock(&sg->guest_table_lock);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 2);
@@ -1895,7 +1894,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	/* Make pgt read-only in parent gmap page table (not the pgste) */
 	raddr = (saddr & _SEGMENT_MASK) | _SHADOW_RMAP_SEGMENT;
 	origin = pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
-	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE, PROT_READ);
+	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE);
 	spin_lock(&sg->guest_table_lock);
 	if (!rc) {
 		table = gmap_table_walk(sg, saddr, 1);
-- 
2.14.3

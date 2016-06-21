From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 23/51] s390/mm: don't fault everything in read-write in gmap_pte_op_fixup()
Date: Tue, 21 Jun 2016 15:13:01 +0200
Message-ID: <1466514809-146638-24-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's not fault in everything in read-write but limit it to read-only
where possible.

When restricting access rights, we already have the required protection
level in our hands. When reading from guest 2 storage (gmap_read_table),
it is obviously PROT_READ. When shadowing a pte, the required protection
level is given via the guest 2 provided pte.

Based on an initial patch by Martin Schwidefsky.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index d00e4ab..738d754 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -811,19 +811,22 @@ static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
  * @vmaddr: address in the host process address space
+ * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
  *
  * Returns 0 if the caller can retry __gmap_translate (might fail again),
  * -ENOMEM if out of memory and -EFAULT if anything goes wrong while fixing
  * up or connecting the gmap page table.
  */
 static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
-			     unsigned long vmaddr)
+			     unsigned long vmaddr, int prot)
 {
 	struct mm_struct *mm = gmap->mm;
+	unsigned int fault_flags;
 	bool unlocked = false;
 
 	BUG_ON(gmap_is_shadow(gmap));
-	if (fixup_user_fault(current, mm, vmaddr, FAULT_FLAG_WRITE, &unlocked))
+	fault_flags = (prot == PROT_WRITE) ? FAULT_FLAG_WRITE : 0;
+	if (fixup_user_fault(current, mm, vmaddr, fault_flags, &unlocked))
 		return -EFAULT;
 	if (unlocked)
 		/* lost mmap_sem, caller has to retry __gmap_translate */
@@ -875,7 +878,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
 				return vmaddr;
-			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr);
+			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
 			if (rc)
 				return rc;
 			continue;
@@ -957,7 +960,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 			rc = vmaddr;
 			break;
 		}
-		rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr);
+		rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, PROT_READ);
 		if (rc)
 			break;
 	}
@@ -1041,7 +1044,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		radix_tree_preload_end();
 		if (rc) {
 			kfree(rmap);
-			rc = gmap_pte_op_fixup(parent, paddr, vmaddr);
+			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
 			if (rc)
 				return rc;
 			continue;
@@ -1910,10 +1913,12 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 	unsigned long vmaddr, paddr;
 	spinlock_t *ptl;
 	pte_t *sptep, *tptep;
+	int prot;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	parent = sg->parent;
+	prot = (pte_val(pte) & _PAGE_PROTECT) ? PROT_READ : PROT_WRITE;
 
 	rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
 	if (!rmap)
@@ -1955,7 +1960,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 		radix_tree_preload_end();
 		if (!rc)
 			break;
-		rc = gmap_pte_op_fixup(parent, paddr, vmaddr);
+		rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
 		if (rc)
 			break;
 	}
-- 
2.5.5

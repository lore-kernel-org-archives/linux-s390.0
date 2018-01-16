From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/6] s390x/mm: cleanup gmap_pte_op_walk()
Date: Tue, 16 Jan 2018 16:03:09 +0100
Message-ID: <20180116150314.201352-2-borntraeger@de.ibm.com>
References: <20180116150314.201352-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116150314.201352-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

gmap_mprotect_notify() refuses shadow gmaps. Turns out that
a) gmap_protect_range()
b) gmap_read_table()
c) gmap_pte_op_walk()

Are never called for gmap shadows. And never should be. This dates back
to gmap shadow prototypes where we allowed to call mprotect_notify() on
the gmap shadow (to get notified about the prefix pages getting removed).
This is avoided by always getting notified about any change on the gmap
shadow.

The only real function for walking page tables on shadow gmaps is
gmap_table_walk().

So, essentially, these functions should never get called and
gmap_pte_op_walk() can be cleaned up. Add some checks to callers of
gmap_pte_op_walk().

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171110151805.7541-1-david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 05d459b638f5..54cfd51a5a27 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -815,27 +815,17 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
  * @ptl: pointer to the spinlock pointer
  *
  * Returns a pointer to the locked pte for a guest address, or NULL
- *
- * Note: Can also be called for shadow gmaps.
  */
 static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
 			       spinlock_t **ptl)
 {
 	unsigned long *table;
 
-	if (gmap_is_shadow(gmap))
-		spin_lock(&gmap->guest_table_lock);
+	BUG_ON(gmap_is_shadow(gmap));
 	/* Walk the gmap page table, lock and get pte pointer */
 	table = gmap_table_walk(gmap, gaddr, 1); /* get segment pointer */
-	if (!table || *table & _SEGMENT_ENTRY_INVALID) {
-		if (gmap_is_shadow(gmap))
-			spin_unlock(&gmap->guest_table_lock);
+	if (!table || *table & _SEGMENT_ENTRY_INVALID)
 		return NULL;
-	}
-	if (gmap_is_shadow(gmap)) {
-		*ptl = &gmap->guest_table_lock;
-		return pte_offset_map((pmd_t *) table, gaddr);
-	}
 	return pte_alloc_map_lock(gmap->mm, (pmd_t *) table, gaddr, ptl);
 }
 
@@ -889,8 +879,6 @@ static void gmap_pte_op_end(spinlock_t *ptl)
  * -EFAULT if gaddr is invalid (or mapping for shadows is missing).
  *
  * Called with sg->mm->mmap_sem in read.
- *
- * Note: Can also be called for shadow gmaps.
  */
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
@@ -900,6 +888,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 	pte_t *ptep;
 	int rc;
 
+	BUG_ON(gmap_is_shadow(gmap));
 	while (len) {
 		rc = -EAGAIN;
 		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
@@ -960,7 +949,8 @@ EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
  * @val: pointer to the unsigned long value to return
  *
  * Returns 0 if the value was read, -ENOMEM if out of memory and -EFAULT
- * if reading using the virtual address failed.
+ * if reading using the virtual address failed. -EINVAL if called on a gmap
+ * shadow.
  *
  * Called with gmap->mm->mmap_sem in read.
  */
@@ -971,6 +961,9 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 	pte_t *ptep, pte;
 	int rc;
 
+	if (gmap_is_shadow(gmap))
+		return -EINVAL;
+
 	while (1) {
 		rc = -EAGAIN;
 		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
-- 
2.13.4

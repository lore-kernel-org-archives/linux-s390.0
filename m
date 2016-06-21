From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/51] s390/mm: prepare for EDAT1/EDAT2 support in gmap shadow
Date: Tue, 21 Jun 2016 15:12:53 +0200
Message-ID: <1466514809-146638-16-git-send-email-borntraeger@de.ibm.com>
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

In preparation for EDAT1/EDAT2 support for gmap shadows, we have to store
the requested edat level in the gmap shadow.

The edat level used during shadow translation is a property of the gmap
shadow. Depending on that level, the gmap shadow will look differently for
the same guest tables. We have to store it internally in order to support
it later.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  5 ++++-
 arch/s390/mm/gmap.c          | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 54a2487..2ab397c 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -26,6 +26,7 @@
  * @shadow_lock: spinlock to protect the shadow gmap list
  * @parent: pointer to the parent gmap for shadow guest address spaces
  * @orig_asce: ASCE for which the shadow page table has been created
+ * @edat_level: edat level to be used for the shadow translation
  * @removed: flag to indicate if a shadow guest address space has been removed
  * @initialized: flag to indicate if a shadow guest address space can be used
  */
@@ -49,6 +50,7 @@ struct gmap {
 	spinlock_t shadow_lock;
 	struct gmap *parent;
 	unsigned long orig_asce;
+	int edat_level;
 	bool removed;
 	bool initialized;
 };
@@ -105,7 +107,8 @@ void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr)
 
 int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
 
-struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce);
+struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
+			 int edat_level);
 int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t);
 int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t);
 int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a7dfb33..f0b2a531 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1382,17 +1382,20 @@ static void gmap_unshadow(struct gmap *sg)
  * gmap_find_shadow - find a specific asce in the list of shadow tables
  * @parent: pointer to the parent gmap
  * @asce: ASCE for which the shadow table is created
+ * @edat_level: edat level to be used for the shadow translation
  *
  * Returns the pointer to a gmap if a shadow table with the given asce is
  * already available, ERR_PTR(-EAGAIN) if another one is just being created,
  * otherwise NULL
  */
-static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
+static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
+				     int edat_level)
 {
 	struct gmap *sg;
 
 	list_for_each_entry(sg, &parent->children, list) {
-		if (sg->orig_asce != asce || sg->removed)
+		if (sg->orig_asce != asce || sg->edat_level != edat_level ||
+		    sg->removed)
 			continue;
 		if (!sg->initialized)
 			return ERR_PTR(-EAGAIN);
@@ -1406,6 +1409,7 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
  * gmap_shadow - create/find a shadow guest address space
  * @parent: pointer to the parent gmap
  * @asce: ASCE for which the shadow table is created
+ * @edat_level: edat level to be used for the shadow translation
  *
  * The pages of the top level page table referred by the asce parameter
  * will be set to read-only and marked in the PGSTEs of the kvm process.
@@ -1416,7 +1420,8 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
  * ERR_PTR(-EAGAIN) if the caller has to retry and ERR_PTR(-EFAULT) if the
  * parent gmap table could not be protected.
  */
-struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce)
+struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
+			 int edat_level)
 {
 	struct gmap *sg, *new;
 	unsigned long limit;
@@ -1424,7 +1429,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce)
 
 	BUG_ON(gmap_is_shadow(parent));
 	spin_lock(&parent->shadow_lock);
-	sg = gmap_find_shadow(parent, asce);
+	sg = gmap_find_shadow(parent, asce, edat_level);
 	spin_unlock(&parent->shadow_lock);
 	if (sg)
 		return sg;
@@ -1436,10 +1441,11 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce)
 	new->mm = parent->mm;
 	new->parent = gmap_get(parent);
 	new->orig_asce = asce;
+	new->edat_level = edat_level;
 	new->initialized = false;
 	spin_lock(&parent->shadow_lock);
 	/* Recheck if another CPU created the same shadow */
-	sg = gmap_find_shadow(parent, asce);
+	sg = gmap_find_shadow(parent, asce, edat_level);
 	if (sg) {
 		spin_unlock(&parent->shadow_lock);
 		gmap_free(new);
-- 
2.5.5

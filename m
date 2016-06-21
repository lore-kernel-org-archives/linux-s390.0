From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/51] s390/mm: fix races on gmap_shadow creation
Date: Tue, 21 Jun 2016 15:12:48 +0200
Message-ID: <1466514809-146638-11-git-send-email-borntraeger@de.ibm.com>
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

Before any thread is allowed to use a gmap_shadow, it has to be fully
initialized. However, for invalidation to work properly, we have to
register the new gmap_shadow before we protect the parent gmap table.

Because locking is tricky, and we have to avoid duplicate gmaps, let's
introduce an initialized field, that signalizes other threads if that
gmap_shadow can already be used or if they have to retry.

Let's properly return errors using ERR_PTR() instead of simply returning
NULL, so a caller can properly react on the error.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  2 ++
 arch/s390/mm/gmap.c          | 45 +++++++++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 4a47055..54a2487 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -27,6 +27,7 @@
  * @parent: pointer to the parent gmap for shadow guest address spaces
  * @orig_asce: ASCE for which the shadow page table has been created
  * @removed: flag to indicate if a shadow guest address space has been removed
+ * @initialized: flag to indicate if a shadow guest address space can be used
  */
 struct gmap {
 	struct list_head list;
@@ -49,6 +50,7 @@ struct gmap {
 	struct gmap *parent;
 	unsigned long orig_asce;
 	bool removed;
+	bool initialized;
 };
 
 /**
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a396e58..a7dfb33 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1384,7 +1384,8 @@ static void gmap_unshadow(struct gmap *sg)
  * @asce: ASCE for which the shadow table is created
  *
  * Returns the pointer to a gmap if a shadow table with the given asce is
- * already available, otherwise NULL
+ * already available, ERR_PTR(-EAGAIN) if another one is just being created,
+ * otherwise NULL
  */
 static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
 {
@@ -1393,6 +1394,8 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
 	list_for_each_entry(sg, &parent->children, list) {
 		if (sg->orig_asce != asce || sg->removed)
 			continue;
+		if (!sg->initialized)
+			return ERR_PTR(-EAGAIN);
 		atomic_inc(&sg->ref_count);
 		return sg;
 	}
@@ -1409,8 +1412,9 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce)
  * The shadow table will be removed automatically on any change to the
  * PTE mapping for the source table.
  *
- * Returns a guest address space structure, NULL if out of memory or if
- * anything goes wrong while protecting the top level pages.
+ * Returns a guest address space structure, ERR_PTR(-ENOMEM) if out of memory,
+ * ERR_PTR(-EAGAIN) if the caller has to retry and ERR_PTR(-EFAULT) if the
+ * parent gmap table could not be protected.
  */
 struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce)
 {
@@ -1428,30 +1432,37 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce)
 	limit = -1UL >> (33 - (((asce & _ASCE_TYPE_MASK) >> 2) * 11));
 	new = gmap_alloc(limit);
 	if (!new)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	new->mm = parent->mm;
 	new->parent = gmap_get(parent);
 	new->orig_asce = asce;
+	new->initialized = false;
+	spin_lock(&parent->shadow_lock);
+	/* Recheck if another CPU created the same shadow */
+	sg = gmap_find_shadow(parent, asce);
+	if (sg) {
+		spin_unlock(&parent->shadow_lock);
+		gmap_free(new);
+		return sg;
+	}
+	atomic_set(&new->ref_count, 2);
+	list_add(&new->list, &parent->children);
+	spin_unlock(&parent->shadow_lock);
+	/* protect after insertion, so it will get properly invalidated */
 	down_read(&parent->mm->mmap_sem);
 	rc = gmap_protect_range(parent, asce & _ASCE_ORIGIN,
 				((asce & _ASCE_TABLE_LENGTH) + 1) * 4096,
 				PROT_READ, PGSTE_VSIE_BIT);
 	up_read(&parent->mm->mmap_sem);
+	spin_lock(&parent->shadow_lock);
+	new->initialized = true;
 	if (rc) {
-		atomic_set(&new->ref_count, 2);
-		spin_lock(&parent->shadow_lock);
-		/* Recheck if another CPU created the same shadow */
-		sg = gmap_find_shadow(parent, asce);
-		if (!sg) {
-			list_add(&new->list, &parent->children);
-			sg = new;
-			new = NULL;
-		}
-		spin_unlock(&parent->shadow_lock);
-	}
-	if (new)
+		list_del(&new->list);
 		gmap_free(new);
-	return sg;
+		new = ERR_PTR(rc);
+	}
+	spin_unlock(&parent->shadow_lock);
+	return new;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow);
 
-- 
2.5.5

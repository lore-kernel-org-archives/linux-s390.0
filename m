Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38094 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHSd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Aug 2019 03:18:33 -0400
From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/2] s390/mm: Use refcount_t for refcount
Date: Thu,  8 Aug 2019 15:18:26 +0800
Message-Id: <20190808071826.6649-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/s390/include/asm/gmap.h |  4 +++-
 arch/s390/mm/gmap.c          | 10 +++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index fcbd638fb9f4..37f96b6f0e61 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -9,6 +9,8 @@
 #ifndef _ASM_S390_GMAP_H
 #define _ASM_S390_GMAP_H
 
+#include <linux/refcount.h>
+
 /* Generic bits for GMAP notification on DAT table entry changes. */
 #define GMAP_NOTIFY_SHADOW	0x2
 #define GMAP_NOTIFY_MPROT	0x1
@@ -46,7 +48,7 @@ struct gmap {
 	struct radix_tree_root guest_to_host;
 	struct radix_tree_root host_to_guest;
 	spinlock_t guest_table_lock;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	unsigned long *table;
 	unsigned long asce;
 	unsigned long asce_end;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 39c3a6e3d262..cd8e03f04d6d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -67,7 +67,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	INIT_RADIX_TREE(&gmap->host_to_rmap, GFP_ATOMIC);
 	spin_lock_init(&gmap->guest_table_lock);
 	spin_lock_init(&gmap->shadow_lock);
-	atomic_set(&gmap->ref_count, 1);
+	refcount_set(&gmap->ref_count, 1);
 	page = alloc_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
 	if (!page)
 		goto out_free;
@@ -214,7 +214,7 @@ static void gmap_free(struct gmap *gmap)
  */
 struct gmap *gmap_get(struct gmap *gmap)
 {
-	atomic_inc(&gmap->ref_count);
+	refcount_inc(&gmap->ref_count);
 	return gmap;
 }
 EXPORT_SYMBOL_GPL(gmap_get);
@@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(gmap_get);
  */
 void gmap_put(struct gmap *gmap)
 {
-	if (atomic_dec_return(&gmap->ref_count) == 0)
+	if (refcount_dec_and_test(&gmap->ref_count))
 		gmap_free(gmap);
 }
 EXPORT_SYMBOL_GPL(gmap_put);
@@ -1594,7 +1594,7 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
 			continue;
 		if (!sg->initialized)
 			return ERR_PTR(-EAGAIN);
-		atomic_inc(&sg->ref_count);
+		refcount_inc(&sg->ref_count);
 		return sg;
 	}
 	return NULL;
@@ -1682,7 +1682,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			}
 		}
 	}
-	atomic_set(&new->ref_count, 2);
+	refcount_set(&new->ref_count, 2);
 	list_add(&new->list, &parent->children);
 	if (asce & _ASCE_REAL_SPACE) {
 		/* nothing to protect, return right away */
-- 
2.20.1

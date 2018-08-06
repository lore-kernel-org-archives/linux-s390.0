Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH] s390x/mm: avoid taking the table lock in gmap_pmd_op_walk()
Date: Mon,  6 Aug 2018 17:54:07 +0200
Message-Id: <20180806155407.15252-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Right now we temporarily take the page table lock in gmap_pmd_op_walk()
even though we know we won't need it (if we can never have 1mb pages
mapped into the gmap).

So let's special case this, so
gmap_protect_range()/gmap_sync_dirty_log_pmd() will not take the lock in
case huge pages are not allowed.

gmap_protect_range() is called quite frequently for managing shadow
page tables in vSIE environments.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bb44990c8212..d4fa0a4514e0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -905,10 +905,16 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
 	pmd_t *pmdp;
 
 	BUG_ON(gmap_is_shadow(gmap));
-	spin_lock(&gmap->guest_table_lock);
 	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
+	if (!pmdp)
+		return NULL;
 
-	if (!pmdp || pmd_none(*pmdp)) {
+	/* without huge pages, there is no need to take the table lock */
+	if (!gmap->mm->context.allow_gmap_hpage_1m)
+		return pmd_none(*pmdp) ? NULL : pmdp;
+
+	spin_lock(&gmap->guest_table_lock);
+	if (pmd_none(*pmdp)) {
 		spin_unlock(&gmap->guest_table_lock);
 		return NULL;
 	}
-- 
2.17.1

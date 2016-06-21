From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/51] s390/mm: flush tlb of shadows in all situations
Date: Tue, 21 Jun 2016 15:12:45 +0200
Message-ID: <1466514809-146638-8-git-send-email-borntraeger@de.ibm.com>
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

For now, the tlb of shadow gmap is only flushed when the parent is removed,
not when it is removed upfront. Therefore other shadow gmaps can reuse the
tables without the tlb getting flushed.

Fix this by simply flushing the tlb
1. Before the shadow tables are removed (analogouos to other unshadow functions)
2. When the gmap is freed and therefore the top level pages are freed.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 6695a09..b02d0d0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -173,6 +173,9 @@ static void gmap_free(struct gmap *gmap)
 {
 	struct page *page, *next;
 
+	/* Flush tlb of all gmaps (if not already done for shadows) */
+	if (!(gmap_is_shadow(gmap) && gmap->removed))
+		gmap_flush_tlb(gmap);
 	/* Free all segment & region tables. */
 	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
 		__free_pages(page, 2);
@@ -226,13 +229,10 @@ void gmap_remove(struct gmap *gmap)
 {
 	struct gmap *sg, *next;
 
-	/* Flush tlb. */
-	gmap_flush_tlb(gmap);
 	/* Remove all shadow gmaps linked to this gmap */
 	if (!list_empty(&gmap->children)) {
 		spin_lock(&gmap->shadow_lock);
 		list_for_each_entry_safe(sg, next, &gmap->children, list) {
-			gmap_flush_tlb(sg);
 			list_del(&sg->list);
 			gmap_put(sg);
 		}
@@ -1360,6 +1360,7 @@ static void gmap_unshadow(struct gmap *sg)
 		return;
 	sg->removed = 1;
 	gmap_call_notifier(sg, 0, -1UL);
+	gmap_flush_tlb(sg);
 	table = (unsigned long *)(sg->asce & _ASCE_ORIGIN);
 	switch (sg->asce & _ASCE_TYPE_MASK) {
 	case _ASCE_TYPE_REGION1:
-- 
2.5.5

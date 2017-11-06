From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 11/22] s390/mm: Remove superfluous parameter
Date: Mon,  6 Nov 2017 23:29:49 +0100
Message-ID: <1510007400-42493-12-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

It seems it hasn't even been used before the last cleanup and was
overlooked.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 5f0e696..d23b750 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2247,7 +2247,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_page);
  * Called with sg->parent->shadow_lock.
  */
 static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
-			       unsigned long gaddr, pte_t *pte)
+			       unsigned long gaddr)
 {
 	struct gmap_rmap *rmap, *rnext, *head;
 	unsigned long start, end, bits, raddr;
@@ -2332,7 +2332,7 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 			spin_lock(&gmap->shadow_lock);
 			list_for_each_entry_safe(sg, next,
 						 &gmap->children, list)
-				gmap_shadow_notify(sg, vmaddr, gaddr, pte);
+				gmap_shadow_notify(sg, vmaddr, gaddr);
 			spin_unlock(&gmap->shadow_lock);
 		}
 		if (bits & PGSTE_IN_BIT)
-- 
2.7.4

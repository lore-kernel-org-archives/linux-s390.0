From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/22] s390/mm: Remove superfluous parameter
Date: Fri, 26 Jan 2018 16:53:13 +0100
Message-ID: <20180126155334.52956-2-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

It seems it hasn't even been used before the last cleanup and was
overlooked.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Message-Id: <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 54cfd51a5a27e..4e9d12af95cc9 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1998,7 +1998,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_page);
  * Called with sg->parent->shadow_lock.
  */
 static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
-			       unsigned long gaddr, pte_t *pte)
+			       unsigned long gaddr)
 {
 	struct gmap_rmap *rmap, *rnext, *head;
 	unsigned long start, end, bits, raddr;
@@ -2083,7 +2083,7 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 			spin_lock(&gmap->shadow_lock);
 			list_for_each_entry_safe(sg, next,
 						 &gmap->children, list)
-				gmap_shadow_notify(sg, vmaddr, gaddr, pte);
+				gmap_shadow_notify(sg, vmaddr, gaddr);
 			spin_unlock(&gmap->shadow_lock);
 		}
 		if (bits & PGSTE_IN_BIT)
-- 
2.13.4

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 20/51] s390/mm: limit number of real-space gmap shadows
Date: Tue, 21 Jun 2016 15:12:58 +0200
Message-ID: <1466514809-146638-21-git-send-email-borntraeger@de.ibm.com>
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

We have no known user of real-space designation and only support it to
be architecture compliant.

Gmap shadows with real-space designation are never unshadowed
automatically, as there is nothing to protect for the top level table.

So let's simply limit the number of such shadows to one by removing
existing ones on creation of another one.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index c07d64f..4a1434b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1455,6 +1455,19 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		gmap_free(new);
 		return sg;
 	}
+	if (asce & _ASCE_REAL_SPACE) {
+		/* only allow one real-space gmap shadow */
+		list_for_each_entry(sg, &parent->children, list) {
+			if (sg->orig_asce & _ASCE_REAL_SPACE) {
+				spin_lock(&sg->guest_table_lock);
+				gmap_unshadow(sg);
+				spin_unlock(&sg->guest_table_lock);
+				list_del(&sg->list);
+				gmap_put(sg);
+				break;
+			}
+		}
+	}
 	atomic_set(&new->ref_count, 2);
 	list_add(&new->list, &parent->children);
 	if (asce & _ASCE_REAL_SPACE) {
-- 
2.5.5

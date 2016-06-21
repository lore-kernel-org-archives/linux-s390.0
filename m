From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 22/51] s390/mm: allow to check if a gmap shadow is valid
Date: Tue, 21 Jun 2016 15:13:00 +0200
Message-ID: <1466514809-146638-23-git-send-email-borntraeger@de.ibm.com>
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

It will be very helpful to have a mechanism to check without any locks
if a given gmap shadow is still valid and matches the given properties.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  1 +
 arch/s390/mm/gmap.c          | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 752cf47..c67fb85 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -109,6 +109,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
 
 struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			 int edat_level);
+int gmap_shadow_valid(struct gmap *sg, unsigned long asce, int edat_level);
 int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		    int fake);
 int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 4a1434b..d00e4ab 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1408,6 +1408,26 @@ static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
 }
 
 /**
+ * gmap_shadow_valid - check if a shadow guest address space matches the
+ *                     given properties and is still valid
+ * @sg: pointer to the shadow guest address space structure
+ * @asce: ASCE for which the shadow table is requested
+ * @edat_level: edat level to be used for the shadow translation
+ *
+ * Returns 1 if the gmap shadow is still valid and matches the given
+ * properties, the caller can continue using it. Returns 0 otherwise, the
+ * caller has to request a new shadow gmap in this case.
+ *
+ */
+int gmap_shadow_valid(struct gmap *sg, unsigned long asce, int edat_level)
+{
+	if (sg->removed)
+		return 0;
+	return sg->orig_asce == asce && sg->edat_level == edat_level;
+}
+EXPORT_SYMBOL_GPL(gmap_shadow_valid);
+
+/**
  * gmap_shadow - create/find a shadow guest address space
  * @parent: pointer to the parent gmap
  * @asce: ASCE for which the shadow table is created
-- 
2.5.5

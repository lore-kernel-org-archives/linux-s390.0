From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 18/51] s390/mm: push rte protection down to shadow pte
Date: Tue, 21 Jun 2016 15:12:56 +0200
Message-ID: <1466514809-146638-19-git-send-email-borntraeger@de.ibm.com>
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

Just like we already do with ste protection, let's take rte protection
into account. This way, the host pte doesn't have to be mapped writable.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index fab03ec..f6d556d 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -966,6 +966,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	int rc;
 
 	*fake = 0;
+	*dat_protection = 0;
 	parent = sg->parent;
 	vaddr.addr = saddr;
 	asce.val = sg->orig_asce;
@@ -1008,6 +1009,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			return PGM_TRANSLATION_SPEC;
 		if (vaddr.rsx01 < rfte.tf || vaddr.rsx01 > rfte.tl)
 			return PGM_REGION_SECOND_TRANS;
+		if (sg->edat_level >= 1)
+			*dat_protection |= rfte.p;
 		rc = gmap_shadow_r2t(sg, saddr, rfte.val);
 		if (rc)
 			return rc;
@@ -1026,6 +1029,9 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			return PGM_TRANSLATION_SPEC;
 		if (vaddr.rtx01 < rste.tf || vaddr.rtx01 > rste.tl)
 			return PGM_REGION_THIRD_TRANS;
+		if (sg->edat_level >= 1)
+			*dat_protection |= rste.p;
+		rste.p |= *dat_protection;
 		rc = gmap_shadow_r3t(sg, saddr, rste.val);
 		if (rc)
 			return rc;
@@ -1045,18 +1051,19 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		if (rtte.cr && asce.p && sg->edat_level >= 2)
 			return PGM_TRANSLATION_SPEC;
 		if (rtte.fc && sg->edat_level >= 2) {
-			bool prot = rtte.fc1.p;
-
+			*dat_protection |= rtte.fc0.p;
 			*fake = 1;
 			ptr = rtte.fc1.rfaa << 31UL;
 			rtte.val = ptr;
-			rtte.fc0.p = prot;
 			goto shadow_sgt;
 		}
 		if (vaddr.sx01 < rtte.fc0.tf || vaddr.sx01 > rtte.fc0.tl)
 			return PGM_SEGMENT_TRANSLATION;
+		if (sg->edat_level >= 1)
+			*dat_protection |= rtte.fc0.p;
 		ptr = rtte.fc0.sto << 12UL;
 shadow_sgt:
+		rtte.fc0.p |= *dat_protection;
 		rc = gmap_shadow_sgt(sg, saddr, rtte.val, *fake);
 		if (rc)
 			return rc;
@@ -1080,18 +1087,16 @@ shadow_sgt:
 			return PGM_TRANSLATION_SPEC;
 		if (ste.cs && asce.p)
 			return PGM_TRANSLATION_SPEC;
-		*dat_protection = ste.fc0.p;
+		*dat_protection |= ste.fc0.p;
 		if (ste.fc && sg->edat_level >= 1) {
-			bool prot = ste.fc1.p;
-
 			*fake = 1;
 			ptr = ste.fc1.sfaa << 20UL;
 			ste.val = ptr;
-			ste.fc0.p = prot;
 			goto shadow_pgt;
 		}
 		ptr = ste.fc0.pto << 11UL;
 shadow_pgt:
+		ste.fc0.p |= *dat_protection;
 		rc = gmap_shadow_pgt(sg, saddr, ste.val, *fake);
 		if (rc)
 			return rc;
-- 
2.5.5

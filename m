From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/51] s390/mm: avoid races on region/segment/page table shadowing
Date: Tue, 21 Jun 2016 15:12:47 +0200
Message-ID: <1466514809-146638-10-git-send-email-borntraeger@de.ibm.com>
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

We have to unlock sg->guest_table_lock in order to call
gmap_protect_rmap(). If we sleep just before that call, another VCPU
might pick up that shadowed page table (while it is not protected yet)
and use it.

In order to avoid these races, we have to introduce a third state -
"origin set but still invalid" for an entry. This way, we can avoid
another thread already using the entry before the table is fully protected.
As soon as everything is set up, we can clear the invalid bit - if we
had no race with the unshadowing code.

Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 97 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 27 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a57a87b..a396e58 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1125,7 +1125,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 
 	BUG_ON(!gmap_is_shadow(sg));
 	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
-	if (!ste || *ste & _SEGMENT_ENTRY_INVALID)
+	if (!ste || !(*ste & _SEGMENT_ENTRY_ORIGIN))
 		return;
 	gmap_call_notifier(sg, raddr, raddr + (1UL << 20) - 1);
 	sto = (unsigned long) (ste - ((raddr >> 20) & 0x7ff));
@@ -1157,7 +1157,7 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = (unsigned long) sgt | _ASCE_TYPE_SEGMENT;
 	for (i = 0; i < 2048; i++, raddr += 1UL << 20) {
-		if (sgt[i] & _SEGMENT_ENTRY_INVALID)
+		if (!(sgt[i] & _SEGMENT_ENTRY_ORIGIN))
 			continue;
 		pgt = (unsigned long *)(sgt[i] & _REGION_ENTRY_ORIGIN);
 		sgt[i] = _SEGMENT_ENTRY_EMPTY;
@@ -1183,7 +1183,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r3e = gmap_table_walk(sg, raddr, 2); /* get region-3 pointer */
-	if (!r3e || *r3e & _REGION_ENTRY_INVALID)
+	if (!r3e || !(*r3e & _REGION_ENTRY_ORIGIN))
 		return;
 	gmap_call_notifier(sg, raddr, raddr + (1UL << 31) - 1);
 	r3o = (unsigned long) (r3e - ((raddr >> 31) & 0x7ff));
@@ -1215,7 +1215,7 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = (unsigned long) r3t | _ASCE_TYPE_REGION3;
 	for (i = 0; i < 2048; i++, raddr += 1UL << 31) {
-		if (r3t[i] & _REGION_ENTRY_INVALID)
+		if (!(r3t[i] & _REGION_ENTRY_ORIGIN))
 			continue;
 		sgt = (unsigned long *)(r3t[i] & _REGION_ENTRY_ORIGIN);
 		r3t[i] = _REGION3_ENTRY_EMPTY;
@@ -1241,7 +1241,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r2e = gmap_table_walk(sg, raddr, 3); /* get region-2 pointer */
-	if (!r2e || *r2e & _REGION_ENTRY_INVALID)
+	if (!r2e || !(*r2e & _REGION_ENTRY_ORIGIN))
 		return;
 	gmap_call_notifier(sg, raddr, raddr + (1UL << 42) - 1);
 	r2o = (unsigned long) (r2e - ((raddr >> 42) & 0x7ff));
@@ -1273,7 +1273,7 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = (unsigned long) r2t | _ASCE_TYPE_REGION2;
 	for (i = 0; i < 2048; i++, raddr += 1UL << 42) {
-		if (r2t[i] & _REGION_ENTRY_INVALID)
+		if (!(r2t[i] & _REGION_ENTRY_ORIGIN))
 			continue;
 		r3t = (unsigned long *)(r2t[i] & _REGION_ENTRY_ORIGIN);
 		r2t[i] = _REGION2_ENTRY_EMPTY;
@@ -1299,7 +1299,7 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r1e = gmap_table_walk(sg, raddr, 4); /* get region-1 pointer */
-	if (!r1e || *r1e & _REGION_ENTRY_INVALID)
+	if (!r1e || !(*r1e & _REGION_ENTRY_ORIGIN))
 		return;
 	gmap_call_notifier(sg, raddr, raddr + (1UL << 53) - 1);
 	r1o = (unsigned long) (r1e - ((raddr >> 53) & 0x7ff));
@@ -1331,7 +1331,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = (unsigned long) r1t | _ASCE_TYPE_REGION1;
 	for (i = 0; i < 2048; i++, raddr += 1UL << 53) {
-		if (r1t[i] & _REGION_ENTRY_INVALID)
+		if (!(r1t[i] & _REGION_ENTRY_ORIGIN))
 			continue;
 		r2t = (unsigned long *)(r1t[i] & _REGION_ENTRY_ORIGIN);
 		__gmap_unshadow_r2t(sg, raddr, r2t);
@@ -1496,10 +1496,14 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
 	if (!(*table & _REGION_ENTRY_INVALID)) {
 		rc = 0;			/* Already established */
 		goto out_free;
+	} else if (*table & _REGION_ENTRY_ORIGIN) {
+		rc = -EAGAIN;		/* Race with shadow */
+		goto out_free;
 	}
 	crst_table_init(s_r2t, _REGION2_ENTRY_EMPTY);
-	*table = (unsigned long) s_r2t |
-		_REGION_ENTRY_LENGTH | _REGION_ENTRY_TYPE_R1;
+	/* mark as invalid as long as the parent table is not protected */
+	*table = (unsigned long) s_r2t | _REGION_ENTRY_LENGTH |
+		 _REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INVALID;
 	list_add(&page->lru, &sg->crst_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make r2t read-only in parent gmap page table */
@@ -1508,11 +1512,18 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t)
 	offset = ((r2t & _REGION_ENTRY_OFFSET) >> 6) * 4096;
 	len = ((r2t & _REGION_ENTRY_LENGTH) + 1) * 4096 - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	if (rc) {
-		spin_lock(&sg->guest_table_lock);
+	spin_lock(&sg->guest_table_lock);
+	if (!rc) {
+		table = gmap_table_walk(sg, saddr, 4);
+		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
+			      (unsigned long) s_r2t)
+			rc = -EAGAIN;		/* Race with unshadow */
+		else
+			*table &= ~_REGION_ENTRY_INVALID;
+	} else {
 		gmap_unshadow_r2t(sg, raddr);
-		spin_unlock(&sg->guest_table_lock);
 	}
+	spin_unlock(&sg->guest_table_lock);
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
@@ -1557,10 +1568,13 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
 	if (!(*table & _REGION_ENTRY_INVALID)) {
 		rc = 0;			/* Already established */
 		goto out_free;
+	} else if (*table & _REGION_ENTRY_ORIGIN) {
+		rc = -EAGAIN;		/* Race with shadow */
 	}
 	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
-	*table = (unsigned long) s_r3t |
-		_REGION_ENTRY_LENGTH | _REGION_ENTRY_TYPE_R2;
+	/* mark as invalid as long as the parent table is not protected */
+	*table = (unsigned long) s_r3t | _REGION_ENTRY_LENGTH |
+		 _REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INVALID;
 	list_add(&page->lru, &sg->crst_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make r3t read-only in parent gmap page table */
@@ -1569,11 +1583,18 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t)
 	offset = ((r3t & _REGION_ENTRY_OFFSET) >> 6) * 4096;
 	len = ((r3t & _REGION_ENTRY_LENGTH) + 1) * 4096 - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	if (rc) {
-		spin_lock(&sg->guest_table_lock);
+	spin_lock(&sg->guest_table_lock);
+	if (!rc) {
+		table = gmap_table_walk(sg, saddr, 3);
+		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
+			      (unsigned long) s_r3t)
+			rc = -EAGAIN;		/* Race with unshadow */
+		else
+			*table &= ~_REGION_ENTRY_INVALID;
+	} else {
 		gmap_unshadow_r3t(sg, raddr);
-		spin_unlock(&sg->guest_table_lock);
 	}
+	spin_unlock(&sg->guest_table_lock);
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
@@ -1618,10 +1639,14 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt)
 	if (!(*table & _REGION_ENTRY_INVALID)) {
 		rc = 0;			/* Already established */
 		goto out_free;
+	} else if (*table & _REGION_ENTRY_ORIGIN) {
+		rc = -EAGAIN;		/* Race with shadow */
+		goto out_free;
 	}
 	crst_table_init(s_sgt, _SEGMENT_ENTRY_EMPTY);
-	*table = (unsigned long) s_sgt |
-		_REGION_ENTRY_LENGTH | _REGION_ENTRY_TYPE_R3;
+	/* mark as invalid as long as the parent table is not protected */
+	*table = (unsigned long) s_sgt | _REGION_ENTRY_LENGTH |
+		 _REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID;
 	list_add(&page->lru, &sg->crst_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make sgt read-only in parent gmap page table */
@@ -1630,11 +1655,18 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt)
 	offset = ((sgt & _REGION_ENTRY_OFFSET) >> 6) * 4096;
 	len = ((sgt & _REGION_ENTRY_LENGTH) + 1) * 4096 - offset;
 	rc = gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);
-	if (rc) {
-		spin_lock(&sg->guest_table_lock);
+	spin_lock(&sg->guest_table_lock);
+	if (!rc) {
+		table = gmap_table_walk(sg, saddr, 2);
+		if (!table || (*table & _REGION_ENTRY_ORIGIN) !=
+			      (unsigned long) s_sgt)
+			rc = -EAGAIN;		/* Race with unshadow */
+		else
+			*table &= ~_REGION_ENTRY_INVALID;
+	} else {
 		gmap_unshadow_sgt(sg, raddr);
-		spin_unlock(&sg->guest_table_lock);
 	}
+	spin_unlock(&sg->guest_table_lock);
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
@@ -1716,20 +1748,31 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt)
 	if (!(*table & _SEGMENT_ENTRY_INVALID)) {
 		rc = 0;			/* Already established */
 		goto out_free;
+	} else if (*table & _SEGMENT_ENTRY_ORIGIN) {
+		rc = -EAGAIN;		/* Race with shadow */
+		goto out_free;
 	}
+	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
-		 (pgt & _SEGMENT_ENTRY_PROTECT);
+		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
 	list_add(&page->lru, &sg->pt_list);
 	spin_unlock(&sg->guest_table_lock);
 	/* Make pgt read-only in parent gmap page table (not the pgste) */
 	raddr = (saddr & 0xfffffffffff00000UL) | _SHADOW_RMAP_SEGMENT;
 	origin = pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
 	rc = gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE, PROT_READ);
-	if (rc) {
-		spin_lock(&sg->guest_table_lock);
+	spin_lock(&sg->guest_table_lock);
+	if (!rc) {
+		table = gmap_table_walk(sg, saddr, 1);
+		if (!table || (*table & _SEGMENT_ENTRY_ORIGIN) !=
+			      (unsigned long) s_pgt)
+			rc = -EAGAIN;		/* Race with unshadow */
+		else
+			*table &= ~_SEGMENT_ENTRY_INVALID;
+	} else {
 		gmap_unshadow_pgt(sg, raddr);
-		spin_unlock(&sg->guest_table_lock);
 	}
+	spin_unlock(&sg->guest_table_lock);
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-- 
2.5.5

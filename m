Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728746AbgEZJdW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 05:33:22 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] KVM: s390: vsie: gmap_table_walk() simplifications
Date: Tue, 26 May 2020 11:33:12 +0200
Message-Id: <20200526093313.77976-3-borntraeger@de.ibm.com>
In-Reply-To: <20200526093313.77976-1-borntraeger@de.ibm.com>
References: <20200526093313.77976-1-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

From: David Hildenbrand <david@redhat.com>

Let's use asce_type where applicable. Also, simplify our sanity check for
valid table levels and convert it into a WARN_ON_ONCE(). Check if we even
have a valid gmap shadow as the very first step.

Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200403153050.20569-6-david@redhat.com
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 1a95d8809cc3..4b6903fbba4a 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -788,19 +788,19 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 					     unsigned long gaddr, int level)
 {
 	const int asce_type = gmap->asce & _ASCE_TYPE_MASK;
-	unsigned long *table;
+	unsigned long *table = gmap->table;
 
-	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
-		return NULL;
 	if (gmap_is_shadow(gmap) && gmap->removed)
 		return NULL;
 
+	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
+		return NULL;
+
 	if (asce_type != _ASCE_TYPE_REGION1 &&
 	    gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
 		return NULL;
 
-	table = gmap->table;
-	switch (gmap->asce & _ASCE_TYPE_MASK) {
+	switch (asce_type) {
 	case _ASCE_TYPE_REGION1:
 		table += (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
 		if (level == 4)
-- 
2.25.4

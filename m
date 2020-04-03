Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404310AbgDCPbQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 11:31:16 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/5] KVM: s390: vsie: gmap_table_walk() simplifications
Date: Fri,  3 Apr 2020 17:30:50 +0200
Message-Id: <20200403153050.20569-6-david@redhat.com>
In-Reply-To: <20200403153050.20569-1-david@redhat.com>
References: <20200403153050.20569-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

Let's use asce_type where applicable. Also, simplify our sanity check for
valid table levels and convert it into a WARN_ON_ONCE(). Check if we even
have a valid gmap shadow as the very first step.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 24ef30fb0833..a2bd8d7792e9 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -788,19 +788,19 @@ static inline unsigned long *gmap_table_walk(struct=
 gmap *gmap,
 					     unsigned long gaddr, int level)
 {
 	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
-	unsigned long *table;
+	unsigned long *table =3D gmap->table;
=20
-	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
-		return NULL;
 	if (gmap_is_shadow(gmap) && gmap->removed)
 		return NULL;
=20
+	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
+		return NULL;
+
 	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1 &&
 			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11))))
 		return NULL;
=20
-	table =3D gmap->table;
-	switch (gmap->asce & _ASCE_TYPE_MASK) {
+	switch (asce_type) {
 	case _ASCE_TYPE_REGION1:
 		table +=3D (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
 		if (level =3D=3D 4)
--=20
2.25.1

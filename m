Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390003AbgDBSsm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Apr 2020 14:48:42 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 5/5] KVM: s390: vsie: gmap_table_walk() simplifications
Date: Thu,  2 Apr 2020 20:48:19 +0200
Message-Id: <20200402184819.34215-6-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
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
 arch/s390/mm/gmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index fd32ab566f57..3c801dae7988 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -790,17 +790,18 @@ static inline unsigned long *gmap_table_walk(struct=
 gmap *gmap,
 	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
 	unsigned long *table;
=20
-	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
-		return NULL;
 	if (gmap_is_shadow(gmap) && gmap->removed)
 		return NULL;
=20
+	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
+		return NULL;
+
 	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1) &&
 			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
 		return NULL;
=20
 	table =3D gmap->table;
-	switch (gmap->asce & _ASCE_TYPE_MASK) {
+	switch (asce_type) {
 	case _ASCE_TYPE_REGION1:
 		table +=3D (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
 		if (level =3D=3D 4)
--=20
2.25.1

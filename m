Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389415AbgDBSsc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Apr 2020 14:48:32 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
Date: Thu,  2 Apr 2020 20:48:15 +0200
Message-Id: <20200402184819.34215-2-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org

In case we have a region 1 ASCE, our shadow/g3 address can have any value=
.
Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
rejecting valid shadow addresses when trying to walk our shadow table
hierarchy.

The result is that the prefix cannot get mapped and will loop basically
forever trying to map it (-EAGAIN loop).

After all, the broken check is only a sanity check, our table shadowing
code in kvm_s390_shadow_tables() already checks these conditions, injecti=
ng
proper translation exceptions. Turn it into a WARN_ON_ONCE().

Fixes: 4be130a08420 ("s390/mm: add shadow gmap support")
Cc: <stable@vger.kernel.org> # v4.8+
Reported-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 2fbece47ef6f..f3dbc5bdde50 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -787,14 +787,18 @@ static void gmap_call_notifier(struct gmap *gmap, u=
nsigned long start,
 static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 					     unsigned long gaddr, int level)
 {
+	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
 	unsigned long *table;
=20
 	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
 		return NULL;
 	if (gmap_is_shadow(gmap) && gmap->removed)
 		return NULL;
-	if (gaddr & (-1UL << (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)))
+
+	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1) &&
+			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
 		return NULL;
+
 	table =3D gmap->table;
 	switch (gmap->asce & _ASCE_TYPE_MASK) {
 	case _ASCE_TYPE_REGION1:
--=20
2.25.1

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33984 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389983AbgDBSsh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Apr 2020 14:48:37 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/5] KVM: s390: vsie: Fix possible race when shadowing region 3 tables
Date: Thu,  2 Apr 2020 20:48:17 +0200
Message-Id: <20200402184819.34215-4-david@redhat.com>
In-Reply-To: <20200402184819.34215-1-david@redhat.com>
References: <20200402184819.34215-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

We have to properly retry again by returning -EINVAL immediately in case
somebody else instantiated the table concurrently. We missed to add the
goto in this function only. The code now matches the other, similar
shadowing functions.

We are overwriting an existing region 2 table entry. All allocated pages
are added to the crst_list to be freed later, so they are not lost
forever. However, when unshadowing the region 2 table, we wouldn't trigge=
r
unshadowing of the original shadowed region 3 table that we replaced. It
would get unshadowed when the original region 3 table is modified. As it'=
s
not connected to the page table hierarchy anymore, it's not going to get
used anymore. However, for a limited time, this page table will stick
around, so it's in some sense a temporary memory leak.

Identified by manual code inspection. I don't think this classifies as
stable material.

Fixes: 998f637cc4b9 ("s390/mm: avoid races on region/segment/page table s=
hadowing")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f3dbc5bdde50..fd32ab566f57 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1844,6 +1844,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long =
saddr, unsigned long r3t,
 		goto out_free;
 	} else if (*table & _REGION_ENTRY_ORIGIN) {
 		rc =3D -EAGAIN;		/* Race with shadow */
+		goto out_free;
 	}
 	crst_table_init(s_r3t, _REGION3_ENTRY_EMPTY);
 	/* mark as invalid as long as the parent table is not protected */
--=20
2.25.1

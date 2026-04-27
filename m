Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA642777FC;
	Mon, 27 Apr 2026 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267218; cv=none; b=TallFfQj+yJaCLTNVgmhU1BmOw919y05mUgygi/Bl/eMPQ2BpEBPDrFZMEiHS/Dzv0jgEM22clHkIV4UEBxBjeO7LVMGhWZD5vaCTF22FuAzLfcdCid+IWiCr5g6afI1F/M+xcmkhxh6q7FhUu7vh7nQo2oph64Nh6z17mf/kWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267218; c=relaxed/simple;
	bh=mAkE7g3WH49ukN69uNYJ06nXsN9ktos/uGKO2gadz6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnW03Ji3IP8+4m05OamZieAon52xV+zUQ0SkZ6msRYvkW7jl4ntr/5yyuQTUaPjUDvh6wX5XzGZH8zZzpyskqrhS8NMXMVXf5aSrBPk9xKRCDhRmxD+voHvWlKMZMzSEQsXgXYPfMIjVV3pw8mk/tws7fpaddk7eOSOowxepzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kexT6xKR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kexT6xKR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMkPsJ2933551;
	Mon, 27 Apr 2026 05:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4nEsBxBk+seZw+u7Xx1eDjzz9+lJYddsqvqoTmtvD
	Q0=; b=kexT6xKRl6u2r4yg5t5alWepxikP5khOYDICyhTTX9fe0PLnSJABE6gDa
	hdBl0ji0Uc2QO1hpb/BAdrqtNhqY9vwWVshwKhZ3EfYWTk3X4amAb/PnRahFMNG/
	NEAaJP3vkCTEDAksZfwzdG5qaPK59zlPWydsyQGnGuzFRmOU/EtpDrwzALe6HZHJ
	61NRZIjrKcwpR69PxQeylURgf1QatspI2qZzkfwLecfgrXvjjwjcjzN3PcZfCT5L
	mSbK0dTT/5FuyrUVCqEfpAl3SsdOScqA3jbo6GafH6P1sev3V6LaLD3Alqbkk8n/
	NejuqLCmKVubL8aVKsoPt85lBy8yg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9qxrnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 05:20:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63R58hSa005843;
	Mon, 27 Apr 2026 05:20:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avkv9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 05:20:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63R5K1RW29033212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 05:20:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA1C2004D;
	Mon, 27 Apr 2026 05:20:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF41020049;
	Mon, 27 Apr 2026 05:20:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Apr 2026 05:20:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id B7C87E066F; Mon, 27 Apr 2026 07:20:00 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry accessors
Date: Mon, 27 Apr 2026 07:20:00 +0200
Message-ID: <20260427052000.196402-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KLWXsFStS9wxIe74e9wlHShCUGR159aI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA1NCBTYWx0ZWRfX6pdaSSR0sFra
 2C2qDgF7ggAvahOz4etl+xbC5UdXzVr+dxqD5A2hHywN5ncaCSDF68YLabuwl/JX+xSpUwKXCgs
 m4I92f6BgzzOb9PSXacdx3JJLS/Ecf0KHHYy84BuemPRTce+rebYaKh9MN5hbrcSVLb4z/vjwJN
 nQhqj64oVuB1bB8O2HJcEmjezgTtnLg/vqg5N0nv4QjTiP5w13+SkHk94wpfJECvvIbIlrVNbd2
 hKM30dfNaBanKEaF9PpSxGKSLOz9hb6zEoYb18FZGIZcryroQdmrvf0ffVODh4SkDgQfhD+wt9Q
 4EOsHb7VZG2bEariAM2yFxpzyvyw8LNopcOqI7Eu+P6+8JgaBTyFjpZ+Hh+1obUkooVztelFUTn
 K465lnGTpT2EVC3nj2M9p+hBNeKo5oVvWhx14uOYHqzI2a3j05OYOj1F08OXkludDE45Nes9jj9
 W0Xsw/Xb+PYh5Dn6ekg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69eef206 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WjDiwf2ghD9uJ69bLr8A:9
X-Proofpoint-ORIG-GUID: KLWXsFStS9wxIe74e9wlHShCUGR159aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270054

Convert pgtable direct entry dereferences to the corresponding
pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
reads when no lock is taken.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/page_vma_mapped.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index b38a1d00c971..a4520bb10d2a 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, =
pmd_t *pmdvalp,
 	if (!pvmw->pte)
 		return false;
=20
-	ptent =3D ptep_get(pvmw->pte);
+	ptent =3D ptep_get_lockless(pvmw->pte);
=20
 	if (pte_none(ptent)) {
 		return false;
@@ -219,17 +219,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_wa=
lk *pvmw)
 restart:
 	do {
 		pgd =3D pgd_offset(mm, pvmw->address);
-		if (!pgd_present(*pgd)) {
+		if (!pgd_present(pgdp_get(pgd))) {
 			step_forward(pvmw, PGDIR_SIZE);
 			continue;
 		}
 		p4d =3D p4d_offset(pgd, pvmw->address);
-		if (!p4d_present(*p4d)) {
+		if (!p4d_present(p4dp_get(p4d))) {
 			step_forward(pvmw, P4D_SIZE);
 			continue;
 		}
 		pud =3D pud_offset(p4d, pvmw->address);
-		if (!pud_present(*pud)) {
+		if (!pud_present(pudp_get(pud))) {
 			step_forward(pvmw, PUD_SIZE);
 			continue;
 		}
@@ -244,7 +244,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk=
 *pvmw)
=20
 		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
 			pvmw->ptl =3D pmd_lock(mm, pvmw->pmd);
-			pmde =3D *pvmw->pmd;
+			pmde =3D pmdp_get(pvmw->pmd);
 			if (!pmd_present(pmde)) {
 				softleaf_t entry;
=20
@@ -317,7 +317,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk=
 *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-		} while (pte_none(ptep_get(pvmw->pte)));
+		} while (pte_none(ptep_get_lockless(pvmw->pte)));
=20
 		if (!pvmw->ptl) {
 			spin_lock(ptl);
--=20
2.51.0


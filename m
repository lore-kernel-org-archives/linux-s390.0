Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27053C871E;
	Fri, 17 Jul 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295159; cv=none; b=CcaPkpBqcD8iUcq6nskykxa9Ysp2jqMKEe8EvEqpEisyD8UWpHumaJTSgNisKTbAtIf6Mye1ZpQf6Km07/F7lKhGS9kEmFa7ZzyhdjPZblzVj6+PMutmqp7VvHJZGe+Ysy8n2E2nP5P1OKqMRDgyOi2D3YSSM59jUtAGS98d9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295159; c=relaxed/simple;
	bh=rxlhCuQ65wijb/RQOSZVOVNfuha/32F1A3V85K5tDgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaOwGq6ABc8WOA2SGklisELRm0XdKMHhuvLjKct04pMy0MIGnpH6iKMLvm8vaMf/SG6J8wBfqhsCvwB3PJHOHDrk+oR4xw/aQaihI+/ea64ui+0L+COdJCbkzB33eaF8FUYk5wvaZ8nniS5QflJdBC12IzRBeA4dzQsgzv4FMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RUdG+nYH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RUdG+nYH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCfYmF2047880;
	Fri, 17 Jul 2026 13:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZR3Mk7zX9t/kXLSfb
	ocR5QURhKS81KJ2aEx3gLrNQX8=; b=RUdG+nYHwqqpVi5O/yz/9FBSkLnlyJW6h
	gU9ds6W4bX7bU4bKlTpFmnsSBVaK+T6YZB5DwwqJmTfXLQ/aCJG1SwW6wkzqYrG1
	5orbNIM1LPlyoAfYE86uk8siVdwkMJcbenb1fvB0fpq+pdtR9rtCSvew4cwfW09C
	zeATKx2s9gT54QTjX/CRgilX4itjgmq1aHxZubHyC1n9DOMOexeOUrOZhxIWwns5
	2Sd0USv21gIKSIW7lZEOn/qj1J5TEDO0HIooJIUSsM1X0R0tDwTlmoKd0U3UtFxW
	3tdDYu5aEI+rbzTK3yIRSOpX1FZyEggBAnSt/VHJ6fMCzRskjGGlQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxxnp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:32:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HDJdZE002992;
	Fri, 17 Jul 2026 13:32:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwj072-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:32:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HDWN6q47579446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 13:32:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E500820067;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7C7D2004F;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 17 Jul 2026 13:32:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 9B59F16274F; Fri, 17 Jul 2026 15:32:22 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>, Chris Li <sparse@chrisli.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: [RFC PATCH 2/4] mm: introduce ptep_get_nopgtable() and set_pte_nopgtable() accessors
Date: Fri, 17 Jul 2026 15:32:20 +0200
Message-ID: <19627b802d38510a6e006ec666d3177278ad8a38.1784292223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784292223.git.agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRWCLk7W3ROJPEtFwpDR_wlth4pH6ZxY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfXxNKXxRcRZm3U
 kzCrK3ojC+2IsC3lmACZA/WyTynT9SOY5Qp3aeeuxdxqascRVXrFlIxGMVpLEiuelphupdK8A5I
 DXwpbiTBDVJjp86tYDyZn5G7x8seu/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzNCBTYWx0ZWRfXx4TnIy60KXIX
 ZxD1RKv9CV8do+R8VJYpfLh/dcd0bftB/N3ViHaEoR602zf4SOc7KkfD1b3oeCNH3mS31G7+wMO
 zcZ1Ob0Lmbrm9h9wj7bT0RdzqF4EezOTZzpT0Mg6SIGQJWV82zUXwy0LpSFVsDaggyrC7Tv8Gnv
 OuvpZu9XpRCYBowaH+8MmA4oliKFB6b6svxrf5QyE0hZkI+qYD5AwioPA+p4PJRkDs2PsByVSsR
 n5+JHDpI4DrgBj5ab/QQydUR7ajzt51m8De06kbY+GFh4sakHArgD15OwnPxKUG0zdih68IFpcK
 MCSdWTBgu9n9m8o4jUoAF/nA9t09f0RAAt7xCZYx1kk7Xlv8qXN842GH4C/qmE0SYw+7KaQPAs2
 vXKkbEBa0Dx8WYrToDj4bYPOto6CcoZClENOMo/ZulJoHO40OWl9Htj8c0RFfOdBVpov497PrLz
 XG26QYxSl0bTyaelYhw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5a2eec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uWIZLCJMPdl43Pu2rEcA:9
X-Proofpoint-ORIG-GUID: bRWCLk7W3ROJPEtFwpDR_wlth4pH6ZxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170134

Add helpers to safely access PTE values stored outside page
tables, such as in stack variables or temporary copies. These
adopt the check from folio_pte_batch_flags() to ensure the
pointer does not point into an actual page table.

Follow the pattern established by commit c33c794828f2 ("mm:
ptep_get() conversion") and use the new accessors instead of
direct pointer dereferences.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/pgtable.h | 25 +++++++++++++++++++++++++
 mm/internal.h           | 16 ++++++----------
 mm/ksm.c                |  2 +-
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2981e386da7b..e38f045d0e73 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -489,6 +489,31 @@ static inline int pudp_set_access_flags(struct vm_ar=
ea_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
=20
+#ifndef ptep_get_nopgtable
+static inline pte_t ptep_get_nopgtable(pte_t *ptep)
+{
+	/*
+	 * Ensure this is a pointer to a copy not a pointer into a page table.
+	 * If this is a stack value, it won't be a valid virtual address, but
+	 * that's fine because it also cannot be pointing into the page table.
+	 */
+	VM_WARN_ON(virt_addr_valid(ptep) && PageTable(virt_to_page(ptep)));
+
+	return *ptep;
+}
+#endif
+
+#ifndef set_pte_nopgtable
+static inline void set_pte_nopgtable(pte_t *ptep, pte_t pte)
+{
+	/*
+	 * See comment in ptep_get_nopgtable().
+	 */
+	VM_WARN_ON(virt_addr_valid(ptep) && PageTable(virt_to_page(ptep)));
+	*ptep =3D pte;
+}
+#endif
+
 #ifndef ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a2..0d04a107962a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -339,18 +339,12 @@ static inline unsigned int folio_pte_batch_flags(st=
ruct folio *folio,
 		unsigned int max_nr, fpb_t flags)
 {
 	bool any_writable =3D false, any_young =3D false, any_dirty =3D false;
-	pte_t expected_pte, pte =3D *ptentp;
+	pte_t expected_pte, pte =3D ptep_get_nopgtable(ptentp);
 	unsigned int nr, cur_nr;
=20
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
 	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) !=3D folio, foli=
o);
-	/*
-	 * Ensure this is a pointer to a copy not a pointer into a page table.
-	 * If this is a stack value, it won't be a valid virtual address, but
-	 * that's fine because it also cannot be pointing into the page table.
-	 */
-	VM_WARN_ON(virt_addr_valid(ptentp) && PageTable(virt_to_page(ptentp)));
=20
 	/* Limit max_nr to the actual remaining PFNs in the folio we could batc=
h. */
 	max_nr =3D min_t(unsigned long, max_nr,
@@ -379,12 +373,14 @@ static inline unsigned int folio_pte_batch_flags(st=
ruct folio *folio,
 		nr +=3D cur_nr;
 	}
=20
+	pte =3D ptep_get_nopgtable(ptentp);
 	if (any_writable)
-		*ptentp =3D pte_mkwrite(*ptentp, vma);
+		pte =3D pte_mkwrite(pte, vma);
 	if (any_young)
-		*ptentp =3D pte_mkyoung(*ptentp);
+		pte =3D pte_mkyoung(pte);
 	if (any_dirty)
-		*ptentp =3D pte_mkdirty(*ptentp);
+		pte =3D pte_mkdirty(pte);
+	set_pte_nopgtable(ptentp, pte);
=20
 	return min(nr, max_nr);
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index 7d5b76478f0b..5b22c602a105 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1352,7 +1352,7 @@ static int write_protect_page(struct vm_area_struct=
 *vma, struct folio *folio,
=20
 		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
 	}
-	*orig_pte =3D entry;
+	set_pte_nopgtable(orig_pte, entry);
 	err =3D 0;
=20
 out_unlock:
--=20
2.53.0


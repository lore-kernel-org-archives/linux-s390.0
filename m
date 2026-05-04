Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD382DCF62;
	Mon,  4 May 2026 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899893; cv=none; b=DT3YOWoRWOYZQ3Mk5sVwvfUKZZU4pP1fx3e6ezlGPt3lUfHWTvhgiIQxTgyapHjVMACiES1aE4+H4BGp031G+wcTBolQBqIGaxvR9cVx235p0B1PN9fO5E0z8c7elYjrXx4OI11Vy+3XOXGatVEeVGQKPusqjbgQQSjulwqws8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899893; c=relaxed/simple;
	bh=JAw4I88+zrFbSPJKpQ+YEjC54DgQ44FO6ZgUxTIsCV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7uSoNWTvEzm8aBTmlr8J3uOhre9eZd4Gt1+7tbVbdPxiYc2hMpwGHc5dSErNzQWbcWtYhGTFvgRdnSQoJqIDgxKcB2I06HnRP9xJzYu7U+gjLZka/0aXQQ+uL830C2FKhE1+ZjO5qrbvpQZAJVNeCjSBleR1ktCiphTJ7jTWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GmAQ1Pmx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GmAQ1Pmx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643MTQ7e3010004;
	Mon, 4 May 2026 13:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pO3syqtmoh2yTQJQGazJgax2lJ/9P8ITd+L4ibUvk
	II=; b=GmAQ1PmxHsYC8i2ze1kzDzkIGKgnV6pXDEsTxslAziS6dBxgvj/Js5uxX
	cri2zHYh8DRnRZlM1r26gG6WDxl7Fhg6y5glBtdUPXlCVKf2lpa+5WCF1bw8oiwU
	3l6969zRBaqHre27gS7viJZSIMJRzMeS0o6CWMz8fdlILI0VwkmRBoNeQndZzLwZ
	K7NeiCsFQoE6c11aqr2hcCIsuNT80mZkUM8npQ+asAv/0cZwRHzlnBTNYor4T4Br
	Vt5Tagujd+S0GWxN7Kzj3eDp3iSWgV/WO16aljwkh9ES0cXqvL+fpDXsHlzHIORj
	/7vc8jX18ueUa4AC3MJ50Ilfsc+1w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v772gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 13:04:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644CsNUA030028;
	Mon, 4 May 2026 13:04:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y4xcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 13:04:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644D4YGZ61538808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 13:04:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 756792004F;
	Mon,  4 May 2026 13:04:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 511592004D;
	Mon,  4 May 2026 13:04:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  4 May 2026 13:04:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 31603E0BD8; Mon, 04 May 2026 15:04:34 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v2] mm/page_vma_mapped_walk: Use ptep_get_lockless() for lockless access
Date: Mon,  4 May 2026 15:04:34 +0200
Message-ID: <20260504130434.2285053-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzNCBTYWx0ZWRfXxv4MVpWLQ7+4
 opdcsqJrR0GT7NRlU9JzyOPcWPqDpek8+IcJy7P7LDtKJe5m/zVJgjkNfeIRL2p6cgSkXCFd0v0
 OInNujcUlcNhR3J0Jp+6K7NiUXJbI3TjTTFDU5AuYziBDJgQ/buOteS7eG/YXMsqOAZhkifs/E4
 2CYI+VqWfpYE0poyYtke+/kINrKOkheB60+7Mv5hUjHaZuj0ffjy0AlGzKLQOXF/PC0w/NidVO2
 TYvp9itY/1XppDwgFXk9F8y/eZhJ6PCfjuIyhhLKdgfxW7vMrt41zugrK2tB7aQptxCGAL2K5OT
 Yn/i1a+E4Gxn7gnT+zaxuRzrmkZlwXsf+TPuoEggculwXivOOfQsMBNYJ+MvyHhlnTqGL9UouIX
 AybfzTYttrBJzFPzTE+RsXDy3PkPr1fQN+mFdyTYWPtUBnWoZ5GByM28Td+umc6Fvn+iQ8XB3TR
 g4jTy+3TDbYvMGbZI+g==
X-Proofpoint-GUID: WeqN-du5uoGuTeZAEmDisiPRQdC4IUAs
X-Proofpoint-ORIG-GUID: WeqN-du5uoGuTeZAEmDisiPRQdC4IUAs
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f89966 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=8KbNvkZQz-Byi51b31MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040134

Switch from ptep_get() to ptep_get_lockless() accessor for
PTE reads when no lock is taken.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/page_vma_mapped.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4d52fdb3056..6559e17f11c2 100644
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
@@ -310,7 +310,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk=
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


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56A3672A2;
	Tue, 16 Jun 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613661; cv=none; b=G6FdFV/DZfg2pY6iWdpwICeDAsQ4H9jLLJc2+u5IN+kl4SCmxdyoel3a/RTInVclSzIlQ6AHlRXlVTo1c4LNQZ9/0jg4XsBaKpf15k5efo18stLD/Wd1tMEl1MwmaYCbdjWkyW00S4S3xY4rFvH2U1+gWFuCtxR1M1vxws4T5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613661; c=relaxed/simple;
	bh=nZIQUZR8/XDdMmuI1KuGaI9U8NT3ahNz7Ht3hIamQCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7iIj+NplsTa6s0mugwtCoagEzI0I1MvB8J/HZHb6lIt2s+1rnb2jacFGNVlbELv/x+2/7yJth/qZPtGP/cNyLrFOuehlMWb1aO+VLOTVN+IRk6/VXNOOaqNAdIXVMgaMc9e+4wF1NFczoB0a9YgVV3NFzLb9cMhidChQJDnIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XNhQy8AT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XNhQy8AT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIxkh1397303;
	Tue, 16 Jun 2026 12:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RtC6xXZI5/qI+GEge
	fxFjxY2EgB/VMaaG8KnUuml/B8=; b=XNhQy8AT8z36DXzyW+E1NMUFlQ95Z/23X
	4T9EUjL4GdHPerFcxPCv4W/HPjANk1yp8K1DNA4j3YnXfTN1VRG1IYxxAoM4Z9dw
	C+DH1R3vSqIaZVrZWOPGIhESg/FYnGrtAql9eAPl/xsKqt65bz1PtVduR/jgnIpm
	EFLyuKHmISX8JJWGOt6O6vOYQJJiWbH6Gs5gYBGtj3RHlq28tRS+5k7HGhWp3gFd
	LLqMw7GOFNUtJQvW1/dKJaPhPOvFxGVR/yUS6A8Xuzt9Ztx7+yPXopDeOjk/vHrc
	w+sLPNRkJIrDXy9usEn7Tl5ttnS6vv42ZfNx72jKi71Viv0bR5ESA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h85pvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYbYS030945;
	Tue, 16 Jun 2026 12:40:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgb46n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCedFq61341964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:40:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C231720043;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39F12004F;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 89311E0E11; Tue, 16 Jun 2026 14:40:39 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 4/7] mm/gup: Cleanup pgtable entry accessors
Date: Tue, 16 Jun 2026 14:40:36 +0200
Message-ID: <991ea4a061aaf84beef65573d9919f7f5992c6ff.1781611976.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781611976.git.agordeev@linux.ibm.com>
References: <cover.1781611976.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX5iW+k+kZ/Ino
 d51K1dyJstUTzqYh+doxSM47ATBfJhyHHSUxi2ufnwIQDIw/DJwUauBwiald/068RD+Vos0wLj+
 6R7xBOr020r2iqlmiOHTcHROIFmVbn8=
X-Proofpoint-ORIG-GUID: akg9qP7F0ogCshEKnnxDK0hQcqAT-4dI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX6CHOU49hV+cE
 Ph4sg+3axfiGcKxXmSIcaIHGz6cw3erwejPRcve8wdTaSNjGXu5p1MU5mA8A4XYEEmIl3WAQF2v
 /NyS9UXOHpEhSxKDjNaHtNHdkstwrgFiQpkT7kqLnTUNcCSkIPV5Hrct9NsywnuAiEgQa5LwBgA
 l3sZFbGurMHMyvIkj3Agqs+RZZL2birtCKg+YEtPqhOgrnUig2pTLtBYoAGuY6OzEnTT+hKETDK
 ZkwkEbWWaRd3jT8PkSZunTnIROADHoTlMUlthtZgh56Hcu6aontO5q2jHOhmMAGoQ350HpeeStj
 1nQr1vktDPahZreglkWGKQ8WmxSbdLRmvgPJ9Rt7a8WLLxOP0Fj/Ce1Aq/MrmhXBpx/h6/YqJYg
 7rvtktejs8JQFQI9bqPqAGjAqHtKYde49yqqtk1wvApFkLWbMlbS8rFA0cRBkgYD6Fs+0lUm10z
 k8Mulvr4Ro4sezqEqag==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a31444d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=YUJdHbaOY7yOrIJlIOYA:9
X-Proofpoint-GUID: akg9qP7F0ogCshEKnnxDK0hQcqAT-4dI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160125

PMD and PUD entries revalidation has the same semantics as PTE entry
revalidation. Convert the remaining direct entry dereferences to the
corresponding accessors.

The PTE validation in gup_fast_pte_range() is inconsistent with the
prior value acquisition in the sense that it drops the lockless
access semantics.

Use the lockless accessor not only for the PTE, but also for the PMD
validation, which is likewise inconsistent with the prior value
acquisition in gup_fast_pmd_range().

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/gup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ad9ded39609c..0692119b7904 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2865,8 +2865,8 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmd=
p, unsigned long addr,
 		if (!folio)
 			goto pte_unmap;
=20
-		if (unlikely(pmd_val(pmd) !=3D pmd_val(*pmdp)) ||
-		    unlikely(pte_val(pte) !=3D pte_val(ptep_get(ptep)))) {
+		if (unlikely(pmd_val(pmd) !=3D pmd_val(pmdp_get_lockless(pmdp))) ||
+		    unlikely(pte_val(pte) !=3D pte_val(ptep_get_lockless(ptep)))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
@@ -2942,7 +2942,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmd=
p, unsigned long addr,
 	if (!folio)
 		return 0;
=20
-	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
+	if (unlikely(pmd_val(orig) !=3D pmd_val(pmdp_get_lockless(pmdp)))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
@@ -2985,7 +2985,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pud=
p, unsigned long addr,
 	if (!folio)
 		return 0;
=20
-	if (unlikely(pud_val(orig) !=3D pud_val(*pudp))) {
+	if (unlikely(pud_val(orig) !=3D pud_val(pudp_get(pudp)))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
--=20
2.53.0


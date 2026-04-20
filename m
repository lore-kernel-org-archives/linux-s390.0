Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412841FB1;
	Mon, 20 Apr 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687246; cv=none; b=gNX63G4w7LM0FfRGjJXn5S681inWnhgOROWt0xSR2TWza3V1BwZ2F5A81NsKXBZw+Gg0n5tnc5WB1iWC9fxa+txl5o+sjpWNJfMrODtkAD3kYsVN83pGudhadrL+d8hVdkOi5fujhZOpCsB5TvAmIwyXjPixV45oJR6z8kCIaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687246; c=relaxed/simple;
	bh=4yji3K8u+Ic+xc++k6tKljnPITuV6OUBMo2ZXMURsXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJemUE4LKZwxz/JHMxFOLWu3k2hGbITikAbRxrrMsj1D1XbKqtcNrEUBiV/lA4xsOcMdIFLTzugR6af1FFCeBmyIWElf1bfJpNkM6eq1Ds/Cl/qaP9tkqhlKtpGytoToEze0QoeICflIhfCcQxabcmIA5Ejoq3/EtV/7RKbbgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IVfsdlNl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IVfsdlNl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JMTQob3932971;
	Mon, 20 Apr 2026 12:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cvEiDRHkSJC9Nkgwg
	gfewpK0vAH7q26Omd0hwxaP2mA=; b=IVfsdlNlywhOK9bbDw4XdwoBDyUKLJdzf
	PQXaDWDj5EStdde6mqVV3UIIFnbpwN+a3cMTwiGSLPshThq1Y8pB4c4aecgZa8pV
	T6J61/Vn1Eab1Kap/TYXOqpfBbCjVf33mTL3mQkFf4QmtpeOz8Xak4EGIb6QmW65
	xee74aDDLc8nyITdcFQXrSVCsc3xZ3OZBP4O4cr293b2qZ1AemlgNLmEl7ee8tLx
	GeCIsU5HZ98P8Hc+ccmrEYMOJL1R+5dprz42XwJ9B/VCw+KlsrmLI0vkeNwmxEQX
	eLuBXQnOrn8jA6ApylPfIl5jb8OFcJ4gRDazti7ZOb/Je2KApbpeQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0pyv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:13:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KBoJ9g000714;
	Mon, 20 Apr 2026 12:13:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg4h6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:13:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KCDrHV15401436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 12:13:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 166552004D;
	Mon, 20 Apr 2026 12:13:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A8320040;
	Mon, 20 Apr 2026 12:13:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Apr 2026 12:13:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D3F53E0876; Mon, 20 Apr 2026 14:13:52 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [RFC PATCH 2/2] mm/gup: add lockless access semantics on entries validation
Date: Mon, 20 Apr 2026 14:13:52 +0200
Message-ID: <55c295e17221dc882e09b4caddc7b3bf4f1309ba.1776684344.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776684344.git.agordeev@linux.ibm.com>
References: <cover.1776684344.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jXvI_MNlPs8AO8j_dEPj7oSPim9ypZZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfXz/QF65KoWDtK
 E1FOB6+IPNHkS+GDRifBZBNX66NiXeoKsA0R/VZmYWQKJMzp9RqUIsPSHtPIzrgN4R5xPo8BV/I
 noPAnWlY5JTx1ULqNCc9tTgw8IBX+xCgvbaII5Nl4EDctWuo9jdIl9ZU8Qf0bxVRkwMgZPDhHQk
 DOVNJ+RI7kbD2NsSRQxGthVdJQny0YR6v6SQ9gJVKOq2P3ZMmo/cSTU8IX7UzpW4VRUhi0p43Va
 HuLhnksJXA67Zeka7aubicn4Jhk9urIrKCVSU7kcHSJAQFEFT9/6yZ+ZqjRaT2X6m49xpFz9rQb
 /kgYd9yGIlNtx8O/A7jPZjfhGq24eOW+r5OqhDBZvsNGh3kGn4L1Cdb0bUOeL8qCO/FoM3cp/fs
 2USk7Luc8IAUyx9dSlJyNnUtptEF25moBAGPKf1+JnpxLw+BFw5WeVLXzd7ohGSpPB2KdpaDHvj
 eiXOmzOwtEKWWpvTBHQ==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e61885 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_g_KzqHIDP97zNRR_5kA:9
X-Proofpoint-GUID: jXvI_MNlPs8AO8j_dEPj7oSPim9ypZZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200115

The PTE validation in gup_fast_pte_range() is inconsistent with the
prior value acquisition in the sense that it drops the lockless
access semantics.

Although this is highly unlikely, prevent a future scenario in which
a semantically mismatching ptep_get() incorrectly yields the same
result as the preceding ptep_get_lockless(), while ptep_get_lockless()
would otherwise return a different value.

Likewise the PMD validation is inconsistent with the prior value
acquisition in gup_fast_pmd_range().

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d149a4b0df71..236450feea9a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2865,8 +2865,8 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmd=
p, unsigned long addr,
 		if (!folio)
 			goto pte_unmap;
=20
-		if (unlikely(pmd_val(pmd) !=3D pmd_val(pmdp_get(pmdp))) ||
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
-	if (unlikely(pmd_val(orig) !=3D pmd_val(pmdp_get(pmdp)))) {
+	if (unlikely(pmd_val(orig) !=3D pmd_val(pmdp_get_lockless(pmdp)))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
--=20
2.51.0


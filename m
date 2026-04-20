Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF43750BC;
	Mon, 20 Apr 2026 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687246; cv=none; b=c6CrG83v9+GLqqzQyU1st++xqiLsXTtVbsTNDYGgPNMsRyBmq6PLm3QT030IlDt1PhGiwWbG+Ug3A+ZGzTy67whm2aKP8xv4qMI/YrUMpgnGUB8vkD4qcV3iJWCM9aRMufLAslllqvXogkuO0IqUO9dhKu0ov9SrCbhYpv0XEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687246; c=relaxed/simple;
	bh=yPrchtAH8HUJ9/bhztN/EA34efC08ucbQ4oqqemWl+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te6nBlt7vltKGJhT2LuEttsfZnBqXL8DpD5BdVGSgh8FjOk0xRtQXfgPpa5hHwexvjKBsGhp/c4wwdD0Yif0bFQf7DPsrbLOe3ETffH1PmFDp5wle3jcEQpdjrmV+6uHJ7Jc6fBl07C4UyiBlqKBizb6eZM1bI2+e6tZSxLcBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I7a3XXoB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I7a3XXoB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JKstv43466831;
	Mon, 20 Apr 2026 12:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mBqlFV4hXBJ/Lgtn2
	j4r3k97I2CtmrM8rGPmrJt1ZvQ=; b=I7a3XXoBIQg3ubMNscT1zvh6OYmwzXhmN
	PaEQXT9BqJhd+inPCsJ5Itb//c6r1SYnMR2OZornR5xCvWHYW4bqd2YvSJDSjzep
	erNA1fsUlhmi60VouurAmXNij3MPTWgT3TIDL+ABObYPi9uLYhwFfuiQMW5rCHjC
	Y4zkzbv+KVpkB8c9GN8LlTnoDWWrIF2hPz9NuMP/Dst3OVytvCkhhcnz9xp5zFgL
	RXooTu6iN9CtaJtBfRmUwxrsBiN0XRCgRpnYlEhJz/xevplesEqzlvB4hcpOkoIc
	tnlCmTeILWwATnsDgFctJX5ajhwRngCa3DUkdimO76+9Xw9ZYgJwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9f0fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:13:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KC5KFI020396;
	Mon, 20 Apr 2026 12:13:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvms6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:13:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KCDrVv38666584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 12:13:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26DA72004E;
	Mon, 20 Apr 2026 12:13:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDAF52004D;
	Mon, 20 Apr 2026 12:13:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Apr 2026 12:13:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D1003E0421; Mon, 20 Apr 2026 14:13:52 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [RFC PATCH 1/2] mm/gup: add missing pXdp_get() conversions
Date: Mon, 20 Apr 2026 14:13:51 +0200
Message-ID: <3d0213714273d83c07cb7681119b799ca77984b9.1776684344.git.agordeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PQwZVy4G3_B9G7fGsiQLWC2lBMTNEpQl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfXxlF3paGKZ6ey
 lxGLeUbgPY3NVNrLHMNKVV3tBDJdBTE3usrPEmVJvxbHISS9COzXBI+k8msaGEv+35pHtH8hoGQ
 FiHrAFSC1ro+Ombmw4y/y98rc2IB/eGa/ixum/vMaJvxWnAPrlAx7eIMUFYt2RUSKdB4Aamd8Ag
 o5T+Yah9+ykYn4JLGcXdS+8fu30YTNt73k2LZBsfjTqo3FuA4GbNPUHyddNA6ZQH4gGxWl6Xils
 ebFGFKPmTwq/9ORV4dJrmBVmC50GAJgo4dTNWi/oeVWnBixtVc2xyvsAH+vonwmbCB/VzBkzyF6
 uf1frIC4HjxTNruo1jEQgkdrCbBuH3enxblkAdcV7K4k5V+Y33vlUi7ReI4gh/jTkSqnI7dJwo2
 7L2ObAGAS+WXQlFmlqfxVO7a7hC12xrhDUMFgondZF3/GXjUVhDPJagbYvC2DyfUNhhTMn7SuMi
 S5ZOI8RU3zyD5t4Ysrw==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e61885 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ngOnC9FdaHMBdyWIK8kA:9
X-Proofpoint-GUID: PQwZVy4G3_B9G7fGsiQLWC2lBMTNEpQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200115

PMD and PUD entries revalidation has the same semantics as
PTE entry revalidation. Convert the remaining direct entry
dereferences to the corresponding pXdp_get() accessors.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 8e7dc2c6ee73..d149a4b0df71 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2865,7 +2865,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmd=
p, unsigned long addr,
 		if (!folio)
 			goto pte_unmap;
=20
-		if (unlikely(pmd_val(pmd) !=3D pmd_val(*pmdp)) ||
+		if (unlikely(pmd_val(pmd) !=3D pmd_val(pmdp_get(pmdp))) ||
 		    unlikely(pte_val(pte) !=3D pte_val(ptep_get(ptep)))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
@@ -2942,7 +2942,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmd=
p, unsigned long addr,
 	if (!folio)
 		return 0;
=20
-	if (unlikely(pmd_val(orig) !=3D pmd_val(*pmdp))) {
+	if (unlikely(pmd_val(orig) !=3D pmd_val(pmdp_get(pmdp)))) {
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
2.51.0


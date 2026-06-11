Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440529BDB5;
	Thu, 11 Jun 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190088; cv=none; b=N5dLHvVMVT9aZAL/jZKZuJMV28DpfMbVxAql1dUScvjgMMSieSS/WVQr6gbG3+H+g3X460GDMaunb7LejdoZoUexm0i+ZxLRHkOTA3bynlB2F8E3TDJx2/v7lwn/FLR8WeYIpvdRBSOyl2qgFszjeDVyJS4mfobVVu+hkVBXghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190088; c=relaxed/simple;
	bh=HsFaOgLyt8kDH0KJZkeq/QmG5x6ziTEEINId4AATlb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcTCOdfSAtYashOivZLoLJfBMt/nN//7Fizk165j7HHm5EszP5pcQrypRnJmmHGKQTu/kZR/8nERrbvB+75mGaoixRo3IzbzvY0V/B+sfyt3Xow3bQUgLhsJ5vfIOszPhpqbL28EjR0Ezu8LP5HHQ+FaN6VBjehw0uae0OEtU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mTaWZVys; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mTaWZVys"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBUNoa4146645;
	Thu, 11 Jun 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E3Oq7xcKwYPYIbCoi
	V3fIVP9zwAkWTYHSoskvCcES2k=; b=mTaWZVys0JSyDcvCKJBo15xqUpzG2Itok
	nova3kgawJp2MwHHV38sDCNxXnbD0PMfvWjTpA0AdPlHY+8qKa8dr7tBV6qKn2HY
	TX19lz2wz3yOEjxi67MwvT2txZ9hnFevjdchKUuNeffw7Iuvw0Xi+RqWNFnjqzNX
	A66tU7Iq5V2QADM0Te6BFBWjZ5cUV9PJ8SvO8AvabbL3eX/R01sb/BmHdRp0s7LA
	thyN9V+w8HOEczxiNBAS5Z7xP5kIjSvs85XR8F6nZ2VFqfGO/O78RiRWWIuqw7rG
	KwMws5mWakj16gfJDFZF9SKDRmpodlksPhnwGlAFNJ5cbQQcOJw4w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c4d5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEnaE5020970;
	Thu, 11 Jun 2026 15:01:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09knfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BF1Hxo36831514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:01:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0361D20043;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF2F92004D;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 2/5] KVM: s390: Fix unlikely race in try_get_locked_pte()
Date: Thu, 11 Jun 2026 17:01:13 +0200
Message-ID: <20260611150116.218162-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611150116.218162-1-imbrenda@linux.ibm.com>
References: <20260611150116.218162-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX8M/9Vfsd35pP
 ON6Qppv+rinychlCzFm5pg7RJekU0zeUO4ZzwbofUYq+ARv2jUj/CQkZAZ70r/UCdG+mJkl13cf
 8nHbTa5NR1YotTinKYAkDbyUAcTJuXY=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2acdc3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WbevkOawJw57NP_rgK0A:9
X-Proofpoint-GUID: YGjMgx3h2oNqH-kuxrr2kuehknAYVOpf
X-Proofpoint-ORIG-GUID: YGjMgx3h2oNqH-kuxrr2kuehknAYVOpf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX31tsJ86A+jDW
 21J2JFr8zpF5RK3FhljWP3/HrQy7ueTYuGJEZmJS9to0Tm64HRrZFqS+r915bCSYqb1QfUFeDg2
 Ev7O7gBcXVH53UPLeudQGthtrYC36VfTvm8W/7jr4TuUoe5SPh5sQBGZe07/M3ouatSTxVStFQz
 8QvcA6WI6Eryg8M7YIQWLtJe4cVcLxpd1zNOM2qW68kMXoO81CgFn1YYjkrwGEJ9vKHQBII7mhA
 B5qfy3dgjcovlWldbEQXsRFZJ4HvVxN3XaBpwWHPpVRnW7gGcuHQh9PzSN0k4B0xa9TEcZeX/K9
 vgEUm7WmjJKXHJ59wG7EeCQHH9HhHPc8NQMqIGnLKgFuuzOtC7EZBlx1B3UhKUq126SNjIbY198
 3+Qrz7DAKVElvZH6qXR8UYjm10SHBq9aoSQW1wbB0BrgUBwSFTwBeEYRDxWYA+uhmh4MkRdu22R
 telsOCbkzpY/VZNHccw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110147

Fix an unlikely race in try_get_locked_pte(), which could have happened
if puds or pmds get unmapped between the p?dp_get() and p?d_offset()
functions.

Fixes: 89fa757931dc ("KVM: s390: Avoid potentially sleeping while atomic when zapping pages")
CC: stable@vger.kernel.org # 7.1
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260611104850.110313-3-imbrenda@linux.ibm.com>
---
 arch/s390/mm/gmap_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 1cfe4724fbe2..ee3f37af8aee 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -51,15 +51,15 @@ pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, spinlock_t
 	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd) || !pgd_present(pgd))
 		return NULL;
-	p4dp = p4d_offset(pgdp, vmaddr);
+	p4dp = p4d_offset_lockless(pgdp, pgd, vmaddr);
 	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || !p4d_present(p4d))
 		return NULL;
-	pudp = pud_offset(p4dp, vmaddr);
+	pudp = pud_offset_lockless(p4dp, p4d, vmaddr);
 	pud = pudp_get(pudp);
 	if (pud_none(pud) || pud_leaf(pud) || !pud_present(pud))
 		return NULL;
-	pmdp = pmd_offset(pudp, vmaddr);
+	pmdp = pmd_offset_lockless(pudp, pud, vmaddr);
 	pmd = pmdp_get_lockless(pmdp);
 	if (pmd_none(pmd) || pmd_leaf(pmd) || !pmd_present(pmd))
 		return NULL;
-- 
2.54.0


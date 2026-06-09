Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713C3B83EE;
	Tue,  9 Jun 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021821; cv=none; b=uTz3+oUDsyCEitFHtWBOa+ocZTgPA5KalQ1nOMW0BuUIaLmKpOtd1+EIMcUuSs651YFYQFE6/O/UFMZ2XXt6wOhMEuXT3rBqP9+AZaT7AKmfZ7pUOQV8rrsngOQI6XygAiGQAPSQz0wU+rktK4o+qm3MSS1YKhMcTTsh0fWntNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021821; c=relaxed/simple;
	bh=E9LD0KaoekkpZDOgReAv+jIHFcm3JMDkv+YM2vE7mVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl/6fM6et0xQJd1aVt97RQKYHrQSTOsM7chBd40hKIEbgMze/KtyMk1gsfVIn0TLcr6GI8oqqozaGensCzf4CWAIIbqArAzskmI0eiqs6DbLG6CAwjt1SxB7enVHsQ8xoNsNhz+pUOrQu9VOXm3yjmT1fXXW+zA0s6Cp2XeX4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dyCaEhMd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dyCaEhMd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659EEUlR2111229;
	Tue, 9 Jun 2026 16:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0M6otYUwAQsCSsg3O
	XW+47eGEZKvl9gACVSlDP9kStk=; b=dyCaEhMdYLsB2vD2DJFMG0jAAm3VM5fQt
	zL/eMFWqxRD4bzcV6MtX5yCvt8Laf9ZFgbsQ9VxjwpIvAIVzcHiUFt8WP80G85m2
	TzkdcDW6FyWNReZfZFBiCPPRqaw4r0oEdzEZZOr2NQ1LcBt18/h5Z16+hQVcfem3
	2fq8jT035L+CWDhcPj2eQ5BTTbL0AsWU0+o+qbc3G6vSVfaBvowteKNZ32jsf2Ua
	vqCXGqzOXROpEUreKN068jYrDbHFhvdLkJRktI2euzw/skTVU7Fahslzs5ujcfPQ
	EPDgX0MV6U4CgUoYR6EqXHOGrLcflhvM6nysCgEJ5D/qQPXTYgzqA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qn3kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659G4dr6022787;
	Tue, 9 Jun 2026 16:16:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq2xxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659GGpvh61931882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 16:16:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ECB12004B;
	Tue,  9 Jun 2026 16:16:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E0F920043;
	Tue,  9 Jun 2026 16:16:50 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 16:16:50 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 2/3] KVM: s390: Fix unlikely race in try_get_locked_pte()
Date: Tue,  9 Jun 2026 18:16:45 +0200
Message-ID: <20260609161646.695361-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609161646.695361-1-imbrenda@linux.ibm.com>
References: <20260609161646.695361-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a283c7a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WbevkOawJw57NP_rgK0A:9
X-Proofpoint-GUID: t8rBNy0Qsg5RUjyWBBM9Drq3HP1J-nCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1MyBTYWx0ZWRfX1mO5eJxqFoMA
 we8Y/TuVjTlmben+yRiogmNX6wKsQ9OrA8L/gUgSnn7PB3fP6EMK6V2Tieq7yyBO31Z4z3dpkKa
 NAU5+MGzrBJyKt0jQZQ5wynhkygsYmexcBfM3Zgp5u08EeJnUsE16N+VBj9SsVMHr6XsBfDFxqO
 q9tigDL+NUwk0191WLzXHdZwpXkcMey3+sKQe3PT9iVRdhdqpMyf8lukeVEpgn/poumwvMBKv59
 uvfTuviyARo11KJkH/auwUBfii9t1uY/v+RsQCYmPbq78ebzzUkWfmHmq+l1y0BLYLJXP6MOFft
 BuRD0Vsl9k4rLPsDbfOCv2w8AvO4I4x/+GMy/nGqGJM9WzuGt7nZV1uFK3qPQSSZglG8y/lMAex
 LHLfLoa/5NkgmSSgbavBkWdBpV4TGDuYVeLUkgS5ZDi564U2ihLjpAZkCyrcjvLuV2F2EnOovGS
 q2CIT/H1jr7+1UhmJ3A==
X-Proofpoint-ORIG-GUID: t8rBNy0Qsg5RUjyWBBM9Drq3HP1J-nCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090153

Fix an unlikely race in try_get_locked_pte(), which could have happened
if puds or pmds get unmapped between the p?dp_get() and p?d_offset()
functions.

Fixes: 89fa757931dc ("KVM: s390: Avoid potentially sleeping while atomic when zapping pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
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


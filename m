Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835F316905;
	Thu, 28 May 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954931; cv=none; b=olZpMGHGt6Zz+xBpBa7AkGY9g5jrwdWjwYND80Uabklbv/FEXh+OU3pEgWn/+gF0kLEkJWskBNOVUvY5nXV2a4q7hb6RBJgcbCM9fTd7X2FnBdkAOSzuztRP0+zov6BgavmYJ7qgXfqIW31hiH7NABBsR0YXQgNGlpylRCPYmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954931; c=relaxed/simple;
	bh=J6GzWJUVHK61hfW1K5j+h4oXKB7B9XHPFqh0WNaR7ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUp/dX0iJ4jKO3yid0Jz7fsQ3UUvqmDfYMAygqMvDNlvRTu7wS2FSVC1NGKBoTlsHgCHHPCPtHL+taSJuDoAs6S1bNDzGiB/PH2bhI8WYgl4HvMZL27+mDMk4nfZi/ADyJNdV/oTNB+a3yQJq/uv3SrbHFLl5TpiobcGYSMPC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hgng53K1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hgng53K1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL7FJN2480393;
	Thu, 28 May 2026 07:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IfZQVgKAAwLvYFg3L5bnbvTsJtOephcrYlweJ87h5
	Qk=; b=Hgng53K1AxQTylOYnZYiW9HdgAZY9ax/jmCLirMjcrlVHL0g4oma22+EQ
	5PA5WFWWwwtc/rsgjl9FMOp1Qd98ZsF7YlH1PhJXi/mArg6YnX735A+OEMzcVql2
	NO2wyXxzXmwhM8fs8vhR63QhIzn4j+aue++wBRAl5/P/l32+2hjZ8bK8NMeQ3+Fv
	u5+RKSaZTSfG1Kinr/d/BoYIDp7JNk1pL/qPJAR/ztq/ZoU/V1EFFSTfSxPD9yOo
	+5/Zx2BsA5VK2KyH7hitHMmutefrQ5VzLp0LRS3GOANkUK1HmU7I3MJSdfV22Dy2
	n2LaR2sqaCbEenN4ojfg4cgSR/avg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee8869xj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 07:55:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64S7d9Ms030378;
	Thu, 28 May 2026 07:55:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb72us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 07:55:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64S7t7bO29688070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 07:55:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974752004B;
	Thu, 28 May 2026 07:55:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7249320040;
	Thu, 28 May 2026 07:55:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 28 May 2026 07:55:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 5B3CEE0993; Thu, 28 May 2026 09:55:07 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for lockless access
Date: Thu, 28 May 2026 09:55:07 +0200
Message-ID: <20260528075507.1821939-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1DMXsV5nP_67MuleWw1hhQC9cplM1fFf
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a17f4de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=r6uuodyqXXh6h6eviuwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA3NSBTYWx0ZWRfX6dIXLh37xcZK
 Ua+X3saVK/tPAfPj83UA+EfHYVLnJeVKaMIcVR2345xjN4e5LZmWkqkqVsCaDxwfHL9oJ2C/zOZ
 zexwt9LlmxvW1nM1NQG3altOquqkIOM6jbn+L1WEI1t7u3ky56vyKU8J0Fyn+MW0NxKOQ1uPmCN
 2UVVADFpvMkDxQqZaKoCINas9IQWPEyGDi57EVlEqyubSDmdZxQWdFQGn1qCik9oZuVLKt3zrxU
 T+cVrdkwy88GWtFOv7BpeHJgYYWsilwmnaVbvpE6ZSQvrzmaJjNZDkmVqhWnIDjj8nLG+E7VcE6
 66mCI3bgTRk+l7U0PauiHZyEzha5FbfkRAXVpp37IFAzIbz53eGMBYeS+uce6iupbWdhmTR9u1N
 jq9sYrrRZWwxYVkErzC2bKWr7WAFGhQpM0IPlcIU8DiE3ZCsaYCg66vyLRQnf92/p+DuzjwiU3f
 NtUFiJqrqkEHbC6h09Q==
X-Proofpoint-ORIG-GUID: yz-3GX041ELtX3Cw9Wm6FzJMiqL9lp2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280075

Switch from ptep_get() to ptep_get_lockless() accessor for
PTE reads when no lock is taken.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/page_vma_mapped.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4d52fdb3056..2ccbabfb2cc1 100644
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
@@ -183,6 +183,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk=
 *pvmw)
 	struct mm_struct *mm =3D vma->vm_mm;
 	unsigned long end;
 	spinlock_t *ptl;
+	pte_t pteval;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -310,7 +311,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_wal=
k *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-		} while (pte_none(ptep_get(pvmw->pte)));
+			if (!pvmw->ptl)
+				pteval =3D ptep_get_lockless(pvmw->pte);
+			else
+				pteval =3D ptep_get(pvmw->pte);
+		} while (pte_none(pteval));
=20
 		if (!pvmw->ptl) {
 			spin_lock(ptl);
--=20
2.51.0


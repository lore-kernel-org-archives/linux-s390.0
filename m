Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBC3D34AD
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632009; cv=none; b=eXEA0u3poRG3OXthl1/85atMTgZ4y632S8JzTovI+RJEw35a2+T6RmlaCiFnQ3S81bCTlLbUXz9tYG9qf8e5Xhnt7KMizM0NsJ2AcggpP6BMYIF/Ns8CXsGnSvIxAcV1bCBM51iBQlxtOK7C3Bf5RFGZm2mNLhEaQow4vghGDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632009; c=relaxed/simple;
	bh=A0GUpJ7Lx+mdHSx6dAUyTTg40ylV2v0wf0sL77W0uIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoINd03Il5GBVgEiZBQIjH9AAxtY3xvmyvTzzFTbiYq9DmXQVhQc7eReJwWImSkdvowxGxJmxcS/TFHpvfOjgQHo9xTNsIAtGrr+P19dsJE/HTP6vh8j4uGJrRAAqdPP3Y9ZH6ilYimxBrI0XyvuiRon+y47jnfYEc28fTKaOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rMnKpiep; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rMnKpiep"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GHI9wL2315105
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 17:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+8eA8m5bkt49KhpDSufvXI5Xmx97MeEhsLAPIR+7c
	vM=; b=rMnKpiep9Xuh1203uahT94K6GCyriUT9Mm06aPZTj2bKp6eG/whmF7V8Z
	m3/iPLQMfcCzh0udrxZ9sewXbhimlYc+07NhH70hW/AIm2Qx+yO74QGRT+CpBfYP
	zVijaP5cG7InEy7ixhz76bEHQcrqT+GZVTZs040TUpfoAH+C5vWZoKOu8vR2d2J2
	ce/XxI1c/oyo/zGbtxxU0PkPfVFm5GqG7WmNnn2MUK4BmJm931s3m1ddAJ01Jvmb
	oa2vN/ZfSAL5Ml2yO7bkMAHGfmb3LQzasHrrGceLET6lyah5JyJKRN59nWp/mdci
	wOLKbBEk7uhdxxHNYO1ayIRKz+hLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h878mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 17:46:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GHYeOY003694
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 17:46:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww4r17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 17:46:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GHkdsH40763652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 17:46:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 627F62004B;
	Tue, 16 Jun 2026 17:46:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4606920040;
	Tue, 16 Jun 2026 17:46:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 17:46:39 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH] s390/mm: Use set_pmd() / set_pud() for hugetlb pagetable entries
Date: Tue, 16 Jun 2026 19:46:27 +0200
Message-ID: <20260616174627.1068004-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3OCBTYWx0ZWRfXzDrPJ4/78m9C
 uHpS+8Kd0o4pwcbNn/1z4CB+sEHUxocKeY+GpGe7RSUU3Iq6q728JfEjhbgPQZHnUa7G9rnDJn2
 WAZ1AIzSsVD4gHKezQsc9bRR0ciRbRI=
X-Proofpoint-ORIG-GUID: o97JwVuS6PVEKPUHTrgGSkbfFZKMj2gh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3OCBTYWx0ZWRfX8Rir2+tplX4E
 X1xLV0eQGijUOGJ9+C57Zm/4ToU2fk7UYELX7j9y8DqfXpjoZGP4uG8Fougu13lfrDq1VyrfJk4
 dkBauGtpcDIirzH1vvURd3HTMAR8Zg2BxOm9gXiuypeJw0rULimsC/veej4XJmSTnQ6aZj/A9un
 ka/Wpkuekecxa+03QXVBDgFfBiLo2nyu36HfCsc79LRhmMuchdT6AjRivLrVyVR6d3WHDr6wvxz
 QQpSdX7io7p/eYKQX0qVfo7/Wl2bGE/xrmLxvbVH/Ls/nHhpinb89lnXTbpLRBb8WhqZQsmm2+Q
 2Z1UK4MeN4hXZMcmOHTyFkdScAee5XQQi5lffJvSPrtrR8jjXoe1y+PP8un+VugujBZw9UNWsIA
 p4qRMljoJInByPmZCOUavwGWqnCkSjtqF2hMQXiA0dUbqxkRRgNLi+3BGCbso0qk3kzzQ2JfLVY
 YzOttZ7KA+TbStrLWRQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a318c04 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6W1Pv_arBbPe3mYO--oA:9
X-Proofpoint-GUID: o97JwVuS6PVEKPUHTrgGSkbfFZKMj2gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160178

hugetlb code is known to view all pagetable entries as PTEs, instead of
corresponding upper levels like PMD or PUD. For s390, with different
pagetable entry layout for different levels, this requires some
conversion action under the hood.

The converted PMD and PUD entries are then written via set_pte()
function, but that might add some PTE-specific modifications.
There is no functional problem with current code, and the clearing of
_PAGE_UNUSED in set_pte(). Avoid future problems by using the set_pmd()
and set_pud() functions instead.

Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/include/asm/hugetlb.h |  4 ++--
 arch/s390/mm/hugetlbpage.c      | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index e33a5b587ee4..02db08429b7c 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -42,9 +42,9 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 				  pte_t *ptep, unsigned long sz)
 {
 	if ((pte_val(ptep_get(ptep)) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
-		set_pte(ptep, __pte(_REGION3_ENTRY_EMPTY));
+		set_pud((pud_t *)ptep, __pud(_REGION3_ENTRY_EMPTY));
 	else
-		set_pte(ptep, __pte(_SEGMENT_ENTRY_EMPTY));
+		set_pmd((pmd_t *)ptep, __pmd(_SEGMENT_ENTRY_EMPTY));
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index db35d8fe8609..f84aa9265430 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -147,10 +147,12 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		if (likely(pte_present(pte)))
 			rste |= _REGION3_ENTRY_LARGE;
 		rste |= _REGION_ENTRY_TYPE_R3;
-	} else if (likely(pte_present(pte)))
-		rste |= _SEGMENT_ENTRY_LARGE;
-
-	set_pte(ptep, __pte(rste));
+		set_pud((pud_t *)ptep, __pud(rste));
+	} else {
+		if (likely(pte_present(pte)))
+			rste |= _SEGMENT_ENTRY_LARGE;
+		set_pmd((pmd_t *)ptep, __pmd(rste));
+	}
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.53.0


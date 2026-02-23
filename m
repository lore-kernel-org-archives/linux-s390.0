Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BD2248A8;
	Mon, 23 Feb 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847607; cv=none; b=T02oGR9EwCESHx0smQo9T6rGN+HjEboCUhJr3ggFh84hB6rC/5BxOI9EVvaNG0DxK1jZ4DDnmqAsgv+OXOnqGjWoa+d3uY3wocjgtQIlkyvjvlISRH6/CsbtAJ1id+EZw/W5I6DvU7mUSP4lw7sSfNxcP0+RJ4Y0HTR+cbthmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847607; c=relaxed/simple;
	bh=4QbVMBT0FIfYfiV7zhsLOolQN0dUh7wnOruyUZLXxz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um7mByxn79U+rTqF8MaQU+/4vi19b/RB5RMyYpXYJk2VWFboL5swGh3TLMkEzqq8G+r3KLU1DiNoECH69hZp9SUn3Z6mxfgfw1vYcT+0wSkQA2dGvJWyR7GL+/pduc3fytySn7cl7l7GChQ0fWMKPfzjIv2YSdLJfrudfm6DikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I55Cmioe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I55Cmioe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N1F8vE2962734;
	Mon, 23 Feb 2026 11:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rkuh8RE1SaYB5ngAV
	CW7AE/3ekpYQtmDHEks3VzHXyY=; b=I55CmioejpT6bkGdnsKvpl7K/BUjYZDy4
	3pIr1yLzBd9JiCSbDbST/Ec9TRNItgTD9pUmD+C5Zv1Xd//jiqR5Sk/B2dE1RwYL
	AATB5GnG6pXHa9kYl8EL+cFKQa4/EWR9vgd1SimWBdQoK2matflxO0lbBrD0fKR5
	gZ8jwq0AsUnMmJ+qqrtf4vcEN7zQaNtlZ21JZ/3WT67KN1Vcoqzm2Yzi5qnlZC6w
	neicizMdfM/QggAYJy4jdWsbRe4BSOu/RIOFyYwy70M2Dqmp9NY0Knxpy4GDdYyA
	MALJANSNhseMmAQ58hSoti0FrJXgfB3W6HKk7bU3AlCGJdUN8qWtA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24g6qap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NBDPWt030385;
	Mon, 23 Feb 2026 11:53:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhk4gru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBrGs731129866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:53:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83CA52004D;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF3320043;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 3FCCCE0B55; Mon, 23 Feb 2026 12:53:16 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH 1/4] mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
Date: Mon, 23 Feb 2026 12:53:13 +0100
Message-ID: <68c2f6df2955033cbf1ccbd2b5c2816e72ac345c.1771845678.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1771845678.git.agordeev@linux.ibm.com>
References: <cover.1771845678.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699c3faf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=pGY3QCu7MjYVx_q7SwQA:9
X-Proofpoint-GUID: CSTS6ZcxiwQHiHahNP_pkftR7dwc7dEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX8meC9A58lixm
 XJ917+b0HnNVBM6bs3817+Qsqyx/N/+QJam8EoRkcPnVMeL53kLDYsNIJGlRpaPY20AkebPPBLd
 Vmh5Ap68PCfldNzudENvaBcEBwboC2H9yra5pxDgiZ6jenFaogRJKWRxfSBEETkzhkL6wSEr5yP
 /4sV3+CnMKF2KXlgZPkd+ThcEtB8xTTujY7veaeDFO47sWKXZouZ/L3W3h7Tu53u36Tr5gfG9+o
 8yxMMiqttTxxsE/mOQGbWS5zcRPP9aooSrCVszcaftwHkkbToDFa81/r1OqJFn8gWkPZ3qIWg5k
 ScgqmcFLp8VJvHsz7j38ekPqdpY8FfUPOuTctCk/cwXlW6hRvi87xoh5BU43423SuId3uyuiTPB
 8MF/vGmvA/clufMlgabcPWZUqIMRBEgz+6aF8egY2PPhI2h4jivcgWDo27VUyDhfec4Excg9vMQ
 kG2EYG1Iv+dXDVjf97A==
X-Proofpoint-ORIG-GUID: CSTS6ZcxiwQHiHahNP_pkftR7dwc7dEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230099

From: Tobias Huschle <huschle@linux.ibm.com>

Unlike other architectures, s390 does not have means to
distinguish kernel vs user page table entries - neither
an entry itself, nor the address could be used for that.
It is only the mm_struct that indicates whether an entry
in question is mapped to a user space. So pass mm_struct
to pxx_user_accessible_page() callbacks.

[agordeev@linux.ibm.com: rephrased commit message, removed braces]

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/arm64/include/asm/pgtable.h |  6 +++---
 arch/riscv/include/asm/pgtable.h |  6 +++---
 arch/x86/include/asm/pgtable.h   |  6 +++---
 mm/page_table_check.c            | 15 ++++++---------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
index b3e58735c49b..ccf0e0638767 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1263,17 +1263,17 @@ static inline int pmdp_set_access_flags(struct vm=
_area_struct *vma,
 #endif
=20
 #ifdef CONFIG_PAGE_TABLE_CHECK
-static inline bool pte_user_accessible_page(pte_t pte, unsigned long add=
r)
+static inline bool pte_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pte_t pte)
 {
 	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
 }
=20
-static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long add=
r)
+static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pmd_t pmd)
 {
 	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_=
exec(pmd));
 }
=20
-static inline bool pud_user_accessible_page(pud_t pud, unsigned long add=
r)
+static inline bool pud_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pud_t pud)
 {
 	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_=
exec(pud));
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
index 08d1ca047104..affe46cf3bc5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -984,17 +984,17 @@ static inline void set_pud_at(struct mm_struct *mm,=
 unsigned long addr,
 }
=20
 #ifdef CONFIG_PAGE_TABLE_CHECK
-static inline bool pte_user_accessible_page(pte_t pte, unsigned long add=
r)
+static inline bool pte_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pte_t pte)
 {
 	return pte_present(pte) && pte_user(pte);
 }
=20
-static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long add=
r)
+static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pmd_t pmd)
 {
 	return pmd_leaf(pmd) && pmd_user(pmd);
 }
=20
-static inline bool pud_user_accessible_page(pud_t pud, unsigned long add=
r)
+static inline bool pud_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pud_t pud)
 {
 	return pud_leaf(pud) && pud_user(pud);
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtabl=
e.h
index 1662c5a8f445..f9353d5c7464 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1680,17 +1680,17 @@ static inline bool arch_has_hw_nonleaf_pmd_young(=
void)
 #endif
=20
 #ifdef CONFIG_PAGE_TABLE_CHECK
-static inline bool pte_user_accessible_page(pte_t pte, unsigned long add=
r)
+static inline bool pte_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
 }
=20
-static inline bool pmd_user_accessible_page(pmd_t pmd, unsigned long add=
r)
+static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pmd_t pmd)
 {
 	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) && (pmd_val(pmd)=
 & _PAGE_USER);
 }
=20
-static inline bool pud_user_accessible_page(pud_t pud, unsigned long add=
r)
+static inline bool pud_user_accessible_page(struct mm_struct *mm, unsign=
ed long addr, pud_t pud)
 {
 	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) && (pud_val(pud)=
 & _PAGE_USER);
 }
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2708c2b3ac1f..53a8997ec043 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -151,9 +151,8 @@ void __page_table_check_pte_clear(struct mm_struct *m=
m, unsigned long addr,
 	if (&init_mm =3D=3D mm)
 		return;
=20
-	if (pte_user_accessible_page(pte, addr)) {
+	if (pte_user_accessible_page(mm, addr, pte))
 		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
-	}
 }
 EXPORT_SYMBOL(__page_table_check_pte_clear);
=20
@@ -163,9 +162,8 @@ void __page_table_check_pmd_clear(struct mm_struct *m=
m, unsigned long addr,
 	if (&init_mm =3D=3D mm)
 		return;
=20
-	if (pmd_user_accessible_page(pmd, addr)) {
+	if (pmd_user_accessible_page(mm, addr, pmd))
 		page_table_check_clear(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT);
-	}
 }
 EXPORT_SYMBOL(__page_table_check_pmd_clear);
=20
@@ -175,9 +173,8 @@ void __page_table_check_pud_clear(struct mm_struct *m=
m, unsigned long addr,
 	if (&init_mm =3D=3D mm)
 		return;
=20
-	if (pud_user_accessible_page(pud, addr)) {
+	if (pud_user_accessible_page(mm, addr, pud))
 		page_table_check_clear(pud_pfn(pud), PUD_SIZE >> PAGE_SHIFT);
-	}
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
=20
@@ -211,7 +208,7 @@ void __page_table_check_ptes_set(struct mm_struct *mm=
, unsigned long addr,
=20
 	for (i =3D 0; i < nr; i++)
 		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep +=
 i));
-	if (pte_user_accessible_page(pte, addr))
+	if (pte_user_accessible_page(mm, addr, pte))
 		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
 }
 EXPORT_SYMBOL(__page_table_check_ptes_set);
@@ -241,7 +238,7 @@ void __page_table_check_pmds_set(struct mm_struct *mm=
, unsigned long addr,
=20
 	for (i =3D 0; i < nr; i++)
 		__page_table_check_pmd_clear(mm, addr + PMD_SIZE * i, *(pmdp + i));
-	if (pmd_user_accessible_page(pmd, addr))
+	if (pmd_user_accessible_page(mm, addr, pmd))
 		page_table_check_set(pmd_pfn(pmd), stride * nr, pmd_write(pmd));
 }
 EXPORT_SYMBOL(__page_table_check_pmds_set);
@@ -257,7 +254,7 @@ void __page_table_check_puds_set(struct mm_struct *mm=
, unsigned long addr,
=20
 	for (i =3D 0; i < nr; i++)
 		__page_table_check_pud_clear(mm, addr + PUD_SIZE * i, *(pudp + i));
-	if (pud_user_accessible_page(pud, addr))
+	if (pud_user_accessible_page(mm, addr, pud))
 		page_table_check_set(pud_pfn(pud), stride * nr, pud_write(pud));
 }
 EXPORT_SYMBOL(__page_table_check_puds_set);
--=20
2.51.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38948A8C7;
	Wed,  7 Oct 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373359; cv=none; b=GdDzRQvUBM1osSTzMXNRcELOkqOYT1urPpO2ogasD3VtxigyjQq7qwSdCzJ4vQithbx4jt3USBGzGGiIaLYGRR9QuXPQ/RIs7ac9vSeByVLIqJbUGGhGikZyfmHagMeAwuAHB47k3gRv2dZG8VFeHx+ThxXm1BviljwzZcguYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373359; c=relaxed/simple;
	bh=GT3kRUe25uWU3bX0c12xZ9PKQGitpX+OkqtTfXeevJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCcLsXlzhG/qzR6Jol2u2FxusnnONInI/gcwir8xqU7UxbtOBwNp0TLQsyAchzBjl1Gmx/aVhsFV6p7CL12e6GogH8JoD4i+G36qknXUZdo8+Jo+Hppc5UOM2Z2ohMM7EsWng++nKdhQhuQJOXmBWxCB1nAZ3JRmfg2pBH9d1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DCp/+WT0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DCp/+WT0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZhOS2259707;
	Wed, 7 Oct 2026 11:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=shJyOauKOOBD/H0U0
	v7hc/PsPoSiyL2m4TXWHyz9T1s=; b=DCp/+WT0k+2dvh47jrkFNOnToC2XdO5yG
	NqFX5lNmluW4hnRjoX/oDW2ksGyxGyYFko6JYZToOk3zEzJZiarI3KcX/kRCES91
	QJsd279KaMIJXyCDhzRGLsdJUHtSf3Oed/siVpB3tjJWjzR5afE26QGeRDgj11DL
	NlaDAJ/WMJfXogdff2qwJGa5ojr6W5Znho98jKGUZbmp1pkNhMgJjGT/AJx4BsE8
	AooLayOIvChuQMz3fJ+S1rJQtZJ3mcN1b060OwQ1wHJc7HbpnGzyLTkLIGA1z15E
	6d09Ag8URq7mXzMc2oGZv9MryBlXcjuWHACcOB1G7z50vgfWt9zpw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jvmbq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69782TKV1562417;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxfh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxlR48759110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F5020040;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5625520063;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 99253160B5C; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v8 15/15] s390/mm: Lazy MMU mode sanitizer
Date: Wed,  7 Oct 2026 13:41:58 +0200
Message-ID: <1890ee88ced60e0d03d88e681b7e6dde6a6158fa.1791365932.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: gcCe8F3CQ5BCZYsIAkt8nvvQAh87lCOb
X-Proofpoint-GUID: ZhGgR0h0gzeUPkR7w8xgqgrq71GTCE_W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX2yDlotAE55ev
 Koli4pRdmy8NExpXmDPFt2mBOi89UIWyl6LTixPxnLHU2b7yjeSbZWgw9Krgack4yJqW9rPypkl
 Q2T2E5Y38Fd/keU9WhSWketmZ5RJzgo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX6LcQRnfiB2Q8
 SiN0S//pA4DUcuKYAicXzk6Kc6YCJXL9rLaw2I5Z36fQrR2Bxbpy/5hULWW9ovj+y8hIFUFSxYQ
 qithfL9FiM+ca0cj6gFa4t+S3ebjAy2TyWvT3x5z+Fvi3CnCRczowSumBVMf/iAozgP+CamDQ3J
 yVOlpjw8cdLznaqJdT37l83Y5yS2Xr/a7fvOBw4v0YRdBJGjgveOKIvpmPW8Z2PHCXOrBP7j0Qr
 HFAgMwsMmKLLZMUkC1/uBsW6afu3BbSXNNSdPx2a2k8NDWE8X/xlqPe5vnUxUXigDhZo+zLXc2f
 snko2x/URfphXnGpuk3sBz/p4CAB61jlIn28UunVhpP8dws1TaBCOzhZBsABpVjT3n9Xf3o+vnv
 osOE/Vp1H1I5+N+0rXqBUznKzcURLQ3vuYA3FY4N/5fwthoiVOZMj9tFINKAc3Mbk96Ieypt8cI
 uNQJhDqV/qAXNxLOQFw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DuHJb5c9rUSq-GGRdagA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

Detect PTE entries access in lazy MMU mode by means other
than set_pte() and ptep_get() primitives, which would be
a read hazard.

The access to kasan shadow memory from ptep_get_lockless()
mistakenly hits invalid access in case a concurrent lazy
MMU access to the same PTE is happening. To avoid that
disable instrumentation for ptep_get_lockless() altogether.

Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  6 ++++++
 arch/s390/mm/lazy_mmu.c         | 27 +++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
index decce76fac74..47f0adfc1029 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1063,6 +1063,12 @@ static inline void set_pte(hw_pte_t *ptep, pte_t p=
te)
 		__set_pte(ptep, pte);
 }
=20
+#define ptep_get_lockless ptep_get_lockless
+static inline __no_sanitize_address pte_t ptep_get_lockless(hw_pte_t *pt=
ep)
+{
+	return __pte_from_hw(READ_ONCE(*ptep));
+}
+
 static inline pte_t __ptep_get(hw_pte_t *ptep)
 {
 	return __pte_from_hw(READ_ONCE(*ptep));
diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
index 8c1a62f23736..e29afa081061 100644
--- a/arch/s390/mm/lazy_mmu.c
+++ b/arch/s390/mm/lazy_mmu.c
@@ -65,10 +65,13 @@ static int invalidate_pte_range(struct mm_struct *mm,=
 unsigned long addr,
 }
=20
 static void set_pte_range(struct mm_struct *mm, unsigned long addr,
-			  hw_pte_t *ptep, hw_pte_t *end, pte_t *cache)
+			  hw_pte_t *start, hw_pte_t *end, pte_t *cache)
 {
-	int i, nr_ptes;
+	int nr_ptes, nr_total =3D end - start;
+	hw_pte_t *ptep =3D start;
+	int i;
=20
+	kasan_unpoison_pte(start, nr_total);
 	while (ptep < end) {
 		nr_ptes =3D invalidate_pte_range(mm, addr, ptep, end);
=20
@@ -79,6 +82,7 @@ static void set_pte_range(struct mm_struct *mm, unsigne=
d long addr,
=20
 		addr +=3D nr_ptes * PAGE_SIZE;
 	}
+	kasan_poison_pte(start, nr_total);
 }
=20
 static void enter_ipte_norange(void)
@@ -98,6 +102,7 @@ static void enter_ipte_range(struct mm_struct *mm,
 			     unsigned long addr, unsigned long end, hw_pte_t *pte)
 {
 	struct ipte_range *range;
+	unsigned int nr_ptes;
=20
 	if (!static_branch_likely(&lazy_mmu_enabled))
 		return;
@@ -116,6 +121,9 @@ static void enter_ipte_range(struct mm_struct *mm,
 	range->base_end =3D end;
 	range->base_pte =3D pte;
=20
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	kasan_poison_pte(range->base_pte, nr_ptes);
+
 	local_bh_enable();
 }
=20
@@ -125,6 +133,7 @@ static void leave_ipte_range(void)
 	pte_t *start_cache, *cache;
 	hw_pte_t *ptep, *start;
 	struct ipte_range *range;
+	unsigned int nr_ptes;
 	int start_idx;
=20
 	if (!static_branch_likely(&lazy_mmu_enabled))
@@ -163,6 +172,9 @@ static void leave_ipte_range(void)
 	range->end_pte =3D NULL;
=20
 done:
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	kasan_unpoison_pte(range->base_pte, nr_ptes);
+
 	range->mm =3D NULL;
 	range->base_addr =3D 0;
 	range->base_end =3D 0;
@@ -244,10 +256,17 @@ static void __ipte_range_set_pte(struct ipte_range =
*range, hw_pte_t *ptep, pte_t
 static pte_t __ipte_range_ptep_get(struct ipte_range *range, hw_pte_t *p=
tep)
 {
 	unsigned int idx =3D ptep - range->base_pte;
+	pte_t pte;
=20
 	lockdep_assert_preemption_disabled();
-	if (pte_val(range->cache[idx]) =3D=3D PTE_POISON)
-		return __ptep_get(ptep);
+	if (pte_val(range->cache[idx]) =3D=3D PTE_POISON) {
+		kasan_unpoison_pte(ptep, 1);
+		pte =3D __ptep_get(ptep);
+		kasan_poison_pte(ptep, 1);
+
+		return pte;
+	}
+
 	return range->cache[idx];
 }
=20
--=20
2.53.0


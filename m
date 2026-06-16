Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851B35677C;
	Tue, 16 Jun 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613654; cv=none; b=fz+TeykVFwJjCJSTi5k+w7Te6mSvSFoViZXQM7SWmZlTjnKS0taGZ9cqRgHMY58jkxDTWS1dctd/RxaEJIvFdJC30ezJ2VoN21dQFVFNq+5zp6dW0HFUWornVWQYkJy0WGMPGdx6QYiX2R37uP1RV+z0R8lCygYz/kDzl+5wjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613654; c=relaxed/simple;
	bh=8PZL43A5Vmyx5qcwm9ojD0DHjG2LXKl85Hz5tytMZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfQC/MNJWoX6Cnyoul8yNKx/reBirdUIJBNqyaqJevB7P6R+ODsxcjOy1B14PveGf+EUKPuVyG7HRBWZsbaZrsC/dJIQjdvhXMgOMuUzt3lemZiZSqebRxHf10mi4pCWKCbT6vcrixLYYTVubUfFeE/FD0F5BN+lmk5ZM+vP/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oCoxpoX5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oCoxpoX5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIZ6D1135440;
	Tue, 16 Jun 2026 12:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S+RYyodoiEOwvmJG/
	H2wYuH2wgz201TLMBhdk5m93Lk=; b=oCoxpoX59P92YvK79RTZMYpthmeejPN0X
	aO7DmnbIuD7XpA55DtKIkTxiCfom317xbF8eWLe/oVP76OYHPLmWr2pPtY1HO56U
	mtlmM/w9/Q5MnmiV5ZXKkJYymdb5whtpqyX/eGEoW6DE2j5KFTUW0GvW2B2SybNp
	j3jkX95BsYBojzNmuaCFThKSu8ESlMMzEUnyTXLAMYQWAt/Yso4R/2DerrHOBarz
	35wxtJvzeL0yiGuGufdQ+WBezuTpysRrEdG8LPv5+DFTHV5fvoLM1EMTZJpVGo8D
	B427pDyRGTPe3PrJ7BVIS0l3v4tTrDr6+HnJEbqPuueCrzGDGVGKQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0n49t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYfUu012946;
	Tue, 16 Jun 2026 12:40:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq3g56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCeeVP49807624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:40:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEFF12004D;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D71DB2004B;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 91FF6E0E22; Tue, 16 Jun 2026 14:40:39 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 7/7] s390/mm: Lazy MMU mode sanitizer
Date: Tue, 16 Jun 2026 14:40:39 +0200
Message-ID: <acd583d5f511732e71a58f251946672633494462.1781611976.git.agordeev@linux.ibm.com>
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
X-Proofpoint-GUID: plqkqvHnvkamyE4tfbtUq-q5Y-lDPAF9
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a31444c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DuHJb5c9rUSq-GGRdagA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX6m3FmX6pAI7x
 PSot/bPU7kdQjSqBGg1WqAAlJq4aal10WFtZPKEa8sxGgcgXxZ6Rm1tha3P7wCyWKJZlb7MSnbp
 IC9V2k39SzVtnonkq2e1t17uCtAHzy5B0ZJ6DigcbMPNU/hWIRcXZrzkL/MVYxJpthB6/W7mLVO
 1lcLnUoCMHuZYJRU3lBnsrfYTtJ9mXIZmeceTKyWsdQtY25tdJOyfYIeA7VFF63vXquvnFVzQkL
 +wL48wWJAsd4CnzdNgydS/HIz22hYGpaqen27+NQA2GokQLvHE1RHVwgeMx0t5pljZ7TLfgqYbv
 1KtNlp34oX3l+1aOGTeBFTeJZU9QaKyAQe8TleiquzFCHtXsnzdNpIKu3a4c5HdxiF4sRLsIsET
 WCH/EI45pIgYm9fWPP/80w4ENbiLxm7iPlR+y5eh5wo92+gvJanhUSX3+5M5qhfRJ9OsIh/Wu53
 avFGXaFnEQ/CN2gYJpA==
X-Proofpoint-ORIG-GUID: plqkqvHnvkamyE4tfbtUq-q5Y-lDPAF9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX1ghW6ZRPp8Cl
 rSbM1Ljx0rwYHghF1+O5r2j3EYXl/NFEAWo1YXiyu/tVpgCJOwtpAgLzvJN2JJ6SH0DiLhpxoz/
 cJB+Yoj1RxAgLIP/mIcFrNXEIJDrD60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

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
index 2b6659d61fa5..a93e7e786457 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1047,6 +1047,12 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 		__set_pte(ptep, pte);
 }
=20
+#define ptep_get_lockless ptep_get_lockless
+static inline __no_sanitize_address pte_t ptep_get_lockless(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
 static inline pte_t __ptep_get(pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
diff --git a/arch/s390/mm/lazy_mmu.c b/arch/s390/mm/lazy_mmu.c
index d75b93d9b0de..ee2385897bc7 100644
--- a/arch/s390/mm/lazy_mmu.c
+++ b/arch/s390/mm/lazy_mmu.c
@@ -63,10 +63,13 @@ static int invalidate_pte_range(struct mm_struct *mm,=
 unsigned long addr,
 }
=20
 static void set_pte_range(struct mm_struct *mm, unsigned long addr,
-			  pte_t *ptep, pte_t *end, pte_t *cache)
+			  pte_t *start, pte_t *end, pte_t *cache)
 {
-	int i, nr_ptes;
+	int nr_ptes, nr_total =3D end - start;
+	pte_t *ptep =3D start;
+	int i;
=20
+	kasan_unpoison_pte(start, nr_total);
 	while (ptep < end) {
 		nr_ptes =3D invalidate_pte_range(mm, addr, ptep, end);
=20
@@ -77,6 +80,7 @@ static void set_pte_range(struct mm_struct *mm, unsigne=
d long addr,
=20
 		addr +=3D nr_ptes * PAGE_SIZE;
 	}
+	kasan_poison_pte(start, nr_total);
 }
=20
 static void enter_ipte_norange(void)
@@ -94,6 +98,7 @@ static void enter_ipte_range(struct mm_struct *mm,
 			     unsigned long addr, unsigned long end, pte_t *pte)
 {
 	struct ipte_range *range;
+	unsigned int nr_ptes;
=20
 	if (!test_facility(13))
 		return;
@@ -105,6 +110,9 @@ static void enter_ipte_range(struct mm_struct *mm,
 	range->base_addr =3D addr;
 	range->base_end =3D end;
 	range->base_pte =3D pte;
+
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	kasan_poison_pte(range->base_pte, nr_ptes);
 }
=20
 static void leave_ipte_range(void)
@@ -112,6 +120,7 @@ static void leave_ipte_range(void)
 	pte_t *ptep, *start, *start_cache, *cache;
 	unsigned long start_addr, addr;
 	struct ipte_range *range;
+	unsigned int nr_ptes;
 	int start_idx;
=20
 	if (!test_facility(13))
@@ -148,6 +157,9 @@ static void leave_ipte_range(void)
 	range->end_pte =3D NULL;
=20
 done:
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	kasan_unpoison_pte(range->base_pte, nr_ptes);
+
 	range->mm =3D NULL;
 	range->base_addr =3D 0;
 	range->base_end =3D 0;
@@ -227,10 +239,17 @@ static void __ipte_range_set_pte(struct ipte_range =
*range, pte_t *ptep, pte_t pt
 static pte_t __ipte_range_ptep_get(struct ipte_range *range, pte_t *ptep=
)
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


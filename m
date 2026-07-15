Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B444C645;
	Wed, 15 Jul 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121775; cv=none; b=mPIjW8nUKLI2QhrJGvsItIgi3UG26yRnCqqoWvAQjJQWkt+lZ4DWfVEhG1yyrV73xb4kb62rwvW9wO96VZF/mKjw5HElFxApNgbFfRfHqShnKzf2OKlbta5YW+1FXcz+mh2Mwej0ggo7jCJjgurPBX1uupZmLDm5dEVmy8j/zmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121775; c=relaxed/simple;
	bh=Sh27Es5Lq7jJBYRCBn3Yl7EO6PmZODdDN03xKqqIHZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvRBX/gRt9UzMdYDLFV7U6Wi9goEnZ+EptPbWQIqnA2E1H9gMQjKPsLLZld4gV4LqSYwqjTOqM+HRbWmuSTj+KjkeYhd7wTH417WqszhG0m+bgMR6DDASWU2XCjuxyaXTNBlACK6mAOzHbnkQ+ZbhN7bqEePu4fpH43Pi+S2mF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olB+mlG8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olB+mlG8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfiuE075082;
	Wed, 15 Jul 2026 13:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LZ/C2SviyVY4H5WIe
	sI8BfP7X/LNOC1ZDba8bhepJz0=; b=olB+mlG82agEwqz7YBUtChMsq+hqt+SQw
	t2uefipLBXY14/kQbhqEnE5fNB8zAiwIrrGe2TBlDW/MDgkdv5jFNRiYgWB6I4GC
	fCLtNwb6BSy0fe4rXvXNbvvVydgP0N2BqgEhP7LVGdqQyc9tb6BwgXvnlGaPdVrC
	b1tML4c3GYf3PkWG2fJfwafNgTNECmUT2P+veQ2e+1Ld6LY2xhJ3ydPmzOgulmxU
	Ol/p3DGkAQxOLX+sarl814tlzO2GXPWSZgHV+nddWNFzILDdIeIQtPoTySRAoebr
	vTDjRR3bCYrLgDjfLLGwVZ10WjIaTp39Wa2VuT9XJ8aXgmr51/zCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtbsbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:22:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDJbBf025130;
	Wed, 15 Jul 2026 13:22:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw8an1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:22:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDMdkI24117690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:22:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1812A20043;
	Wed, 15 Jul 2026 13:22:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEE9B20040;
	Wed, 15 Jul 2026 13:22:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jul 2026 13:22:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id C67FC162688; Wed, 15 Jul 2026 15:22:38 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 4/4] s390/mm: Lazy MMU mode sanitizer
Date: Wed, 15 Jul 2026 15:22:38 +0200
Message-ID: <a3a32c582430b6065810025466d414aad7c0fda7.1784121418.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784121418.git.agordeev@linux.ibm.com>
References: <cover.1784121418.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NzwnRmpJrrt-hFlhno_51qgFNBqErqBa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfX68NFAi6S/zcg
 UzWZpRSfcFOWnkA+tKIgL+8hsC9iFOl0mxI0jVU/Sj8NeDd5XERLPISiXP8dQT5JOVoBmzboGIg
 Zy9Vkxoj2Vl16Ld6/e9kfMTdlNDuuyI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfXz9xZeV2pgw+U
 J37NUlB/7LIPSOuILoz47iaVhqJpIGMh3zRW5D7cvkdzNI32csohwSsC9QuLgStkVfSAKCPp8hU
 LtwtTUD4+V7k3K+oh+ZLWGN6IEarSJzKkLa6h6x/F58Nm5Uyi3suTF+++bdWOsvrJIcV6JiGX/u
 fGqk6GO70J5m6+wvTTgRBiitmdvfkHYsUNDbSowhfV5PeVk3UqxI48X8lNUzMqBoljQobBF4E1O
 C0FmGCz3mias0Qt+pPraw3GCWg10wPublKEBfWJaqKSYfuyefwq8XI1YkWYQyYD9gbXaWyw1+hp
 kolHongc6zw6v9VFel6ACNcmMq6Qw9kJ/1/8Llj1+JEEAimGdfRZ691bKGKqgtEG15DyegodyLx
 KQH3JCTHnt4UxhMVug/I2iWaZ6pNJA263aSNMPAG/W+0vlth4pTHo09QssSUvyNcaymLeK1VPQZ
 kvzKlkP5xEauEPlTFiw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a5789a4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=DuHJb5c9rUSq-GGRdagA:9
X-Proofpoint-GUID: rLnwT-xYCmxNLq09tf11Z8QOx2djurBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150131

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
index bf54202a0630..1e8a79989ed6 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1049,6 +1049,12 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
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
index 79dc68bb9a53..8947e29132ca 100644
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
@@ -108,6 +113,9 @@ static void enter_ipte_range(struct mm_struct *mm,
 	range->base_addr =3D addr;
 	range->base_end =3D end;
 	range->base_pte =3D pte;
+
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	kasan_poison_pte(range->base_pte, nr_ptes);
 }
=20
 static void leave_ipte_range(void)
@@ -115,6 +123,7 @@ static void leave_ipte_range(void)
 	pte_t *ptep, *start, *start_cache, *cache;
 	unsigned long start_addr, addr;
 	struct ipte_range *range;
+	unsigned int nr_ptes;
 	int start_idx;
=20
 	if (!test_facility(13))
@@ -151,6 +160,9 @@ static void leave_ipte_range(void)
 	range->end_pte =3D NULL;
=20
 done:
+	nr_ptes =3D (range->base_end - range->base_addr) / PAGE_SIZE;
+	kasan_unpoison_pte(range->base_pte, nr_ptes);
+
 	range->mm =3D NULL;
 	range->base_addr =3D 0;
 	range->base_end =3D 0;
@@ -230,10 +242,17 @@ static void __ipte_range_set_pte(struct ipte_range =
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


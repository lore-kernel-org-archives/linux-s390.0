Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A261472765;
	Wed, 15 Jul 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121774; cv=none; b=t6q3cOUgnl8kzA2Kgl+ukkEqKmKAbDwpWkKVGrfIk0KEcPvkziykV9H5KkB8eaZb3JgNPFQbV5XQb9CqnkqRtpJkS7QsiPqHTVwCAy+csPQEt/ydxFt+F6Wd8cO9TLO21YWfx871wgr9QW880C+eMsiDQtM+4ESmV1+atuMHWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121774; c=relaxed/simple;
	bh=Pj7muIkHVV7p/3ibgnYK0z3YYXatpPcl464jDq+I2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1Kcxv1Bz/slo6mHsN2wJH3KiQ+hf2oE/5vQUmf8bZeEULEMmIopudxdAHqGiNHfXAVM9E73NGixpgxX7o/Eb2BNofeizwXkhLpPBSwDn6odmTKLzWw8tILWM2PhNi4bwP/NWYzG1Kc2yAXl/GKlk+PHxEJSHEkaeFvSYKm1eEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PhE+jxTO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PhE+jxTO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBfwpS4179583;
	Wed, 15 Jul 2026 13:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vIFo0YrK5esCG67Dm
	/2h5j9Bki/Ly61qdMaw02Uu8MM=; b=PhE+jxTOXGB8BQ4QyyMswmDciwBbYrj1k
	rPANFzDHOzHLz47e5EJTVtG4q4Fh/c6uiMHLQsZYJoRG9136twRe72xzIj0OSRIA
	dDYxP0J/qv127hYyiZ2vo6ImoJZ043nwlG9Z5PdyYffvdGvU3bZqvJ9HGVZ76NLG
	5ZP90coqDU3K94gMkr5mPlAH5SWG2LT0trPEPYXCFMlKqW9bNDBsIDT/6P5NJGvZ
	eumsEMmv3WVxJ9YwuBu4o9YsCrm6fwQ8v3nGc7kv1rsiyQ2LQX51zw9jsQtxfUI9
	zKsacZlJlp9+YBv31Ir2aVeDInNYWxfptn9MVd2Bdq5/a01UbfhNg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwu31m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:22:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FDJevV025139;
	Wed, 15 Jul 2026 13:22:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw8an2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 13:22:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FDMdp940960292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 13:22:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16A082004B;
	Wed, 15 Jul 2026 13:22:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCF3320043;
	Wed, 15 Jul 2026 13:22:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Jul 2026 13:22:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id C454B16267D; Wed, 15 Jul 2026 15:22:38 +0200 (CEST)
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
Subject: [PATCH v6 3/4] mm/kasan: Introduce helpers for lazy MMU mode sanitizer
Date: Wed, 15 Jul 2026 15:22:37 +0200
Message-ID: <a5bf7ac327864193bb7c95d8575d6ce1f6a9576c.1784121418.git.agordeev@linux.ibm.com>
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
X-Proofpoint-GUID: 2ZgdxkD_DYSdg9jm7Pp6y5oNH5YOUkHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfXwrK7eiK2dknl
 51QHOgXzU39lTsIxK9u9LCfMzbI4qgTtRmhhyG5FAVTwfEmWxmJYbU4q2zFLIjWSGvus23wtqU8
 roC1X+wiXxX56BswANoX4v0pm5GrqEgZSgaMSqSmUCbPFkJbVGkhnFjCHR6HA9JoiV7tDV7LlH5
 VBy8Ybnu4q4MAKKt4OR8gW1I7+D0w94BrANMDGlQE4+4vrLo8Cm0BctlW18gOe8MppJzRv0ixrk
 hM4o+Omul91T15izPsT7db63Z6OhuM+hdGJosA5PMdXlZZiY/Mzqg1RQnOseTIruSREnHjs6QFM
 JrVFjdK7qY5+VV0iKIA58BbKRq2xZuVXsH+MrCt1MkhnxhWmK5hlWmXqQdkwpClMv3SDDW8P4Ar
 NrGOQ/8ZW4MgEZN29NpWay4ccT2NIJp8pijkydyOIrz9dwGC3Oo4eHoq33agFghFZ39JZvQ9Rbg
 tlWvfgASLia0IaqZuqw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a5789a4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IbWDVZlrxelGz4sJbtUA:9
X-Proofpoint-ORIG-GUID: FE-uiVEGEwD2-Wux2TSiwKAzgMqSIBSs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzMSBTYWx0ZWRfXyYt7UqZQ06T/
 rBvOxOuNJCamh4xOpMiPJJW7nukNzFcGbangxtz5EIWDHthw7llQba4INI1kgxRPZVuOhNn2nqq
 ZX5HCFF3uVAaStAKg7ae/DXtpFKeUm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150131

Provide helpers that allow architectures implement
illegitimate PTE direct accesses while the lazy MMU
mode is enabled, such as:

	pte_t pte =3D *ptep;
	*ptep =3D pte;

By contrast, these would have to be:

	pte_t pte =3D ptep_get(ptep);
	set_pte(ptep, pte);

The direct PTE accesses pose a real issue on s390.

Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/kasan.h     | 16 ++++++++++++++++
 mm/kasan/common.c         | 14 ++++++++++++++
 mm/kasan/kasan.h          |  2 ++
 mm/kasan/report_generic.c |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bf233bde68c7..deadf566b84a 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -134,6 +134,20 @@ static __always_inline void kasan_poison_slab(struct=
 slab *slab)
 		__kasan_poison_slab(slab);
 }
=20
+void __kasan_poison_pte(pte_t *pte, int nr);
+static __always_inline void kasan_poison_pte(pte_t *pte, int nr)
+{
+	if (kasan_enabled())
+		__kasan_poison_pte(pte, nr);
+}
+
+void __kasan_unpoison_pte(pte_t *pte, int nr);
+static __always_inline void kasan_unpoison_pte(pte_t *pte, int nr)
+{
+	if (kasan_enabled())
+		__kasan_unpoison_pte(pte, nr);
+}
+
 void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)=
;
 /**
  * kasan_unpoison_new_object - Temporarily unpoison a new slab object.
@@ -414,6 +428,8 @@ static inline bool kasan_unpoison_pages(struct page *=
page, unsigned int order,
 	return false;
 }
 static inline void kasan_poison_slab(struct slab *slab) {}
+static inline void kasan_poison_pte(pte_t *pte, int nr) {}
+static inline void kasan_unpoison_pte(pte_t *pte, int nr) {}
 static inline void kasan_unpoison_new_object(struct kmem_cache *cache,
 					void *object) {}
 static inline void kasan_poison_new_object(struct kmem_cache *cache,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b7d05c2a6d93..94d106094989 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -163,6 +163,20 @@ void __kasan_poison_slab(struct slab *slab)
 		     KASAN_SLAB_REDZONE, false);
 }
=20
+void __kasan_poison_pte(pte_t *pte, int nr)
+{
+	if (IS_ALIGNED(sizeof(*pte), KASAN_GRANULE_SIZE))
+		kasan_poison(pte, sizeof(*pte) * nr, KASAN_LAZY_MMU_PTE, false);
+}
+EXPORT_SYMBOL_GPL(__kasan_poison_pte);
+
+void __kasan_unpoison_pte(pte_t *pte, int nr)
+{
+	if (IS_ALIGNED(sizeof(*pte), KASAN_GRANULE_SIZE))
+		kasan_unpoison(pte, sizeof(*pte) * nr, false);
+}
+EXPORT_SYMBOL_GPL(__kasan_unpoison_pte);
+
 void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)
 {
 	kasan_unpoison(object, cache->object_size, false);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index fc9169a54766..1a2d18cdb21d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -144,12 +144,14 @@ static inline bool kasan_requires_meta(void)
 #define KASAN_PAGE_REDZONE	0xFE  /* redzone for kmalloc_large allocation=
 */
 #define KASAN_SLAB_REDZONE	0xFC  /* redzone for slab object */
 #define KASAN_SLAB_FREE		0xFB  /* freed slab object */
+#define KASAN_LAZY_MMU_PTE	0xFD  /* direct pte access in lazy mmu mode *=
/
 #define KASAN_VMALLOC_INVALID	0xF8  /* inaccessible space in vmap area *=
/
 #else
 #define KASAN_PAGE_FREE		KASAN_TAG_INVALID
 #define KASAN_PAGE_REDZONE	KASAN_TAG_INVALID
 #define KASAN_SLAB_REDZONE	KASAN_TAG_INVALID
 #define KASAN_SLAB_FREE		KASAN_TAG_INVALID
+#define KASAN_LAZY_MMU_PTE	KASAN_TAG_INVALID
 #define KASAN_VMALLOC_INVALID	KASAN_TAG_INVALID /* only used for SW_TAGS=
 */
 #endif
=20
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index f5b8e37b3805..489d4a8d6902 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -113,6 +113,9 @@ static const char *get_shadow_bug_type(struct kasan_r=
eport_info *info)
 	case KASAN_SLAB_FREE_META:
 		bug_type =3D "slab-use-after-free";
 		break;
+	case KASAN_LAZY_MMU_PTE:
+		bug_type =3D "lazy-mmu-pte-access";
+		break;
 	case KASAN_ALLOCA_LEFT:
 	case KASAN_ALLOCA_RIGHT:
 		bug_type =3D "alloca-out-of-bounds";
--=20
2.53.0


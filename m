Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DC25D53B;
	Mon, 13 Jul 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952322; cv=none; b=OvisZjBdXVMvqCZtTcKY/DVVADNCMYTgroCEqSZA3tuVYUzLOjnh9BAqqbdkbVhpY/KkFM660gGYw79UlCRI6tKopRYNBgGyz90jRk45Xi/B+/JIqRPJkod9+1a1Bk1GnEL8IgdZa54DsmOEsaxCXip7zwd2K90RZpD5X/o13+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952322; c=relaxed/simple;
	bh=/rdnzgxnj9ZGGjli54t6DhUWz7IVNu2vUWKglsBV7Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvkMlps8A6tzROKn/kZaRTyimwCPGxQIYPJof3ExiXrBXyjdPX+QDG9rlh7pj5YpZSsnC9CVWwFQz6W1Um9pQ1B0u/uGEMqq1rRZfBw5OuyIsav7A8V2C2mz7xCSBXjm/0z+9N5MEd89cnpkREOicY5mh3eYtK9AbzWG4REqxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IAu7vwxn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IAu7vwxn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCCxJ02433473;
	Mon, 13 Jul 2026 14:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2vl0RvV9NekKqP5eY
	/XJThSoFdB3ZQjbMNiVfPbkbRs=; b=IAu7vwxnbvNMLA1uCK0ng2nE5kW1Wq+lH
	1gfKv45Ewei+jomoTIIRuR9zlJxwXQTg3Z7rV0o1MJPhPQ0nl69UEtNKII/DtbV6
	tsW1YQeBudDwLqM23/CCfihj3C3SXh/B1ZZJL472HehTPm2O+zIBMWsu/fef+RMW
	bq6MX9xZZxpt1wVSbY8/kiUrQuxiqhu7BtU7RxZDeJ6V6eKUEcTAeYFi6hIJ+ovj
	3NqtTvS3L2p1Z8KJvHq40fWECkehsHmTcm+rskSJ/vWtZmxfiRmZ6Xd4dNEutGYZ
	asKWQiyOwZA1CxLieP9c5VQJa8ffLSophYbuS+19uwexq4XYWYOBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbgrkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:18:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DE4iUU025308;
	Mon, 13 Jul 2026 14:18:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxwr3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 14:18:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DEISpd14418342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 14:18:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 393182004D;
	Mon, 13 Jul 2026 14:18:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13E9320043;
	Mon, 13 Jul 2026 14:18:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 13 Jul 2026 14:18:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id F27DD162522; Mon, 13 Jul 2026 16:18:27 +0200 (CEST)
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
Subject: [PATCH v5 3/4] mm/kasan: Introduce helpers for lazy MMU mode sanitizer
Date: Mon, 13 Jul 2026 16:18:26 +0200
Message-ID: <38a663eeccd060d961990baf65338e2f2550e580.1783945507.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783945507.git.agordeev@linux.ibm.com>
References: <cover.1783945507.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54f3b9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=iFyILk1haAFnC_s91q8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0OCBTYWx0ZWRfXy1I9EchAqqyO
 dXL8Pnx9oOjgJN/nfv563MDUqGvPiSRS+wsivCrOONCRp5LF4Wmhao9QoGBvrmws4VeUaGvfQ+t
 8IEN1s2ncYpk9NV0roZqtfbTPZ/A9w2vMw4v+FUkwBzgrsTOqqnYMtenhKtnE8VbQ7+2FaPYSwt
 vR5YRrQvblKdKbvQK2pQvKcMTeAWpLtFxLlL5bMiEq19uexQ80E0sW6oK/038XoWzqht/ayBtPs
 5fqxSr5vdpf8auvOq8OeAfc8lXHp6T7N71cqs0QDh3+RP4MmDFQuv61Hc2YAq8lIs7ZGi6XZYFu
 Y7oCIYYWkPp2b50gNY6c9X9ihTDboG3EQ2pGxtO673U0BPSZrNTkvW+BdcTAqcoeDAsZbXGyoWj
 XV2MXJAr+sP2/OXiSHL+YcCAcqLiGQFgUDgXpItrgSe9iIsD1DcK3uPSpWxWU+Jwck2KdDXYDvM
 gx6L3TOMbS7ZiRzCnYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0OCBTYWx0ZWRfX2MXCilhzZkG5
 0oHQF+aUOwwDmM7CK39kg+KtMEilOiDOb+lySdlR+A+AqGFsfZlnH/iFRgY/wWGIHjvHFVsTq0S
 mhq/Be1YZHBMCU0lxhcfUEbbaHX1VxQ=
X-Proofpoint-GUID: fbeKGc689gDMosGxsekWQ_xt2MkGAW4U
X-Proofpoint-ORIG-GUID: vqO7vk9TXadg0UNw7zBHzra_XtR5hBsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130148

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
 mm/kasan/common.c         | 10 ++++++++++
 mm/kasan/kasan.h          |  2 ++
 mm/kasan/report_generic.c |  3 +++
 4 files changed, 31 insertions(+)

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
index b7d05c2a6d93..cbf68680614e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -163,6 +163,16 @@ void __kasan_poison_slab(struct slab *slab)
 		     KASAN_SLAB_REDZONE, false);
 }
=20
+void __kasan_poison_pte(pte_t *pte, int nr)
+{
+	kasan_poison(pte, sizeof(*pte) * nr, KASAN_LAZY_MMU_PTE, false);
+}
+
+void __kasan_unpoison_pte(pte_t *pte, int nr)
+{
+	kasan_unpoison(pte, sizeof(*pte) * nr, false);
+}
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


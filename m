Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7E360EEA;
	Tue, 16 Jun 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613655; cv=none; b=Ml5A4vnT5WC538SSu7WhbGKf2hXZUhQCf2SJu1nJxCwg0eno1vKSsGrOpta9Z2OknK8FabhkHp7FLy7fRBml4myXtaFwfiutZm7k1buXVlBRDhacsTGGxsq4vvQruXAqHT3X7d3fk2XGHk/+chqGkcE2m+4gkEQl4/aVJU2kuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613655; c=relaxed/simple;
	bh=zk/RSbN6RZ7ABlkFkPJo4CjjUUbpsORg+MkEStfZ3NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrV3ysxjO5sLpW+au0UyZEJWwntUq3peIZLvBYK2H2FqvTTp0w1AP1pvlNT+b2qbqHQVewKtGpvlpmFdk8eOtkqbmioShY0H01W/j5LZU2zMbavnshrfcFQ/aLTdLcFvzIhhKHgn4wb9naLCA/wJEaGEawOFatDXsOSAB2GOPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DQPvdnRF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DQPvdnRF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIZfA1156428;
	Tue, 16 Jun 2026 12:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wVZh/diParohRV0vS
	r+dwmsRa2RCsdg+05fhUVnh7AA=; b=DQPvdnRF8fbHbxMnPBGHCMVzusDC0Wmua
	oxAVPRe9x7LW7NkSEWGOGUUb8eR09sQoPkjmL1xGzn0s88AWJ9JDOJBVTJ5l6U0m
	wAaG+b/0j5OZqZ10+afu/LsC+pyQ/EUS8Y5yjmfOcYS6gnOglRPp6xQtu+SCcHot
	Ytk4uCI3dT+c42dSCSnSoQttixiX1O5Psi0zdJeLromZzWRN11G1ewZayqKPysOK
	i2nY9xZkrqvtGkecba5bp2FsHMq1Doq3EXHYCap5ATZf9Zj2mhuK/hBq8cDCfYds
	EPrQcur/xcU/QGApESx4HePL++TK/xxZqBecuQeszzskY3BXaJ1Pw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg53mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYgJu030961;
	Tue, 16 Jun 2026 12:40:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgb46k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:40:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCeex344433910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:40:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 019DA20067;
	Tue, 16 Jun 2026 12:40:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D767620065;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 12:40:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8E863E0E21; Tue, 16 Jun 2026 14:40:39 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 6/7] mm/kasan: Introduce helpers for lazy MMU mode sanitizer
Date: Tue, 16 Jun 2026 14:40:38 +0200
Message-ID: <cb187d0388131718513176cc7183bf352ee55b18.1781611976.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX2M9hgxPj5oJb
 0F3NsExc8Va46IiKTMXLRysZQVwfB946uEdbxk7KoGgKaOherCE7owiYD9+mpLqo4UdW9eT6obH
 cHvEtFynvJG7YKy+WrXYgbvMjSfIOF0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX6BqdBTWJ8EHc
 RD37L6sQWHF74bGTgDNIIJ50kUu5gNkv8TIjHH+iQHjmObk+WrCB0ifKq4+2sVewzoxZnnmUQP4
 u+IaYsiGEg3KEAiWNQ0xMZzvWcnSiEapfChp3zYrzCr3PRVOLQkW0JZEkMhc/el3kU/9+5h8/C0
 fj2k0KLN1HXv9iQ3PViMyijJscAGcNHaaHLDaclLXBR+nMKxfAb4dCKUpfsovBx68yh0Maf4a6Z
 O+EwJlx4HJeGerAD7EABnVJ2RROsGpjxW1EF7MA17MCSRLWZQvPC58bh6r2zNzyzTQ/9PgXSUcW
 aQhOM0jufNAY1d3Oz44N901Fboeo7fd8Ah67nmEF0ObIGQ9XFJsFOGON8MUoO05Cu3g6U7Q9nUr
 gY1Ob25UJ2d6ILqWtAJEgyEi9WfVn3eFQm6Gvv7Ov8Sk3aHQqChbh9MPLOhtxiOXZnk42pAWn21
 nNkrjp3VjQTNohkeP1A==
X-Proofpoint-GUID: 4Xqwqj3nFd1R4rD5liTXXmuEnhty_zX4
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a31444c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=lldn-txhwCp5ury-Zd0A:9
X-Proofpoint-ORIG-GUID: 4Xqwqj3nFd1R4rD5liTXXmuEnhty_zX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

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
 include/linux/kasan.h | 16 ++++++++++++++++
 mm/kasan/common.c     | 10 ++++++++++
 mm/kasan/kasan.h      |  2 ++
 3 files changed, 28 insertions(+)

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
index fc9169a54766..8ba0fbabd75b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -144,12 +144,14 @@ static inline bool kasan_requires_meta(void)
 #define KASAN_PAGE_REDZONE	0xFE  /* redzone for kmalloc_large allocation=
 */
 #define KASAN_SLAB_REDZONE	0xFC  /* redzone for slab object */
 #define KASAN_SLAB_FREE		0xFB  /* freed slab object */
+#define KASAN_LAZY_MMU_PTE	0xFD
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
--=20
2.53.0


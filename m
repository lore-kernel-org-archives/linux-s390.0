Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5F4915B6;
	Wed,  7 Oct 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373364; cv=none; b=szINTP4HoZvXZWGmxR+HwQ/GYZ/Lswb+A4zzl3/q2xdPrwseXiG4/JRb5aPhbDXyci+Nrgc+aHNFIQAfmyrfaXgcUEdtqNsERxXq3bMdZ+5j71dER2jumpkcvn8H6+4jkHZL3x+EoRD2Gt84Nd8TtNIUbhq22z2g2TTkR/dS/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373364; c=relaxed/simple;
	bh=8T2GQJm7H5ksVGR/L+6oOcxlUisl9y2M4o3s3/eNwNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrz6xo5LFE/+GB1TlLwWYbtch9Lfv0g0a5pS+yHxZQkQUNrZdJTaAFnGtJ3Qh9mEamsbzgN2HovwVGVXyRXj4yZPBdG3ofrCO480/T5Db29UX6XpqcE7AtS5r0kA/R+h0Jnlz7ptUb2KutOIVxEKGIHpmoNIHfF3rJVE4Tr2m+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVA68+tU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVA68+tU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZwxA597192;
	Wed, 7 Oct 2026 11:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LENXcUhtNjTRcUvlC
	4i+bIRx00OSk2JxzpFUTOM/Jic=; b=dVA68+tUQppiVzNffU2oqfB08m16MixeB
	RlOa5Ms8tM9dfqNt26yZQ+b8c8VMtBaZrYV/vSj5qVLb4o3gUa2+QC0jlu5rdBg0
	3+OWGI6HJMD7L3/Eiyr1kmBuwoetqcKQUDsN07j738C3yrsy/1bBxkAdnEUV8svp
	rt4KSv8zVDjOLr77MfCqxaw5pD0ZunE7Y+yvcRvTWzSmd9x2kY5O2gWjOHDsOTxV
	lRzykbTBO9g4gEywdHFDihYE1qc1a4cnkVVOjvPJmPNPpzFWjt0FGVSu/bg7PFi7
	aNGXOpCslqGXAsPMAp4D5RgK6f0Kv73oqXnpjlfr1C5P/lTJjSdag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrn5kq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BWmPU1789976;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5jmhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxGN35127770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC302004D;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 116252004E;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 89F1F1609B4; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 08/15] drm/i915: use hw_pte_t for PTE range callbacks
Date: Wed,  7 Oct 2026 13:41:51 +0200
Message-ID: <fec82d136996345f5937cc3a8fac951fdc2ba2f0.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfXyy3E+t6pM3Zw
 E4RKZ6W9Vz+LgTLcJcj+Xw6HNuJ5WgJquVE6UnPW+GkFtIzyuNwH/HUSxkOfkPLTab8+htUsMv7
 aDEjW6y2Q+n+ugj6HNRATShLOfX4Ygc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX8N8fkP/4i3KV
 dTgP+/oV/CeYw/3O9gvGgHpjzOjxUzHMoUklra8YP19PY5b5Vd/IdkYrlfOOa6d7MWtxZGJr6Ol
 eni1W05m05OlhIOx3tZLVtcB3hfFpN7AX8IFJBcvwZvLG82BIlr/EOiaaRIGUm4eNtAP2xmVEaR
 XSQQcb0XMQoQH8mPqPh47qteUYAGWghd7GH2ymGcSjIuK17eOIsjnBszmGahnFV276GsEnqf+gf
 Rgub9aDVyowCkmT4YTjYzVCIUJ+QW/sKkPji6q7K60F5BjGocMvqB4rqIWynkdTeevnk9aXSFcd
 5FETSJbTganoNAykilh8mCfA70mMFSpMOKpotd4l4cj0gFe1766R0Xc+3JrvY3Jq8NjQjS3qUPw
 kl+tlt7ybpWjYkYVmK0Nbwvphe4oRgkOyTGrJwfV6EHLkxnLrvs1onTLFegJKYkejKWOspyM6po
 M/yvfwZigTiFAEc5vsA==
X-Proofpoint-GUID: cI8WzYm86iYgzZtGvHYBajDSbKBmdn_H
X-Proofpoint-ORIG-GUID: 6s5fZS3ntdQw-LkPSoqhoh7y4N7vzvjU
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=7CQSdrXTAAAA:8 a=irxyurOfxv8hHXk4GvsA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

apply_to_page_range() now passes PTE table storage to its callback as
hw_pte_t *. Update the i915 remap and selftest callbacks to match the new
type.

Continue to use ptep_get() for software PTE values and set_pte_at() for
updates.
The type remains an alias of pte_t on x86 until that architecture opts in=
.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 4 ++--
 drivers/gpu/drm/i915/i915_mm.c                     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers=
/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index d01acfb7d93d..056faf4a3618 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1690,7 +1690,7 @@ static int igt_mmap_gpu(void *arg)
 	return 0;
 }
=20
-static int check_present_pte(pte_t *pte, unsigned long addr, void *data)
+static int check_present_pte(hw_pte_t *pte, unsigned long addr, void *da=
ta)
 {
 	pte_t ptent =3D ptep_get(pte);
=20
@@ -1703,7 +1703,7 @@ static int check_present_pte(pte_t *pte, unsigned l=
ong addr, void *data)
 	return 0;
 }
=20
-static int check_absent_pte(pte_t *pte, unsigned long addr, void *data)
+static int check_absent_pte(hw_pte_t *pte, unsigned long addr, void *dat=
a)
 {
 	pte_t ptent =3D ptep_get(pte);
=20
diff --git a/drivers/gpu/drm/i915/i915_mm.c b/drivers/gpu/drm/i915/i915_m=
m.c
index fd89e7c7d8d6..aab88e8edf94 100644
--- a/drivers/gpu/drm/i915/i915_mm.c
+++ b/drivers/gpu/drm/i915/i915_mm.c
@@ -48,7 +48,7 @@ static inline unsigned long sgt_pfn(const struct remap_=
pfn *r)
 		return r->sgt.pfn + (r->sgt.curr >> PAGE_SHIFT);
 }
=20
-static int remap_sg(pte_t *pte, unsigned long addr, void *data)
+static int remap_sg(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	struct remap_pfn *r =3D data;
=20
@@ -70,7 +70,7 @@ static int remap_sg(pte_t *pte, unsigned long addr, voi=
d *data)
 #define EXPECTED_FLAGS (VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
=20
 #if IS_ENABLED(CONFIG_X86)
-static int remap_pfn(pte_t *pte, unsigned long addr, void *data)
+static int remap_pfn(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	struct remap_pfn *r =3D data;
=20
--=20
2.53.0


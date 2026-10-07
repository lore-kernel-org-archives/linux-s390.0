Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866049D5BD;
	Wed,  7 Oct 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373359; cv=none; b=s1HJJPBocrM2uLDrt3F+RwQRwumduP4JqrGElTLgnd2XBEwfLuCWyyNE7X20e5aavvAAOzZkwKu5BLIt1xWslely9N76Ca/3eBCoPVHe9e4+wqJZwqu3xhrzDk+P00mImfb2jFSvXyaXjtqdhekKcB0JpdFkMK5n3RfPWCMc14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373359; c=relaxed/simple;
	bh=LMo1Sag3sz2MOH/otxgyEirDX0Yqf5/HzmWwzM0b0QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvSzD7vY9x2hLzKNtv7aA36iKJh+tkLQnMQ2t8cO8JZVtRBriKDoW+Bt6IZaxA09MPbvsNLQNouYVWDpzex4+W24yPrkBc1FPxp0PhHXrGY27UFlASy4W0u/HGzIFmxtAAyDRQRAMAriAPO37B9LPE+Cnb9Jd9sqjAHTVFjghBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1QsRBXR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1QsRBXR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZQNv2375606;
	Wed, 7 Oct 2026 11:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=abX4Nq/5AyAFWdNBp
	pfKO4gObdBOnRXbHlhnHB8IPa0=; b=M1QsRBXRYXI3PNQ3dXQyQVASCeOkwYgEM
	r5jpylwnhdNw6ri8TMUDp+xdHHyIEbE7f6+H49/nlW0VNoNJqZKHmCogepNchNLk
	jdVgX3rtvB0jZJZR38UskIoIXVzIOhLMXl8snnhNIHVQ2q3ILg4A1fv7zHX7jPx0
	9CjFP8BUmtDJWbEJoYjo8d0a92otZniOaQkrfK+l7I0j3Vbo6N6DxNtO3cOgHVch
	KSzFFbiDakeueuJa0Jbe1tPscd/H0vrWJ+docbzrY0TCH7YHgj9L9ZGPAdqOyBda
	JP0x20lHVPq48M4pSWn+nSDcWuymqz6sK4YiTLChurxqmjiRyk/bA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5n55r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69782RdI1562407;
	Wed, 7 Oct 2026 11:42:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxfh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697BfxU837355960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 612B320043;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1216E20063;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 87FB41609AF; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
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
Subject: [PATCH v8 07/15] mm/kasan: use hw_pte_t for the early shadow PTE table
Date: Wed,  7 Oct 2026 13:41:50 +0200
Message-ID: <e24977fba12bae1a05e8eda80c6bebab423ae5e1.1791365932.git.agordeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX1qYEKV7bKBha
 Z6vE427s5TOQaGNcAe02e2yRGioQ0XdpycGCtFbL7iv8DRIvqlCcWBFz4k9wTWPsbwb80mOx/xV
 8FOgX7h5x+fMcaa3oPbEEff4Zs6QiRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+jK91lYLDmjG
 58/HvuoRRQ/CLPpSgaLnGza4i9FTqyeBXWg11ncIjV+f9fLtyvBW48IIZvtHtdlyL7MrGeehOk+
 zW8HNvLoJ6MYjkqUPfdnRpbhWZhIcoiKwbxYCELzHXV+UGjRJD7l76VbS1y+1fBEfbN1MgV3ytl
 pGKkRmKjSvNlmMUA++CJdD4Emj8mzY2yfDbCYXlH77kn4oTms1L58gB+dK9q2Ncp/CMzL+fNIJp
 nqVRW3go5AQ9ml3UbBHKElmnccj1TRlw509zKRB0PrkEHYLaH9cRDHOgjgS+eUPsB/6OY/MWdXl
 LAi7pRl6lCrtg4CaAz1/Gr0ndHoJ0lPkJn3YJ+JKS33o7X7qE/3YnP64qPcTYxsIOBbycWc0Z+I
 rvMSpDFmnkAZ38UlXyuEVC6Hx97fum6MEq+2FanWbn6xqZUr3xnmOgybx85e2CqhZ1sw/3BnqHm
 qcfmjBn+9SvTzXpFaNw==
X-Proofpoint-GUID: s9S2W-A6tSAdq8XGy8mTE75XRUEWIcqI
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac6300e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=7CQSdrXTAAAA:8 a=AO8vZCCDSQ0loUGPtsYA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: FN1Y3Ei1wDooguhmrQWKXB3qRV0x0tJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

kasan_early_shadow_pte is a complete PTE table rather than a software
PTE value. Declare and define its elements as hw_pte_t so the object uses
the PTE table storage type.

Read the first element through ptep_get(), which returns the software PTE
value expected by note_page_pte(), instead of accessing hw_pte_t storage
directly. This also uses the accessor selected by the architecture.

No architecture selects ARCH_HAS_HW_PTE_T at this point, so the storage
representation remains unchanged.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 include/linux/kasan.h | 2 +-
 mm/kasan/init.c       | 2 +-
 mm/ptdump.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bf233bde68c7..ff41949c0ac0 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -51,7 +51,7 @@ typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 #endif
=20
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]=
;
+extern hw_pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PT=
RS];
 extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
 extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index 30c5266eaf37..9bbc2a41d23f 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -64,7 +64,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
+hw_pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
 	__bss_pgtbl;
=20
 static inline bool kasan_pte_table(pmd_t pmd)
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 376880071ca2..8f19f20be3c4 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -19,7 +19,7 @@ static inline int note_kasan_page_table(struct mm_walk =
*walk,
 {
 	struct ptdump_state *st =3D walk->private;
=20
-	st->note_page_pte(st, addr, kasan_early_shadow_pte[0]);
+	st->note_page_pte(st, addr, ptep_get(kasan_early_shadow_pte));
=20
 	walk->action =3D ACTION_CONTINUE;
=20
--=20
2.53.0


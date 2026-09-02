Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9241168B;
	Wed,  2 Sep 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384256; cv=none; b=pjkLprSunLIHpwU+IAJJBHMX8vPCqyBRuMTmvU54lAbbzPetYjZ3qjlQAsYm25aU+bCWJMQYyqNAXhgIVlBkGz7bLeLxcO3yvRzV31YvxfyJ/GUmk2wevchqzpdADBiITyHygnDeIh2XHZk/5cQZF06UiRviUal1lzePrxa7GcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384256; c=relaxed/simple;
	bh=EIYUOMUuFfVPzOXzfY5JHb/TW2WSq/PkUFIT084qqxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAao9Iw19OYV5if/u9cVypN2DrH/u1bPYtftFrZhUfn6eVsJ3HCnj/Y2cE4T/0MvvmMB20cups03YLHpfrAD9/pTZLSgzP7rhe6KpkdTU2mruBoKEVH2S0k+/eLdwLy+5F56bBvs02NTdomd80+ftXJ0JGVeoLB9JwcoQRqfwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JOurh/Gk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JOurh/Gk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KW4Lb1049322;
	Wed, 2 Sep 2026 21:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jgA8r6HOYLo5NgvJU
	ow5NjWaY0Sn1DM1UKfiiXLJ3DI=; b=JOurh/GkMYn+vnm2mE37gTQqzxbhAnLiU
	5zGZRqqy+acNsT8AgOPZZR0BddhhAGgIMkiLa3cF4b4kvkAnvlm/nhoemqCI/49X
	B/KGcF3BOz+3EDPrb1rV35h9VYDp+egUYQ2EtubZIxOGl6azTRDT8yQ0cWwiYyAs
	lbBw0Kk2xeMGjeLyQXG5WpmL9ArwoV2Q1FEmt7x4zZFkgia95j1p2tCLKopo+U4Q
	kmhamrQpTiCYoE13yGB0ZzC/NuKHSzg/KabT+pZB96T0H4g1wx03olUHZe93BunS
	dBA87w2Pmi+hIW2YMwNMROjB4Nbnm5aFyp4SnqJzjIjZaJXg3lr7A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq551mrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 21:24:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682LBEDi019727;
	Wed, 2 Sep 2026 21:24:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyc9qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 21:24:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682LO3lE46334374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 21:24:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2983D2004B;
	Wed,  2 Sep 2026 21:24:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A6F20040;
	Wed,  2 Sep 2026 21:24:02 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.87.158.224])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 21:24:02 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 1/2] s390/ebcdic: Add character classes for the ASCII subset of EBCDIC
Date: Wed,  2 Sep 2026 23:20:17 +0200
Message-ID: <20260902212400.674450-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902212400.674450-1-iii@linux.ibm.com>
References: <20260902212400.674450-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX94lQgPw1SmCD
 8hMoSDP/n3bN8j9hX6Ls9E9LzuO3BE+zYzT/zjcaE/maQlcAtZ0Kge9O1ZIB10Tp7Mj4ddwpvrl
 /k4xrbea91Khe/gDo4SlX9Pp2yR6TcTvb8PMuf9ddVnvqApdO0R81mbcsE83rwp5NXIrmZ+DmTh
 UV5SSf4VgqnvfLdaqMPscFwX2WQcRWMbUgPfI9fpiK+/Aw5a34woUZ4UkwktJHPhO5Twu7dAflq
 m4hSc2NWDYFF+dw0MH2+U3ZgTP67DSxQtnA815DN/TMpKLk2oxe5QF4w0+vPXaEJ/RUftvZDpFl
 tEhxXKs9gw4dWF4d9BU3+S09Pzx8zMwbN0kooUt8lB0DSlj3+L/vrqTh9xZx82Vh1pIQGdMaDhL
 K8xQEzM8Y58PaOrBHWs8jjV7bGLaQHjUkyDQqRW1K+IcwkchciCTfNZkGrb3eZT5y6PmsZ7Cbhc
 Zl1g0knJ5GXYp/c84bg==
X-Proofpoint-ORIG-GUID: yy4GExU2H3sdcFt1gciTjcKT1GgY8ET_
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9893f8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=8pif782wAAAA:8 a=VnNF1IyMAAAA:8
 a=lou5dwPg_VZd3XMStWsA:9
X-Proofpoint-GUID: vqNzDz0GMpDrlKJYUgdeK2lnMKejTL4m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NiBTYWx0ZWRfX3dKOIly3AUdL
 lmk6FGEsXsoqvCWU/2KbY3Oxl1ORBS7YQiic1JhcritbiLSj05F75lHdNliX0Gx1j9Vyn59e7Rb
 QtaatBpsjl/zy/HTECX04Jn8HmyzPF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020186

Add _ctype-like array for EBCDIC characters. Mark only those that also
exist in ASCII, loosely based on invariant subset of EBCDIC [1], but
with cent, broken bar, not sign, and plus-minus sign, left out.

[1] https://en.wikipedia.org/wiki/EBCDIC#Code_page_layout

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ebcdic.h |  6 +++++
 arch/s390/kernel/ebcdic.c      | 40 +++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ebcdic.h b/arch/s390/include/asm/ebcdic.h
index 7164cb6584355..78d2e37e985d3 100644
--- a/arch/s390/include/asm/ebcdic.h
+++ b/arch/s390/include/asm/ebcdic.h
@@ -10,6 +10,7 @@
 #ifndef _EBCDIC_H
 #define _EBCDIC_H
 
+#include <linux/ctype.h>
 #include <linux/types.h>
 
 extern __u8 _ascebc_500[256];   /* ASCII -> EBCDIC 500 conversion table */
@@ -18,6 +19,11 @@ extern __u8 _ascebc[256];   /* ASCII -> EBCDIC conversion table */
 extern __u8 _ebcasc[256];   /* EBCDIC -> ASCII conversion table */
 extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
 extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
+extern const __u8 _ebctype_asc[256]; /* EBCDIC -> character classes */
+
+#define __ismask_ebc_asc(x)	(_ebctype_asc[(int)(unsigned char)(x)])
+#define isprint_ebc_asc(c)	((__ismask_ebc_asc(c)&(_P|_U|_L|_D|_SP)) != 0)
+#define isspace_ebc_asc(c)	((__ismask_ebc_asc(c)&(_S)) != 0)
 
 static inline void
 codepage_convert(const __u8 *codepage, volatile char *addr, unsigned long nr)
diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
index 0e51fa537262b..815b90ef520c0 100644
--- a/arch/s390/kernel/ebcdic.c
+++ b/arch/s390/kernel/ebcdic.c
@@ -392,10 +392,48 @@ __u8 _ebc_toupper[256] =
 	0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF
 };
 
+/*
+ * ASCII subset of EBCDIC -> character classes
+ */
+const __u8 _ebctype_asc[256] = {
+	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x00-0x07 */
+	_C,     _C,    _C,    _C|_S, _C|_S, _C|_S, _C,    _C,	/* 0x08-0x0f */
+	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x10-0x17 */
+	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x18-0x1f */
+	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x20-0x27 */
+	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x28-0x2f */
+	0,      0,     _C,    _C,    _C,    _C,    _C,    _C,	/* 0x30-0x37 */
+	_C,     _C,    _C,    _C,    _C,    _C,    0,     _C,	/* 0x38-0x3f */
+	_S|_SP, 0,     0,     0,     0,     0,     0,     0,	/* 0x40-0x47 */
+	0,      0,     0,     _P,    _P,    _P,    _P,    _P,	/* 0x48-0x4f */
+	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0x50-0x57 */
+	0,      0,     _P,    _P,    _P,    _P,    _P,    0,	/* 0x58-0x5f */
+	_P,     _P,    0,     0,     0,     0,     0,     0,	/* 0x60-0x67 */
+	0,      0,     0,     _P,    _P,    _P,    _P,    _P,	/* 0x68-0x6f */
+	0,      0,     0,     0,     0,     0,     0,     0,	/* 0x70-0x77 */
+	0,      _P,    _P,    _P,    _P,    _P,    _P,    _P,	/* 0x78-0x7f */
+	0,      _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L,	/* 0x80-0x87 */
+	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0x88-0x8f */
+	0,      _L,    _L,    _L,    _L,    _L,    _L,    _L,	/* 0x90-0x97 */
+	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0x98-0x9f */
+	0,      _P,    _L,    _L,    _L,    _L,    _L,    _L,	/* 0xa0-0xa7 */
+	_L,     _L,    0,     0,     0,     0,     0,     0,	/* 0xa8-0xaf */
+	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0xb0-0xb7 */
+	0,      0,     _P,    _P,    0,     0,     0,     0,	/* 0xb8-0xbf */
+	_P,     _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U,	/* 0xc0-0xc7 */
+	_U,     _U,    0,     0,     0,     0,     0,     0,	/* 0xc8-0xcf */
+	_P,     _U,    _U,    _U,    _U,    _U,    _U,    _U,	/* 0xd0-0xd7 */
+	_U,     _U,    0,     0,     0,     0,     0,     0,	/* 0xd8-0xdf */
+	_P,     0,     _U,    _U,    _U,    _U,    _U,    _U,	/* 0xe0-0xe7 */
+	_U,     _U,    0,     0,     0,     0,     0,     0,	/* 0xe8-0xef */
+	_D,     _D,    _D,    _D,    _D,    _D,    _D,    _D,	/* 0xf0-0xf7 */
+	_D,     _D,    0,     0,     0,     0,     0,     _C,	/* 0xf8-0xff */
+};
+
 EXPORT_SYMBOL(_ascebc_500);
 EXPORT_SYMBOL(_ebcasc_500);
 EXPORT_SYMBOL(_ascebc);
 EXPORT_SYMBOL(_ebcasc);
 EXPORT_SYMBOL(_ebc_tolower);
 EXPORT_SYMBOL(_ebc_toupper);
-
+EXPORT_SYMBOL(_ebctype_asc);
-- 
2.55.0


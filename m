Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D146D0A9;
	Fri, 28 Aug 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925670; cv=none; b=dJhO2gpp5DzAW3K9QGyxHPt7/lI79DksgKRtlQeIrn/ELloZ0ioE/pbXAwKnWssoN6gvdT+/IElzNAPxGyng4FyA9GNnLYkkPbspLEMUnVdCvfuIOC/bYrsq2OY4f43WyR4zM3RL73joWntAzVFtXIkP4rY7oEb7KBj8kYYA0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925670; c=relaxed/simple;
	bh=oNzy1NQ7l4T5doKBWAGLW1aIuQAilARTzHfUbbtOwRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEJyHtQeiPC5KlYwqXl/84tLNkmEOFwQTQipeCtq0hUNze9ouiDKuqJEZOt3ltig0ysddTty3VJAXLmYUKFnnm0kDcj/q8Z4II1bnyhV7XdhSJQPkU/nglcz4M4u+ir1bUNSdXtoehVfSNRGMAhW3Ft1C0ES204NLhoSHpFuHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fy6n2r4P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fy6n2r4P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDW3Up2103797;
	Fri, 28 Aug 2026 14:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0534/p5k6ef+lPaMa
	2Z3Ppc5vEwulOnW+DPCnHdmbr8=; b=fy6n2r4PlpToP4a015abh5YFwC+WKha3u
	4YHbhSn5s7t6bJVVgTvTNHj4b3eMZ60vpZfgkjtWkjgTINunSAB/j44jOrYPLvWg
	pK6IDayaPoq4uShULF3HSjTgrcV95A+OYYUYrljDdx+6GQbTr9b2N5R+06Yd7Ypl
	gxRtMX+Jsu4GCIFFSFO4zaQcDBUlqdu4WrlZDbVaSJOgb0PqYNMzXU+Taz8F/Ur1
	t0OvA1mbgxWbHoVbYUF3YtMeS23WGWXD7xsqt73NKbEkqsC2EdRHA+JeybVevOrf
	mzyegKFMtRccOoT8qndgIiGxCrtuBdIQNmlaU5yOXjiw6B/wGK+nQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394mmu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 14:01:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SDfGYO017214;
	Fri, 28 Aug 2026 14:01:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kegfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 14:01:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SE10Y843843998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 14:01:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 655BA2004B;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298982004F;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.26.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 14:01:00 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/2] s390/ebcdic: Add character classes for the invariant subset of EBCDIC
Date: Fri, 28 Aug 2026 15:59:34 +0200
Message-ID: <20260828140057.1728173-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828140057.1728173-1-iii@linux.ibm.com>
References: <20260828140057.1728173-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: jLNktS3vq0JlUEgv4HaDqjbleEib2ZCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfX3h1SD8TLNcL8
 rDA8IfZWewICOvAj95eHMRZ+DVjhwRdrJErBpNaAZR14IKXGczPeZU4M18MeBGuX9dbXBO3oPph
 JlzGx1T9WSBuGPV8zaHJlFhjOsaPRUGmGfZQ/Fj5fMybn/lCCwsbT8LHixnqRSlr+khW+0HcCl9
 wPbZqAImr8OkKnB77jSytB/OeHrDLf5s02OhHM9MVQ59QHw1OPlmNayRqYjawl9aidoex5K+e4O
 ijhdWRuWFqcwt1lHUq5tURWRyD0A6J3mh3zxeHjtdU2Bk929INoP5NTtR3tAaOt3BH84Z7l1Qj/
 oCjYtcaNafNsU1h6AqqYAW0eqKgkLwGnLdIPps/CTSpmbNwCdw4c/htjwN6UtuRL6lDOrqTkahc
 vgB20/5r6yGI43o2+j7xnDPnrMHbsoyLBTLzxhAIFPQrH0+0WeDjdXm18XF826woh4xBzgd87mT
 ZUIhO0qYcFlYrJkePew==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9194a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=8pif782wAAAA:8 a=VnNF1IyMAAAA:8
 a=lou5dwPg_VZd3XMStWsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExNyBTYWx0ZWRfXz54IhTO+iNe+
 l3Sd4XUkMsdCafxqrJiatc7h97dzzOzkWle8N9d9fnfycceUX/SKW3Lb+TDsXPP48yVfbLNqVmk
 uLLay7i1gcvgASBNwUJFZA9ShWi0xaQ=
X-Proofpoint-ORIG-GUID: 3SkTzaksy9Py-EiEeyX44MvI2xhBFjhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280117

Add _ctypes-like array for the invariant subset of EBCDIC, which
consists of characters that should have the same assignments on all
EBCDIC code pages that use the Latin alphabet [1].

[1] https://en.wikipedia.org/wiki/EBCDIC#Code_page_layout

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ebcdic.h |  5 +++++
 arch/s390/kernel/ebcdic.c      | 40 +++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ebcdic.h b/arch/s390/include/asm/ebcdic.h
index 7164cb6584355..9b7e3a58ca738 100644
--- a/arch/s390/include/asm/ebcdic.h
+++ b/arch/s390/include/asm/ebcdic.h
@@ -10,6 +10,7 @@
 #ifndef _EBCDIC_H
 #define _EBCDIC_H
 
+#include <linux/ctype.h>
 #include <linux/types.h>
 
 extern __u8 _ascebc_500[256];   /* ASCII -> EBCDIC 500 conversion table */
@@ -18,6 +19,10 @@ extern __u8 _ascebc[256];   /* ASCII -> EBCDIC conversion table */
 extern __u8 _ebcasc[256];   /* EBCDIC -> ASCII conversion table */
 extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
 extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
+extern const __u8 _ebctype_inv[256]; /* EBCDIC -> character classes */
+
+#define __ismask_ebc_inv(x) (_ebctype_inv[(int)(unsigned char)(x)])
+#define isprint_ebc_inv(c) ((__ismask_ebc_inv(c)&(_P|_U|_L|_D|_SP)) != 0)
 
 static inline void
 codepage_convert(const __u8 *codepage, volatile char *addr, unsigned long nr)
diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
index 0e51fa537262b..15cbb0b42aa6e 100644
--- a/arch/s390/kernel/ebcdic.c
+++ b/arch/s390/kernel/ebcdic.c
@@ -392,10 +392,48 @@ __u8 _ebc_toupper[256] =
 	0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF
 };
 
+/*
+ * EBCDIC -> character classes
+ */
+const __u8 _ebctype_inv[256] = {
+	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x00-0x07 */
+	_C,     _C,    _C,    _C|_S, _C|_S, _C|_S, _C,    _C,	/* 0x08-0x0f */
+	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x10-0x17 */
+	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x18-0x1f */
+	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x20-0x27 */
+	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x28-0x2f */
+	0,      0,     _C,    _C,    _C,    _C,    _C,    _C,	/* 0x30-0x37 */
+	_C,     _C,    _C,    _C,    _C,    _C,    0,     _C,	/* 0x38-0x3f */
+	_S|_SP, 0,     0,     0,     0,     0,     0,     0,	/* 0x40-0x47 */
+	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x48-0x4f */
+	_P,     0,     0,     0,     0,     0,     0,     0,	/* 0x50-0x57 */
+	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x58-0x5f */
+	_P,     _P,    0,     0,     0,     0,     0,     0,	/* 0x60-0x67 */
+	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x68-0x6f */
+	0,      0,     0,     0,     0,     0,     0,     0,	/* 0x70-0x77 */
+	0,      _P,    _P,    _P,    _P,    _P,    _P,    _P,	/* 0x78-0x7f */
+	0,      _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L|_X, _L,	/* 0x80-0x87 */
+	_L,     _L,    0,     0,     0,     0,     0,     _P,	/* 0x88-0x8f */
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
+EXPORT_SYMBOL(_ebctype_inv);
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111438;
	b=Nshmpl/W1FTMm4K3OxrShT9+n9dgcB5jpfVP2IBPEw0CeQEVwsRILl/lvBjJ/XFUPfhI
	 K/H1qWzIjlnZ50NpVvzq9FLB0fve1F9IiAdGHLavNYkFIH6N8PY4SpLdD2hZjWYiRYr06
	 rXHigJvwcMUV+u/Ad63mJA3g+n95OyugZ7UK41bFxsG6sqWw2C0m2MZe9SaYttp/jRmOH
	 MIH425VMkkt0rQrFtLo1fH4HGjwfv2OOEQRxKY1Ra/ikLtu8xisHo+F++uS1iyxvP0xSX
	 19AsYsuDeN79XBPqs/sZOgmbokdQ+pjSJ9nzHxjiUB9liXbTMjvAEwCx7d67Wz9ua0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BHgMNRisVwfsuzc7MthRshUr+h8nXGtjBDy+iGIViC4=;
	b=RoNva1+eiA8cMROR633SkUDmsKaku34504kqqbJGX2pkWWWX+gP8mEpmW6OQQPGZ6ORY
	 4+go9u2wmnpT6ZD3H0x/Hzp0QnqYedlQ9N91AhA7WfLiicz/MsZZxKtAMKTrApCqPyZPI
	 1gG4saTNOlVPaFaIH4Fi9b7yqM50Qmbwfdm8dVKqAmzJba4xSq1wAYE/lviukQQmYBkxp
	 c+GfJG7UzdY4mznjuNKztW0nL3USxHmRQY69EkHpyWaq3x22NUkRevX4raT7tT3QuO6NX
	 DEck06duRx8PYiyLS+rMDfb/oB99qEiWV3v7x4UsaE0qUEk5+87hUigKQJo6Pbbecjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RekJbvtP;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669A606A325;
	Tue, 27 Oct 2026 14:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A669A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RekJbvtP
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REE9dR2676182;
	Tue, 27 Oct 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BHgMNRisVwfsuzc7M
	thRshUr+h8nXGtjBDy+iGIViC4=; b=RekJbvtP9RY/C+2yFAI3542KCqd6RyuAA
	OKBOSNHfZ4nWImFGBHlQd0LtVuI/anWrVWOLCMDp3h9dMo2so0QsZuh62bvmf2ih
	3SR5wIC6/PoZ5WV4M8+sXbJ1CorDId28cMbhw7CjZombrYoSgYDEZjljom4Fz8HE
	AyaD9KcEzv2UMtld+T08ez174MAkxPCHHQkeDyo2XrR14e/D1H8CA5j2xGFtPnvl
	x4kjPzBoo/5wOYzZw7S7T8aHb/iGhf7wE2aHjOI/bMqQMSYr5BH9mRRnyTlzFe1G
	PUiES1T6v4KBPDtTPj+v5w+czsmA9ZP+nZXdv2Vwfskq9FDi1O9aA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6yxdc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoQmZ3057804;
	Tue, 27 Oct 2026 14:30:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gtyjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUW1b43712840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 304FF2004E;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0544B2004F;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 06/10] s390/stackprotector: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:26 +0100
Message-ID: <20261027143030.3154657-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae0b58c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_zDaQq67t2A-s4DWc54A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXwB4Vr9UIqfu4
 5Q6ADNP8j5uJJKBAXxp6D1RXHfsU2pt7Oz4G4khldUOycr1/kOoJ4fhOvA9dRjtNAGteEKZfLwh
 b/hLP8bneVN4gPniv9oQYtDeXyygUWxEQpOVIUxWKU6kuai/TIGfi74+tmmL+NzwQg5JQC6AOpz
 lNmrP5GiwXceJIIOgHHZqvr83EmVx6/52HigBkt6UN93U9TFJSiiaCIjYUTU7UzIUpUoGQSufn4
 63N2J4MBxy0WajzlkKKR8rZomRSqBUh9KBvXFxYns/FTjrbku9VtieAeRMOMOhOZmFsava3q8aU
 Q9Hd3dPwYLjAPtM+I0fbB1OQUHVWVO7henobPwPk1F4XGR/3vqyAPxidQrUXqc/rA+Dwzt0nZB3
 cF0YFDjcsC1bsgsTnsiPcK/FZOY/7GZDT60gSBHNS6TMDJpzQOnfakYCUjEc9U3orrsJ55pxDaj
 JyHFCuBbygF5jDsc+4g==
X-Proofpoint-GUID: W7lGfh6cbRpW5T18FkXw7QhNYQHF2P6T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX7iwucQmRSXGC
 by1/5kPl+cEWnzDu7reLr5F+Tjs1AJnRzpc5Hvc7WVV0SWCMwmRspO+kZlQ2NpNT/KYmKVyM5ED
 TrR/wu59InNWTmHXPMFdB5VFp0RF2b4=
X-Proofpoint-ORIG-GUID: W7lGfh6cbRpW5T18FkXw7QhNYQHF2P6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

Acquire text_mutex inside __stack_protector_apply() to serialize text
patching.

Serialization is not required for __stack_protector_apply(), however this
is part of larger series where at the end s390_kernel_write() requires
that callers hold text_mutex.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/stackprotector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/stackprotector.c b/arch/s390/kernel/stackprotector.c
index 8bd3ecf9200a..d72aef57a40a 100644
--- a/arch/s390/kernel/stackprotector.c
+++ b/arch/s390/kernel/stackprotector.c
@@ -6,6 +6,7 @@
 
 #include <linux/export.h>
 #include <linux/hex.h>
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/printk.h>
 #include <asm/abs_lowcore.h>
@@ -120,6 +121,9 @@ int __stack_protector_apply(unsigned long *start, unsigned long *end, unsigned l
 	struct insn_ril *insn, new;
 	int rc;
 
+#ifndef __DECOMPRESSOR
+	guard(mutex)(&text_mutex);
+#endif
 	/*
 	 * Convert LARL/LGRL instructions to LLILF so register R1 contains the
 	 * address of the per-cpu / per-process stack canary:
-- 
2.53.0


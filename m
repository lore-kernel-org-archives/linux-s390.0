Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013237;
	b=uWjg0m4swA5aCgZ+jtAXm+1nIk9AWBSKaGsLlEB4CtruJ/PTKx0744x/NHbaS2hnmBzs
	 adJb4Cjh4xskpFigwb39j7fjXRY5qgb8lIIb1ykI0Qlx2pc2Hrb5KXi3T+gKUtnexaoEv
	 OTT/0tGRlBQ8lj7JUrxwbCgV60X0Ghyzd9+ru4r1lwTBsYqieYjxKlgQV31MVhtb2R8Xj
	 rc53FPtH1CGOKCNSVXc9E7NR822XOtiDBbjh9E5Z61r2pUbaQRmVjD5FVa78Oh9M35+Vm
	 fa85U630MDkSFlsXUQNnIrd0pemB0SWXRrJxnuwRuc5L1czLcHoAWZ6vf51QOny3z3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cJywHsUADtTM3++tg4eCg4QYYlZIFVUrlfHWQrJ/bTg=;
	b=YexfqmZxot+X9+WcjvtqMB1gUu2js8lLef5sFHbGQhuFR6bsN1DJxwWHrSujfbzAVa8e
	 CO7e/3un1P2YPJUed2ht95ICeGT11fxgfL4QaPWmvFnnjv/Cp7l7emaEC9/VM5PwJGsnM
	 2y7N54Q1N9FVafoKvmj73iX9S4dAKssxMvmhL/KjG63bqq7R+adO9/I4Nd9fPAmAvW/NP
	 16WMrkpcE/cGaH1I59GpBzoozB4/NGmP0/2DdYDCQoKe97OuQ8JQLlad0XnhF2OkVvSK8
	 6JvGvguobHyKhrnsOZ+MPsbR8vy2TY4EPzrsprhIUBPwYSlwqJT6+mhAn4XyspzzpHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DmIIrjd0;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50388606A31C;
	Wed, 18 Nov 2026 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50388606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DmIIrjd0
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQqsr1211986;
	Wed, 18 Nov 2026 14:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cJywHsUADtTM3++tg
	4eCg4QYYlZIFVUrlfHWQrJ/bTg=; b=DmIIrjd0e4I1FalS6Bn3r6QjIfuiBXhJt
	QXZ06jmLtJrO/U0wbrS7vPpTqttRt22IxZVadzSnRrgSlFsRE2NQo+qjB9ngKr9E
	+npqbNEwUf9xmVcyDg/RtyYx9SY/KpmNpAHLbIBXoXeibX5ZZJ9gJhN5o8h043BW
	tPCvV6713P8BzLsw2TonWNYgaCS9vTLuTcu67/3CyFUEGSeOqEvYbnAuyJFU+wBV
	sJiUs8BJhA4liw+A9/Ohf+UJq2zSrRedClkOLIE2B0EO9HY2QOqWg5aE/V60PFby
	6cl3TdM/HUOtorh+/+O6zyC8WOdBZNW64z9PHb5fowOyOQub9+sQw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t2xjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDZ3522073429;
	Wed, 18 Nov 2026 14:47:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4s8fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElAu650659738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8DF20040;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59D9320049;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:10 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/8] s390/kprobes: Add error handling to alloc_insn_page()
Date: Wed, 18 Nov 2026 15:47:03 +0100
Message-ID: <20261118144709.202520-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afdba73 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=3pObCyJrl42-hwcAx0IA:9
X-Proofpoint-ORIG-GUID: wW128siuHfKVOGS4evt3z0_lttNammDo
X-Proofpoint-GUID: wW128siuHfKVOGS4evt3z0_lttNammDo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX23CG8Mc7YWHC
 DklJdTCbnQOpIqNb/tjfHVqqJVUomwp5Q5sAjx7ZkHLVjlq6QS5oF0TP1FT5bPlzYuzLGsTV/z4
 elFcTx9QRaa1Y7UF+feSbTQeOrQUbeMqPSiq7Ge1T8kcKcsM702I5qwR1Bmbck4oUYYCKDu31GO
 qfSVEPgFYBywNK1tg8Kv+eUrjpTw+UhUL8pDCkSQuAhfAnA8i82YzL3LQ3NODIcOOzYGoazdOSj
 SsqSJfBSU7ZaYeT8lGixH3bqkVwNOly0g6siUzACFEg7wE8oAjLL4QlW90+JJJLjORFA30m6+cz
 JWXHnQ8pdB2Egn9BAjzlOId+KEweQFrMniPQz1/NHhzV/h0J2Hg+Sqqd+hHF3Rj3H6dB28k7pW1
 RsJ0YU3cxO/c/HOMsGZixDZdB1v62sZUTONxM992kMdJ+BRXz6Rt47apcdCP7/Z4ObcUXWSPkyv
 kuH0F2tcpomrXYoWDbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX7i33yG4RjPyG
 U4TI8GxNj1bHlctDEY4UbE3OIjyGGajBfS3D8uYUUg1+5sPUWi8he0JHAOdUY6p7dEBTYrOsXrc
 uNElE1OrfBnV9prs3sB5vDLjv7pLy/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180057

If set_memory_rox() fails, let alloc_insn_page return NULL, instead of
a pointer to a not executable page.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/kprobes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index e806b124e4ba..90efe90c609e 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -40,7 +40,10 @@ void *alloc_insn_page(void)
 	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
 	if (!page)
 		return NULL;
-	set_memory_rox((unsigned long)page, 1);
+	if (set_memory_rox((unsigned long)page, 1)) {
+		execmem_free(page);
+		return NULL;
+	}
 	return page;
 }
 
-- 
2.56.1


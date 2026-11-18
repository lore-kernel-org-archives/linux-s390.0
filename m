Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013237;
	b=Nr9OMh277XFp+JoF6qyLS7i+WA2t4xTtr9gFbFY0SprBo1N1I2vwlOGnrxkEpSgpZuuR
	 HugZF/Qzr28JgIUPk7NJii0nFzJeRWwlqJpvoSIDnf8rQJUWIpYHm4oFBDeS3dkqV09I0
	 fih+COnrQ6C8mkdvBNRPPJIh0GRG0OzBstt3Ym0kjoqq4rhkqecQ9waUdWNKwAmb54acv
	 pnaVQ+kh2/pnZefyb46C4zhjBWqKPbfY5HYGf8nYY3T9AhFrUMgIREadpZUypPgX99SOc
	 7TTphnTp6rZfQddO3pALXgSN4Zg3522B79oi0yOk4fctST88/E0MnY777qV5AJX+SAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8OAY2FtqZvMsztPBWj8oXKiBhlgE+h/vh6iOnIVpILE=;
	b=1pPQIyQGLEjJAhpUgsmZ3Zg1fzl4sYUvHc4myJqqSuBzSTMeJAy/ZWbUVCJE7J8itauT
	 K0mOaZCizP1IhAq7jQNHEganlffR7mdDW2Dy1UDH3B2Pzl8cJ+HzRQsIb2cS8nFt0153x
	 2HqZnsPpTzMozC1SzrnP3wI/mFRCo9TzCn6b4337JJ5FbuhnRLWQQ38f/K2d7soIOjqYK
	 4Kb8dIE2uQcMCmqlKrgrMjabDHM2/WGJ2U88TZkocoRVIVcMp1rHvs+eVbC2iSo6E2ybI
	 6bIGnpB2HEbOno7qTrGZ2/m2aZdkdX598dipZHYh/vYshtgxWzt3+rsLPvfNrts7THQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PDW4SQr2;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13D606A320;
	Wed, 18 Nov 2026 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B13D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PDW4SQr2
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQGX71211301;
	Wed, 18 Nov 2026 14:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8OAY2FtqZvMsztPBW
	j8oXKiBhlgE+h/vh6iOnIVpILE=; b=PDW4SQr2kxYJt94moN6lwxNATHlaqEP2t
	xKeoE4V70a0PEEseKMB8bovcO9VyyIDM/NwERy4ASBauzSrQo2tWUiCaRx7NXcjO
	UXY/r9cdHkG2JetTehXaJ5FIDy6ooi0SCYDbXsXknymdVSK0m765V+KTUveasQvO
	7g6auqZDPGewpe7MNG+yHiqLf9jdewbl6zCot4IX7/YnHqwpt4zclHCnToVnG4xK
	wiMcfLt4K1KvlNQPNUCZRHAanXftxLdyrfTHyRb2mUmnlXetSBCuLz9nTBW10sMY
	SCzTYRf+Nz38N4R3ycfecMKCYNl5pTVrikTc4G1jVIrU1X80urykQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t2xjk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYuH52135407;
	Wed, 18 Nov 2026 14:47:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb58hkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElBco34341248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 885B32004D;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A0C62004E;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/8] s390/mm: Add error handling to vmem_map_init()
Date: Wed, 18 Nov 2026 15:47:08 +0100
Message-ID: <20261118144709.202520-8-hca@linux.ibm.com>
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
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=PHOHLIUfZx9d3LZ3ASIA:9
X-Proofpoint-ORIG-GUID: QqLHL8bPWPehGzfqN833Uw1UpuEWIaFC
X-Proofpoint-GUID: QqLHL8bPWPehGzfqN833Uw1UpuEWIaFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX7UuWn/PISplJ
 htTX/Vc2KE6ld0vDDnX7RtGnRQY3F/LjHMNpGyiduryvrqlzWJ7Gqw5Y92UrNT4/CJ90rMJByFe
 VOBLkpOWBrnJtPafPokRFfCBZW4k884wFVtT3yZeo2P4/JV8bDhygJHIQIvpgoKgL3RI2GnKCEb
 lVJZwOycQeDXT7Pd9e9R5w1L2J6KeMAaohpZbll/aKHfhnQrrarFp0//ByFCMmsYwY9GrtIoKoH
 52U6jyH4L/k0l3TxE6xnpfhXFy1gULKUjkiMzHUIikoBqsGNTPoCaoDri0UvkTOI8+sDxmr4NJM
 1ADWwYi6HpiNf1Z3jB32ppFT7IeR5XsCB/s8HBrMcfqmpQXDb2Ps6wl3cemgVkUwTwKPnk09Wuz
 zl+APaq79J5TEEyH5A+bAynMaf3WkFQCv6swfD5OOg/WQLAy8Sgk84EUFxurYU+3iNWErdyqVc8
 VjU2vzxXBE/uv2mkdfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX3ldH/Rb0FLSJ
 4JI2a0lTb6P/vus+nP2y6WspcAIcV3b1UGXQAsy7zO93byRwRpZ0a4n51X239xHSNUdxVH9kMet
 uysy+yuKO3RilUP/ekXKCPA6NBCqYVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180057

If any of the set_memory() calls in vmem_map_init() fails just panic.
This should never happen, and would lead to a broken kernel mapping.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index d2879ce860a1..317bd01dca86 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -671,18 +671,22 @@ void vmem_unmap_4k_page(unsigned long addr)
 
 void __init vmem_map_init(void)
 {
-	__set_memory_rox(_stext, _etext);
-	__set_memory_ro(_etext, __end_rodata);
-	__set_memory_rox(__stext_amode31, __etext_amode31);
+	int rc;
+
+	rc  = __set_memory_rox(_stext, _etext);
+	rc |= __set_memory_ro(_etext, __end_rodata);
+	rc |= __set_memory_rox(__stext_amode31, __etext_amode31);
 	/*
 	 * If the BEAR-enhancement facility is not installed the first
 	 * prefix page is used to return to the previous context with
 	 * an LPSWE instruction and therefore must be executable.
 	 */
 	if (!cpu_has_bear())
-		set_memory_x(0, 1);
+		rc |= set_memory_x(0, 1);
 	if (debug_pagealloc_enabled())
-		__set_memory_4k(__va(0), absolute_pointer(__va(0)) + ident_map_size);
+		rc |= __set_memory_4k(__va(0), absolute_pointer(__va(0)) + ident_map_size);
+	if (rc)
+		panic("Failed to set kernel mapping permissions");
 	pr_info("Write protected kernel read-only data: %luk\n",
 		(unsigned long)(__end_rodata - _stext) >> 10);
 }
-- 
2.56.1


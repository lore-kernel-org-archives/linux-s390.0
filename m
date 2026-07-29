Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CC442B0C
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317785; cv=none; b=Cf/0clTyalNLO5dx+1+SIWKJak7Oj9HF3n1IvJifwRmOaeK8u7lD0GLBiC+SurXxDUEe+n3ChqyDMzqcgQDaOIr6LxdXWi9Uq+1ZmWO2ofb2j7bu1WqqqN7v8DpsFvMVe3E9abLQgZeG+YYSOxbHoZHoCKVUWkq53e/BiT5obmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317785; c=relaxed/simple;
	bh=txOdN9lMUYJzoRglIWgKVwGIotmbrN1us5S1N9EcP4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEWeBLYPaS2WvgYjIxyKZbtj5wIQmnbreCTjXGxRiee8C0fMfTj9JYhwj3yrbbGzTV9ufBYDe2BDEAVmbb4I3oOUBBPNRpIGUTQuxkXDdHTHq0GRxpfA8X0Ny8G9vxeMxXWSTi6UYFe/vM+zUEWcX5P2vWhR5IhkK3Ytk2FtKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tgi1Nm4A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tgi1Nm4A"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7lhbq3621329
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lHFlzBR9WH8I5hZQ+
	1yQAUiI6F7qtUF5PJfTscoWFpA=; b=Tgi1Nm4A9/UL9y6kgDhb1gIorcRphwk45
	dJJRezA/C4SWZlhlCMRK833IRSxSBloHzmBbjYksKvJxdQGXxPsEhnixiabFiuLs
	p52P15H+cUM1iMRkxBKmhjohrB0FyEmOe86zYXm2JqJTKsFG44tegIydiXYBfQIn
	ExHuXnAhuERwcbyOJ3EDMZWBrVu14Xpud91WQNc8Az8ozTKlljU2TIJKqbCkx5Np
	W8fhf6KQAW5Cz5cMd2RM+34vwQkyzw4xM61wbOXDQU9DzhnkHGB4FUX9n7a9w5Aa
	wwfgsm9PpTJDKEO8xlda8Z1w8StT2uJhHl7jEcz2Ld7VK8fS7Fy9Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xsyyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9QHnI023032
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw678j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9aHPj31129892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:36:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BEC20040;
	Wed, 29 Jul 2026 09:36:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 578892004B;
	Wed, 29 Jul 2026 09:36:17 +0000 (GMT)
Received: from ibm.com (unknown [9.111.67.171])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:36:17 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: freude@linux.ibm.com
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, ifranzki@linux.ibm.com
Subject: [PATCH v1 1/2] s390/zcrypt: Validate length for CCA AES cipher key requests
Date: Wed, 29 Jul 2026 11:36:15 +0200
Message-ID: <20260729093616.4184642-2-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729093616.4184642-1-dengler@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Md8-MfkBn4euQy2SKDPen8WFpoZwmJPS
X-Proofpoint-ORIG-GUID: Md8-MfkBn4euQy2SKDPen8WFpoZwmJPS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3NiBTYWx0ZWRfX9aD5m8vlVX3c
 txLMsKNafRHMkyZY7ACayx0Pa0MTE21aAgU6JmMltcNqdaJcEy/iNgsT6EQ5hcWJsmiH0gygtk2
 dlCUR8wdhXEGhTtvMVY6j8vybSblPLQ=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69c996 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=-MrgVM98Xa_NYdXM1gcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3NiBTYWx0ZWRfX0AkJky0GKq/g
 W5N2zYii+4c1FG22AlTuZI7WGkp5+fEXQ3emQUw4ZXaClRjTG3Q/lva/hL2Xl+YRP1gH3eoU09b
 4RR2MJBebuqs+LbbUu6IwHNxoOjJrhzv1zA+evz6UTSP63l1I3vi5zIVxp39kcaFsEj96LbsWZM
 7+XSLQCS2tReUlget5aIJl/K3F1b8M+YugyLyRlHEVAk1O54CPOIjgupHD6plf/Zs09VRV4Wd/w
 wMdmSLQtXgA5jiZ9uDhUN7zmJKoPR7j1Q95EHkd5yxnoWbk27sCDyOmf+BUO2nbWkmy0P96kcyM
 vB1OHv+0/BRajURG4HFrG/yWFL8nMoHYzr4vUorzTDRbTDSPaKYZf+MvQXSi97qY3TPfa/PUlxJ
 LgeH6KQhnzwVYEyZ91U2nUlf6vLfXN5eq+NXSmi9U2suUmhinvrLFEzxquYuPmeuiQlqeBsAHh3
 oJPJf1v7VKr+fvLL2CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290076

cca_cipher2protkey() derives the copy length for the CPRB parameter
block directly from the length field in the key token. Reject the
request early if the token length exceeds the available space in the
parameter block.

Fixes: 4bc123b18ce6 ("s390/zcrypt: Add low level functions for CCA AES cipher keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 5.4+
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 84936a795b95..db6a4211a97e 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1261,6 +1261,9 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	} __packed * prepparm;
 	int keytoklen = ((struct cipherkeytoken *)ckey)->len;
 
+	if (keytoklen > PARMBSIZE - sizeof(struct aureqparm))
+		return -EINVAL;
+
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
 				    &preqcblk, &prepcblk, xflags);
-- 
2.55.0


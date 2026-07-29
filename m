Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD1442FC8
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317785; cv=none; b=WMmhIB8nJwqsjVoA3vTFSx3qOnr9nexJtuT6QutlBrffW9Fb5LL0JcL+snctSpmeArGOafAKQaUr624QGlbHoQrlZiIDsfcXQcp8BT1CkiRNYzqYA07D63qsnrZE1YuIunE1bgkwkRc3vBkmxIMhuKdqRYUYezw1FdcaslVssj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317785; c=relaxed/simple;
	bh=JQeT6Dgt3anGvhc8DXHykbsDUXxDHNwqHf5hLwJVX8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1e7liU9TAoCsORgUmPrDhoVwDr2VGkKvfMBD/QAyq6MARUp3BGDfkUpkqL/W7fG/GMADK8SIPArGjLkFhVGvPlIBn3qnVokHdd3fhiwLQ6/9w4zLnkfCiLXA2CX+jry2Vjvk3DqsjaSym01GIunLW7+gr4cUxy/iQZ2T9nw9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pcyaX34T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pcyaX34T"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7lb9o1722077
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oRaUEkNuITCOqft1T
	AHeF1ebJTs05t+U6/wPyrYv9cQ=; b=pcyaX34TP+g7dbmh8sZb3Kq2sLG7Ks8o3
	MyRyy7pC2xyy44+5Ob4IRw2Btu73jNyD+F5EQDi8GaMf+VnKyZhzJhGPAQGapYHl
	oSRUugZV8hH68vvOql5Adn4cSZvzS3jPjpMmOi47AJNuwiekxxjk36EJsT/42wfy
	0kEKHh/xLPkz5+lLGByblHjpMykCN6vNLD9j/E8kzHkJxKKrDb2Tk0uNoSxuy9H7
	kGMtl4IYYQWS/DECmmWsw67aAhk9IqiccPaofGcdpknn7RpuwGmZAA3aVJ5+5VUK
	JbQOz8cPV5SM5sETPm/g2wdA+AflRWvlgXapZYvWL+Mh2Dd1LtDsQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuychw79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9QMiJ025804
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhe0du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:36:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9aI0g16253188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:36:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 130B12004B;
	Wed, 29 Jul 2026 09:36:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B619820043;
	Wed, 29 Jul 2026 09:36:17 +0000 (GMT)
Received: from ibm.com (unknown [9.111.67.171])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:36:17 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: freude@linux.ibm.com
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, ifranzki@linux.ibm.com
Subject: [PATCH v1 2/2] s390/zcrypt: Validate length for CCA ECC private key requests
Date: Wed, 29 Jul 2026 11:36:16 +0200
Message-ID: <20260729093616.4184642-3-dengler@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: agrnrbzRWqNLbDyQCXr4IANbBRVaecqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3NiBTYWx0ZWRfXwXAK09jbsrKs
 Iz9BxYFRHn7NusCgd8FK4TKIHe1TcTD32GUiEdbbD/822vL29mgfADNf+3Fz8DD+DysJrAnLC89
 YZpyVgzrulqTK+y1x6Yx5FYNUZh9HpHDPC5dzhfhlJo3WXXOJB0mW/RRFke1eBl6FFnBhIgClSF
 D7imH3pazo8iyTcMsl6IY8I/F7Q4ySU/kVCSBA2mTrPsVev/Lw+4fKfTtBUpRw7jsRdPttJFXwx
 1xqyBej25SAjnGl2ahIPuCA5nREwuWLl1x7bpYn1hGbqdT1YJ0rcqgiBN74KSQ0b/LlNCiFuyaf
 we1AWQZTqmvlZZlkXi027f3AVbfwF6kB8gMs8voIFoKXpsUD51sC8B3rwFkX1g0F88OzPTfWa8N
 w2caz8k3zeW04GODhuloI3P9QJcgOOWzaP4eNAQbQrWZVKz5yMh0u2gIeXhVxWdg8XX7y2DH3Ts
 SJg2q91pW9oxfwdzYgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3NiBTYWx0ZWRfX4WcEI/Nim3qO
 PrtYEaQLmSsSgGpUIj2i0RKltO4SXTc8fFPnhcx5EdVNb9SfHuEAd32bFT5ffeQ84YQCjVEFhlk
 dRaEvWeVU34MGt2/avukJI1ttGeWhVA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69c997 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=NmcI_XSKg2PqJeucygYA:9
X-Proofpoint-GUID: agrnrbzRWqNLbDyQCXr4IANbBRVaecqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290076

cca_ecc2protkey() derives the copy length for the CPRB parameter
block directly from the length field in the key token. Reject the
request early if the token length exceeds the available space in the
parameter block.

Fixes: fa6999e326fe ("s390/pkey: support CCA and EP11 secure ECC private keys")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 5.10+
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index db6a4211a97e..322677a8d320 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1428,6 +1428,9 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 	} __packed * prepparm;
 	int keylen = ((struct eccprivkeytoken *)key)->len;
 
+	if (keylen > PARMBSIZE - sizeof(struct aureqparm))
+		return -EINVAL;
+
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
 				    &preqcblk, &prepcblk, xflags);
-- 
2.55.0


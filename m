Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50236DA10
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906194; cv=none; b=o7bx0anCFQRysXq2KgwlMOv4piaaAK/HrQfG+KisoQLmklOq4+2O+8A+zsPTCd1sPtZulxGB+E3GfwHK1hzCC88++1P+64ME4u+EPxankGaSTQ6dfh3BNnJ8criocUHjJA95zAC4eZlCrsZtU+rMGYrzmXYZHrI/7JHeeGodyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906194; c=relaxed/simple;
	bh=Wp5ytuqDE8hZVA+Az+XKJpkVs+n91ea/vcpP8kilG8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXoWc7ECodPEdH5Bg2ZcR3V9ezdhl9NL5hp/y5tc/fQsdA1eN0vbXTPT/kxr26imujMlEDJGuXfxiyb0aQ7crlyk4TP6vWw6prPJJexoyCciTJv5aaLIMigjTTTS6yF04o2o+6epBeDmK47h8obBv/U+SlDeBvSbmgAdyARZQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z1nXJuUb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z1nXJuUb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfwcU1994351
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S9DMBcH+2L3vtGTb4
	33SExTBZ8CuhkpPyVGVmfw3n0s=; b=Z1nXJuUbIAFZHMQaWNAZvQEPWX7TMUjru
	qQcAm3ClOTYmy/0J8E3xFym3nqvs66gyQ5svkOaqJ0YCSEC6f4YCHb7peVG5N/aT
	CAOXYHF+74/U7Tq5YasGFdeQehOkqkVwPnTjwCHyaA2yb6YeF8b+cjlF+PV6gips
	aAmCSdZMH00lpSW949CJ6jDpcSgGuenyt8bwvTNdhO9k0TPMT/95Zp4sl8PJXIFf
	CTeJxBHVFFRCtawF7I121slpwKeN17dZaW6qdfSBPXLppX2NglNVWOUg6POQKr8O
	OMw+ZCDZBWt6Ph9XxzQpVHjXCBblRAPJQi8/XlkBUi/83QHWBfULA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmnyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OF4eA0015924
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgys65j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OFGRS946596386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 15:16:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3EBB200A8;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C01D4200AB;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 2/2] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Fri, 24 Jul 2026 17:16:16 +0200
Message-ID: <20260724151616.147765-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151616.147765-1-freude@linux.ibm.com>
References: <20260724151616.147765-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qvv7tti4UOSi6AsYgC-Fb5_XN_Fr1J8H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX3gnlyc2F8QeT
 SwqX/EFTuMYv/v6foIBI8YJDQmKMqPFu9h3YM2xC0kMd1riwl+UqTWfYa243l1zuffJBCng8tII
 PULapXRTg9HZvKKPT375xhg2rqU2Ht1SP269Uh54/gs5nPASwu7Se5s4HwlKOYKp8ia4g58n8iG
 yHqxatjvCAvNETQK5OFwaYadf1zG7tijmAtjO9UDSZieqpWTiGwPR+ZwIpYP+EOIjj9Vg1GoeM7
 F6OdJt1SXs9mBMZOSnpyTSM9knmj+oq/eTjDg+n2Oj7mIuIrmGDTz+1bUw8bzsiFnYUZzZvs/ac
 SyWp1CysF73GqBopBvRrrbAfB7wQaS3nA5egHAxdY5fJSjynixsHKYESwwzopChUntmkEVnj/Od
 KCmXnpbKX4Mnp5Xwug1NcPrwV/okDmeUrBoECzu2bmFN2wmZhi5VwQ359BDFNRGLXL/UP9HkhyH
 XAK5SNbe/bHZo4Eb3bA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX4ZeKwyNZltCq
 1tclqkjPXBwjgKMl//9QsanF2Ujo/aOMtIIdwqH2lIrdmTDqCitZMVHdWNhtM7iaCrk0v7xRu1j
 hzAKYLW2d21dNmHCMCzb1ZHwCi9IkyE=
X-Proofpoint-GUID: qvv7tti4UOSi6AsYgC-Fb5_XN_Fr1J8H
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6381d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=yrkiJltxsN2MUqc3cT0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Missing minimum size validation: The ep11_cprb structure and
   subsequent payload fields (pld_tag, pld_lenfmt) are copied from
   userspace without verifying sufficient buffer length.
2. Arithmetic overflow in length calculations: CEIL4 alignment could
   overflow, bypassing size checks and enabling buffer overflows.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, and validating minimum request size and
minimum reply size before copying from userspace.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 2e4aef330b68..f7a504f5d54e 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -477,16 +477,25 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 		unsigned int	dom_val;	/* domain id	   */
 	} __packed * payload_hdr = NULL;
 
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
+	size_t req_len, rep_len;
 
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
+	/* request length and overflow checks */
+	if (xcrb->req_len < sizeof(struct ep11_cprb) +
+	    2 * sizeof(unsigned char) + sizeof(struct pld_hdr))
+		return -EINVAL;
+	req_len = CEIL4(xcrb->req_len);
+	if (req_len < xcrb->req_len || req_len > U32_MAX)
+		return -EINVAL;
+	ap_msg->len = sizeof(struct type6_hdr) + req_len;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
 
-	if (CEIL4(xcrb->resp_len) < xcrb->resp_len)
-		return -EINVAL; /* overflow after alignment*/
+	/* reply length and overflow checks */
+	if (xcrb->resp_len < sizeof(struct ep11_cprb))
+		return -EINVAL;
+	rep_len = CEIL4(xcrb->resp_len);
+	if (rep_len < xcrb->resp_len || rep_len > U32_MAX)
+		return -EINVAL;
 
 	/* prepare type6 header */
 	msg->hdr = static_type6_ep11_hdr;
-- 
2.43.0


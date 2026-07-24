Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF830569B
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901711; cv=none; b=CxrZs3U/YpEziTpM0QQpWTqWe7EXBIurwun73PFhI0Q+O4qn8AIJRdIG+gPWaoTGcnEGwX2Grw13TCMYEvwn8WcdDeyHuPYtCu8aCcKDxoZ3NDXMU/xgz/Cb/38+og8hvmLA7YzHPiNitHkMMtLWMAR58HHxJes7ssxSpUvIUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901711; c=relaxed/simple;
	bh=G4lBM4I0bYXmqksieMWAhAqpUTv+jqWObxI2ja3eg/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmIqN46MXYq8PatwrGkNE5+dDw6ieaUnb3bkUyv7KUxLl5eI/qVjlfL3bj0nReuV7QHJG0nvs7Dpjqp4KwcS4qRMaWwvGl8HCAdgDmTqAijqLFttUxZ6zgSP+aJOYsgs94kjV7aJl/Ny7XYczNFtMjcyXn5xirOdej4jPUYLEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZbsX0rnU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZbsX0rnU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg0r81994548
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AcPtgEJe0D0gTIvRm
	YUwyQHfwAuAJ4QP43/Zx1vi4Xg=; b=ZbsX0rnUBcuaAtzZxMBsYYzKYAXcBcRzw
	LSd/xR10tUHUTo9aoVpzgPZM7fD+5cT30MvI6iIhtAe6vTvAEyHUrE/ggaFNrecV
	qiKTYpEM9rWv5tnML6QdwsvKXrmZZuDdwFNm9WaMbVHzNAQkIAlwJzPZkFz8QT4Z
	15xW4bHdC3+25xQCEQQy/HmHzF9fNWtVx4iLoo8B78Ol8pViJHhtp6CT0ecrIoom
	6j/7x2nTTTuSIyxYjYiF1hrLCtxaDhM4D2H7Zkb+NEtaiz+8M3d9JlP1CtkewIji
	eLWJzp077/3Oe1+sXHN3OFg4z1lR5yJ3bLImDUvvnHLG1TfAFREqQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmbh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODo1Q5028644
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqhbeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE1h4853477698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:01:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 497A720186;
	Fri, 24 Jul 2026 13:45:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E8C20185;
	Fri, 24 Jul 2026 13:45:54 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 13:45:54 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 2/2] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Fri, 24 Jul 2026 15:45:56 +0200
Message-ID: <20260724134556.144597-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724134556.144597-1-freude@linux.ibm.com>
References: <20260724134556.144597-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2RkxszcLXg2z3YFhacVef7RXDUNw2KoI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX59+bhNA8DCsq
 jrlcnNeHJCfuySZXnz7HEoU8oz5lhOlJ2M2R+kZhqbufC/3ah3LAGTFcoe62x2OYdtoDMLHGAS8
 o0EYG3SCRLGcWDZy2SVQopvgu/0ycDYU3YnDTc75vQ+u1G8ebuaLvebRB0HS2WmQB0riWGnar+d
 pKc9bDTnSdYDVfgrRBEPpLKdDlSwIi+7DyXC8fWQuJ5AO1JaFvUxVAsbv/z57xbImKWC9mB/uqy
 8Bfz6YBgAj9G3JGpBzw5//JMtVbwrctO2/evki7LEyyuROfTyT0lEURT8CFCPtUK3apjUroPAcs
 p9bAYSoO8dkPcFSh9W84AnwMSMnvChihHs1Vweem6dx4LTbDISBJkMZxGPz5tltsKTHycOPdcHA
 MSZDzXKX0q/C2sy+SjKKPyJvg/VhlpbECcBVlITs26KqjQfPCeHW8yXngjD4vuxZKsbSbEyzRXO
 CIxWtK5HOid9gT2rB7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX+fxcWyx23e7f
 WkxB2sh1lFhPPgE87rk1Io7Tu1prS4x5LqfburrtJgVdfDpMfp1EPdd99dV9KI52S0VbectDcl+
 dbkD3uDfZs6o785LjPCHOsN2K0Tkw2w=
X-Proofpoint-GUID: 2RkxszcLXg2z3YFhacVef7RXDUNw2KoI
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63704c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=yrkiJltxsN2MUqc3cT0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

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
 drivers/s390/crypto/zcrypt_msgtype6.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 2e4aef330b68..6f49165d7732 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -477,16 +477,24 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 		unsigned int	dom_val;	/* domain id	   */
 	} __packed * payload_hdr = NULL;
 
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
+	size_t req_len, rep_len;
 
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
+	/* request length and overflow checks */
+	if (xcrb->req_len < sizeof(struct ep11_cprb) + 2 * sizeof(unsigned char))
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


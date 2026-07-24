Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933263DFC88
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888036; cv=none; b=QKwO+rPL6IWOXyvLqp/6z604X24aqMsE0bI8W4G8wuHVWKaqUuOywACLXFor3NBBKLgwCubH7/jU/qNtEsh60nwKpPFc6A6SLFc0wJxF3yCxSVCVEoEcxWM+4rTwsr+sLajSBZkwMQgS0paUmKrbODtBT7STmr4qJJr70TiUJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888036; c=relaxed/simple;
	bh=bW8fOimnwDEsWMJz/4fZZ8Y0Tbo1Efba41GxiPFv1Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkbReTnp8oJyAZX61/MIlp1WneKOdOTcrLPufEZjqEseyVyp4OMuM4G5lR14YwmTNkl2F4i/leC0LwXbLP7yqSHrYMppP1xdIpgaj50AFvTkl8RQIPrxPk5HS9n7gjuwX071n83A0XQ+SVpnfMws+z454qQvomFOaGb5kb4VwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phRzd2WP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phRzd2WP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADS9i1532559
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vzv4jeM9HrDB9Glzt
	6lmUpP4gU19ocDpcIm+9Sb5E1M=; b=phRzd2WPy+AC27TpmJ7JBa/OZs99bQzDG
	o8gsWyR0Dq/KIAT+rI+nNKGsn/j0rihDYw49IHGsnu7RHnKF/m/smV/Q9GceQgT+
	7iCv13n9mKkg5bOWjIm5heacaIchSgOpwnZWIvRrUCfoT65Scsjnb3T8CWMZ8Pox
	lTv6N4QXVuWgdR7EByZOGWc3a+4vIMiyk6V5JrIFxiEAxWmGoA2F4JjoBRAoW12v
	rSeBasKD2q7I+juNpU5NUIoi6g9EB6F+Fn2T/DsPifua1byUsxi7k0eVkUL6otDJ
	KuZmhXJF0RtGqyXr2KKMO5DlzyXmY3naRbAhl7SPffk+ztPdnTa3A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abv6r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OA4eCg019384
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyr5ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:13:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OADnZX42664248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:13:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3825220259;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17A782025B;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:51:26 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 1/2] s390/zcrypt: Improve CCA CPRB length and overflow checks
Date: Fri, 24 Jul 2026 11:51:27 +0200
Message-ID: <20260724095128.140810-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724095128.140810-1-freude@linux.ibm.com>
References: <20260724095128.140810-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfXyrLyf40WzSnd
 GK4LQWTijKo9WvFyu0OfAj7gcWdN9QX4J9Jz8VDD1FS/lfsGOnZTgOxHRK04HU4Di9YKdZeeOsy
 ftBek1PbxfO0atNWkAK7oxb/aCq479+90KOJkreXhvZD9cDlRGNqGLjBeMKDMHoLaOtv5dOiC3Q
 AivDHkZIvw4IYMc+X9nw9elGWLODTQBSvHsfX92QoIVA67ljATy6wB4N9l9kErPWnyzuDgVaqvw
 fYQhQtu2uoZ1dDfB445qy2uyGkSCzHLxPxBI4Q1f8N806n/gVBPFm4nGRbcchyFMNrQoorYCdPm
 0wzpEJdd1K8rHxj5Ly0HE96HCv66piuYOtMoMcPOfLApVFw8cQgQ+R8zVs5x6nVBCiSNa40N3b1
 uTNrlF7IVyOOK8QAmSWrJv7s9xB1N3HInPP6jmZp6BxnRLjK0ZPW1mvqgC4A0lLHmzu/HUL57kv
 svuWdAiQbzv2ADra6zg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a633ae2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=hwlYjH4sdu7Xt8Y-kJcA:9
X-Proofpoint-ORIG-GUID: OU6_KAGWQPSvsjfqKZ9IFfe1WLNbPf4g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX9fTdq8nHfojO
 pF1wJ9BOV7vMVl7/C5LzQkyaEJpgE8oc3qF2ZlH4uqxiaee2mxzi5YzIULZx5XWC6V7fVxRzQoD
 rg/OdaVhLT5TM7y/27vMjuQBE57bDSY=
X-Proofpoint-GUID: OU6_KAGWQPSvsjfqKZ9IFfe1WLNbPf4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093

The xcrb_msg_to_type6cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Integer overflow after CEIL4 alignment: Signed int variables could
   overflow during 4-byte boundary alignment, causing undersized
   buffer allocations or incorrect bounds checking.
2. Missing minimum size validation: The CPRBX structure is copied from
   userspace without verifying sufficient buffer length. Undersized
   buffers cause uninitialized memory access when reading structure
   fields like cprbx.cprb_len and cprbx.domain.
3. Arithmetic overflow in sum calculations: Adding control block and
   data block sizes could overflow, bypassing size checks and enabling
   buffer overflows.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, validating minimum control block size before
copying from userspace, and detecting sum calculation overflows.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 74 ++++++++++++---------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..4ac767661cb5 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 		};
 	} __packed * msg = ap_msg->msg;
 
-	int rcblen = CEIL4(xcrb->request_control_blk_length);
-	int req_sumlen, resp_sumlen;
-	char *req_data = ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
-	char *function_code;
+	size_t req_cblen, rep_cblen, req_sumlen, rep_sumlen;
+	char *function_code, *req_data;
 
-	if (CEIL4(xcrb->request_control_blk_length) <
-			xcrb->request_control_blk_length)
-		return -EINVAL; /* overflow after alignment*/
-
-	/* length checks */
+	/* request length and overflow checks */
+	if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
+		return -EINVAL;
+	req_cblen = CEIL4((size_t)xcrb->request_control_blk_length);
+	if (req_cblen > U32_MAX)
+		return -EINVAL;
 	ap_msg->len = sizeof(struct type6_hdr) +
-		CEIL4(xcrb->request_control_blk_length) +
-		xcrb->request_data_length;
+		req_cblen + xcrb->request_data_length;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
-
-	/*
-	 * Overflow check
-	 * sum must be greater (or equal) than the largest operand
-	 */
-	req_sumlen = CEIL4(xcrb->request_control_blk_length) +
-			xcrb->request_data_length;
-	if ((CEIL4(xcrb->request_control_blk_length) <=
-	     xcrb->request_data_length) ?
+	req_sumlen = req_cblen + xcrb->request_data_length;
+	if (req_sumlen > U32_MAX)
+		return -EINVAL;
+	if (req_cblen <= xcrb->request_data_length ?
 	    req_sumlen < xcrb->request_data_length :
-	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
+	    req_sumlen < req_cblen) {
 		return -EINVAL;
 	}
 
-	if (CEIL4(xcrb->reply_control_blk_length) <
-			xcrb->reply_control_blk_length)
-		return -EINVAL; /* overflow after alignment*/
-
-	/*
-	 * Overflow check
-	 * sum must be greater (or equal) than the largest operand
-	 */
-	resp_sumlen = CEIL4(xcrb->reply_control_blk_length) +
-			xcrb->reply_data_length;
-	if ((CEIL4(xcrb->reply_control_blk_length) <=
-	     xcrb->reply_data_length) ?
-	    resp_sumlen < xcrb->reply_data_length :
-	    resp_sumlen < CEIL4(xcrb->reply_control_blk_length)) {
+	/* reply length and overflow checks */
+	if (xcrb->reply_control_blk_length < sizeof(struct CPRBX))
+		return -EINVAL;
+	rep_cblen = CEIL4((size_t)xcrb->reply_control_blk_length);
+	if (rep_cblen > U32_MAX)
+		return -EINVAL;
+	rep_sumlen = rep_cblen + xcrb->reply_data_length;
+	if (rep_sumlen > U32_MAX)
+		return -EINVAL;
+	if (rep_cblen <= xcrb->reply_data_length ?
+	    rep_sumlen < xcrb->reply_data_length :
+	    rep_sumlen < rep_cblen) {
 		return -EINVAL;
 	}
 
@@ -393,7 +384,7 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	memcpy(msg->hdr.agent_id, &xcrb->agent_ID, sizeof(xcrb->agent_ID));
 	msg->hdr.tocardlen1 = xcrb->request_control_blk_length;
 	if (xcrb->request_data_length) {
-		msg->hdr.offset2 = msg->hdr.offset1 + rcblen;
+		msg->hdr.offset2 = msg->hdr.offset1 + req_cblen;
 		msg->hdr.tocardlen2 = xcrb->request_data_length;
 	}
 	msg->hdr.fromcardlen1 = xcrb->reply_control_blk_length;
@@ -437,10 +428,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	}
 
 	/* copy data block */
-	if (xcrb->request_data_length &&
-	    z_copy_from_user(userspace, req_data, xcrb->request_data_address,
-			     xcrb->request_data_length))
-		return -EFAULT;
+	if (xcrb->request_data_length) {
+		req_data = ap_msg->msg + sizeof(struct type6_hdr) + req_cblen;
+		if (z_copy_from_user(userspace, req_data,
+				     xcrb->request_data_address,
+				     xcrb->request_data_length))
+			return -EFAULT;
+	}
 
 	return 0;
 }
-- 
2.43.0


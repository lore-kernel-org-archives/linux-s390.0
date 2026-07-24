Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FE149C6F
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906182; cv=none; b=KyWKHcfr4cvx9ZEkt9zm5twmVPEaukyyCSqxe4sXBpYGAZwhgkSqkF3yLL7RKHOnqwFQLTYXLGDJrJELWXMaxDbqCDsEGPXKvxEjfoXN0HeVq6fehks3mWT1dqgK19UORcYmvkqhK70Hu5+/eKpk8ZzlNZMLH96JgugeWme1paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906182; c=relaxed/simple;
	bh=AwyzOTSkAO4kv/+ygf19ur80DrUve52xvQLCxqaSYqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPwNFpie04bSw//fqRbN1NgPafUjz+yZaE7WsM7S1qrPXwZ80UcDDgidwIwgvA7iJR8yk9DJn+iuIFGgeKDCQWVkmKIbicOxN6LITldm0/VuCdlDuQq1QQEes4pI7EDeOGpk4Qiw6o0zrAsTWwot75w3xGKD68lURA2Lo78gxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FvoLiq+i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FvoLiq+i"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfvPb1869849
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d2ccHbSGYsTizGNYs
	+ijaN7PDZUorQ0x7TsgTPd/tYc=; b=FvoLiq+iwG428O5e6unTQGh7+v08ZRhQg
	fACO/cPaCY7nsELFP/qmadv/Y6Vf0WW0r8/LULuOC1eJszKt6d10iHf5qhcIqK+h
	qk12asiQZcqCC+kqWV6O7n4RZ4axVDdxj1PZYFdFXfDRRTR8AMMg/dmxva35fwv/
	UAJQB1+CfCJWBxy8Ds6xlTn3njB7LeEeMZ6At4zCzkMZcNbAGPhY0KHw7aDTvbp8
	5JiBTL7/HZjLhBAaNUYu+xwEgVMvHQYYERsHlGC+EzhCgAwkbXZSL+oj2z3bbsc1
	T0qVUdfhAa5RJDugN8hFHwJk4xsnL75nKR+fW8WaPfSZawF1QJARA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gmn0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OF4e9H017995
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahhd7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 15:16:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OFGEis51249430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 15:16:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CB32004E;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C15F200AA;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 15:16:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 1/2] s390/zcrypt: Improve CCA CPRB length and overflow checks
Date: Fri, 24 Jul 2026 17:16:15 +0200
Message-ID: <20260724151616.147765-2-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX3qr/EaBWAvrs
 1C6it0PNY0togs+zn/oTG+lWVXXLGTq+VNBfcPeZWljXFNm0f0kgggyzjfCbMplIwUqVgWYokyY
 mJ4SgiSUL5mSWNjofjgH48G91V6JwbQGqFIKI2E58h5shEBDTLGGYIc3z0Ld4CsekrOhatJB2qp
 5ahvhWHO+FdwQ/tGaUoMqa3/5BTV6eAW/x7Qdk9/hJcr5yMAI4GVqGu2CeTQ+WfiytZBnzwWIU8
 UIyKureRTpuEjY3qaqHtZGLse9sKKdJ2lsYpWs57zIsC+R7iVK4wLyvYsRCX5QPJ1SVElkjlJS3
 Bd6Qp9tT0BMVnyVTRtzHJqGaCMfDmwcKXxE9X/wu3mNKFoSkBxVFkCo3YwurCNjZjqc8HLe+s3B
 xoivAiJKH9aJXYDT2EFsx10B5l4b6TyT++mTSR40FT2/xNBuUsby56Gfa46A7fay5ZKQA2Y/68W
 mVNe4EZsU/0vVikfFkg==
X-Proofpoint-GUID: 9SdoNze5yfVeagG6XB--EqJUNPogcEGr
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a6381c3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=A9_4VoiraDeQe4jIP7EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX2Fvgq58FInEk
 eiZ1HV9LwKytmQ6GOzQSIE24D7FP/41wbRUca9t+/EnapeQcNt+3yzmJD3Pe9lcEaSEieFMXU3w
 bImhYmu3bPtQvnYgWcGA4LQ/AtNQ5QI=
X-Proofpoint-ORIG-GUID: 9SdoNze5yfVeagG6XB--EqJUNPogcEGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

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
4. Potential kernel memory leak if copy_from_user() only copies
   xcrb->request_control_blk_length bytes but the processing of the
   message works with the rounded up to 4 byte boundary buffer size.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, validating minimum control block size before
copying from userspace, and detecting sum calculation overflows. Fix
the possible kernel memory leak by zeroing the trailing bytes.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 77 +++++++++++++--------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..2e4aef330b68 100644
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
@@ -404,6 +395,9 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 			     xcrb->request_control_blk_addr,
 			     xcrb->request_control_blk_length))
 		return -EFAULT;
+	if (xcrb->request_control_blk_length < req_cblen)
+		memset(msg->userdata + xcrb->request_control_blk_length,
+		       0, req_cblen - xcrb->request_control_blk_length);
 	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
 	    xcrb->request_control_blk_length)
 		return -EINVAL;
@@ -437,10 +431,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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


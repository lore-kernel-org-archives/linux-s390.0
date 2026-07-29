Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629903AAF4F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339907; cv=none; b=RW24b4MIzegFVJvoQeF4hW/4Vuu29ShJGMUThTLyrvnaEFPX8EOR9jpwr9PkwVXqXII/MYpflCGsHPezMdgNxbJMcI5wG4i+O92yB5/XZqsQcR4NNGA2BrlpfB3okoa5L5BTf1FXILq59yfLCo5DvYcLZbVgs5c89QmYzxN+WYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339907; c=relaxed/simple;
	bh=oNch6HufH+vLjA0CMuBJ2bS6fgpRCvCwvGp+7hNe7NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7Flc4oYIGVsxiDE+FRX90RgUedg3M0SRVSCjCLK3OiwNHnopWzhpKtMfL6RFU6vqafQJjDKGolXlUhXofb2K4OJXPejrk1X95oDbD2k9jxuZRnYg9zaast4m4ZPfLiz396rPjMGPYVzkg5IxrD8Yy81XqD1NP2wa47eO9q6Z0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snyMC1kE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="snyMC1kE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHeSk282809
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=urwDIhLV8fmX83420
	NOiRMV+QzIl0NLHeRuvpL82Cjs=; b=snyMC1kEbkWGY6AeWspOFYKfKSp6Fq46n
	31UMbQw6syoOVDZvoqXS2Vf/zOMSDlm7vFfSBxwqr5Ekrsg01Np4bW9w7NJ0Sev7
	zF5hYVtURgvylnjX42OcTS1W3h7MP1JqLC6wzv5ljU0Xk0+QiZyOYQqm1XaTK0vf
	5CdGTktgFaadAfbDmQ9hD1Fb//x8be1ziAg69FkZObIBhpwpECFvsUVOGAg6Is+k
	VjIzEhbhqOBELcpyKkH+qgQ5V8saa4oYITR3G/wEM2R1bKOs6KvPcfxKuh0gYYq0
	3YnWQNQiV8o7vY8nw8NZZIK5UIHnDt00kWnB5Ewd4cGfPcTST4iRQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntnn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfKjM013766
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf7ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFj01D27984250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:45:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307DE20040;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D342004B;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:44:59 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v9 2/5] s390/zcrypt: Improve CCA CPRB length and overflow checks
Date: Wed, 29 Jul 2026 17:44:55 +0200
Message-ID: <20260729154458.195135-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729154458.195135-1-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXysWIlowkl/Sb
 YhRUhhv6ixTlSaR97kU6oHZ05Zmpc/AvwpiaKO6/s9Fmze5VbqOiLH8UE+YJ1efKmCXTF1JIUiL
 Eofg8zKDWUOkXTnA19weHmRovvxIU2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX/jBb+jmEwYLC
 kkjGrI30iSF4daU134n7GkhoHH6uM3xSW5MVk47d1seTH2x+dsaaaGM9uzjF2blx871619Wd1ho
 lDkB2rlO99RbbXyrKZH3lqk4GYG5Fe253nC/d9j95VubglPzXJYeERq3lw0MdNEcYNRkR9eexAq
 pY3FaVfSWfGARr0Pn0pRQjW1bPEXSWskQeN3fixd8ueawow6qDeM6MVQMp173xaf1JvsiduBIoY
 hsxebYBgUi2kwC3T9F6xEw2/gMpMu7ubgNFENwI46yL8XpQJokywZsr3xXDj6iA/HSTmy+UPT+d
 /QYd077ip0KeQA9tdIL/9Hp+mgiaTCLaxbI+uITYSuI8jgoVVBsrvKpDKLbxgnyj41H26xkwAVT
 2sU4ErTwX/PEqiaBBWf+9jdLWqLVXhwlMFIIK04lDThPtLBR3/06KAAB7AwBVLpdvXW+zhDCNFl
 x9/lfYRu1LmWDKsT+oA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a2000 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=A9_4VoiraDeQe4jIP7EA:9
X-Proofpoint-GUID: Lht5ini4rl782ZR61o32cG258Wf4776F
X-Proofpoint-ORIG-GUID: Lht5ini4rl782ZR61o32cG258Wf4776F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

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
 drivers/s390/crypto/zcrypt_msgtype6.c | 78 +++++++++++++--------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..fb37e28c8242 100644
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
@@ -404,8 +395,8 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 			     xcrb->request_control_blk_addr,
 			     xcrb->request_control_blk_length))
 		return -EFAULT;
-	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
-	    xcrb->request_control_blk_length)
+	/* copy subfunction code into AP msg type 6 function code field */
+	if (msg->cprbx.cprb_len > req_cblen - sizeof(msg->hdr.function_code))
 		return -EINVAL;
 	function_code = ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
 	memcpy(msg->hdr.function_code, function_code,
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


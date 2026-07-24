Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7A284B2F
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901711; cv=none; b=tK6H+lTrVz0hLonEVNeTAkBc4/V6ey6xUkuE9HW9MWoBC7AG1qCnnS41iZXSmsFebZS51kooWqE2Qzi1/5FE/tgXJg8DPzJnkO2+OipxUQJ1aydEZ4zkjHJxJdxmJnhgermC5C637sUDb09aLKXtj67aTIif6HxaNqZDYqpWaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901711; c=relaxed/simple;
	bh=AwyzOTSkAO4kv/+ygf19ur80DrUve52xvQLCxqaSYqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i10TRiVXjvMMQF6mbVcA7/+cRfyvhLgIw1bXpHI6QyNaF3Fco7Dtu+282LleYyKZASUNwcs6ZYNrFQgzTqrPR0stU+Q5WLoeQV9HVTGEUpuzRc9KFgK7kEnJviSvwnpFnsA0jIVdQmrgfMzLRjniYoKS266lp76I93UzX/IA/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7iQGp8b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7iQGp8b"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODflqE1869235
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d2ccHbSGYsTizGNYs
	+ijaN7PDZUorQ0x7TsgTPd/tYc=; b=Q7iQGp8boxOUEBrupT9+0tb8gqfLsLm9+
	z/3ZTaRGVKhD5r4J5qh2pyyKp8cNvVypabt+z+hdMaEbFocUpD5/LnSJ4hgYg/PB
	ZvOqm2jvubPEpytkTpD316fEV62MCYxlfz1ef8MF4XAB6JglhmPdKIR3gIracoJe
	H10gPnGY6mrGx/bKEBrcphJqiSKgpN+TA3o9lDYIj7raZuViv1hj0zXa8Fu1kQVv
	x0g/MUaoM1UndFmt/bRXz0iIZTG8cEHgInInidcnUu46PHAkUy9LIgqaLR1Wucy2
	c9agBBrExpHGPzKtM7VLO7ag+bv+fSmlXcUHza4DeBbdKyHlO9P+Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gmakb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODo2nV024900
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahh4py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 14:01:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE1iRG53215646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:01:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24E1120184;
	Fri, 24 Jul 2026 13:45:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E56920183;
	Fri, 24 Jul 2026 13:45:54 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.143.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 13:45:54 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v4 1/2] s390/zcrypt: Improve CCA CPRB length and overflow checks
Date: Fri, 24 Jul 2026 15:45:55 +0200
Message-ID: <20260724134556.144597-2-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX8sVjmBh5BrT6
 p7vWXmY37W/gTgNwxY/AbD2RvnkKtx6j43uhzOEbVrNmGbKml+7L/9wDMD4lnSF43ZrEjdB7Rqe
 fOJBHuQ3uEy9CDhQzTJ4jwa3Z5Tallwf35jlFjJT/k82JWf8YkA+SyAXrv8E27KgSsG/gwHGQFs
 lWtdSk03elQNi03unE6mWRNKL+I6zPrYyfEGat/kSclnnu4ZYNuKZXvO2K2MvEZMA3+YiguVzTN
 U0RKL61deV6ZEjg20iuLlk4WuR0K7q/rhqFESTRr5HX0CW82uMKJa3aXyRermNfT8cNjNTV+6Y9
 gDfg0fVp/DMv/estHrHJZnQwiUZoSQKg2TimWavlIHcjWmndLAtfVv/EUGUiybj4gllzVp/Qmpc
 UAvEyHVQEkRvhkkyiohuJPDiISzCrhKtbQeDBO9pJNXGKfXgEn1JFZmBNLIvbrRpDVPcjNxX+4e
 J8Xvf4DMd2z7UIacwcQ==
X-Proofpoint-GUID: yevkumZb8uy7KczebfV6F7eBglZ7QfxE
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a63704c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=A9_4VoiraDeQe4jIP7EA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX6sb6lNR9zgsc
 j5Gr+ZXvum3Z+ep3co0/1mH7y0j0RUHETWEfTeRwUqweH3eUibRxu34TaqDGeA2OmBGeT35QZ4/
 CBEkDcaZi+2R8wKhgne0j273LKKumh0=
X-Proofpoint-ORIG-GUID: yevkumZb8uy7KczebfV6F7eBglZ7QfxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

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


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BA3E44EC
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825067; cv=none; b=RHKQR8fq3TOFyEtWwn5YENbquveyOqEdyLAHH6D37ZT+IASxKCPz4C4ZT9aFfSqzb/ZqfdOyXn5d2S4Qos3zTAeKwu+mljohFxuyQ5UwQ88pGqE/ES8kLMQoPczIqcJ31isFTHRzJWHNaKzulWGNi9GI3nKtqwnP9A0c6i+/oX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825067; c=relaxed/simple;
	bh=TVg24mQWGyWhofQYCpQMnAKSDEBKGATIHsp87wFHZn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbC6doeziQphHKNTF1gMj31OwTHBkHk4YpsCFqaVYXte5wobfNCxvGz1KawVJUs4/e73xg0l0MZLmZQ75VS+0hT/svFK/xhJuRqmkzVMOTGtNMRQyfzCQf6QJSoBzZhT7B0Je/Se3Ry+siBGaouVZ9V0898rmPxBACxg7EiXVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sbets+b0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sbets+b0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBoGV1210859
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZdTikn6hh8nf3y2/v
	o7Hfus3D1ETJ5ed23MXwtcPE3k=; b=Sbets+b0Qqb8aRaIz0Ru79e+LH74bcz0q
	sN5g7+CiR/Qon88QIhl9B3jc7CVssNcbMidTFO4tr3APHZ9Yh3cTT128GQaDV9En
	fCP4ySPn5yMF2SvNO9XSb1YKj2CWQw8cTVPkryRP2JH/cqzfro2qcF87L8x8ml8U
	73nqUG/Vv6CF4ZP3T5aB6W2+SrhVU9poBdOmzJVjGg9z1vozhR3Gz0NdNNjoWIkj
	J5r3LMROORQ1NGt5phX5j21DjYaBHflitW7d4dV5WG3seemHXxZIY9sZJI+pnOex
	vTgBYMCp5PI8xLdJosgnOCtfrYV+r45qmILSi3J62EwKGn8JQVoLw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77arm6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NGJZTr013282
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gmvu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:44:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGiJNH49218012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:44:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40EA20043;
	Thu, 23 Jul 2026 16:44:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD462004F;
	Thu, 23 Jul 2026 16:44:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:44:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/zcrypt: Improve length check and overflow detection at zcrypt msg type 6
Date: Thu, 23 Jul 2026 18:44:12 +0200
Message-ID: <20260723164412.134500-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723164412.134500-1-freude@linux.ibm.com>
References: <20260723164412.134500-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ww48MOPHSoUq34Fk74x_xIoeajtyZ7Iw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX+3D0qeEQZTh9
 QFYlRKrTBR7D9qTou/NQZIKR2OwdWnjqVrUQsSAtcB/pQTT+Pkn3zSY546dgscmHzY65ak3BlDw
 cqksQGRwE8mRUVG8sr5zNxRrqnFAeYo=
X-Proofpoint-GUID: ww48MOPHSoUq34Fk74x_xIoeajtyZ7Iw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE2NCBTYWx0ZWRfX+uRvJ+oc6XSf
 ocVegEvq1ptu9IB9+caOC4/YAc5+ZvKH3rzio/ZpuaZ4MIG7Jk4vzdbSpB/wkyUFyZ7R8hMl7wZ
 018UeJF5gBw7zKWmN30hymdDlKCDVTF8xIFreSrQ4BSDQeVDRORkBOkInDhavxDM4+Ui7qfCMgz
 i4TueNNqq+Ful4vjhiMQ771PoNT+W7w5hHpsQ9oh3ciq/dcrw7IvJXdSPps67LRubxJ/qFD4HFW
 n+ISX5kX5FLCW7d05H+DWRZBeHV7uuhTI3tYjAg357eZdEMJsIAut8LKdqR9vQl2y6b6YkvISBC
 EIeTB3qspc0XUraNtQnbTy3NSmjZF5rJGIF7ghgaX+eFtgzJ4Der4jR40TTrMts/qTaKcAlwd5l
 lQHNQBQUqd4dl0BIL31fsRslXgu5rzTjymtrm5G7qcyArLg7pWh/3Pq3g/flJtFI2t3NnyBsLo9
 eBv5V9wBJjJoBVLANwg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a6244e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=of3ay6-9yh-YZq-hFs4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230164

The existing overflow checks in zcrypt_msgtype6.c in function
xcrb_msg_to_type6cprb_msgx() and xcrb_msg_to_type6_ep11cprb_msgx() had
several security weaknesses:

1. The CEIL4() macro used for overflow detection has itself an
   overflow problem.
2. Post-calculation overflow detection could allow undefined behavior
   to occur before the check was performed.
2. Missing overflow checks on message length calculations created
   potential buffer overflow vulnerabilities.
3. Use of signed integer types for size calculations risked signed
   integer overflow undefined behavior.

The patch improves this by:

- Implementing overflow detection before the CEIL4() macro is used via
  kernel function check_add_overflow().
- Adding explicit overflow checks for all message length calculations
  to eliminate buffer overflow risks.
- Converting size variables from signed to unsigned types and thus
  prevents from signed overflow.
- Improving code readability by replacing complex ternary operators
  with clear if-else structures.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 83 +++++++++++++++------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..d2ae58789aa3 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -342,19 +342,18 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 		};
 	} __packed * msg = ap_msg->msg;
 
-	int rcblen = CEIL4(xcrb->request_control_blk_length);
-	int req_sumlen, resp_sumlen;
-	char *req_data = ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
-	char *function_code;
+	u32 u, req_cblen, rep_cblen, req_sumlen, rep_sumlen;
+	char *req_data, *function_code;
 
-	if (CEIL4(xcrb->request_control_blk_length) <
-			xcrb->request_control_blk_length)
-		return -EINVAL; /* overflow after alignment*/
+	if (check_add_overflow(xcrb->request_control_blk_length, 3, &u))
+		return -EINVAL; /* would overflow at CEIL4 */
+	req_cblen = CEIL4(xcrb->request_control_blk_length);
 
 	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) +
-		CEIL4(xcrb->request_control_blk_length) +
-		xcrb->request_data_length;
+	if (check_add_overflow(sizeof(struct type6_hdr), req_cblen, &u))
+		return -EINVAL;
+	if (check_add_overflow(u, xcrb->request_data_length, &ap_msg->len))
+		return -EINVAL;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
 
@@ -362,30 +361,31 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	 * Overflow check
 	 * sum must be greater (or equal) than the largest operand
 	 */
-	req_sumlen = CEIL4(xcrb->request_control_blk_length) +
-			xcrb->request_data_length;
-	if ((CEIL4(xcrb->request_control_blk_length) <=
-	     xcrb->request_data_length) ?
-	    req_sumlen < xcrb->request_data_length :
-	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
-		return -EINVAL;
+	req_sumlen = req_cblen + xcrb->request_data_length;
+	if (req_cblen <= xcrb->request_data_length) {
+		if (req_sumlen < xcrb->request_data_length)
+			return -EINVAL;
+	} else {
+		if (req_sumlen < req_cblen)
+			return -EINVAL;
+
 	}
 
-	if (CEIL4(xcrb->reply_control_blk_length) <
-			xcrb->reply_control_blk_length)
-		return -EINVAL; /* overflow after alignment*/
+	if (check_add_overflow(xcrb->reply_control_blk_length, 3, &u))
+		return -EINVAL; /* would overflow at CEIL4 */
+	rep_cblen = CEIL4(xcrb->reply_control_blk_length);
 
 	/*
 	 * Overflow check
 	 * sum must be greater (or equal) than the largest operand
 	 */
-	resp_sumlen = CEIL4(xcrb->reply_control_blk_length) +
-			xcrb->reply_data_length;
-	if ((CEIL4(xcrb->reply_control_blk_length) <=
-	     xcrb->reply_data_length) ?
-	    resp_sumlen < xcrb->reply_data_length :
-	    resp_sumlen < CEIL4(xcrb->reply_control_blk_length)) {
-		return -EINVAL;
+	rep_sumlen = rep_cblen + xcrb->reply_data_length;
+	if (rep_cblen <= xcrb->reply_data_length) {
+		if (rep_sumlen < xcrb->reply_data_length)
+			return -EINVAL;
+	} else {
+		if (rep_sumlen < rep_cblen)
+			return -EINVAL;
 	}
 
 	/* prepare type6 header */
@@ -393,7 +393,7 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	memcpy(msg->hdr.agent_id, &xcrb->agent_ID, sizeof(xcrb->agent_ID));
 	msg->hdr.tocardlen1 = xcrb->request_control_blk_length;
 	if (xcrb->request_data_length) {
-		msg->hdr.offset2 = msg->hdr.offset1 + rcblen;
+		msg->hdr.offset2 = msg->hdr.offset1 + req_cblen;
 		msg->hdr.tocardlen2 = xcrb->request_data_length;
 	}
 	msg->hdr.fromcardlen1 = xcrb->reply_control_blk_length;
@@ -437,10 +437,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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
@@ -480,16 +483,20 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 		unsigned int	dom_val;	/* domain id	   */
 	} __packed * payload_hdr = NULL;
 
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
+	u64 u;
+
+	if (check_add_overflow(xcrb->req_len, 3, &u))
+		return -EINVAL; /* would overflow when used with CEIL4 */
 
 	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
-	if (ap_msg->len > ap_msg->bufsize)
+	if (check_add_overflow(sizeof(struct type6_hdr),
+			       CEIL4(xcrb->req_len), &u) ||
+	    u > ap_msg->bufsize)
 		return -EINVAL;
+	ap_msg->len = u;
 
-	if (CEIL4(xcrb->resp_len) < xcrb->resp_len)
-		return -EINVAL; /* overflow after alignment*/
+	if (check_add_overflow(xcrb->resp_len, 3, &u))
+		return -EINVAL; /* would overflow when used with CEIL4 */
 
 	/* prepare type6 header */
 	msg->hdr = static_type6_ep11_hdr;
-- 
2.43.0


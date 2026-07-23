Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C3329C7B
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823047; cv=none; b=Nf5SBtAETHbCSKusN9vZYEUgymJeYGS5jFxloi2g1TV80bukqWcwWw+SJGOkslXvgzQfDgzSI6/X7TspT1VCGzVn1RqAk1Np4MbcBH9F8dkFHVZyIe1Uqd39Zn1eFSYXltA8kK3nnXiIlVk/G6x7yxQXhc0nbP+ee9jQ/okno78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823047; c=relaxed/simple;
	bh=BMzPXQnQ1OQ3GqvpD/gqwrYZKbrLpQhGqLpP2T2hc3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPuUIu8x8w1/NXbjt0bWm9YL3XPonq8izQkdT/Jj1mpLyzph1/AkwfD3WBgEKKsOQI3deKyTWMR5iFRdrhynlOaOHknZpVNvKsBdn42T7IxlvqY768Li9xPM0IKnrY0CIay/NLRWVTjwesCd+PEnQR5LTwG3IKqSg+V0lac2Bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sRPXE1Wx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sRPXE1Wx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBgcA3106134
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=049Glw7RxUSShrCmj
	yDeuGQxjmDbknRdDcBfX71rcaA=; b=sRPXE1Wxa++UqJDUB8Yl+LQlfTyDZeJnL
	+e8xA/vAYVadrhzyec29or5FvXTyiDuGqyqid9trCCbs7sChXAhOA6LVNCdWj7MH
	daMNdR54BH9dIDjkUT1lC6s50qy4KSweQWLRAwuE7nvwqSRNZPZ8hNcrwd43FK9Q
	I5caNFgGyYJqjV+5Pq9EK6fkA122rjHTL5LBdVnEKRaINVCLsdkZwyb2jdUiLYAe
	eFL2fSLQRNtJV6PJvSHA5eVkr7f9/Pm/e8dsJDfpyMqHy3XQfPPd4pX38eVnWxkv
	oTkEwjlGiYLOPR+HiZgiBuYCVmFKv3iJfNvQ86nZ5O6vTy4Bf3Vkw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7918fjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NG4i3G008653
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcwmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 16:10:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGAbYW51511634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:10:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8838E20197;
	Thu, 23 Jul 2026 16:10:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FF962019A;
	Thu, 23 Jul 2026 16:10:37 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:10:37 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v1 1/1] s390/zcrypt: Improve length check and overflow detection at zcrypt msg type 6
Date: Thu, 23 Jul 2026 18:10:37 +0200
Message-ID: <20260723161037.133395-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723161037.133395-1-freude@linux.ibm.com>
References: <20260723161037.133395-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FWsOxcBl5Ez-NcOocSN4jm9NPxVB6k6k
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a623d02 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=of3ay6-9yh-YZq-hFs4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1NSBTYWx0ZWRfX6zPHknMtpYlv
 KzmK2bDjEwz2N4CCU1AXhk9OCFhWUZgn0oQ/hu/PEWsgg5c8u8rJnO2OZJeWGX1mqQdVRnZlDTi
 /BcyYs/oXOHlcCfcf2Hpm812cLW69fY=
X-Proofpoint-GUID: FWsOxcBl5Ez-NcOocSN4jm9NPxVB6k6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1NSBTYWx0ZWRfX+DHbXaQ+A3WN
 po1SUTfSFHgOuIGZjmLfsptbcEgjDdFyCpRmreXGixJl7R3E7hGSmLMg0+ESnYsvogjwf6PrhXD
 dfBqOkFPusPriohjjI8IpNvbqKEYnXaB3YIiKd5/vjuwEgoMel9y4BKT7UbtVL1NRO1u4yn4oKo
 OU+Np+koRuQTrsWCA/Qex8AUBKhgw5QocCXywbB8t7HOhHt5pQDB038uWDPlo9hYQJHYHsiYb3x
 tfsjTXZYbMC1+FsFSidEFOkQzhXw2SBTPcMMcnqxQKFgLbWEVwMrCDZz8S4fZUbcp+qYWXeyvgu
 loAWiVbXdVUwNcqNrM8fq8iu5voisZ2W6FvM299xelFeLEDaqONrTur2wNVvITqW2pjHVanmVRX
 Zn40cQ8ZZGdRxN7OfMDeZlUjxfoVSv7WI3QjUPVbbKEoqf74iu99V30pnNN7B2AnlhckuMC5VZc
 MkiYcQYim7vcmq5zZ4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230155

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
 drivers/s390/crypto/zcrypt_msgtype6.c | 84 ++++++++++++++-------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..8bf735a64383 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -342,50 +342,49 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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
-	if (ap_msg->len > ap_msg->bufsize)
+	if (check_add_overflow(sizeof(struct type6_hdr), req_cblen, &u))
 		return -EINVAL;
+	if (check_add_overflow(u, xcrb->request_data_length, &u))
+		return -EINVAL;
+	ap_msg->len = u;
 
 	/*
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
@@ -393,7 +392,7 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	memcpy(msg->hdr.agent_id, &xcrb->agent_ID, sizeof(xcrb->agent_ID));
 	msg->hdr.tocardlen1 = xcrb->request_control_blk_length;
 	if (xcrb->request_data_length) {
-		msg->hdr.offset2 = msg->hdr.offset1 + rcblen;
+		msg->hdr.offset2 = msg->hdr.offset1 + req_cblen;
 		msg->hdr.tocardlen2 = xcrb->request_data_length;
 	}
 	msg->hdr.fromcardlen1 = xcrb->reply_control_blk_length;
@@ -437,10 +436,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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
@@ -480,16 +482,20 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
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


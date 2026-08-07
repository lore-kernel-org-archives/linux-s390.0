Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1A2F30
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097967; cv=none; b=PIv3rk6tLRFfVWKOD6bU/sVBbxWVSna90dROUyL+JasoD4JmFEQ9iuk8B/e2rNryXuncN1JzFLNqFctDbtxir4vIkVKuL6kZQeBXwepq8kUIr65vFixgeQYkURgCukbZuDKv9aP0y6GBbzbfMIHhr5lNdOTa28M1QgJtePdD/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097967; c=relaxed/simple;
	bh=W8qDS9q363KalbEbWi5b/ZaeOcckpOrI68Ve53koGmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1qZwF6vbv+Wa+y/e0I5LhASroYkAtrY/TyMUYjvHkENH2TNgctZ1D8/zbc2m17haS4z0ULQTxwFwaeu6ET8+ktQIo4uyaYYt1/0iyFnk7BC/NRJ/mNQG2mx1PlHF83U4frRyZdFmtDSwNS7osUeZAgQst+WfTjerHfL7lW/qYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aR9NI8HQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aR9NI8HQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IISk4062553
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DYwzIFLSD1ImBvDbc
	dSGk1ho3IEfTmy9Y/735oWyino=; b=aR9NI8HQNrWrxfkRHAZotwgnFTSkNtbdd
	2hbeO1PQMhpOdvvP3AHEzcciGJyAtdTDdB2bs9b6R2Wk9ec0N/d8Ns1Qayi84E4c
	Hc3W09BB8cwcmMTOlPGqw/N8+c88JKNwIcTx3XRbPpOZX4x3FbKpoHMO8cplDcS8
	DB2AE+B6oIXmvsg0aPQUZ51Ah6DXBAFaV3GQJPzVrUfCfLsaMRqyKtY0BnnkvLuL
	qAiN5bbsLk5VlNO4mHrEvYlqzh8HO5fGPdj7lD0JhO7HJjACdgjeWH46Z2cLJfnA
	7QZAQSUzT3mAMsJjq0/ZkxErwEi5DSAEQVydETbOVpZMtI/gBTKgQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02b9qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:19:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677ABHFg008246
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:19:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kf9mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:19:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AJICD30474602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:19:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE28520078;
	Fri,  7 Aug 2026 10:19:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9049F20077;
	Fri,  7 Aug 2026 10:19:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.146.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 10:19:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v7 1/1] s390/zcrypt: Improve zcrypt reply message verification checks
Date: Fri,  7 Aug 2026 12:19:18 +0200
Message-ID: <20260807101918.31482-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807101918.31482-1-freude@linux.ibm.com>
References: <20260807101918.31482-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75b12c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GbRadHWkDXeqoyddjvkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfX+d+Jtq2GdiGw
 FQ1OSyT6Nw/R/S7qYpHFVWrtzHE0/3snTh2cR/eRFJ5SsKrdasph9OuXOZTc5G42CPZ1U15oQYS
 Jq0KQEgzLK1pfFhznfkcWeIvwODC97gsBC6L8OdTDMh/BcrIr5n/87T7efkfc1zz8dTiIWwYiHv
 Ril+OxsQ94vfzyUfs7S8PRmnRSCYAcjDw8WF34cvYSiGhwH6MnzY3EG9Q84hSSLeRWH8+AD3LrZ
 tKWn2wN718UM0A8WANHVSWYZTiPqDrExgt51JgGMVQVGwmjEvKT3oO5W4INOc0FHy5onX3dZOTR
 t1qzUAi0pteqOExnfDqIWLHKOms6L4zr1NmUrsLmsJy0BUh5NkqnRLOWmqIGtaqCE9hKtEhARSl
 5m57Vf90x5vGwPLHJ4qvz4PMsKvvVGV+Rjbisp3CyjW4lT/c5lr/QSqEcHjfw6uu5nqyZMTy9yH
 Z+Ky471iJ45jNhMRbJg==
X-Proofpoint-ORIG-GUID: 8gVzwHFKA4kyq_ENXqi8vj0OIywlY_E0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OCBTYWx0ZWRfXw8W0M4QFq/Xt
 BsLdvxInkTJnVkPa15fKAWRJx+VJdFFoBDRAs5FjHiZsRsz41ej3WqqNuDQrI0IjrVrZAtelkQj
 8ekWmyc10PbLdPpNLPjeefzi+RKEIXY=
X-Proofpoint-GUID: 8gVzwHFKA4kyq_ENXqi8vj0OIywlY_E0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070078

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA, EP11 (AP message
type 6) and ICA (AP type 50) messages. The verification code related
to reply field length was not designed well and thus firmware
deficiencies could lead to unexpected behavior in the zcrypt device
driver. Thus improve the code to more closely inspect especially
length fields at message replies.

Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
zcrypt_msgtype50_receive() to validate reply lengths more carefully
before copying data back into the request buffer. Use size_t for
length calculations, reject inconsistent reply sizes, and add
defensive handling for short invalid replies. For XCRB replies,
validate both reply segments and derive the effective message length
from the covered range instead of trusting only the second segment.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
 drivers/s390/crypto/zcrypt_msgtype6.c  | 149 ++++++++++++++++---------
 2 files changed, 124 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index d6fc2d8e7fad..3c5fc97f7399 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -416,26 +416,39 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
 	struct type80_hdr *t80h;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t80h = reply->msg;
-	if (t80h->type == TYPE80_RSP_CODE) {
-		len = t80h->len;
-		if (len > reply->bufsize || len > msg->bufsize ||
-		    len != reply->len) {
-			pr_debug("len mismatch => EMSGSIZE\n");
-			msg->rc = -EMSGSIZE;
-			goto out;
-		}
-		memcpy(msg->msg, reply->msg, len);
-		msg->len = len;
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
+
+	if (t80h->type != TYPE80_RSP_CODE) {
+		if (reply->len < sizeof(error_reply))
+			memcpy(msg->msg, &error_reply, sizeof(error_reply));
+		else
+			memcpy(msg->msg, reply->msg, sizeof(error_reply));
 		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+	len = t80h->len;
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
 	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&msg->response.work);
 }
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 3df1d676de5d..5af3e20ad114 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -766,6 +766,13 @@ static int convert_type86_rng(struct zcrypt_queue *zq,
 
 	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
 		return -EINVAL;
+	/*
+	 * Note that offset2 and count2 have already been checked in
+	 * zcrypt_msgtype6_receive(). So only check for not exceeding
+	 * the hard coded rng buffer size.
+	 */
+	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
+		return -EMSGSIZE;
 	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
 	return msg->fmt2.count2;
 }
@@ -928,48 +935,73 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
-	int len;
+	size_t len, len1, len2 = 0;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t86r = reply->msg;
-	if (t86r->hdr.type == TYPE86_RSP_CODE &&
-	    t86r->cprbx.cprb_ver_id == 0x02) {
-		switch (resp_type->type) {
-		case CEXXC_RESPONSE_TYPE_ICA:
-			len = sizeof(struct type86x_reply) + t86r->length;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		case CEXXC_RESPONSE_TYPE_XCRB:
-			if (t86r->fmt2.count2)
-				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
-			else
-				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
+
+	if (t86r->hdr.type != TYPE86_RSP_CODE ||
+	    t86r->cprbx.cprb_ver_id != 0x02) {
+		if (reply->len < sizeof(error_reply))
+			memcpy(msg->msg, &error_reply, sizeof(error_reply));
+		else
+			memcpy(msg->msg, reply->msg, sizeof(error_reply));
+		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+	switch (resp_type->type) {
+	case CEXXC_RESPONSE_TYPE_ICA:
+		len = sizeof(struct type86x_reply) + (size_t)t86r->length;
+		break;
+	case CEXXC_RESPONSE_TYPE_XCRB:
+		len1 = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		if (t86r->fmt2.offset1 > reply->len ||
+		    t86r->fmt2.count1 > reply->len) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=%d\n",
+				 t86r->fmt2.offset1, t86r->fmt2.count1,
+				 reply->len, msg->rc);
+			goto out;
+		}
+		if (t86r->fmt2.count2) {
+			len2 = (size_t)t86r->fmt2.offset2 +
+				(size_t)t86r->fmt2.count2;
+			if (t86r->fmt2.offset2 > reply->len ||
+			    t86r->fmt2.count2 > reply->len) {
 				msg->rc = -EMSGSIZE;
+				pr_debug("offset2 %u count2 %u rpl.len %zu mismatch, msg.rc=%d\n",
+					 t86r->fmt2.offset2, t86r->fmt2.count2,
+					 reply->len, msg->rc);
 				goto out;
 			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		default:
-			memcpy(msg->msg, &error_reply, sizeof(error_reply));
-			msg->len = sizeof(error_reply);
 		}
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
+		len = max_t(size_t, len1, len2);
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
 		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
 	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }
@@ -992,34 +1024,49 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t len;
 
 	/* Copy the reply message to the request message buffer. */
 	if (!reply)
 		goto out;	/* ap_msg->rc indicates the error */
+
 	t86r = reply->msg;
-	if (t86r->hdr.type == TYPE86_RSP_CODE &&
-	    t86r->cprbx.cprb_ver_id == 0x04) {
-		switch (resp_type->type) {
-		case CEXXC_RESPONSE_TYPE_EP11:
-			len = t86r->fmt2.offset1 + t86r->fmt2.count1;
-			if (len > reply->bufsize || len > msg->bufsize ||
-			    len != reply->len) {
-				pr_debug("len mismatch => EMSGSIZE\n");
-				msg->rc = -EMSGSIZE;
-				goto out;
-			}
-			memcpy(msg->msg, reply->msg, len);
-			msg->len = len;
-			break;
-		default:
+
+	if (t86r->hdr.type != TYPE86_RSP_CODE ||
+	    t86r->cprbx.cprb_ver_id != 0x04) {
+		if (reply->len < sizeof(error_reply))
 			memcpy(msg->msg, &error_reply, sizeof(error_reply));
-			msg->len = sizeof(error_reply);
-		}
-	} else {
-		memcpy(msg->msg, reply->msg, sizeof(error_reply));
+		else
+			memcpy(msg->msg, reply->msg, sizeof(error_reply));
 		msg->len = sizeof(error_reply);
+		goto out;
 	}
+
+	switch (resp_type->type) {
+	case CEXXC_RESPONSE_TYPE_EP11:
+		len = t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
+		msg->len = sizeof(error_reply);
+		goto out;
+	}
+
+	if (len != reply->len) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu rpl.len %zu mismatch, msg.rc=%d\n",
+			 len, reply->len, msg->rc);
+		goto out;
+	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		msg->rc = -EMSGSIZE;
+		pr_debug("len %zu exceeds buf %zu/%zu, msg.rc=%d\n",
+			 len, reply->bufsize, msg->bufsize, msg->rc);
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }
-- 
2.43.0


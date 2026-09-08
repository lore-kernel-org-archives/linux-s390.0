Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B551120E
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862866; cv=none; b=CpCEmQILVviTykPUFliacHlzLaZoZAQd5RNjFxjOf4XvIWYo16iD/F/OOQX8RKySna2bdkA6Y2QTN71XQZirIxByc/aFn1aG/d8WgnjhBxsJV8soPM2ydeG7gyhsQnBoXcALaK4uoPwr/PdUM6zKNpMEbfcCGTMm9fWFoDwV934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862866; c=relaxed/simple;
	bh=e3GBFmiwwKP0E3NvAYgn1hzY22QUWd0c4AEFeCBCEm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e04D4xoh7gl4OTXUpBjE/ud4dJfdawyuX/ZklrOet0dKyGIa+O5VQcuxnN3lMtYpfJEoI7n4VNZaR2MgKrrtOBUHyo3MrwyXS64YxQeo6xK6x/qVDMgsLXCCcKYe4+L20DM8cm25BggXM6FXU18HJaRqhIE42nC9y9DAuis8DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UcXmt60z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UcXmt60z"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VgQ5059268
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 10:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DJqyk3UkNOY3BNwnD
	hzbUdtwaPVQhwJIb344SiXrX0Y=; b=UcXmt60zHsFsmCclsafI3YCCK4sKnYh8j
	P2I+KhWuHUmOrDgiS5UJ1UcEAuBcZlmlBuqV6Ov50xSE3/lQJrVslgH//rzT1hvN
	ePgRhMjtzvdbFrPUO2c1CwH0IiOfaRbPNFLmNkhP8xw6YCktwWxWDDE0v+vNL3JU
	o3w0/nwpj+y+sq3vF4b/+vU/vaQAEFVPTI72wH36weXfpl2dLHiOT0pIMbgTSef9
	843OpS2SzmLgzm37+XJ2X2RwGuJD8ByR/azm1yeugp3IUqwfsKZMeBbuc5fOVsyG
	mRlhnK/3jky16ihXsTY7aYbe9mEAb0FKmC6fB07VWdcHUdrPIK94g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkp6p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 10:21:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688ACvDj011726
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 10:21:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw38xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 10:21:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688AKwOI45679058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 10:20:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ADBE2004B;
	Tue,  8 Sep 2026 10:20:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DDBD2004E;
	Tue,  8 Sep 2026 10:20:58 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.138.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 10:20:58 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/zcrypt: Fix and improve zcrypt reply message verification checks
Date: Tue,  8 Sep 2026 12:20:57 +0200
Message-ID: <20260908102058.14329-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102058.14329-1-freude@linux.ibm.com>
References: <20260908102058.14329-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfX5g4M8emXT1nL
 NX74nC+2fR6ZqxP6msfLFi8Gm+/z7cxLeFwaZOW+YEKiCazi0+bbmfIQhyEDQTu0v3W1zJYUDLL
 yf1q2TlS/b7gU7+LOn8YON0eRXsh6B0=
X-Proofpoint-ORIG-GUID: 5f9cXPO3k0dg1pJUubPNA8CBGQvw-sWk
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9fe18f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=OnDvl9nT2VvQF00v-d4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNiBTYWx0ZWRfXyOPCcXMVfA1s
 Ir6Gs7VA4+gEL+MoQPHw+Tf8GarpgbA8l25vU/L7PKKi9DyxtD1oQVKwHhSsjGdPPMnTIJlgxal
 zcX2oyAIBggXZVJSf+AZzBrhSRFMPOP8G5qd13/O/wZ6tf0+dg9cutS8aZcQyd8KlKPMcs1H0c9
 HmCGmw5cKr+SdT1/vHMK3Ur5t2s5Rfe3Gx9DQeJuoCz6qPO98wSAtAf4a/nN74rEgJpQO9XkzoN
 LEHtUGG+nT5GGHTsr8EoXXcqAjC/zhKBS1jCqAEkm6vJpHdKdsKQlbXsMUjkbNk50LdItITSSeq
 6Q52lbWUazijDT1ChVRTt09MXiVuEFH13DWnOidO3XupukWl8LkYxs/nuK95aFpky8jMTzhfxus
 qT7+A9e37J/I/rIxUr7uqDteOR+pDH5sr+qjHlMnd9ag4TiGMbz6YHma+LSRhKrO8qAnY/dKyEr
 dkM+VOVr6OqwlcjtGSQ==
X-Proofpoint-GUID: 5f9cXPO3k0dg1pJUubPNA8CBGQvw-sWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080106

Add or improve checks related to buffer sizes and reply sizes to the
handling of replies from the crypto cards for CCA, EP11 (AP message
type 6) and ICA (AP type 50) messages. The verification code related
to reply field length was not designed well and thus firmware
deficiencies could lead to unexpected behavior in the zcrypt device
driver. Thus improve the code to more closely inspect especially
length fields at message replies.

Add length validation before accessing reply message structures in
zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11(), and
zcrypt_msgtype50_receive() to prevent out-of-bounds reads and
potential kernel memory disclosure.

Also rework these three functions to validate reply lengths more
carefully before copying data back into the request buffer. Use size_t
for length calculations, reject inconsistent reply sizes, and add
defensive handling for short invalid replies. For XCRB replies,
validate both reply segments and derive the effective message length
from the covered range instead of trusting only the second segment.

Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from card modules.")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype50.c |  40 ++++--
 drivers/s390/crypto/zcrypt_msgtype6.c  | 162 +++++++++++++++++--------
 2 files changed, 138 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index d6fc2d8e7fad..80c447ea2d83 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -416,26 +416,40 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
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
+	if (reply->len < sizeof(*t80h) ||
+	    t80h->type != TYPE80_RSP_CODE) {
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
index 3df1d676de5d..aad82e798a01 100644
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
@@ -928,48 +935,82 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86x_reply *t86r;
-	int len;
+	size_t minlen, len;
 
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
+	minlen = sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
+		offsetof(struct CPRBX, cprb_ver_id) +
+		sizeof(t86r->cprbx.cprb_ver_id);
+
+	if (reply->len < minlen ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
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
+		if (reply->len < sizeof(struct type86x_reply)) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("rpl.len %zu < struct type86_reply, msg.rc=%d\n",
+				 reply->len, msg->rc);
+			goto out;
+		}
+		len = sizeof(struct type86x_reply) + (size_t)t86r->length;
+		break;
+	case CEXXC_RESPONSE_TYPE_XCRB:
+		len = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
+		if (t86r->fmt2.offset1 > reply->len ||
+		    t86r->fmt2.count1 > reply->len) {
+			msg->rc = -EMSGSIZE;
+			pr_debug("offset1 %u count1 %u rpl.len %zu mismatch, msg.rc=%d\n",
+				 t86r->fmt2.offset1, t86r->fmt2.count1,
+				 reply->len, msg->rc);
+			goto out;
+		}
+		if (t86r->fmt2.count2) {
+			len = (size_t)t86r->fmt2.offset2 +
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
+		break;
+	default:
+		memcpy(msg->msg, &error_reply, sizeof(error_reply));
 		msg->len = sizeof(error_reply);
+		goto out;
 	}
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
@@ -992,34 +1033,53 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
 	};
 	struct ap_response_type *resp_type = &msg->response;
 	struct type86_ep11_reply *t86r;
-	int len;
+	size_t minlen, len;
 
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
+	minlen = sizeof(t86r->hdr) + sizeof(t86r->fmt2) +
+		offsetof(struct ep11_cprb, cprb_ver_id) +
+		sizeof(t86r->cprbx.cprb_ver_id);
+
+	if (reply->len < minlen ||
+	    t86r->hdr.type != TYPE86_RSP_CODE ||
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
+		len = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
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


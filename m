Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB32264C7
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854976; cv=none; b=AlFmOo+jCjX3UNSdXkDI5NRlAcvlo+lXlhSWJuOl48Htb7QtjQaRJW+6K0X9A4ckdAurhTz90S+fP3qSfEChwxsx3k+n1lxOiV6EZ/RzIW9T3Pbyj25GXEMlTQIerBxcZc5vjBmZLAjEVoaLXUsaQgTMip4n8lRAToaDIsBYVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854976; c=relaxed/simple;
	bh=T0ijYPWOhl4tC9ZM/1ONLc2vxyAql3LNtq+v6ZR9BwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZsVAe/uUa9E8itwdD1QIy1+s38ojXon5XBclHMushjnJI1UUqwWU4nJ5qly+iWGR6IMguHL99kE+fhd976GryL4wA1D0eK538ZgkJ4hDUoATi8GghLG2rzuyaniG1hRwAZ8cxoUtv04Ixvz2DCR+FL3ZL9sHdzA786n+zJ1MFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YGa+S5Pi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YGa+S5Pi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Cpa2i808721
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 14:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GCKpaahYEBX6ezJrv
	Naa+cMbjm10Ae73eZL67g4au1A=; b=YGa+S5PiGLTWztpTg8pc2/ZPlElYSamE3
	1KGzd78WLrGhJ0fcNOVo2ZLzuoiLoLCIsUIFD8zbNS1mHWA9KyR8mYs9pVbDbm2k
	Y7+cH2ta68Bxm1KQmvKtXDE/EGgUarvk2ZGxot8B0EN5RPXeiKW+mzG7f/WkdWoa
	wVl5HoQEe6/VK59jpshPpPFBFx4a/TfZDdyh5etFD/dQHG6kShMU2K4RHRcquYsC
	awjLDSAGgNNUi2MfAYEYrLXguBBuu/MEVjW5OjYt9CbxFL3NYr23ajNZhkcuJEDd
	dyknZCHGcCodKd7FEgN5SL0hw/GSoGDu2EwQzNEsxUvZO6+zlhI5Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hp7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:49:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674EfFPl032763
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 14:49:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k2cug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:49:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674EnP0B25363180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:49:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B9B620040;
	Tue,  4 Aug 2026 14:49:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ED452004E;
	Tue,  4 Aug 2026 14:49:25 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:49:25 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v6 1/1] s390/zcrypt: Improve zcrypt reply message verification checks
Date: Tue,  4 Aug 2026 16:49:26 +0200
Message-ID: <20260804144926.241039-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804144926.241039-1-freude@linux.ibm.com>
References: <20260804144926.241039-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX5pc+2drOTl9u
 ZcfZUbTYCc+NpBULnPlhoDXmTgyY03AKK5ZnLrIiDFb50FhdVs7q5tFhshHgx7oqb4QQf9y2R6b
 GaDvA079PjBRMjTQgxrndYsqnT1WbY0=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71fbfa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=y5L5pJLULh4rkpwcvBgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX2gRtk2fHOo85
 p9BNnH5y7CREyaPWgHTgUjEBNX/VliuEnBXXysseA+SOZGq9xjd6l/jQ9esUqsjaJDmaWb/Y/jz
 WAaD+nlC5/Z+RiCANnVEzAU4ih10hLm0Ff9T1Qt4Vcg64xHpgD8dpUXZFPFhWYw8eEHK4/ANSwO
 /VvuViSimsba2G5AiWOHKcOc+vh+Jknh680O5LwK06PG+J+s2UB5UsyMSJf0+MIXazef3R6YrL7
 amc3J77q0elG+3Tt51ncKXFd6UVlEQPyDNC+AplKwcotrHwA+HfPTF/EZzDhO4sPKPyjCL+Hyf7
 Rn99GWaIPaL2NuIk0Y5lBv1YK2A4tTdv6B15J1LlI/SJVyLnhvZTq6PbO+2rTB+d1QK3RdKi3BS
 HR4oEeBngzLfgMPOgwszLKOjZzBb42mVcMHfiFTTYQRnavjFNcAIkJFUBAUMg3TSFJKjlY9aYbT
 23HsGL6AN8GmvpBFivA==
X-Proofpoint-ORIG-GUID: -Plvay7UL4zCoXuPw5SUXchNi5qvs1Dl
X-Proofpoint-GUID: -Plvay7UL4zCoXuPw5SUXchNi5qvs1Dl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040120

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
 drivers/s390/crypto/zcrypt_msgtype6.c  | 151 ++++++++++++++++---------
 2 files changed, 126 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index d6fc2d8e7fad..ef925b399806 100644
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
+		pr_warn_ratelimited("len %zu rpl.len %zu mismatch => EMSGSIZE\n",
+				    len, reply->len);
+		msg->rc = -EMSGSIZE;
+		goto out;
 	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
+				    len, reply->bufsize, msg->bufsize);
+		msg->rc = -EMSGSIZE;
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&msg->response.work);
 }
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 3df1d676de5d..b98449913e24 100644
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
@@ -928,48 +935,75 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
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
+			pr_warn_ratelimited(
+				"offset1 %u count1 %u rpl.len %zu mismatch => EMSGSIZE\n",
+				t86r->fmt2.offset1, t86r->fmt2.count1,
+				reply->len);
+			msg->rc = -EMSGSIZE;
+			goto out;
+		}
+		if (t86r->fmt2.count2) {
+			len2 = (size_t)t86r->fmt2.offset2 +
+				(size_t)t86r->fmt2.count2;
+			if (t86r->fmt2.offset2 > reply->len ||
+			    t86r->fmt2.count2 > reply->len) {
+				pr_warn_ratelimited(
+					"offset2 %u count2 %u rpl.len %zu mismatch => EMSGSIZE\n",
+					t86r->fmt2.offset2, t86r->fmt2.count2,
+					reply->len);
 				msg->rc = -EMSGSIZE;
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
+		pr_warn_ratelimited("len %zu rpl.len %zu mismatch => EMSGSIZE\n",
+				    len, reply->len);
+		msg->rc = -EMSGSIZE;
+		goto out;
 	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
+				    len, reply->bufsize, msg->bufsize);
+		msg->rc = -EMSGSIZE;
+		goto out;
+	}
+	memcpy(msg->msg, reply->msg, len);
+	msg->len = len;
+
 out:
 	complete(&resp_type->work);
 }
@@ -992,34 +1026,49 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
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
+		pr_warn_ratelimited("len %zu rpl.len %zu mismatch => EMSGSIZE\n",
+				    len, reply->len);
+		msg->rc = -EMSGSIZE;
+		goto out;
+	}
+	if (len > reply->bufsize || len > msg->bufsize) {
+		pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
+				    len, reply->bufsize, msg->bufsize);
+		msg->rc = -EMSGSIZE;
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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0633E7622
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335977; cv=none; b=e5qsprtG1LXg23/NSIRuhU5q6w6NvAgt2w9COeqQAA9QpwwCvRfUB/VNhb6cjBe3zc6pzfxagxGhTV1ZAkAO2meQcGXH6ESljBBH1W1plaj1BR00RTGk2nhLSlrndkj6ChoLGfX0du+BywsxpgsCUNKlh+8X+kX4THFxISAkvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335977; c=relaxed/simple;
	bh=DrqwnQ6QcT2064zgYE5LX90cwTSM+iQArHx2wnJwBV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhxL6hoytRX8dB+0yP4bkvcNuSGU1GEhPQEaSBl0ALOEplSyobcGTWeAEFKPf+C8zj9HZHXdQ45lukfoD39KV1baCXKNpyJYDSkQNw7/w4F4VZWrau9uDDWhHHAElJAXKGXhKiCq4Gd5p6xB/3U+2Vq/jmKGCxF6ImDhuedaL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ShJZU/na; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ShJZU/na"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHplq141319
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GqsPS7aNJOq8AsbDy
	/nNbvKk7Y70bQOmNWt+24eJ8+E=; b=ShJZU/naYJ+Gk5+xqjYyQeF+ipuLzFetZ
	XdNPo1n7YxjTsdPA5whNpA9vbN6WSXW/5QlTmFXSOwjd0694+CQmJ7kiuIeg1hxe
	DeSlGagb/oUBKxaKYw/zbIlWB/4PEMQ+AaQ39KaV6NZU07NAHlZy3F/qlwuWXdym
	6kaoYgiUdjHzM7BjF6YGbIxyJESlq41e8EjaOKHZFLTxiP72xIsW0ojP7KPbEs2X
	Jq+lvjpaXSIZGdy06GyhMgkSWXcWBvCNRFJF9t+0QyQQNg27ZRawtDypWylwdpAh
	vst/EcgNIqFOdSf7pmcbo18tbL3uMg4HkdbmIGSgr2YNNPlQ9uo3A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd2dvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEQkoi023265
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf0m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEdTrL33489194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:39:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB382004B;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8055020043;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v8 4/5] s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
Date: Wed, 29 Jul 2026 16:39:27 +0200
Message-ID: <20260729143928.191969-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729143928.191969-1-freude@linux.ibm.com>
References: <20260729143928.191969-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rLqUgYuyKbzcZt26ndt8d_lwpl-6jSvL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX3OFnUrNUENH2
 +im4detdLtQkA70X2V0WXsZZo3IjCTkPg0tDqUEyNOHrxWB7+JnlLMbWvTj9sVsQeg42aat/+ej
 P5XVmDZVgFdHvBpTH2kiR6PT1Kh+CSk=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6a10a6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=hoYYr1_72z9RSZTYHFsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfX2fMHLZR+Wojd
 FOEYN6oRnXX7tc7KMVP7bl8TqMyKe8lYsp+ldMgHIFW0PSunce01uONZ8E0GBZ4ylQRQip9ra3n
 rDWZwE9BQoQXdwqZuxcml855OSAE6g9ocBVbwkLiHqmXmxAQA0TgcabIJkRdOxuCKJCNvbnUbi1
 DIm4MdWndrcjv12bzwKwOuS9P6A2zXDfzwTp/tp6U9YazrTHmYzKx20xeHQGklnF5AXjQM99FLQ
 ronLEYghtwjtUsN4i+XgaU2xLFet29eOvUrxMjUzkl4wwUB/7y3RSKvqB+Jc3kdtN1yjlsHbHTh
 Dkisi7QF63UYLbpLfjiYlnCxh7ZOEAUT897XJzY4wxGDY01Da8RaM4mmdUQ1jcE+JynD3Fnw1Yv
 WwzfOk33+vmNRc6gEEX+m3yAlCqzyjgvGbLh16Ohgv2FtDL9ShcOyUJjSFR7rUx6kYgqNowr8he
 LEGrBzRH9dkz+0P9H7A==
X-Proofpoint-GUID: rLqUgYuyKbzcZt26ndt8d_lwpl-6jSvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290117

The zcrypt_msgtype6_send_ep11_cprb() function uses fragile struct
overlays to access and modify the domain field in the EP11 CPRB
payload, creating maintainability and security concerns:
1. Struct overlay approach (pld_hdr) assumes fixed payload structure
   and doesn't validate the actual ASN.1 encoding.
2. Complex length format detection logic is error-prone and doesn't
   properly validate bounds at each parsing step.
3. Direct struct member access bypasses proper ASN.1 validation.

Fix by replacing struct overlays with explicit ASN.1 parsing that
validates each field (payload tag/length, function tag/length/value,
optional domain tag/length/value) with proper bounds checking at every
step. Add asn1_int_encode() helper function to safely write integer
values with correct endianness conversion. This makes the code
consistent with the validation pattern introduced with the rework of
the xcrb_msg_to_type6_ep11cprb_msgx() function.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 123 +++++++++++++++++++-------
 1 file changed, 92 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index c4b5d9b85f7a..59e182d1bddf 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1223,6 +1223,28 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 					       func_code, domain);
 }
 
+/*
+ * Simple asn1 int writer/encoder helper function
+ * Returns number of bytes processed or < 0 on failure
+ * Only accepts int length values of 1, 2 or 4.
+ */
+static inline int asn1_int_encode(u8 *buf, size_t intlen, u32 u)
+{
+	switch (intlen) {
+	case 1:
+		*((u8 *)buf) = (u8)u;
+		return 1;
+	case 2:
+		*((u16 *)buf) = cpu_to_be16(u);
+		return 2;
+	case 4:
+		*((u32 *)buf) = cpu_to_be32(u);
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * The request distributor calls this function if it picked the CEX4P
  * device to handle a send_ep11_cprb request.
@@ -1235,51 +1257,90 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 					   struct ap_message *ap_msg)
 {
 	int rc;
-	unsigned int lfmt;
 	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
 		struct ep11_cprb cprbx;
-		unsigned char	pld_tag;	/* fixed value 0x30 */
-		unsigned char	pld_lenfmt;	/* payload length format */
 	} __packed * msg = ap_msg->msg;
-	struct pld_hdr {
-		unsigned char	func_tag;	/* fixed value 0x4 */
-		unsigned char	func_len;	/* fixed value 0x4 */
-		unsigned int	func_val;	/* function ID	   */
-		unsigned char	dom_tag;	/* fixed value 0x4 */
-		unsigned char	dom_len;	/* fixed value 0x4 */
-		unsigned int	dom_val;	/* domain id	   */
-	} __packed * payload_hdr = NULL;
 
 	/*
 	 * The target domain field within the cprb body/payload block will be
 	 * replaced by the usage domain for non-management commands only.
 	 * Therefore we check the first bit of the 'flags' parameter for
 	 * management command indication.
-	 *   0 - non management command
-	 *   1 - management command
 	 */
-	if (!((msg->cprbx.flags & 0x80) == 0x80)) {
-		msg->cprbx.target_id = (unsigned int)
-					AP_QID_QUEUE(zq->queue->qid);
-
-		if ((msg->pld_lenfmt & 0x80) == 0x80) { /*ext.len.fmt 2 or 3*/
-			switch (msg->pld_lenfmt & 0x03) {
-			case 1:
-				lfmt = 2;
-				break;
-			case 2:
-				lfmt = 3;
-				break;
-			default:
+	if (!(msg->cprbx.flags & 0x80)) {
+		int i, offs = 0;
+		size_t pld_len;
+		u8 *pld;
+		u32 u;
+
+		/* update target field in ep11_cprb */
+		msg->cprbx.target_id = (u32)AP_QID_QUEUE(zq->queue->qid);
+
+		/* ptr and length to payload */
+		pld = ap_msg->msg +
+			sizeof(struct type6_hdr) + sizeof(struct ep11_cprb);
+		pld_len = msg->cprbx.payload_len;
+
+		/*
+		 * Parse the asn1 payload, at least we have
+		 *   pld tag (1 octet)
+		 *   payload length (1-5 octets)
+		 *   function tag (1 octet)
+		 *   function length (1-5 octets)
+		 *   function value (1-4 octets)
+		 *   ----- optional fields -----
+		 *   domain tag (1 octet)
+		 *   domain length (1-5 octets)
+		 *   domain value (1-4 octets)
+		 *   ... maybe much more data ...
+		 */
+
+		/* payload tag */
+		if (pld[offs++] != 0x30)
+			return -EINVAL;
+		/* payload length field */
+		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+		if (i < 0)
+			return -EINVAL;
+		offs += i;
+		if (u > pld_len - offs)
+			return -EINVAL;
+		/* function tag */
+		if (pld[offs++] != 0x04)
+			return -EINVAL;
+		/* function length */
+		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+		if (i < 0)
+			return -EINVAL;
+		offs += i;
+		if (u > pld_len - offs)
+			return -EINVAL;
+		/* skip over the function value */
+		offs += u;
+		/* is there some payload left which could hold a domain value ? */
+		if (pld_len - offs >= 3) {
+			/* domain tag */
+			if (pld[offs++] != 0x04)
 				return -EINVAL;
-			}
-		} else {
-			lfmt = 1; /* length format #1 */
+			/* domain length */
+			i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+			if (i < 0)
+				return -EINVAL;
+			offs += i;
+			if (u > pld_len - offs)
+				return -EINVAL;
+			/*
+			 * pld[offs] is now at the start of the domain value
+			 * with the value sprawled in u octets.
+			 */
+			i = asn1_int_encode(pld + offs, u,
+					    AP_QID_QUEUE(zq->queue->qid));
+			if (i < 0)
+				return -EINVAL;
+			offs += i;
 		}
-		payload_hdr = (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
-		payload_hdr->dom_val = AP_QID_QUEUE(zq->queue->qid);
 	}
 
 	/*
-- 
2.43.0


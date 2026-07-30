Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D543BDCB
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420916; cv=none; b=PeNP69BzCwRl/aDXh1uTh3YgQmi8w/vq1PRInUyFpchl7A6UDOMSjrNSz7bemTWDyYVohiT6485FsSECI82AAfzsvsbrvlj4yPA7NI9qF1KJp3ucZ5cGSyMt+euRzU8yC93eSyyAKxBPBbi/nYcuTAYsW9i/yJIrfEhBjNSb0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420916; c=relaxed/simple;
	bh=Z3HlLPic+6ySy2ODFTwJ3uJt18Mou/z/7KyENkPy2AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIKsWgiYYyYhtvfUnWeLTSqVyg5e3O18EfeiTmYGHSw/fWOSUfaUTD4hT9OMxI76cuYam2wofUjJYxxLQMKQVAQnxj6sLy3beb/bNT5G7DPuxKE9JMigntkKRx/FmaSv24n4AhLC5XmL8bGcUyQuKplPNHK/ZSWsHuZsYzEFo5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IxdI+fck; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IxdI+fck"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHrtF3146331
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d+AyEkXsfduMUenri
	ZiBEbF0KpluFFDFToJnWATdKx8=; b=IxdI+fckJ39Mr5W9YC36m5oSfDtSqJVMR
	8ogCXWrvZYbJ6IRTiFjQCLQTrA4W1qHm4bQICbCA34s7h77SqA3Rc+FyI7eVWyh7
	+/t3i5g095DJAJSl72kSxo0TA4U2Ttw6YBvcDJC9zPNVLZnfkXLRfYHdOAbzYats
	nnt1PqL8PTjDyOckK/AQ2lmJoYGjTzD4HL3uLn/p5PGRofEpDzIk2pl1VkwhV0QT
	wkJ3IUR7WVo9LqZ3TBkacarZNYJ5jzmz5itaxRG+3RL0KtbXVkTmdAsG7GSZ/Uu2
	Ly5eDPUOuVqOhEF/WU1KVvFFhG6iSygDf8Hp1xNVcl7qbGRbBWMCQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd7a0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEBNwX004024
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkbpty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEF9X747907234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:15:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD2720040;
	Thu, 30 Jul 2026 14:15:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1CBC2004F;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v10 4/5] s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
Date: Thu, 30 Jul 2026 16:15:08 +0200
Message-ID: <20260730141509.205970-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730141509.205970-1-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bVL_yF-21AU-XteRadt9GP5XlrVyItNX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX7YpLmgc0dC5U
 3uUcE9hi1qQsk6P4Sx9Sfjwywh09Za6uQS4Pjbn7PffWaqWbIN2WMd/P15V7OM2euD55wWdc70G
 ksQMJKMJcTKY58GZSFv7ttZWeSlHXTM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b5c71 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=hoYYr1_72z9RSZTYHFsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX6yRImseC1c3i
 YINxgBMopxPv1DOcYftBEJXFjUt7PQDqRgYhOqxEMl+QAu0lVCIv66jtwuCX1WqCeRUbi3fQEpQ
 sNK1io3miiZCM7TXD9St8pbs/ijULBFIUSPeRYd01wKjw+tiKrixNyYl+dZZReaCPOYIB0ziB0r
 NKii7D5sIVEhFufj2EC/7lL5NjfrmS8vVfcLsxNRTaWH5ViGyLrIPSnJ/oiL/9d36g1UwPAZPbr
 tnsmGCbg2uQ6rcgq6SHwVLgUyBmZ3/RuKpLXfHUXkQXOFp8Y8+qewlusutanY511nC/LQ4p/0H6
 ZazS8WEiRTaMyedkK3AFNy7JiDTdimomzoY9QMq42Qgq0p4aabeu9C7LBNFHU9WUcNjQZ89ashP
 Aa5Mb8HMG1FP8yMF37V8JQXl0EYLThSERFxz0ofIurb19iqx7wBtqEkUAAlXyap5Xnxy58ckW3L
 m9+fvQ5sJvoiy342JOQ==
X-Proofpoint-GUID: bVL_yF-21AU-XteRadt9GP5XlrVyItNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300105

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

Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.1+
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 127 +++++++++++++++++++-------
 1 file changed, 96 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index c351ead03072..02705f184ef8 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1227,6 +1227,28 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
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
+		*buf = (u8)u;
+		return 1;
+	case 2:
+		put_unaligned_be16((u16)u, buf);
+		return 2;
+	case 4:
+		put_unaligned_be32((u32)u, buf);
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * The request distributor calls this function if it picked the CEX4P
  * device to handle a send_ep11_cprb request.
@@ -1239,51 +1261,94 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
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
+		if (pld_len < MIN_EP11_PAYLOAD_SIZE)
+			return -EINVAL;
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
+		if (offs > pld_len || u > pld_len - offs)
+			return -EINVAL;
+		/* function tag */
+		if (pld[offs++] != 0x04)
+			return -EINVAL;
+		/* function length */
+		if (offs > pld_len)
+			return -EINVAL;
+		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+		if (i < 0)
+			return -EINVAL;
+		offs += i;
+		if (u > pld_len - offs)
+			return -EINVAL;
+		/* skip over the function value */
+		offs += u;
+		/* is there some payload left which could hold a domain value ? */
+		if (offs < pld_len && pld_len - offs >= 3) {
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
+			if (offs > pld_len || u > pld_len - offs)
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


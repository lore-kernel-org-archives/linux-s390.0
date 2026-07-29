Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902102BEFEF
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339911; cv=none; b=UsHwu3TIXN+/HurnDYVCirCRmXqfiZqknx3ZXEpyR4eq6paYbh0qE1x2+EXDyM0k06E8ejd0Ngp/DCkKpym6JlhrhmZ7rQvCuqmHjRkGw3ag3P53VO8qmeuxa8y0akv6H1Bzq1Btq2BjGmSeTc2MD3c6eZppHoG+7qLN6E8HW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339911; c=relaxed/simple;
	bh=lUka9y2XPTrItF5l1ebp2YJmVwJ2KGLpRmYrH4uW10Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgRmx6XKgIzYxVFRDjzgkXfRCoJdSddl3RKZD9ZIaQDX/kDaNm2IYmUu1SSjIrLkJqGfDT6hyHq+ms8DnoGjdrXMIuiJx/0+SYcpN91GVVmd+K5OapaqYeMvcbyvFQHXMH4Md6P82WHkb4aL6mBJnHn7ELTTgCXkGyYhjzxtE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VnPSZIEK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VnPSZIEK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHnvI356419
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uA/Q8NFDVnP68UteV
	vRx/E8Z8Th57LWa4kvhDeBLYN8=; b=VnPSZIEKqu2FaDj8LE9Cqw57Kshu/Xxnh
	HA/djp3F81AtdTIDfy9gDaWdYLNVYDUzpz/6leKb85j50Re3x24RMnF7k6yoMNLw
	X3tt0srr1yQt6k+MGu8GL7mEDL5ChNZJGbeqfARdK+d2bPLUkZKMuLGknHreYJCE
	a0s1wLJutQ5u3sfBW2RyX5j9xWooN7gTVNzV/a29xD6GbS3aRqCVROMGVDmdsFiu
	WNamqfs+AuGZk/wWysNf5y/In8VEDb+QDHHHONdKlnkxhdg6FK6BO2WgqmtdEJzX
	qUrPKtRVSs+Q/hRUZjN1uZ8H8iA0jwLNFrbCogM2Oxd2GLEqek/xg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7kfbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfefH004088
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7bbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFj0GD27984254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:45:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A5920040;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616382004D;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v9 4/5] s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
Date: Wed, 29 Jul 2026 17:44:57 +0200
Message-ID: <20260729154458.195135-5-freude@linux.ibm.com>
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
X-Proofpoint-GUID: hxgI68aW-5T_6VuG6ol7CXThiIkW4c1j
X-Proofpoint-ORIG-GUID: hxgI68aW-5T_6VuG6ol7CXThiIkW4c1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX69tnpSwVJ5dV
 l6/zdOhksdHyVqfJCoiaXrthh63cKsryUCHaIq5GE5dYYIjRqZFwDrN9apYzBIgws1OrPvOha0V
 K4CsJzZ/6QdLyBiLBUw3I5cVT+nZ0Jhi+wWwUWbOc6UErB6yAfFqwjreLWTiL+GGb7ALEexjY4u
 ptQ2cPDP4+CwTgQuXGK8monyku/4/QRYy++AH73fOr5oDQbrZAQvg9LkD9wFq/SyLS05CYzNipv
 nG/2vAuJfIqaUF6x56zgcuG4ZAUXP1p3vM1SnrdHiGpSTUiG7TKXa4PwENd+pud8P87qOPT3MRt
 t/7AqE/ecR2t08utttDpabKsvYpWarK7LRXXWnpSrc8ui1GeMnAvLJvQr3rkxE/Id1BDq+/fEf+
 cynHkrUY2kX+v/rs+63wLl8ZWAg+gL0fa/6l2nGqaXcZC4Igp316QW61Vh65vMLNMWispE6V1+c
 WWyjMvJPX1ngw+4rEbA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a2004 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=hoYYr1_72z9RSZTYHFsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX1P0BJOz2OnP1
 /bCxdqANbHIlwvtsLoIXAqyIkt6QBbS4JGGsXo9SsW5loSYxZ3Rvs3l3nKCc0J8m12Ba47Qe4ic
 zluFqZIQP0D+/Stj4EVcNPuGdCHxYo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

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
 drivers/s390/crypto/zcrypt_msgtype6.c | 124 +++++++++++++++++++-------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index c4b5d9b85f7a..da7580933c6f 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/unaligned.h>
 
 #include "ap_bus.h"
 #include "zcrypt_api.h"
@@ -1223,6 +1224,28 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
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
@@ -1235,51 +1258,90 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
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


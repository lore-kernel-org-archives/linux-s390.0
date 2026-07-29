Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94F442B1A
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318808; cv=none; b=hEHvK0iLBOjtl2hRBVdmUfqT+hAb7OsJ9LchpMKBD2DE0fylcJibyOcvl4Lzdm393us/8we8+ptFPJVVN03m2JzvzFyO9IAY/a5Pjla3Mm8CjmeHgp3S/iBXrlvYUeWBFEJKj1tOdyPuKlWDbytxiOLQMg6aObhooDeHf1fCZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318808; c=relaxed/simple;
	bh=DrqwnQ6QcT2064zgYE5LX90cwTSM+iQArHx2wnJwBV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOSaNJg7EYEB9SCNjLwiLv1a4qi0tqkV7hmGF9JWlkA0ioeR0taznyQfNj1WkK08d4EOtTPw3DaLC0HPiHFUmqGSUvR5qkAkKb8SFoGTcwc67+aVKgV3WquNYwlyqD8ESB15tkYN3fEUHydROEjgNaxzr3SoAz/AJA/rAqduTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EUXD7GlB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EUXD7GlB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7llcN3506373
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GqsPS7aNJOq8AsbDy
	/nNbvKk7Y70bQOmNWt+24eJ8+E=; b=EUXD7GlB12aDG3jDD9IigjCM1QA4EpWxl
	kTaRwp3FZ9VcL7J4ai+8jLoN64SLAQ7b5i7NLIUWkVxE/kGJ5JSsfj6IhE9NDGnR
	pqmLz+lV6KYQEd6PiX4QRGc1rYZc41tk7JheTigWCvKVggOEdLEFrr5oJu9hzSJn
	DamqHeIMqIo+Cs85lLOqr5/MmaEIuVoZugRghI1cjBaU0llWZsRxxCQ4uluZW/LF
	8aKZdxK4C8H1ohv+Neoq593DSARSG7GgOXR9/uMks8R+kxFew5c5VHpHdjsopF2z
	z1OYl/icx9ZWsPwT7EjHqp1FxLlMTDDrIfsPBZdlWrcFWnvtPMNEg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj98ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9fG6W017316
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgdxnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 09:53:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T9rKgk32702886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 09:53:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9AC42004B;
	Wed, 29 Jul 2026 09:53:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 860B82004E;
	Wed, 29 Jul 2026 09:53:20 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 09:53:20 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v7 4/5] s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
Date: Wed, 29 Jul 2026 11:53:17 +0200
Message-ID: <20260729095318.184141-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729095318.184141-1-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX56Xrr4Im7sV3
 wXyeAprcxMXE8VavjjCJv6fH1+BilO91L+PuDurX9EMbJggurMMw496p53x/kvYpus4xpHDu58c
 PLkbNQMPeoqKy2jXijFwCPVUutiGvek=
X-Proofpoint-GUID: EDiAKL8-nRCPH3LxaaVWUV1R9oPWuj8N
X-Proofpoint-ORIG-GUID: EDiAKL8-nRCPH3LxaaVWUV1R9oPWuj8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX/p34KaZqspPC
 n6aD6fSRdtmHJZ4e2/Ia74ZHQ04BNI/cxfbokKA1sbenxY9OALuC6PZ8+y9d5YA5F9IRut8a6CC
 k1bVN03z1PveIbDUsFn5Q7pNUStuYF7/2QPpi/arijMsdsPS6W3iCC59F0amLbbAz6fEaKCG5aT
 zdoJCcDrxM61NXGef3H0iwg6Z2TS/8EyataMvj9Ovr44v4lsM/+AWZ+N3Yp81yXSN8aKhKE95Ca
 uvWJuZJZdoG8eb8uaS6RsS+eJ9k8zfcuXAMJlsrAVbgxNOZQpmINOqeFuomNys2au4+hN4tJBjf
 3FM77RdUEcUwXiDaeL1a9Ly1+Qn0mqmRcib+VutsmBQ0NcO01QmPkvgemQkmxAis9ZVry8pF6BV
 usktR8IobUQrO4InTMdLC+Xg0QO5JYvNxz5HdFVEYsXPBUl0LrYf9QouB8h4LyPSYQG8rpUSTUO
 Ug+7N2nVdU+62p8E2uw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69cd95 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=hoYYr1_72z9RSZTYHFsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290080

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


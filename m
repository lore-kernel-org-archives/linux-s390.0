Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2443CEF5
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420916; cv=none; b=tm/WsHWcCLWYp/iwBW+XsZLgQ4ZYAWG2Wdm9daqdLS6XpkjzH4hVPwB6Co1ky9Cf2gmM0ryvsI+gnLEQlctrhwHIxK2OvmUmwTlBx2vECSceXr5U60ijn4rENBZkziRRY94pf5r6XM6GqYKZY4heC09qk3DM9DYHgmi0jwEZssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420916; c=relaxed/simple;
	bh=uAo4p4WvTvwnoQoIOXJ7v2iJUCTcnhlmN4Dn45vTl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBzQgXfRmcZ5V7Pn/QVDUUOuSgf7qS90zdbsFpnPSMZP4Jq4QTn16ffiu7fKECSyemUmygLycvQGavHtKGJsuGmO8bEkTrZU/v0WQjsbAA8LnJSo/tXtQEOdwY8f3qDgDI0WjAU324y72yF1FO46/9EBG5ESFDhWcouOzEZ92OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cBtftntp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cBtftntp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDI9173022251
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PNGDqPZGiPmKnmf8j
	rbRdpBz7uRQq5MJSWwy0AuuHk0=; b=cBtftntpvZku15RSckVTtnrj09mGojGav
	yqgZaauO7gwt4izi/Xg7V6Iwot+HkvZnfX8IYwdgNi+20vcvoMaC8QoOyotwgAZC
	Y9r9co+umpm/bRkqcRsjJyyG7gHkCko3Z4fkhUlr6jMJSqV7+3zMVhjRd9T6t/Fc
	KOLFplD0zb+Bck6f0fOidfyru2C9pjoqpgKrVoatxEyIcyW9QIw2YfXK9TBSDuez
	sLgRi7kQAZj/gkckVg+Aj3156Rf6H0vpSfJW3IXF6GPxwPPoPwAMLmVsOP7oD8s+
	oFRaeM6E9bxseZ799nAcoAouMgcgc6emcnz1KSfm1Sgftf6LOr/sA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ny97k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEBLGs011782
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ybdxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:15:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEF9B047907232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:15:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E041C2004E;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB3262004B;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.145.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:15:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v10 3/5] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Thu, 30 Jul 2026 16:15:07 +0200
Message-ID: <20260730141509.205970-4-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX25nFR5QV8xC+
 JJ4eiyl9f1EENh4i2Oq6ZzdsVXBAjFTWLBA2otlIeMLCSCTYT+gSdrWnWiHAKnlhGvzR7Rmkz1y
 OF+g5DqsJKuq54WF7N8ZdfKv6ZD1nxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX2Espndx8cgvl
 Y80NU4JwAVA98qNLpb82TJZO6YSKley12HtEvHkohAaBR0ArZb6BSosDgHhCADAlhH4uuIae9nj
 SP+VR6eFm+daLN1qovKBJDyCFKTl5ZVnaIr+hh9pXcVcsj9yW429089T6lqr8LlNrwKf6spvVpw
 /D8+ON3cXXey/DgpwhFMvNf5cwXUvkwZcGM17NtCMoY5ro4axz0Wa56Y5YnEF7nCHkRwrV3rf1i
 XbTl8xDxpbfEXfo8+x/RqcfYZ1M6029iBf/pS/TGvT6j5cfVwqbY0KpophkzQKNIPB2VhNv7eJY
 IiMc+m0Sne8CrVvUK+JUeaFNi5i2Hhr+j9L4kr170+XBYyyY8n5LU2jl7tD+6FQtaX4/cUbAKVD
 QAPmyOtXQMJZvdaxM5GqhXmsTY20gyn1Cdl5S3feevwPGLYP4wYUlW+rE6ytTcGU9htCJBvbkzB
 BuKsX98T1xWG7rYH9kQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b5c71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=UcxJCmR-suVRDkBv_WQA:9
X-Proofpoint-GUID: 5DnUQBMAAVibAOcTfArFwDhZv40zWrpP
X-Proofpoint-ORIG-GUID: 5DnUQBMAAVibAOcTfArFwDhZv40zWrpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300105

The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
validation, creating security vulnerabilities:
1. Missing minimum size validation: The ep11_cprb structure and
   subsequent payload fields (pld_tag, pld_lenfmt) are copied from
   userspace without verifying sufficient buffer length.
2. Arithmetic overflow in length calculations: CEIL4 alignment could
   overflow, bypassing size checks and enabling buffer overflows.
3. The payload is asn1 encoded but the function just uses a simple c
   struct overlay to access some fields of the payload.

Fix by using size_t for length calculations, adding U32_MAX boundary
checks after alignment, and validating minimum request size and
minimum reply size before copying from userspace. Do a very simple
asn1 parsing of the payload up to the function value field.

Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.1+
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 152 +++++++++++++++++++-------
 1 file changed, 113 insertions(+), 39 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index fb37e28c8242..c351ead03072 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/unaligned.h>
 
 #include "ap_bus.h"
 #include "zcrypt_api.h"
@@ -34,6 +35,9 @@
 #define CEXXC_RESPONSE_TYPE_XCRB 1
 #define CEXXC_RESPONSE_TYPE_EP11 2
 
+/* smallest possible EP11 payload size */
+#define MIN_EP11_PAYLOAD_SIZE 5
+
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("Cryptographic Coprocessor (message type 6), " \
 		   "Copyright IBM Corp. 2001, 2023");
@@ -439,12 +443,59 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	return 0;
 }
 
+/*
+ * Simple asn1 int reader/decoder helper function
+ * Returns number of bytes processed or < 0 on failure
+ * Only accepts int length values of 1, 2 or 4.
+ */
+static inline int asn1_int_decode(const u8 *buf, size_t intlen, u32 *u)
+{
+	switch (intlen) {
+	case 1:
+		*u = (u32)(*buf);
+		return 1;
+	case 2:
+		*u = (u32)get_unaligned_be16(buf);
+		return 2;
+	case 4:
+		*u = (u32)get_unaligned_be32(buf);
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Simple asn1 length parse helper function
+ * Returns number of bytes processed or < 0 on failure
+ * Only accepts length encoded within the length octet
+ * or for long form 1, 2 or 4 octet length bytes.
+ */
+static inline int asn1_length_decode(const u8 *buf, size_t buflen, u32 *u)
+{
+	int i;
+
+	if (buflen < 1)
+		return -EINVAL;
+
+	if (*buf < 128) {
+		*u = (u32)(*buf & 0x7F);
+		return 1;
+	}
+
+	i = *buf & 0x7F;
+	if (--buflen < i)
+		return -EINVAL;
+	i = asn1_int_decode(++buf, i, u);
+
+	return i < 0 ? i : i + 1;
+}
+
 static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap_msg,
 					   struct ep11_urb *xcrb,
 					   unsigned int *fcode,
 					   unsigned int *domain)
 {
-	unsigned int lfmt;
 	static struct type6_hdr static_type6_ep11_hdr = {
 		.type		=  0x06,
 		.rqid		= {0x00, 0x01},
@@ -456,34 +507,32 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 	struct {
 		struct type6_hdr hdr;
 		union {
-			struct {
-				struct ep11_cprb cprbx;
-				unsigned char pld_tag;    /* fixed value 0x30 */
-				unsigned char pld_lenfmt; /* length format */
-			} __packed;
+			struct ep11_cprb cprbx;
 			DECLARE_FLEX_ARRAY(u8, userdata);
 		};
 	} __packed * msg = ap_msg->msg;
 
-	struct pld_hdr {
-		unsigned char	func_tag;	/* fixed value 0x4 */
-		unsigned char	func_len;	/* fixed value 0x4 */
-		unsigned int	func_val;	/* function ID	   */
-		unsigned char	dom_tag;	/* fixed value 0x4 */
-		unsigned char	dom_len;	/* fixed value 0x4 */
-		unsigned int	dom_val;	/* domain id	   */
-	} __packed * payload_hdr = NULL;
-
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
+	size_t req_len, rep_len, pld_len;
+	unsigned char *pld;
+	int offs = 0, i;
+	unsigned int u;
 
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
+	/* request length and overflow checks */
+	if (xcrb->req_len < sizeof(struct ep11_cprb) + MIN_EP11_PAYLOAD_SIZE)
+		return -EINVAL;
+	req_len = CEIL4(xcrb->req_len);
+	if (req_len < xcrb->req_len || req_len > U32_MAX)
+		return -EINVAL;
+	ap_msg->len = sizeof(struct type6_hdr) + req_len;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
 
-	if (CEIL4(xcrb->resp_len) < xcrb->resp_len)
-		return -EINVAL; /* overflow after alignment*/
+	/* reply length and overflow checks */
+	if (xcrb->resp_len < sizeof(struct ep11_cprb))
+		return -EINVAL;
+	rep_len = CEIL4(xcrb->resp_len);
+	if (rep_len < xcrb->resp_len || rep_len > U32_MAX)
+		return -EINVAL;
 
 	/* prepare type6 header */
 	msg->hdr = static_type6_ep11_hdr;
@@ -492,26 +541,51 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 
 	/* Import CPRB data from the ioctl input parameter */
 	if (z_copy_from_user(userspace, msg->userdata,
-			     (char __force __user *)xcrb->req, xcrb->req_len)) {
+			     (char __force __user *)xcrb->req, xcrb->req_len))
 		return -EFAULT;
-	}
 
-	if ((msg->pld_lenfmt & 0x80) == 0x80) { /*ext.len.fmt 2 or 3*/
-		switch (msg->pld_lenfmt & 0x03) {
-		case 1:
-			lfmt = 2;
-			break;
-		case 2:
-			lfmt = 3;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		lfmt = 1; /* length format #1 */
-	}
-	payload_hdr = (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
-	*fcode = payload_hdr->func_val & 0xFFFF;
+	pld = msg->userdata + sizeof(struct ep11_cprb);
+	pld_len = msg->cprbx.payload_len;
+	if (pld_len != xcrb->req_len - sizeof(struct ep11_cprb))
+		return -EINVAL;
+	/*
+	 * At this point pld_len is always >= MIN_EP11_PAYLOAD_SIZE
+	 * and the smallest supported asn1 payload is:
+	 *   payload tag (1 octet)
+	 *   payload length (1-5 octets)
+	 *   function tag (1 octet)
+	 *   function length (1-5 octets)
+	 *   function value (1-4 octets)
+	 */
+
+	/* payload tag */
+	if (pld[offs++] != 0x30)
+		return -EINVAL;
+	/* payload length field */
+	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	if (offs > pld_len || u > pld_len - offs)
+		return -EINVAL;
+	/* function tag */
+	if (pld[offs++] != 0x04)
+		return -EINVAL;
+	/* function length */
+	if (offs > pld_len)
+		return -EINVAL;
+	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	if (offs > pld_len || u > pld_len - offs)
+		return -EINVAL;
+	/* function value */
+	i = asn1_int_decode(pld + offs, u, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	*fcode = 0xFFFF & u;
 
 	/* enable special processing based on the cprbs flags special bit */
 	if (msg->cprbx.flags & 0x20)
-- 
2.43.0


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4D3D669E
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335977; cv=none; b=ZNFJoaOFUH7gqytnHvP5A5RILzqXuvvtAplgoZlXpHMaULUkMxrSrh/H6BV70me6DyrZ6Nz/iq+g23vTzoEFJQq5/Io7/QxFCVaYNNJV/FbFjo4Tq9wQEXKGjgm8AM6pueHVoWfCKV8tTKWm3LaEvseSbjXkWn6/qPgMEFc2O+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335977; c=relaxed/simple;
	bh=yOQbVXLiWg5puHkKagRHFnqtkLI5ByA+hKn4f0G19VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQJw+d2Odlrg8cNQJbVY4hl620g2f8VHfr+kBGYXJkhWkRmzedD1iKv0S579qEUWWjnaa7BUfuWJGFneBt6tkRitFwzjmsvWs0tQn+cvhIU7VHUPb60mWkvCQdFrNDDCJuVudjYDsX/Y4xQcBLs6Yg9QlfYtfLeD16kXKEk5gZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pCIr0Smc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pCIr0Smc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDI6pf2424238
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZuorcClAMOCj5p3vd
	buAdJcxEK+sJ/f6kvFLQsEUAxc=; b=pCIr0SmchgzKwpS+hPex6LlYhcnujas65
	wGEo07u7egRMKiYpYjW8tPA7WHEqf4dNqahK2mnyMD7mgTcS0DNoZ1efEsS8KlL5
	OQsSqrHZALJBISI//JNpfN1xoP5HB9ymnRUtzzS/hqr3nips1Prkf03yrTKcbFjL
	/L+otqzH464UNlCOHMTYP97WDbBIgnJ+YeNHWiHsopNYM8JnZW7VJbvEbkYTz64i
	52zCtRvDRqwQpApivfecGIIOf2oCZhsJtQzqOvM5K7Yc/0UZlb6rAWQ8Vwx67bjJ
	xl41DsE8aiLqIHVO5f08VMqXiPjV5h1LUgjpLjOnBeSmSf3a6T82w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyck4dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEQcZE022083
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw77qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:39:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEdTS633489192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:39:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A30420040;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 463922004D;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:39:29 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v8 3/5] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Wed, 29 Jul 2026 16:39:26 +0200
Message-ID: <20260729143928.191969-4-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PX2q9NcZ8vIRNIvMOYi_zC2b6K_x2n9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfXw2+i2kxO/mU4
 BCMRg6/6TQaLoOxBeYanmtTQ8UyABYpnHdGs6lBB92irdGRAmdDsNjyMDNf2iXpK1Nme5zzfvvc
 dD82eq1GcDKZS8TWFj+hHwHH8Dsq4YpjZwdEnGUdefwhpeltfjrFB8+hNcanJ6UlQGy6WsNAnkf
 EtxE/tNKV2y+5rqeT3Zh+7UYjb/ELxPPy2wZEMBq08MbA8CWQ23DYVWWpdr1g2V80CmoPjALJs0
 3J6EmwuT2KzF2NnEj+EI54d/2ejjEhRJu9cUQswnjP1fxFYa74HlBXm/iawAaH+jizIlvy7ut18
 nqd0cVY1k/K2/PChwcu5RhLuPAELAhqnNU13t74PGwqsc5YITwl50kfMsd+3E4gN+bz6W+4uGJg
 pdBCmu6BaGxprqV7qqrT2JoBseIRUmW/noLX7WAi7jsSC3E8Tju/lRi1QJZvXujcQrgoo0cGd1P
 gCg6qnr3kC26A2oJfzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNyBTYWx0ZWRfXxoAwSdFKIqTk
 aYXM3ACFmg8meVAulrERB3pNIsypaDo3ndIS5z4dMuj5umkIwjr3lAX6u8Eoo5iKnBTuelxQ9En
 uqhd7lcULZBAWWN0YH5ayKXc2zOI14Q=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a10a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Q_BBhMjZiOGXkBpcGJEA:9
X-Proofpoint-GUID: PX2q9NcZ8vIRNIvMOYi_zC2b6K_x2n9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290117

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

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 148 +++++++++++++++++++-------
 1 file changed, 109 insertions(+), 39 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index fb37e28c8242..c4b5d9b85f7a 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -439,12 +439,61 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
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
+		*u = (u32)(*((u8 *)buf));
+		return 1;
+	case 2:
+		*u = (u32)be16_to_cpup((u16 *)buf);
+		return 2;
+	case 4:
+		*u = (u32)be32_to_cpup((u32 *)buf);
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
+	static const size_t min_pld_size = 5 * sizeof(unsigned char);
+
 	static struct type6_hdr static_type6_ep11_hdr = {
 		.type		=  0x06,
 		.rqid		= {0x00, 0x01},
@@ -456,34 +505,32 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
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
+	if (xcrb->req_len < sizeof(struct ep11_cprb) + min_pld_size)
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
@@ -492,26 +539,49 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 
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
+	 * At this point pld_len is always >= min_pld_size
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
+	if (u > pld_len - offs)
+		return -EINVAL;
+	/* function tag */
+	if (pld[offs++] != 0x04)
+		return -EINVAL;
+	/* function length */
+	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	if (u > pld_len - offs)
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


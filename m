Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83F3AAF7F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339908; cv=none; b=XcQGNDUVh5juzzMjFaEIEE31A9VnI+tRnIcilL44C0iPdcy0NRv5pOdQgZdoDAs308PInWKX5XII6oXcYTGRCiA0AE7ZpbKkQ8UhM7RQNL7YmVkw0tvh1ofl4HnWnpAUAn93yd50x+DEsGIoglPuHjNyLAc/zD+UQq0ASZq3JtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339908; c=relaxed/simple;
	bh=yOQbVXLiWg5puHkKagRHFnqtkLI5ByA+hKn4f0G19VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm8giCVf9isjbhrqbNNVo3QeX8IcUpdbm/Xd8MY/U8w6ejnSRpUSptJL1Oy5Y8XFbo3VEddtBV9WQIt5FvOy3sDJLF8hL6WoIHWHQPHsdSHcq0lW6dA4zSiXlq1XHeqzNcellv9TEtHna435k4QrPEUG5sXg0j4jyH1JwUCL6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iSH9Otn6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iSH9Otn6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHnvH356419
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZuorcClAMOCj5p3vd
	buAdJcxEK+sJ/f6kvFLQsEUAxc=; b=iSH9Otn68m/bXR0JD2IX4W4alpCjieFJO
	fueflZ1CkgzBM2eoU+SZ7Wg97dtHBtSGooaBd8uNkMftQ35ml8ivrppBoRTszoW1
	7gzL8KKdE014r/VsNK9VzaOcnmg1YKd9iMJek0YoJewWeP0Gvuf/2rEUKeIKviEV
	uNRkkmtDMqIn25/nx4WR715aC/apCrgRUiOOu9g55VIT+2Np8PIYl6DmkVoXFEkD
	5vQ7lnmD1pnISebGJzORNHk6Jevu5GMEkxJctam1+kt7rk8gm4N4vb0hw7B8roxQ
	BhdgLi1MnLgd4EzNUtUFOUTtDvfgGXmUyRkLB04EjDY1mTsZDiUzw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7kfb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfefG004088
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk7bbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 15:45:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFj0qH27984252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:45:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BF222004B;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CAF20043;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:45:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v9 3/5] s390/zcrypt: Improve EP11 CPRB length and overflow checks
Date: Wed, 29 Jul 2026 17:44:56 +0200
Message-ID: <20260729154458.195135-4-freude@linux.ibm.com>
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
X-Proofpoint-GUID: 8PIYGBt_vbgUz81ZeA51CHapVBj1FTQj
X-Proofpoint-ORIG-GUID: 8PIYGBt_vbgUz81ZeA51CHapVBj1FTQj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX+YCBq1+6ALfd
 4VCgQ8Sw118FvreozmKElBq7MHkd5m8IsVQrCWQPySfS/kdB6iRG72zUcOlDL88BpbOxQDthzkl
 iQS1Z+VoHuJgdgvVTqFn0092wi10IKUYBsFWxpG4m/M+wEdlbUJ3sDicYHxqPoYoVnrKWG1I46M
 fSQNmU1u2Q6THRJO1dBZQY6DQnX22seGjjuSI4vfgmpydyDrk4ZRkPp+WBuLD8SJsEcumNhWaz9
 enlf1mlGm680yBJ70tW2LCJux/wjcrwrLL1ce+ZEpTxxFeZos+piPQmK2mGC4pcysCq+7RyUj1/
 dnIL0R1AgFW+Efipv1EM9T+tOyuPrlK9pkKa1lrS8MBdloWWXkOS+J2va2o4lE9hxbgPNkFeY2l
 Fl7/rEK4fyPCNy+N8tQBKRD88TO2jp72Ekm9dx0KHxe1LImiTnMs0ZGvtKdIRRTQ92lXQtqwPvW
 u/vDpTPkIGBwBORQmAw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a2001 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Q_BBhMjZiOGXkBpcGJEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXzLuqSQeo2euN
 OBDwBJ6kSTkKSqSQ8i00ahsncO+JU+MHdJa8SAJynZrZis8EeuWv0aILKpxdgUsI+Xkh11w8RXn
 ikqLBI/tPQucyUR28xfz7L4Vf1Jkr/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

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


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302E376A1D
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210024; cv=none; b=mKylOMYSZbJFEyX1a1vhVdMs6OUm17ERrQdielEgY6nlMaiR70yS/PhgPTqppnO02ZawBr23klzEy2Ch1ex22HgzBfpgKtEAxptoF7XCjKC5yr2jwMTLo5FAD+6Xr3K7wATdpixjvEn4J9u+C6gDjC3MUhwuzvtymVT9VCxvDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210024; c=relaxed/simple;
	bh=80qRhJeHl4e+0YOkTwUixPloAYjgbwKL7FIB0CIgUB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKUT6WbcKU1e0WKwwof02l+yHGihZ3lrWrSKqFRLsYE5UzgoMQgG2LEtiCdmpJ845n9OOeWeCbQ9RsVmnxKgRv51iB9FdmwclFNyp498fDwQefJg+0/m+h2W1ggXd3iBLKlhshEwpbPJ1KVHbaFN/WyJtX9sYuUK64Ws+QFWLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YmxXenwe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YmxXenwe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mRg01105198
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6C4NIDp66ytFrJJMg
	3nsQTCSd7ZTznw2PwmNfJtOi+w=; b=YmxXenweRdSmLWmDjIFGznsTy0v10cL5X
	D7MXevH9N9ncFqlTyWZFZZ5vX9bB6OgLKTJ7x+p8U7OvFohSZTNXwfZmhAx17veX
	cLcCu9BtsU38j7+kNfspwPnzFOnGzFv7JQuR5nfaNQquVaX4lSF6KYwqePni+bJO
	lTofMGJwB73o9QDNGIW+dQeaCpXhheZ2LkCM8SHk2t+t1PdsMP8I9uX0ARbAhrpx
	S6D5nIndj/MpjVL3f7INewVOTC/wkQYLIohhraD6ARTWeSnp4Le7vVhnhbJ7+tiS
	Fwc5GVj7Q6B3qr5Op2YBMGNXNSvu/7qnKkXG+/Mme8/SjVtXcnIUw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hp542-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NAJfwJ012917
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k2qkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 10:20:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NAKH5J50004284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 10:20:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE3A20040;
	Tue, 23 Jun 2026 10:20:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318BC2004B;
	Tue, 23 Jun 2026 10:20:17 +0000 (GMT)
Received: from ibm.com (unknown [9.111.90.150])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 10:20:17 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 1/1] pkey: Fix for PKEY_VERIFYPROTK iotl
Date: Tue, 23 Jun 2026 12:20:16 +0200
Message-ID: <20260623102016.3930343-2-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623102016.3930343-1-dengler@linux.ibm.com>
References: <20260623102016.3930343-1-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3_y7q5pk1MNLh-dWUsisCjKLDzWzALxe
X-Proofpoint-GUID: 3_y7q5pk1MNLh-dWUsisCjKLDzWzALxe
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a5de6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qyl3c23n3BZc0HQdqekA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX4F6OkkMauFhb
 myCa8x4PSrhAU0uOtvhbP8n6Laaexzoqsl84G9jwpfphts8V1noDQMOIj2SUaxco5vrC21Ke4Pl
 xuatVOjiGrfMW8qUKchRFD5gnGWS+Lf39UsKn6HXZRJJto5/w7CMVhW3rZz+tEI2N55X7Tvj/Oo
 u4pJg6800qH67nbTjelgowDigmp035u+ukPCPIE0xJeRBsPWy/Wmv2u2ecqWvjb2bXPHZHrD3SS
 9fBLNLhC+jPaU6KvbkpU1hqhDA+x4qh5TEisBZ1TtheRmRkXMGVVCsrQx7Xf8bd5F49maFBsH4X
 UFjFQj7pJzgqoAR/Z2W1hkP1+D4A/o6SAgdUXgR9flV3veZeiir2/qdGkzO8Wt7ndNxcWJIFf36
 reZY7EGHWGHiRJfNckKKyrzdPT0ZElTUfBayghMrm/xPwXHx4qofCII14oJbFK1iPfQ8VU5XK6W
 X7vLv1zqypXQce6KAEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX+6urDpMJu3Un
 NGeZAS4pvokwVTZxs6/O1OAYSMel/67I2B4WNiHnLJmUoZyXif9g4SNYR9CFAdic7bWC+pPlNea
 OitlhGXggc2exh8FdIGNjvpNNrAREwo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230083

Remove the keytype calculation based on key length. The verification,
including the keytype check, is the responsibility of the pkey
handler.

The removal also fixes a bug in the key-length calculation, which is
now no longer required.

Cc: stable@kernel.org # 6.12+
Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_api.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 28e1007005f2..5d8f63f390a8 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -327,7 +327,6 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 {
 	struct pkey_verifyprotk kvp;
 	struct protaeskeytoken *t;
-	u32 keytype;
 	u8 *tmpbuf;
 	int rc;
 
@@ -341,14 +340,6 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 		return -EINVAL;
 	}
 
-	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
-	if (!keytype) {
-		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
-			     __func__, kvp.protkey.len);
-		memzero_explicit(&kvp, sizeof(kvp));
-		return -EINVAL;
-	}
-
 	/* build a 'protected key token' from the raw protected key */
 	tmpbuf = kzalloc(sizeof(*t), GFP_KERNEL);
 	if (!tmpbuf) {
@@ -358,7 +349,7 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 	t = (struct protaeskeytoken *)tmpbuf;
 	t->type = TOKTYPE_NON_CCA;
 	t->version = TOKVER_PROTECTED_KEY;
-	t->keytype = keytype;
+	t->keytype = kvp.protkey.type;
 	t->len = kvp.protkey.len;
 	memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);
 
-- 
2.54.0


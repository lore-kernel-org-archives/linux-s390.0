Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9581310777
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333710; cv=none; b=EJcBge20D1WpUKkzcM4AcEHtNs6XuMrNoUrYRiDINN1/CEG/J/odXHiBcltOLxFeQp7fjzZ8DNf5HRD6TZWZEYsodzfkEceR/vAqvk4MwQ0A46tmHIM6Twy0tIOe7PKQ0UhUkXo6j9cF9iuQaPIc0XAY3Y8XWbtsRME50OM9pSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333710; c=relaxed/simple;
	bh=jsruzfWFc/O4Fe/qV/wAQPefBn200844YZ4z72VGw00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNUr5Byp8l9OHHtNNSaZ+ffsqmCBED0x0TluOxTOy80FSRLkyZDhYvhRjPcbXiJNPeJdEczyNHXrT8p1HMzenL5rY4lD/OSlL4eynC0IDUx6MJ4C7JeoK5pfgM4O59c8SNv1s4uOQEjN8OARo4EgsswODfgXHq/NlrOv43rWQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DBsuXvkM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DBsuXvkM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDI58J022517
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tL1oYNQpEYeIZu9XA
	wZbWhWaZVMFEIiDSmPATj292eQ=; b=DBsuXvkMx7320U0kVU7IEn4WUFC3wxPkR
	NBSH9lPJw9dFPUBr1febqNAdej53hNyUDc73lWXygKaVwugIFmRnaeV7uxdJt63v
	I2e68ap004c6lxlraoVETgAoZg5AkwvRGfoVnwj8CGfhSEBoGv+2BBFB26FSyuYa
	1JXguXhpCRW6e3+xw3Ik9l9xfvdINMK7M2hpZSCMg5PtenMkTbSsJlzrq99Zbpld
	wmURmwk1U2J628cNj2ecWxjWM+g4CxuyhoXHNxRXhZ/1lePfqgBJI1O8WNYtGT3k
	LAoMiiCZiZnSKzk/bkwEftFgh0EBeJu6glrP+ZqYjam6wjoL5/sSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nt7ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TDuPgJ018210
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw73j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 14:01:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TE1Z6k33882612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:01:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56CA20043;
	Wed, 29 Jul 2026 14:01:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE112004B;
	Wed, 29 Jul 2026 14:01:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.165.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:01:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 1/1] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Wed, 29 Jul 2026 16:01:34 +0200
Message-ID: <20260729140134.191448-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729140134.191448-1-freude@linux.ibm.com>
References: <20260729140134.191448-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX+NN5Hxb7+jul
 Hivj4Q+n6D7rmp/iL8KRSdULdx9vXLPvlr5rQGmRet+yw3pyuYV3Wm52yUBTSx7R4Lpr4RFYw70
 BNUleLhDWCWHlHuE1HWEoICz2/q/hPM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX+g2hnGVYqpD7
 HGdStdQIKbsQeJa9/hrRA37BgiaOEVch5qdmhb2k5KOxJhQnvbhOnXdGWTLdj+8Fa2kS841RflH
 /v8+OeO4fcTnwz4cxwXYyXrOxh2GT1cATMO4uVABs5bjvPSF+sW4sImajRgSGvaonNELK74k+MB
 btT+UmuDjNjlBMO9pn++SLxyN7laBJSKr8kx+qSH53sNshQIhWk/KomRM4GmTV2YRZjWyJdA4ua
 2y0tKZpHmTH62WnvJ1NmMCp8lzP4YzoPD8RKbfEZrvbuIkE9nS0TnUX39F+gla0kg4GenyPSG7A
 3WMmNF6W0Lt3Lj8PKABINXxJUgqU+c3GdgSgisy1q9+gTCpOlQKl/kjxp/jW+G9+5RVEXoiCvjE
 pzW1MF7mj37kcqfZZvogf6W0O04c3Q==
X-Proofpoint-GUID: 5Cy2G41F8nQGN4Gw58BN3fNKwAi2O2oZ
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a07c4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l_XADsiG0JAIV5gd_FcA:9
X-Proofpoint-ORIG-GUID: 5Cy2G41F8nQGN4Gw58BN3fNKwAi2O2oZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607290114

The helper function _ip_cprb_helper() uses internal buffer memory for
building and processing CPRBs. After use this buffer was never
scrubbed which could lead to leaving for example clear key material in
memory which could be exposed via tricky reuse of this same memory.

Extent the _ip_cprb_helper() function with another parameter 'scrub'
used to steer scrubbing of this buffer. So now the caller has the
opportunity to decide if scrubbing is needed or not.

Extent the clear key to secure key token import process in function
cca_clr2cipherkey() to tell the helper function from above to scrub
the cprb buffer when the clear key value is part of the request data.

Add explicit scrubbing on return from function cca_clr2cipherkey() for
the random EXOR buffer and the cprb buffer.

Overall this cleans the internal used buffer in case of clear key
import to prevent sensitive data to get exposed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 84936a795b95..9cf268efd4ab 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -971,7 +971,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   int clr_key_bit_size,
 			   u8 *key_token,
 			   int *key_token_size,
-			   u32 xflags)
+			   u32 xflags,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1111,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, false, xflags);
+	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
 	return rc;
 }
 
@@ -1162,28 +1163,32 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize, xflags);
+			     exorbuf, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize, xflags);
+			     clrkey, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize, xflags);
+			     exorbuf, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize, xflags);
+			     NULL, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
@@ -1200,6 +1205,8 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	*keybufsize = tokensize;
 
 out:
+	memzero_explicit(exorbuf, sizeof(exorbuf));
+	memzero_explicit(mem, CPRB_MEMPOOL_ITEM_SIZE);
 	mempool_free(mem, cprb_mempool);
 	return rc;
 }
-- 
2.43.0


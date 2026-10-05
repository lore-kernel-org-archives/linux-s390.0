Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997294052B6
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200425; cv=none; b=VYlSQ7rRHI2rR23+U2GGfgkCD94BGIVPpTwoOtpo8AEhme0gpCOOduCChbQQ3JfcJQVcyM5wrAZv8gA+0k2BisLgIAE9yDLOSIsCDgTp22bYocEd2xdoF26Hg9h1XiLRydDkwB/+8aalhmCRqJxOAqo4Mvh2zUUKk2yM/rKjmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200425; c=relaxed/simple;
	bh=miBV3HgQ8dHwB0y9Wu8rCKU3sUM0Q2NGxnnivOLYA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAjHN/MsDLFVBXBf2248MsBYCLsiowkbVP8oZnvmterYczt1vZB9uBo8uYNMg6bPdUcSZS5GHb6Z48I50quUdN+bJLCzB3HI1mq+wRPY+MCPhMZNm6xyXkm/opfsSE2NcCPaSb2KDiPHtR8z9H2v5zpsDpMsDHkC9muQCJMFeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=poNfvgbE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="poNfvgbE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZeck379171
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 11:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G+tYCDmb3ieiwZmkZ
	s5e/WzVWn10mYhtU0Ip3wArjnU=; b=poNfvgbEJehD4R/yZj3Yi3t/cH5SKEY3N
	3dv5ME2ILzU+br9GGe+HrjZBsykpjNQ4dbrKqOeozCtJ/Se4mHAC1RBoof+tCr3c
	FdGM1H+lLN8kzEZ3A/MceAB+tm0Qbdbdo06R7WI+vM6mnbGoc48HqxJcsjK/GkXr
	EMpn2KtbxvaKT2S+Sj8akgF18FyGh7BGZYepak5oBOLgVko49M2vY3EESZSKErHY
	tO0tnHq0/Q1zBTkJBcjOzIL1ggTGY7LmOcdxPEl8BhGxAAPqbgAsNfeZp1npBL8e
	UMycv5z4cMK9/21WJdNTSyyI4hsDpe9sOxKTDzAO1rrtR2OeBVXpg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jhk9g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 11:40:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWVMi2824116
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 11:40:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jn853-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 11:40:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695BeJgF44630432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 11:40:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07CC620043;
	Mon,  5 Oct 2026 11:40:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA00720063;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.168])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()
Date: Mon,  5 Oct 2026 13:40:18 +0200
Message-ID: <20261005114018.62489-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005114018.62489-1-freude@linux.ibm.com>
References: <20261005114018.62489-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -NQARaofkopYmRo6RbetwUPIaw0l3i-m
X-Proofpoint-GUID: -NQARaofkopYmRo6RbetwUPIaw0l3i-m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX4fi8RaKBs5kG
 LsYr4qnixJOneqMWFF0DTN84bUYqqPpVGoND0F2kuic3JQAcHl9uqvn7TUslaM8hrtjk75nwd3o
 ABgaqVxcQ15I1seoSuxZTfvNS85VPDo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX93J9Lggt7jOx
 bn9OYpH08KvbbA5CsOwAIScA+29lI4jMO95vHTG8Ph+OSaGYW1SFbtyFvv1bSut6JbdReSfhW33
 sRKxqhzryGuwS71Pb74nTkyERrE99VSVTTEOHBGoIAkKXc3B44kI1bPpYpTYUniCWxWhEEZB1KS
 Hm/Co9iyMgQK4EEEMuyanZ+7zP7hKkoRH0a+9K9iyxFVrtCI50gLOXHD4mPrGXPOENEEzF85ASd
 /SuKleO/xw+tsMIl0eSYWe+/Bt3xq99n4HyOdaPG8l44utmkhfDRPiLocj7uwy+w/7Z4xdi1+Pz
 apzL8F19v45LfZitqTqwAf+Vv5Z7pckLvpSxs6Q6qQebdYo0xg+WdraZYfMG1UXGCn02wuW2NWb
 BPdGOHTzA/0LXBFiHDKIQlsUSDJucxstvc87806sfM5/P8GyxBS4Dw4uprDx2B5a+mjS7ISVF7N
 dJ7/IsXESt3Yp/iYMNw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac38ca7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WRuNL78x4yoRP3YN28cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

The FQ reply parser code blindly advanced the walk pointer by a length
value read directly from the hardware reply payload without checking
that the advance stayed within the allocated reply buffer. A corrupt
or malicious device response could push ptr beyond the cprbmem region,
causing an out-of-bounds dereference or kernel memory exposure via the
subsequent memcpy().

Fix this by tracking the remaining reply buffer space in a variable
and validating each device-supplied length field against it before
advancing or dereferencing the pointer.

Fixes: 2004b57cde6b ("s390/zcrypt: code cleanup")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 19909bf43dc9..862947431164 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1627,6 +1627,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 		u8  subfunc_code[2];
 		u8  lvdata[];
 	} __packed * prepparm;
+	size_t datalen;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(parmbsize, &mem,
@@ -1673,27 +1674,44 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prepcblk->rpl_parmb = (u8 __user *)ptr;
 	prepparm = (struct fqrepparm *)ptr;
 	ptr = prepparm->lvdata;
+	datalen = parmbsize - 2 * sizeof(u8);
 
 	/* check and possibly copy reply rule array */
 	len = *((u16 *)ptr);
+	if (len > datalen) {
+		ZCRYPT_DBF_ERR("%s reply rule array len %u exceeds datalen %zu\n",
+			       __func__, len, datalen);
+		rc = -EIO;
+		goto out;
+	}
+	datalen -= sizeof(u16);
+	ptr += sizeof(u16);
 	if (len > sizeof(u16)) {
-		ptr += sizeof(u16);
 		len -= sizeof(u16);
 		if (rarray && rarraylen && *rarraylen > 0) {
 			*rarraylen = (len > *rarraylen ? *rarraylen : len);
 			memcpy(rarray, ptr, *rarraylen);
 		}
+		datalen -= len;
 		ptr += len;
 	}
 	/* check and possible copy reply var array */
 	len = *((u16 *)ptr);
+	if (len > datalen) {
+		ZCRYPT_DBF_ERR("%s reply var array len %u exceeds datalen %zu\n",
+			       __func__, len, datalen);
+		rc = -EIO;
+		goto out;
+	}
+	datalen -= sizeof(u16);
+	ptr += sizeof(u16);
 	if (len > sizeof(u16)) {
-		ptr += sizeof(u16);
 		len -= sizeof(u16);
 		if (varray && varraylen && *varraylen > 0) {
 			*varraylen = (len > *varraylen ? *varraylen : len);
 			memcpy(varray, ptr, *varraylen);
 		}
+		datalen -= len;
 		ptr += len;
 	}
 
-- 
2.43.0


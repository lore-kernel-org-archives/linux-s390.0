Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717149E5E5
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301575; cv=none; b=fepymOqV48izQ4O/lQ7i7mGz+XIK4nI+tjImI1zHNEPEkYOQRQZuPvvsND08Sftv7rMFcDr/r7+A19WtF0itFOamQXjAm3CqrmFsgV9NvYj5GoR7w32yHsWauoGfSf/D6FHiFnhTuL7NgBo6VT7Kpc+Tcce/HQneVngqZshmGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301575; c=relaxed/simple;
	bh=miBV3HgQ8dHwB0y9Wu8rCKU3sUM0Q2NGxnnivOLYA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGvOvS5gt+22n3cqL7lDbOBv0DMGWIq32RRrwWn2Kx267e8i+X4FOqRh3agJ3/qh/oapMJJL5buIKvQll0eKFwwU7+z0X/7rw9C1r0ani8eXNOaTxRIapFPegMBp7avO+U6zqwjW8UR57/KLrZXWGW5FQQO1KF+FeXUVOLLVL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kkEhQQUz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kkEhQQUz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Ea10U2778541
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G+tYCDmb3ieiwZmkZ
	s5e/WzVWn10mYhtU0Ip3wArjnU=; b=kkEhQQUzGlZTm/gEte1rsoCnUFiW6IcDz
	zHXOOp2NniX8tCw8H8awAIO93g3RDS5qmeTQeYaooYcqNegZFBDYVFURywqU4nOS
	uiRCsZ0tqB7E+VRiqhsSseZfyVHKiy3Sz0yx1OG49EA+2MJNlm1Vc7NUxLHWAqOk
	QWqFV+bzRKb0aeqrmxHMshP7UQyz3xgC1HZjSLAncr9ZrVXc4bz7f3tmzWV+xZvq
	HS9e3zEC3lC9PkoE0Kla2VtQIBTvIyneu83jeyBOUYDEhkQrd+0lTqlpgOlwB+3v
	TCJgdeHwuO9yv73SpqDNW3Az3fXI3XJbJ8lC8aBrnBaLGCjPfLJ6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g03m5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:46:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHV5Z387143
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:46:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jtj4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:46:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696Fk4mH39846350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:46:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92DD72004B;
	Tue,  6 Oct 2026 15:46:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24D392004D;
	Tue,  6 Oct 2026 15:46:04 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:46:04 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()
Date: Tue,  6 Oct 2026 17:46:03 +0200
Message-ID: <20261006154603.9699-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006154603.9699-1-freude@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac517c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WRuNL78x4yoRP3YN28cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfXyNg/j7OAB+X/
 W0/rDAPwSOgBq4akuJGdwHi4uZJYSLdnEA83JTa5PmqoWNYqx8xO6C4U+J1ffZrDnhkXZo4Fefy
 UDOZkoTexgkXLJChgJ9OiWXNTle1fvFFmKtQTOCG4i1nrCcTxWty8RJN/e/wz5u5vOVW3eR4UWz
 0y4uy82AT7Yz3s6JdkYf6R97Mgz047+itF/dI0++BerCgV0LZIP6M5nBVnchbA9CFR5HA+2AOWO
 9nycY62x2+mhe3FD1qQEHAxlEbu5AMpYqjOzE7ZpBgtBsJ12z1WSTsxzl/7belzYxqDpgkgoz3f
 kDAR252fbAyVEbhXg17jz33DUu9DU/va5udp6EcB63fRmkeeHHXZ1gX7b8sfyEWK15tmgfqTgJ7
 nxlI9neZCG3JGyINsRnyBR5bV8m6vNJOWz3pHvrDttgQ6vNOp16MFnKpghYH01ACuMLPyA+dgo5
 3FHl4NksWbmKG8De4sw==
X-Proofpoint-GUID: aFn5y9Fp_4Wd53o5dnr2ehz-2MskrvS2
X-Proofpoint-ORIG-GUID: aFn5y9Fp_4Wd53o5dnr2ehz-2MskrvS2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX/FlIZ6aTzmp5
 iHuE8lLnCcdx3VAkpj7UeUbyWvOh/l8OloncldUoH09TqEPu+vbxhehDngdgE4gRLR2gMdssHil
 HLf5Rt+4awLDhy9t2RZICHfvN1Gu6sg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062

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


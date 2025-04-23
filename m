Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7D1F2C44
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403355; cv=none; b=ozFxNOS4AlRs5xO12gCCftiDhEdo6Nb+QNAivnQLfScLYrzyUB6wuKk36sphLc9f3PXp1r4IBQ8sGIMJEagrwAgnDI7ybuQ2SLk5yVprPW43oUnf8eXGa2q3iVCQg7g7n6gWMMpnRmLhYBeHMNna/I0G/9gWeJjRMImnAgWOy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403355; c=relaxed/simple;
	bh=bUjmygEbaKVCAdim7d7RDKelyqhAlf4DfbQvbK8Sp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oePk30K1s2xIoMJQSeu4p8Ima4k4SD1bNhwAl5O4iu211BMC+5xelhFYUfUOKosdiXS/zt8pax8cTim88WlPOx33WZjLe2jC6nFuAsmUL7dCBJ43QoQPFH3MXdozym9MEmMYRQEB5Jx/gSIFmOEKzfECY3gUwcGO70x4G4Yuacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=akPKbK3H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="akPKbK3H"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fkxm024575;
	Wed, 23 Apr 2025 10:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sxPYmdP8dEfnJ6gwk
	+Hs3YHDgbG5KiDXMF2Rh8hmguo=; b=akPKbK3HsAQ89v6VjfQhyNi/9Ac1ePwBm
	Kfsz74LbPeY1wkjLcitPvjwpzb9ysHFTxwugJIq0whCYSl9WWrQVjcWS6g0eeWmV
	NxU8SGk7hgv40itzBPQP4Ptx/IZd/2NO9N9E92VZUWdSE/5lvpxvWFxE7HK0dU5d
	LGrExhGlmWInA6fzNVfAINuVzCxDKDnhwhFYUcwvBxUipTDDtwQG+GNNkQ7CgHr1
	Q+GMKe973XsqMs8UJ1F8aErDUGhLMWuiHFsJQxHPjH0cYoD/rm9x9N7w0ViOHF14
	esyyYN9jxODwe1Ua3CXGEC2a1UymHP/UbKYuJRMgX0aGH/BT+po1Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466k77jkw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6T9hU008557;
	Wed, 23 Apr 2025 10:15:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxjhca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFlQR17957342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B8702004D;
	Wed, 23 Apr 2025 10:15:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3C1C20049;
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:46 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 19/25] s390/pkey: Rework CCA pkey handler to use stack for small memory allocs
Date: Wed, 23 Apr 2025 12:15:28 +0200
Message-ID: <20250423101535.143137-20-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FYEGPKOFY3-CuzJ0G3F-_TiBQ4ffpKfl
X-Authority-Analysis: v=2.4 cv=TNdFS0la c=1 sm=1 tr=0 ts=6808bdd7 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=tcbCEGChaADSxsZLY-kA:9
X-Proofpoint-GUID: FYEGPKOFY3-CuzJ0G3F-_TiBQ4ffpKfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX+63kIPn8yxAc Iv2D987GUDSJ+eZBIS94ovw1s5qh8N0J1A8TEEx1wTVqcaoSqFKWCVx7GicG6u170ZeTAI3ZIDm rikG8wqtjz2meZQOEisDiGpa6J36K0W12fOtV2Cn7a1OUElOBvZfKKhHO0dWvG+xkjinyn7vxe8
 fcV27Y0FgX8gwVxI96QnhhY+m54KinWhRElMQW+OgK1gY0DVNpwMSHTF2xzVODvyL5khuPVLGgy BSqd3/YZOGe1Qq/rP/jcakvn5IcCz6KPqnX2s60GWd3eESqmw/UrYl97b881TQqsW8Ok0BCBPWX MtvNNr4ARl5ZX/IjZCU7mGCy1dfXF6fXGRoyjttGu8KM+LpLAyAj1Q+52RV/ZC+0cmVkQVOUSK+
 Q5oYyJTT67vn23QGe8wJF5IXHA6vhDo7fccc2A3Tg/iwUslsFsorOG9ptuVwHJYeADOHZr8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

There have been some places in the CCA handler code where relatively
small amounts of memory have been allocated an freed at the end
of the function. This code has been reworked to use the stack instead.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_cca.c | 43 ++++++++--------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index 5b1f4c571c88..6986611fcde5 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -213,7 +213,7 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 			   u8 *protkey, u32 *protkeylen, u32 *protkeytype)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -251,14 +251,10 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = cca_apqns4key(key, keylen, 0, local_apqns, &nr_apqns);
+		rc = cca_apqns4key(key, keylen, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -283,7 +279,6 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -302,7 +297,7 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       u32 keybitsize, u32 flags,
 		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 
 	/* check keytype, subtype, keybitsize */
@@ -338,15 +333,10 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = cca_apqns4type(subtype, NULL, NULL, 0,
-				    local_apqns, &nr_apqns);
+		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -363,7 +353,6 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -383,7 +372,7 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       const u8 *clrkey, u32 clrkeylen,
 		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 
 	/* check keytype, subtype, clrkeylen, keybitsize */
@@ -424,15 +413,10 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = cca_apqns4type(subtype, NULL, NULL, 0,
-				    local_apqns, &nr_apqns);
+		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -449,7 +433,6 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -552,8 +535,8 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 {
 	const struct keytoken_header *hdr = (const struct keytoken_header *)key;
 	const struct clearkeytoken *t = (const struct clearkeytoken *)key;
+	u8 tmpbuf[SECKEYBLOBSIZE]; /* 64 bytes */
 	u32 tmplen, keysize = 0;
-	u8 *tmpbuf;
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -565,11 +548,6 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 	if (!keysize || t->len != keysize)
 		return -EINVAL;
 
-	/* alloc tmp key buffer */
-	tmpbuf = kmalloc(SECKEYBLOBSIZE, GFP_ATOMIC);
-	if (!tmpbuf)
-		return -ENOMEM;
-
 	/* try two times in case of failure */
 	for (i = 0, rc = -ENODEV; i < 2 && rc; i++) {
 		tmplen = SECKEYBLOBSIZE;
@@ -584,7 +562,6 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 		pr_debug("cca_key2protkey()=%d\n", rc);
 	}
 
-	kfree(tmpbuf);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
-- 
2.43.0


Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED421F4615
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403358; cv=none; b=di122+k3PjydhAlphMCBTO6NbMJFRBRGBU5GHTstyBdDLqVNsMclAKAi7G1BhAiyGLCXrThtxHTXCfmeA/rFkkVNNI9ttWWswV4U3WzBXdng5EQEck+Vg0oJVmdUxFqGtGrTcticVx7OArQGEYCzVpqINdqzvRpneMgTDY9MPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403358; c=relaxed/simple;
	bh=M/CihbpymVeG2xsJrPAZyxvn0Dcebo9mOWwj6XQB8Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g78YTQH5Huh7PfuRQkHPJQj1Fv8HJa0l+mqcv3p1bhWIR/CY72806iOzbzkWEC15eSXnosVekUe7FVxCsn7Afjfnk+LZcc3orZhs3oaOPO8IYIZ8D9PTkZ9rfW8VKQHk4quMYXU+Sfs8NNj96B01NdKGGabI/HLYpqFVXf+Mpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IHbQE/EP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IHbQE/EP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fiXM012544;
	Wed, 23 Apr 2025 10:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T7WkMhQ8AOZGOLGMV
	9HZDODJTy3iO623qXi/z7LzlLk=; b=IHbQE/EPdAkms0IRebOWZpJ4amoqfrySX
	nXh3qFBE30uhbZjTGNNFXTtWKu1wCVVYZCDCo0YPH5HQgxNk93B3kLT+v10h1Dm4
	PfbSNEK1AAHAade+e4Ghu7oOfqB2ELE+us9SQO8St9PgKFs8paQ1hA3LViPrROwA
	nIGMVYSqIdRGKGLCR8JstlS1ft2mcUVdE0G9AlbeV6p+67ItiGODyWfJjJiKgBdm
	dDBKNq545LempdWn+rvLcB5KMsXNgHHCcyf+AOId8DG7+cf3pbwLMm8nfx3yndtg
	N7ktyKBDQKemHmcCAnEL+xGs9N8ypTlLY1S8LxNkylhQXALv5sMBA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466n30a5p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6VrIS000925;
	Wed, 23 Apr 2025 10:15:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxth47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFm4w40042792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E44212004D;
	Wed, 23 Apr 2025 10:15:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7143C20049;
	Wed, 23 Apr 2025 10:15:47 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:47 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 20/25] s390/pkey: Rework EP11 pkey handler to use stack for small memory allocs
Date: Wed, 23 Apr 2025 12:15:29 +0200
Message-ID: <20250423101535.143137-21-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX4vzAYUQLFT14 2mxe9AzD6YNj4xTJoIC0QsUs2fesyjcD5euRfc9+ZgU5IfJbePXZaxvDqL8lNuf06N+mnk1aWeU JkQ2Gz3h2VOUkN6lY/qVMV7g3NFgmtnUo6No9BBEvYRfW7O7Zw9P13AfAoNOvufIHfwBaicmra7
 MMiTLAhwhhI4r1ypdx0JPJm9TXjKCtR8d99GY+d5Gc6W7GkRVRbCIhiSVc4cxZMIjhnq/kYBzun 3MiN9l7F0RTJ2RzKROYakjzWG7G5E7z23Pj6oOW3DMgQpOZqLFcuUyz2d946neKcKGa1UUdJoNq j0E1DtAWvZRA5hqjiucG60VsdojHc05g9yVn001cOeW5IU3LRnRacmYYr+XONFmxaZnJWD+2iN4
 behrImBVOxZ8HUZzFj9yCXHh7od6cSoLSoW/AL8aDJuIeq+66vOxeUOZx128zVh30i9/qC3G
X-Authority-Analysis: v=2.4 cv=aoiyCTZV c=1 sm=1 tr=0 ts=6808bdd8 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=tcbCEGChaADSxsZLY-kA:9
X-Proofpoint-GUID: j-MOioUtLx5A0-hi72ReFdz3sFA11G7G
X-Proofpoint-ORIG-GUID: j-MOioUtLx5A0-hi72ReFdz3sFA11G7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

There have been some places in the EP11 handler code where relatively
small amounts of memory have been allocated an freed at the end
of the function. This code has been reworked to use the stack instead.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c | 43 ++++++++-------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index 38aa0c7807c2..429c08facbfe 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -186,7 +186,7 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 			    u8 *protkey, u32 *protkeylen, u32 *protkeytype)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -223,14 +223,10 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = ep11_apqns4key(key, keylen, 0, local_apqns, &nr_apqns);
+		rc = ep11_apqns4key(key, keylen, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -259,7 +255,6 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -278,7 +273,7 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			u32 keybitsize, u32 flags,
 			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 	const u32 xflags = 0;
 
@@ -315,15 +310,10 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = ep11_apqns4type(subtype, NULL, NULL, 0,
-				     local_apqns, &nr_apqns);
+		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -333,7 +323,6 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -353,7 +342,7 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			const u8 *clrkey, u32 clrkeylen,
 			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
 {
-	struct pkey_apqn *local_apqns = NULL;
+	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
 
 	/* check keytype, subtype, clrkeylen, keybitsize */
@@ -394,15 +383,10 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		local_apqns = kmalloc_array(nr_apqns, sizeof(struct pkey_apqn),
-					    GFP_KERNEL);
-		if (!local_apqns)
-			return -ENOMEM;
-		rc = ep11_apqns4type(subtype, NULL, NULL, 0,
-				     local_apqns, &nr_apqns);
+		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
 		if (rc)
 			goto out;
-		apqns = local_apqns;
+		apqns = _apqns;
 	}
 
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
@@ -412,7 +396,6 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	}
 
 out:
-	kfree(local_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -502,8 +485,8 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 {
 	const struct keytoken_header *hdr = (const struct keytoken_header *)key;
 	const struct clearkeytoken *t = (const struct clearkeytoken *)key;
+	u8 tmpbuf[MAXEP11AESKEYBLOBSIZE]; /* 336 bytes */
 	u32 tmplen, keysize = 0;
-	u8 *tmpbuf;
 	int i, rc;
 
 	if (keylen < sizeof(*hdr))
@@ -515,11 +498,6 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 	if (!keysize || t->len != keysize)
 		return -EINVAL;
 
-	/* alloc tmp key buffer */
-	tmpbuf = kmalloc(MAXEP11AESKEYBLOBSIZE, GFP_ATOMIC);
-	if (!tmpbuf)
-		return -ENOMEM;
-
 	/* try two times in case of failure */
 	for (i = 0, rc = -ENODEV; i < 2 && rc; i++) {
 		tmplen = MAXEP11AESKEYBLOBSIZE;
@@ -534,7 +512,6 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 		pr_debug("ep11_key2protkey()=%d\n", rc);
 	}
 
-	kfree(tmpbuf);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
-- 
2.43.0


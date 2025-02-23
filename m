Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD796201269
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304519; cv=none; b=NnsC2thfWS4Iks3oVyuDHw8BHTp824gAT0bhyYeCBKZcJmPwYlo6El+6bHeB4lqm1/GGTm9lE1/2UNEpXJm8JA/sQMXBlFA/YkWvyUz0m9pfbOUdVYA21zZ/+CnDp0gAV4mACHN8MAUO4sxxYyKDxBXX7aJq5A82IaugJTX4/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304519; c=relaxed/simple;
	bh=h4hlfv8AZJE88KYwBC7xLULkYqYWN9Ej4LCpBo3oDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOrL8OY7+g+DIXIB0CNNO8sb/bEsP557XOrbTLRpejctbE+tykApaD1Tshyc4lj+HouwCFg0GXEFLJhR/4R/IInX726MWOLkVHRRdk4e/zsz+Yy72XsQXTCRRTl0rjeZOl0dflMW9GxpZFyaRJkzO6qovxgnNettciilnPAJmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iqu3Q4RF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iqu3Q4RF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6Q3MM009739;
	Sun, 23 Feb 2025 09:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=htX5/bJoRRJl8o4wf
	lY0EgX0aoTJGH7p6+9Z58QFR2Y=; b=iqu3Q4RFaPzTzrMG4dQczOr4WXhQmLBLR
	J8BIOuMU8wcczKjfCg2QzmAaTGxWHV9jVPI1O309yvMJblLEflV929gEUIHf/hdQ
	CyEQbJQERcmBUkRHYcLxhYTlhlA4J6FGbYsrty6T3hXAAAnAns5RrdyJXBgWVCvb
	ayMnNjmxsNnawNOsciMOdl8wKzyd39oEKH7lowOgxj0eovM3sEQYaXcbVJNPBPHd
	nY6KMkry7oDgQbGuehzERuTxEvtH2FwCa380JQwrj8CLFz0Gtxa3RifZplc79X7+
	YkzrPD8z7FGxM8kaW54hE4rGVsFVHMrU1sSF7gukdRMBmO66XSLCQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gjfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N6VlAc027396;
	Sun, 23 Feb 2025 09:55:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdk1m05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t7fA30540308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01F22004D;
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B98B20049;
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:07 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 19/20] s390/zcrypt/pkey: Provide and pass xflags within pkey and zcrypt layers
Date: Sun, 23 Feb 2025 10:54:58 +0100
Message-ID: <20250223095459.43058-20-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223095459.43058-1-freude@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U2qd6YlcXEUMwNHIb6w67AvX_6V-I6bt
X-Proofpoint-GUID: U2qd6YlcXEUMwNHIb6w67AvX_6V-I6bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230073

Provide and pass the xflag parameter from pkey ioctls through
the pkey handler and further down to the implementations
(CCA, EP11, PCKMO and UV). So all the code is now prepared
and ready to support the currently only xflag ("execution flag"):

  * ZCRYPT_XFLAG_NOMEMALLOC - If this flag is set, no memory
    allocations which may trigger any IO operations are done.

The in-kernel pkey API still does not provide this xflag param.
That's intended to come with another patch which more or less
only enables this functionality.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/pkey_api.c        | 49 +++++++++++-----------
 drivers/s390/crypto/pkey_base.c       | 34 ++++++++-------
 drivers/s390/crypto/pkey_base.h       | 37 ++++++++++-------
 drivers/s390/crypto/pkey_cca.c        | 59 +++++++++++++++------------
 drivers/s390/crypto/pkey_ep11.c       | 49 ++++++++++++----------
 drivers/s390/crypto/pkey_pckmo.c      |  9 ++--
 drivers/s390/crypto/pkey_sysfs.c      |  4 +-
 drivers/s390/crypto/pkey_uv.c         | 16 +++++++-
 drivers/s390/crypto/zcrypt_ccamisc.c  | 53 +++++++++++-------------
 drivers/s390/crypto/zcrypt_ccamisc.h  | 25 +++++++-----
 drivers/s390/crypto/zcrypt_ep11misc.c | 10 ++---
 drivers/s390/crypto/zcrypt_ep11misc.h |  7 ++--
 12 files changed, 196 insertions(+), 156 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 3a39e167bdbf..55a4e70b866b 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -24,7 +24,8 @@
  */
 static int key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       const u8 *key, size_t keylen,
-		       u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+		       u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		       u32 xflags)
 {
 	int rc;
 
@@ -32,14 +33,14 @@ static int key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	rc = pkey_handler_key_to_protkey(apqns, nr_apqns,
 					 key, keylen,
 					 protkey, protkeylen,
-					 protkeytype);
+					 protkeytype, xflags);
 
 	/* if this did not work, try the slowpath way */
 	if (rc == -ENODEV) {
 		rc = pkey_handler_slowpath_key_to_protkey(apqns, nr_apqns,
 							  key, keylen,
 							  protkey, protkeylen,
-							  protkeytype);
+							  protkeytype, xflags);
 		if (rc)
 			rc = -ENODEV;
 	}
@@ -55,13 +56,14 @@ int pkey_key2protkey(const u8 *key, u32 keylen,
 		     u8 *protkey, u32 *protkeylen, u32 *protkeytype)
 {
 	int rc;
+	const u32 xflags = 0;
 
 	rc = key2protkey(NULL, 0, key, keylen,
-			 protkey, protkeylen, protkeytype);
+			 protkey, protkeylen, protkeytype, xflags);
 	if (rc == -ENODEV) {
 		pkey_handler_request_modules();
 		rc = key2protkey(NULL, 0, key, keylen,
-				 protkey, protkeylen, protkeytype);
+				 protkey, protkeylen, protkeytype, xflags);
 	}
 
 	return rc;
@@ -103,7 +105,7 @@ static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)
 	keybuflen = sizeof(kgs.seckey.seckey);
 	rc = pkey_handler_gen_key(&apqn, 1,
 				  kgs.keytype, PKEY_TYPE_CCA_DATA, 0, 0,
-				  kgs.seckey.seckey, &keybuflen, NULL);
+				  kgs.seckey.seckey, &keybuflen, NULL, 0);
 	pr_debug("gen_key()=%d\n", rc);
 	if (!rc && copy_to_user(ugs, &kgs, sizeof(kgs)))
 		rc = -EFAULT;
@@ -129,7 +131,7 @@ static int pkey_ioctl_clr2seck(struct pkey_clr2seck __user *ucs)
 				     kcs.keytype, PKEY_TYPE_CCA_DATA, 0, 0,
 				     kcs.clrkey.clrkey,
 				     pkey_keytype_aes_to_size(kcs.keytype),
-				     kcs.seckey.seckey, &keybuflen, NULL);
+				     kcs.seckey.seckey, &keybuflen, NULL, 0);
 	pr_debug("clr_to_key()=%d\n", rc);
 	if (!rc && copy_to_user(ucs, &kcs, sizeof(kcs)))
 		rc = -EFAULT;
@@ -154,7 +156,8 @@ static int pkey_ioctl_sec2protk(struct pkey_sec2protk __user *usp)
 					 ksp.seckey.seckey,
 					 sizeof(ksp.seckey.seckey),
 					 ksp.protkey.protkey,
-					 &ksp.protkey.len, &ksp.protkey.type);
+					 &ksp.protkey.len, &ksp.protkey.type,
+					 0);
 	pr_debug("key_to_protkey()=%d\n", rc);
 	if (!rc && copy_to_user(usp, &ksp, sizeof(ksp)))
 		rc = -EFAULT;
@@ -198,7 +201,7 @@ static int pkey_ioctl_clr2protk(struct pkey_clr2protk __user *ucp)
 	rc = key2protkey(NULL, 0,
 			 tmpbuf, sizeof(*t) + keylen,
 			 kcp.protkey.protkey,
-			 &kcp.protkey.len, &kcp.protkey.type);
+			 &kcp.protkey.len, &kcp.protkey.type, 0);
 	pr_debug("key2protkey()=%d\n", rc);
 
 	kfree_sensitive(tmpbuf);
@@ -228,12 +231,12 @@ static int pkey_ioctl_findcard(struct pkey_findcard __user *ufc)
 	rc = pkey_handler_apqns_for_key(kfc.seckey.seckey,
 					sizeof(kfc.seckey.seckey),
 					PKEY_FLAGS_MATCH_CUR_MKVP,
-					apqns, &nr_apqns);
+					apqns, &nr_apqns, 0);
 	if (rc == -ENODEV)
 		rc = pkey_handler_apqns_for_key(kfc.seckey.seckey,
 						sizeof(kfc.seckey.seckey),
 						PKEY_FLAGS_MATCH_ALT_MKVP,
-						apqns, &nr_apqns);
+						apqns, &nr_apqns, 0);
 	pr_debug("apqns_for_key()=%d\n", rc);
 	if (rc) {
 		kfree(apqns);
@@ -262,7 +265,7 @@ static int pkey_ioctl_skey2pkey(struct pkey_skey2pkey __user *usp)
 					 sizeof(ksp.seckey.seckey),
 					 ksp.protkey.protkey,
 					 &ksp.protkey.len,
-					 &ksp.protkey.type);
+					 &ksp.protkey.type, 0);
 	pr_debug("key_to_protkey()=%d\n", rc);
 	if (!rc && copy_to_user(usp, &ksp, sizeof(ksp)))
 		rc = -EFAULT;
@@ -285,7 +288,7 @@ static int pkey_ioctl_verifykey(struct pkey_verifykey __user *uvk)
 	rc = pkey_handler_verify_key(kvk.seckey.seckey,
 				     sizeof(kvk.seckey.seckey),
 				     &kvk.cardnr, &kvk.domain,
-				     &keytype, &keybitsize, &flags);
+				     &keytype, &keybitsize, &flags, 0);
 	pr_debug("verify_key()=%d\n", rc);
 	if (!rc && keytype != PKEY_TYPE_CCA_DATA)
 		rc = -EINVAL;
@@ -312,7 +315,7 @@ static int pkey_ioctl_genprotk(struct pkey_genprotk __user *ugp)
 	rc = pkey_handler_gen_key(NULL, 0, kgp.keytype,
 				  PKEY_TYPE_PROTKEY, 0, 0,
 				  kgp.protkey.protkey, &kgp.protkey.len,
-				  &kgp.protkey.type);
+				  &kgp.protkey.type, 0);
 	pr_debug("gen_key()=%d\n", rc);
 	if (!rc && copy_to_user(ugp, &kgp, sizeof(kgp)))
 		rc = -EFAULT;
@@ -354,7 +357,7 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
 	memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);
 
 	rc = pkey_handler_verify_key(tmpbuf, sizeof(*t),
-				     NULL, NULL, NULL, NULL, NULL);
+				     NULL, NULL, NULL, NULL, NULL, 0);
 	pr_debug("verify_key()=%d\n", rc);
 
 	kfree_sensitive(tmpbuf);
@@ -377,7 +380,7 @@ static int pkey_ioctl_kblob2protk(struct pkey_kblob2pkey __user *utp)
 	ktp.protkey.len = sizeof(ktp.protkey.protkey);
 	rc = key2protkey(NULL, 0, kkey, ktp.keylen,
 			 ktp.protkey.protkey, &ktp.protkey.len,
-			 &ktp.protkey.type);
+			 &ktp.protkey.type, 0);
 	pr_debug("key2protkey()=%d\n", rc);
 	kfree_sensitive(kkey);
 	if (!rc && copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -414,7 +417,7 @@ static int pkey_ioctl_genseck2(struct pkey_genseck2 __user *ugs)
 	}
 	rc = pkey_handler_gen_key(apqns, kgs.apqn_entries,
 				  u, kgs.type, kgs.size, kgs.keygenflags,
-				  kkey, &klen, NULL);
+				  kkey, &klen, NULL, 0);
 	pr_debug("gen_key()=%d\n", rc);
 	kfree(apqns);
 	if (rc) {
@@ -471,7 +474,7 @@ static int pkey_ioctl_clr2seck2(struct pkey_clr2seck2 __user *ucs)
 	rc = pkey_handler_clr_to_key(apqns, kcs.apqn_entries,
 				     u, kcs.type, kcs.size, kcs.keygenflags,
 				     kcs.clrkey.clrkey, kcs.size / 8,
-				     kkey, &klen, NULL);
+				     kkey, &klen, NULL, 0);
 	pr_debug("clr_to_key()=%d\n", rc);
 	kfree(apqns);
 	if (rc) {
@@ -514,7 +517,7 @@ static int pkey_ioctl_verifykey2(struct pkey_verifykey2 __user *uvk)
 
 	rc = pkey_handler_verify_key(kkey, kvk.keylen,
 				     &kvk.cardnr, &kvk.domain,
-				     &kvk.type, &kvk.size, &kvk.flags);
+				     &kvk.type, &kvk.size, &kvk.flags, 0);
 	pr_debug("verify_key()=%d\n", rc);
 
 	kfree_sensitive(kkey);
@@ -544,7 +547,7 @@ static int pkey_ioctl_kblob2protk2(struct pkey_kblob2pkey2 __user *utp)
 	ktp.protkey.len = sizeof(ktp.protkey.protkey);
 	rc = key2protkey(apqns, ktp.apqn_entries, kkey, ktp.keylen,
 			 ktp.protkey.protkey, &ktp.protkey.len,
-			 &ktp.protkey.type);
+			 &ktp.protkey.type, 0);
 	pr_debug("key2protkey()=%d\n", rc);
 	kfree(apqns);
 	kfree_sensitive(kkey);
@@ -579,7 +582,7 @@ static int pkey_ioctl_apqns4k(struct pkey_apqns4key __user *uak)
 		return PTR_ERR(kkey);
 	}
 	rc = pkey_handler_apqns_for_key(kkey, kak.keylen, kak.flags,
-					apqns, &nr_apqns);
+					apqns, &nr_apqns, 0);
 	pr_debug("apqns_for_key()=%d\n", rc);
 	kfree_sensitive(kkey);
 	if (rc && rc != -ENOSPC) {
@@ -626,7 +629,7 @@ static int pkey_ioctl_apqns4kt(struct pkey_apqns4keytype __user *uat)
 	}
 	rc = pkey_handler_apqns_for_keytype(kat.type,
 					    kat.cur_mkvp, kat.alt_mkvp,
-					    kat.flags, apqns, &nr_apqns);
+					    kat.flags, apqns, &nr_apqns, 0);
 	pr_debug("apqns_for_keytype()=%d\n", rc);
 	if (rc && rc != -ENOSPC) {
 		kfree(apqns);
@@ -678,7 +681,7 @@ static int pkey_ioctl_kblob2protk3(struct pkey_kblob2pkey3 __user *utp)
 		return -ENOMEM;
 	}
 	rc = key2protkey(apqns, ktp.apqn_entries, kkey, ktp.keylen,
-			 protkey, &protkeylen, &ktp.pkeytype);
+			 protkey, &protkeylen, &ktp.pkeytype, 0);
 	pr_debug("key2protkey()=%d\n", rc);
 	kfree(apqns);
 	kfree_sensitive(kkey);
diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index 64a376501d26..9e6f319acc63 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -150,7 +150,8 @@ EXPORT_SYMBOL(pkey_handler_put);
 
 int pkey_handler_key_to_protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 				const u8 *key, u32 keylen,
-				u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+				u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+				u32 xflags)
 {
 	const struct pkey_handler *h;
 	int rc = -ENODEV;
@@ -159,7 +160,7 @@ int pkey_handler_key_to_protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (h && h->key_to_protkey) {
 		rc = h->key_to_protkey(apqns, nr_apqns, key, keylen,
 				       protkey, protkeylen,
-				       protkeytype);
+				       protkeytype, xflags);
 	}
 	pkey_handler_put(h);
 
@@ -177,7 +178,7 @@ int pkey_handler_slowpath_key_to_protkey(const struct pkey_apqn *apqns,
 					 size_t nr_apqns,
 					 const u8 *key, u32 keylen,
 					 u8 *protkey, u32 *protkeylen,
-					 u32 *protkeytype)
+					 u32 *protkeytype, u32 xflags)
 {
 	const struct pkey_handler *h, *htmp[10];
 	int i, n = 0, rc = -ENODEV;
@@ -199,7 +200,7 @@ int pkey_handler_slowpath_key_to_protkey(const struct pkey_apqn *apqns,
 			rc = h->slowpath_key_to_protkey(apqns, nr_apqns,
 							key, keylen,
 							protkey, protkeylen,
-							protkeytype);
+							protkeytype, xflags);
 		module_put(h->module);
 	}
 
@@ -210,7 +211,7 @@ EXPORT_SYMBOL(pkey_handler_slowpath_key_to_protkey);
 int pkey_handler_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			 u32 keytype, u32 keysubtype,
 			 u32 keybitsize, u32 flags,
-			 u8 *keybuf, u32 *keybuflen, u32 *keyinfo)
+			 u8 *keybuf, u32 *keybuflen, u32 *keyinfo, u32 xflags)
 {
 	const struct pkey_handler *h;
 	int rc = -ENODEV;
@@ -219,7 +220,7 @@ int pkey_handler_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (h && h->gen_key) {
 		rc = h->gen_key(apqns, nr_apqns, keytype, keysubtype,
 				keybitsize, flags,
-				keybuf, keybuflen, keyinfo);
+				keybuf, keybuflen, keyinfo, xflags);
 	}
 	pkey_handler_put(h);
 
@@ -231,7 +232,8 @@ int pkey_handler_clr_to_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			    u32 keytype, u32 keysubtype,
 			    u32 keybitsize, u32 flags,
 			    const u8 *clrkey, u32 clrkeylen,
-			    u8 *keybuf, u32 *keybuflen, u32 *keyinfo)
+			    u8 *keybuf, u32 *keybuflen, u32 *keyinfo,
+			    u32 xflags)
 {
 	const struct pkey_handler *h;
 	int rc = -ENODEV;
@@ -240,7 +242,7 @@ int pkey_handler_clr_to_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (h && h->clr_to_key) {
 		rc = h->clr_to_key(apqns, nr_apqns, keytype, keysubtype,
 				   keybitsize, flags, clrkey, clrkeylen,
-				   keybuf, keybuflen, keyinfo);
+				   keybuf, keybuflen, keyinfo, xflags);
 	}
 	pkey_handler_put(h);
 
@@ -250,7 +252,8 @@ EXPORT_SYMBOL(pkey_handler_clr_to_key);
 
 int pkey_handler_verify_key(const u8 *key, u32 keylen,
 			    u16 *card, u16 *dom,
-			    u32 *keytype, u32 *keybitsize, u32 *flags)
+			    u32 *keytype, u32 *keybitsize, u32 *flags,
+			    u32 xflags)
 {
 	const struct pkey_handler *h;
 	int rc = -ENODEV;
@@ -258,7 +261,7 @@ int pkey_handler_verify_key(const u8 *key, u32 keylen,
 	h = pkey_handler_get_keybased(key, keylen);
 	if (h && h->verify_key) {
 		rc = h->verify_key(key, keylen, card, dom,
-				   keytype, keybitsize, flags);
+				   keytype, keybitsize, flags, xflags);
 	}
 	pkey_handler_put(h);
 
@@ -267,14 +270,16 @@ int pkey_handler_verify_key(const u8 *key, u32 keylen,
 EXPORT_SYMBOL(pkey_handler_verify_key);
 
 int pkey_handler_apqns_for_key(const u8 *key, u32 keylen, u32 flags,
-			       struct pkey_apqn *apqns, size_t *nr_apqns)
+			       struct pkey_apqn *apqns, size_t *nr_apqns,
+			       u32 xflags)
 {
 	const struct pkey_handler *h;
 	int rc = -ENODEV;
 
 	h = pkey_handler_get_keybased(key, keylen);
 	if (h && h->apqns_for_key)
-		rc = h->apqns_for_key(key, keylen, flags, apqns, nr_apqns);
+		rc = h->apqns_for_key(key, keylen, flags, apqns, nr_apqns,
+				      xflags);
 	pkey_handler_put(h);
 
 	return rc;
@@ -283,7 +288,8 @@ EXPORT_SYMBOL(pkey_handler_apqns_for_key);
 
 int pkey_handler_apqns_for_keytype(enum pkey_key_type keysubtype,
 				   u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
-				   struct pkey_apqn *apqns, size_t *nr_apqns)
+				   struct pkey_apqn *apqns, size_t *nr_apqns,
+				   u32 xflags)
 {
 	const struct pkey_handler *h;
 	int rc = -ENODEV;
@@ -292,7 +298,7 @@ int pkey_handler_apqns_for_keytype(enum pkey_key_type keysubtype,
 	if (h && h->apqns_for_keytype) {
 		rc = h->apqns_for_keytype(keysubtype,
 					  cur_mkvp, alt_mkvp, flags,
-					  apqns, nr_apqns);
+					  apqns, nr_apqns, xflags);
 	}
 	pkey_handler_put(h);
 
diff --git a/drivers/s390/crypto/pkey_base.h b/drivers/s390/crypto/pkey_base.h
index 7347647dfaa7..9cdb3e74477f 100644
--- a/drivers/s390/crypto/pkey_base.h
+++ b/drivers/s390/crypto/pkey_base.h
@@ -159,29 +159,33 @@ struct pkey_handler {
 	bool (*is_supported_keytype)(enum pkey_key_type);
 	int (*key_to_protkey)(const struct pkey_apqn *apqns, size_t nr_apqns,
 			      const u8 *key, u32 keylen,
-			      u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+			      u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+			      u32 xflags);
 	int (*slowpath_key_to_protkey)(const struct pkey_apqn *apqns,
 				       size_t nr_apqns,
 				       const u8 *key, u32 keylen,
 				       u8 *protkey, u32 *protkeylen,
-				       u32 *protkeytype);
+				       u32 *protkeytype, u32 xflags);
 	int (*gen_key)(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       u32 keytype, u32 keysubtype,
 		       u32 keybitsize, u32 flags,
-		       u8 *keybuf, u32 *keybuflen, u32 *keyinfo);
+		       u8 *keybuf, u32 *keybuflen, u32 *keyinfo, u32 xflags);
 	int (*clr_to_key)(const struct pkey_apqn *apqns, size_t nr_apqns,
 			  u32 keytype, u32 keysubtype,
 			  u32 keybitsize, u32 flags,
 			  const u8 *clrkey, u32 clrkeylen,
-			  u8 *keybuf, u32 *keybuflen, u32 *keyinfo);
+			  u8 *keybuf, u32 *keybuflen, u32 *keyinfo, u32 xflags);
 	int (*verify_key)(const u8 *key, u32 keylen,
 			  u16 *card, u16 *dom,
-			  u32 *keytype, u32 *keybitsize, u32 *flags);
+			  u32 *keytype, u32 *keybitsize, u32 *flags,
+			  u32 xflags);
 	int (*apqns_for_key)(const u8 *key, u32 keylen, u32 flags,
-			     struct pkey_apqn *apqns, size_t *nr_apqns);
+			     struct pkey_apqn *apqns, size_t *nr_apqns,
+			     u32 xflags);
 	int (*apqns_for_keytype)(enum pkey_key_type ktype,
 				 u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
-				 struct pkey_apqn *apqns, size_t *nr_apqns);
+				 struct pkey_apqn *apqns, size_t *nr_apqns,
+				 u32 xflags);
 	/* used internal by pkey base */
 	struct list_head list;
 };
@@ -199,29 +203,34 @@ void pkey_handler_put(const struct pkey_handler *handler);
 
 int pkey_handler_key_to_protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 				const u8 *key, u32 keylen,
-				u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+				u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+				u32 xflags);
 int pkey_handler_slowpath_key_to_protkey(const struct pkey_apqn *apqns,
 					 size_t nr_apqns,
 					 const u8 *key, u32 keylen,
 					 u8 *protkey, u32 *protkeylen,
-					 u32 *protkeytype);
+					 u32 *protkeytype, u32 xflags);
 int pkey_handler_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			 u32 keytype, u32 keysubtype,
 			 u32 keybitsize, u32 flags,
-			 u8 *keybuf, u32 *keybuflen, u32 *keyinfo);
+			 u8 *keybuf, u32 *keybuflen, u32 *keyinfo, u32 xflags);
 int pkey_handler_clr_to_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			    u32 keytype, u32 keysubtype,
 			    u32 keybitsize, u32 flags,
 			    const u8 *clrkey, u32 clrkeylen,
-			    u8 *keybuf, u32 *keybuflen, u32 *keyinfo);
+			    u8 *keybuf, u32 *keybuflen, u32 *keyinfo,
+			    u32 xflags);
 int pkey_handler_verify_key(const u8 *key, u32 keylen,
 			    u16 *card, u16 *dom,
-			    u32 *keytype, u32 *keybitsize, u32 *flags);
+			    u32 *keytype, u32 *keybitsize, u32 *flags,
+			    u32 xflags);
 int pkey_handler_apqns_for_key(const u8 *key, u32 keylen, u32 flags,
-			       struct pkey_apqn *apqns, size_t *nr_apqns);
+			       struct pkey_apqn *apqns, size_t *nr_apqns,
+			       u32 xflags);
 int pkey_handler_apqns_for_keytype(enum pkey_key_type ktype,
 				   u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
-				   struct pkey_apqn *apqns, size_t *nr_apqns);
+				   struct pkey_apqn *apqns, size_t *nr_apqns,
+				   u32 xflags);
 
 /*
  * Unconditional try to load all handler modules
diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index 619d134b028d..8761e3822ef2 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -70,7 +70,7 @@ static bool is_cca_keytype(enum pkey_key_type key_type)
 }
 
 static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
-			 struct pkey_apqn *apqns, size_t *nr_apqns)
+			 struct pkey_apqn *apqns, size_t *nr_apqns, u32 xflags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
@@ -109,7 +109,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 		}
 		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp, 1, xflags);
 		if (rc)
 			goto out;
 
@@ -128,7 +128,7 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 		}
 		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp, 1, xflags);
 		if (rc)
 			goto out;
 
@@ -153,7 +153,8 @@ static int cca_apqns4key(const u8 *key, u32 keylen, u32 flags,
 
 static int cca_apqns4type(enum pkey_key_type ktype,
 			  u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
-			  struct pkey_apqn *apqns, size_t *nr_apqns)
+			  struct pkey_apqn *apqns, size_t *nr_apqns,
+			  u32 xflags)
 {
 	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
@@ -172,7 +173,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			minhwtype = ZCRYPT_CEX6;
 		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   minhwtype, AES_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp, 1, xflags);
 		if (rc)
 			goto out;
 
@@ -185,7 +186,7 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 			old_mkvp = *((u64 *)alt_mkvp);
 		rc = cca_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				   ZCRYPT_CEX7, APKA_MK_SET,
-				   cur_mkvp, old_mkvp, 1);
+				   cur_mkvp, old_mkvp, 1, xflags);
 		if (rc)
 			goto out;
 
@@ -210,7 +211,8 @@ static int cca_apqns4type(enum pkey_key_type ktype,
 
 static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 			   const u8 *key, u32 keylen,
-			   u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+			   u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+			   u32 xflags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 	struct pkey_apqn _apqns[MAXAPQNSINLIST];
@@ -251,7 +253,7 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		rc = cca_apqns4key(key, keylen, 0, _apqns, &nr_apqns);
+		rc = cca_apqns4key(key, keylen, 0, _apqns, &nr_apqns, xflags);
 		if (rc)
 			goto out;
 		apqns = _apqns;
@@ -262,16 +264,17 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 		    hdr->version == TOKVER_CCA_AES) {
 			rc = cca_sec2protkey(apqns[i].card, apqns[i].domain,
 					     key, protkey,
-					     protkeylen, protkeytype);
+					     protkeylen, protkeytype, xflags);
 		} else if (hdr->type == TOKTYPE_CCA_INTERNAL &&
 			   hdr->version == TOKVER_CCA_VLSC) {
 			rc = cca_cipher2protkey(apqns[i].card, apqns[i].domain,
 						key, protkey,
-						protkeylen, protkeytype);
+						protkeylen, protkeytype,
+						xflags);
 		} else if (hdr->type == TOKTYPE_CCA_INTERNAL_PKA) {
 			rc = cca_ecc2protkey(apqns[i].card, apqns[i].domain,
 					     key, protkey,
-					     protkeylen, protkeytype);
+					     protkeylen, protkeytype, xflags);
 		} else {
 			rc = -EINVAL;
 			break;
@@ -295,7 +298,7 @@ static int cca_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       u32 keytype, u32 subtype,
 		       u32 keybitsize, u32 flags,
-		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
+		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo, u32 xflags)
 {
 	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
@@ -333,7 +336,8 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
+		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns,
+				    xflags);
 		if (rc)
 			goto out;
 		apqns = _apqns;
@@ -343,11 +347,11 @@ static int cca_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		if (subtype == PKEY_TYPE_CCA_CIPHER) {
 			rc = cca_gencipherkey(apqns[i].card, apqns[i].domain,
 					      keybitsize, flags,
-					      keybuf, keybuflen);
+					      keybuf, keybuflen, xflags);
 		} else {
 			/* PKEY_TYPE_CCA_DATA */
 			rc = cca_genseckey(apqns[i].card, apqns[i].domain,
-					   keybitsize, keybuf);
+					   keybitsize, keybuf, xflags);
 			*keybuflen = (rc ? 0 : SECKEYBLOBSIZE);
 		}
 	}
@@ -370,7 +374,7 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		       u32 keytype, u32 subtype,
 		       u32 keybitsize, u32 flags,
 		       const u8 *clrkey, u32 clrkeylen,
-		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
+		       u8 *keybuf, u32 *keybuflen, u32 *_keyinfo, u32 xflags)
 {
 	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
@@ -413,7 +417,8 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
+		rc = cca_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns,
+				    xflags);
 		if (rc)
 			goto out;
 		apqns = _apqns;
@@ -423,11 +428,11 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 		if (subtype == PKEY_TYPE_CCA_CIPHER) {
 			rc = cca_clr2cipherkey(apqns[i].card, apqns[i].domain,
 					       keybitsize, flags, clrkey,
-					       keybuf, keybuflen);
+					       keybuf, keybuflen, xflags);
 		} else {
 			/* PKEY_TYPE_CCA_DATA */
 			rc = cca_clr2seckey(apqns[i].card, apqns[i].domain,
-					    keybitsize, clrkey, keybuf);
+					    keybitsize, clrkey, keybuf, xflags);
 			*keybuflen = (rc ? 0 : SECKEYBLOBSIZE);
 		}
 	}
@@ -439,7 +444,7 @@ static int cca_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 
 static int cca_verifykey(const u8 *key, u32 keylen,
 			 u16 *card, u16 *dom,
-			 u32 *keytype, u32 *keybitsize, u32 *flags)
+			 u32 *keytype, u32 *keybitsize, u32 *flags, u32 xflags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 	u32 apqns[MAXAPQNSINLIST], nr_apqns = ARRAY_SIZE(apqns);
@@ -461,13 +466,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = t->bitsize;
 		rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX3C, AES_MK_SET,
-				   t->mkvp, 0, 1);
+				   t->mkvp, 0, 1, xflags);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
 			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX3C, AES_MK_SET,
-					   0, t->mkvp, 1);
+					   0, t->mkvp, 1, xflags);
 			if (!rc)
 				*flags = PKEY_FLAGS_MATCH_ALT_MKVP;
 		}
@@ -494,13 +499,13 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 			*keybitsize = PKEY_SIZE_AES_256;
 		rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 				   ZCRYPT_CEX6, AES_MK_SET,
-				   t->mkvp0, 0, 1);
+				   t->mkvp0, 0, 1, xflags);
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
 			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX6, AES_MK_SET,
-					   0, t->mkvp0, 1);
+					   0, t->mkvp0, 1, xflags);
 			if (!rc)
 				*flags = PKEY_FLAGS_MATCH_ALT_MKVP;
 		}
@@ -531,7 +536,7 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 				    size_t nr_apqns,
 				    const u8 *key, u32 keylen,
 				    u8 *protkey, u32 *protkeylen,
-				    u32 *protkeytype)
+				    u32 *protkeytype, u32 xflags)
 {
 	const struct keytoken_header *hdr = (const struct keytoken_header *)key;
 	const struct clearkeytoken *t = (const struct clearkeytoken *)key;
@@ -553,12 +558,12 @@ static int cca_slowpath_key2protkey(const struct pkey_apqn *apqns,
 		tmplen = SECKEYBLOBSIZE;
 		rc = cca_clr2key(NULL, 0, t->keytype, PKEY_TYPE_CCA_DATA,
 				 8 * keysize, 0, t->clearkey, t->len,
-				 tmpbuf, &tmplen, NULL);
+				 tmpbuf, &tmplen, NULL, xflags);
 		pr_debug("cca_clr2key()=%d\n", rc);
 		if (rc)
 			continue;
 		rc = cca_key2protkey(NULL, 0, tmpbuf, tmplen,
-				     protkey, protkeylen, protkeytype);
+				     protkey, protkeylen, protkeytype, xflags);
 		pr_debug("cca_key2protkey()=%d\n", rc);
 	}
 
diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index 429c08facbfe..82b01fbf08ae 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -70,7 +70,7 @@ static bool is_ep11_keytype(enum pkey_key_type key_type)
 }
 
 static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
-			  struct pkey_apqn *apqns, size_t *nr_apqns)
+			  struct pkey_apqn *apqns, size_t *nr_apqns, u32 xflags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
@@ -99,7 +99,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		}
 		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
-				    minhwtype, api, kb->wkvp);
+				    minhwtype, api, kb->wkvp, xflags);
 		if (rc)
 			goto out;
 
@@ -116,7 +116,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		}
 		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
-				    minhwtype, api, kb->wkvp);
+				    minhwtype, api, kb->wkvp, xflags);
 		if (rc)
 			goto out;
 
@@ -141,7 +141,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 
 static int ep11_apqns4type(enum pkey_key_type ktype,
 			   u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
-			   struct pkey_apqn *apqns, size_t *nr_apqns)
+			   struct pkey_apqn *apqns, size_t *nr_apqns, u32 xflags)
 {
 	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
@@ -158,7 +158,7 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 			wkvp = cur_mkvp;
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
-				    ZCRYPT_CEX7, api, wkvp);
+				    ZCRYPT_CEX7, api, wkvp, xflags);
 		if (rc)
 			goto out;
 
@@ -183,7 +183,8 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 
 static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 			    const u8 *key, u32 keylen,
-			    u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+			    u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+			    u32 xflags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 	struct pkey_apqn _apqns[MAXAPQNSINLIST];
@@ -223,7 +224,7 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		rc = ep11_apqns4key(key, keylen, 0, _apqns, &nr_apqns);
+		rc = ep11_apqns4key(key, keylen, 0, _apqns, &nr_apqns, xflags);
 		if (rc)
 			goto out;
 		apqns = _apqns;
@@ -235,19 +236,22 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 		    is_ep11_keyblob(key + sizeof(struct ep11kblob_header))) {
 			rc = ep11_kblob2protkey(apqns[i].card, apqns[i].domain,
 						key, hdr->len, protkey,
-						protkeylen, protkeytype);
+						protkeylen, protkeytype,
+						xflags);
 		} else if (hdr->type == TOKTYPE_NON_CCA &&
 			   hdr->version == TOKVER_EP11_ECC_WITH_HEADER &&
 			   is_ep11_keyblob(key + sizeof(struct ep11kblob_header))) {
 			rc = ep11_kblob2protkey(apqns[i].card, apqns[i].domain,
 						key, hdr->len, protkey,
-						protkeylen, protkeytype);
+						protkeylen, protkeytype,
+						xflags);
 		} else if (hdr->type == TOKTYPE_NON_CCA &&
 			   hdr->version == TOKVER_EP11_AES &&
 			   is_ep11_keyblob(key)) {
 			rc = ep11_kblob2protkey(apqns[i].card, apqns[i].domain,
 						key, hdr->len, protkey,
-						protkeylen, protkeytype);
+						protkeylen, protkeytype,
+						xflags);
 		} else {
 			rc = -EINVAL;
 			break;
@@ -271,11 +275,10 @@ static int ep11_key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
 static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			u32 keytype, u32 subtype,
 			u32 keybitsize, u32 flags,
-			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
+			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo, u32 xflags)
 {
 	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
-	const u32 xflags = 0;
 
 	/* check keytype, subtype, keybitsize */
 	switch (keytype) {
@@ -310,7 +313,8 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
+		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns,
+				     xflags);
 		if (rc)
 			goto out;
 		apqns = _apqns;
@@ -340,7 +344,7 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 			u32 keytype, u32 subtype,
 			u32 keybitsize, u32 flags,
 			const u8 *clrkey, u32 clrkeylen,
-			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo)
+			u8 *keybuf, u32 *keybuflen, u32 *_keyinfo, u32 xflags)
 {
 	struct pkey_apqn _apqns[MAXAPQNSINLIST];
 	int i, len, rc;
@@ -383,7 +387,8 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	if (!apqns || (nr_apqns == 1 &&
 		       apqns[0].card == 0xFFFF && apqns[0].domain == 0xFFFF)) {
 		nr_apqns = MAXAPQNSINLIST;
-		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns);
+		rc = ep11_apqns4type(subtype, NULL, NULL, 0, _apqns, &nr_apqns,
+				     xflags);
 		if (rc)
 			goto out;
 		apqns = _apqns;
@@ -392,7 +397,7 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
 		rc = ep11_clr2keyblob(apqns[i].card, apqns[i].domain,
 				      keybitsize, flags, clrkey,
-				      keybuf, keybuflen, subtype);
+				      keybuf, keybuflen, subtype, xflags);
 	}
 
 out:
@@ -402,7 +407,7 @@ static int ep11_clr2key(const struct pkey_apqn *apqns, size_t nr_apqns,
 
 static int ep11_verifykey(const u8 *key, u32 keylen,
 			  u16 *card, u16 *dom,
-			  u32 *keytype, u32 *keybitsize, u32 *flags)
+			  u32 *keytype, u32 *keybitsize, u32 *flags, u32 xflags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 	u32 apqns[MAXAPQNSINLIST], nr_apqns = ARRAY_SIZE(apqns);
@@ -427,7 +432,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		rc = ep11_findcard2(apqns, &nr_apqns, *card, *dom,
 				    ZCRYPT_CEX7, api,
-				    ep11_kb_wkvp(key, keylen));
+				    ep11_kb_wkvp(key, keylen), xflags);
 		if (rc)
 			goto out;
 
@@ -451,7 +456,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		rc = ep11_findcard2(apqns, &nr_apqns, *card, *dom,
 				    ZCRYPT_CEX7, api,
-				    ep11_kb_wkvp(key, keylen));
+				    ep11_kb_wkvp(key, keylen), xflags);
 		if (rc)
 			goto out;
 
@@ -481,7 +486,7 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 				     size_t nr_apqns,
 				     const u8 *key, u32 keylen,
 				     u8 *protkey, u32 *protkeylen,
-				     u32 *protkeytype)
+				     u32 *protkeytype, u32 xflags)
 {
 	const struct keytoken_header *hdr = (const struct keytoken_header *)key;
 	const struct clearkeytoken *t = (const struct clearkeytoken *)key;
@@ -503,12 +508,12 @@ static int ep11_slowpath_key2protkey(const struct pkey_apqn *apqns,
 		tmplen = MAXEP11AESKEYBLOBSIZE;
 		rc = ep11_clr2key(NULL, 0, t->keytype, PKEY_TYPE_EP11,
 				  8 * keysize, 0, t->clearkey, t->len,
-				  tmpbuf, &tmplen, NULL);
+				  tmpbuf, &tmplen, NULL, xflags);
 		pr_debug("ep11_clr2key()=%d\n", rc);
 		if (rc)
 			continue;
 		rc = ep11_key2protkey(NULL, 0, tmpbuf, tmplen,
-				      protkey, protkeylen, protkeytype);
+				      protkey, protkeylen, protkeytype, xflags);
 		pr_debug("ep11_key2protkey()=%d\n", rc);
 	}
 
diff --git a/drivers/s390/crypto/pkey_pckmo.c b/drivers/s390/crypto/pkey_pckmo.c
index 835d59f4fbc5..00aabb1b3e18 100644
--- a/drivers/s390/crypto/pkey_pckmo.c
+++ b/drivers/s390/crypto/pkey_pckmo.c
@@ -406,7 +406,8 @@ static int pckmo_verify_key(const u8 *key, u32 keylen)
 static int pkey_pckmo_key2protkey(const struct pkey_apqn *_apqns,
 				  size_t _nr_apqns,
 				  const u8 *key, u32 keylen,
-				  u8 *protkey, u32 *protkeylen, u32 *keyinfo)
+				  u8 *protkey, u32 *protkeylen, u32 *keyinfo,
+				  u32 _xflags)
 {
 	return pckmo_key2protkey(key, keylen,
 				 protkey, protkeylen, keyinfo);
@@ -415,7 +416,8 @@ static int pkey_pckmo_key2protkey(const struct pkey_apqn *_apqns,
 static int pkey_pckmo_gen_key(const struct pkey_apqn *_apqns, size_t _nr_apqns,
 			      u32 keytype, u32 keysubtype,
 			      u32 _keybitsize, u32 _flags,
-			      u8 *keybuf, u32 *keybuflen, u32 *keyinfo)
+			      u8 *keybuf, u32 *keybuflen, u32 *keyinfo,
+			      u32 _xflags)
 {
 	return pckmo_gen_protkey(keytype, keysubtype,
 				 keybuf, keybuflen, keyinfo);
@@ -423,7 +425,8 @@ static int pkey_pckmo_gen_key(const struct pkey_apqn *_apqns, size_t _nr_apqns,
 
 static int pkey_pckmo_verifykey(const u8 *key, u32 keylen,
 				u16 *_card, u16 *_dom,
-				u32 *_keytype, u32 *_keybitsize, u32 *_flags)
+				u32 *_keytype, u32 *_keybitsize,
+				u32 *_flags, u32 _xflags)
 {
 	return pckmo_verify_key(key, keylen);
 }
diff --git a/drivers/s390/crypto/pkey_sysfs.c b/drivers/s390/crypto/pkey_sysfs.c
index 57edc97bafd2..cea772973649 100644
--- a/drivers/s390/crypto/pkey_sysfs.c
+++ b/drivers/s390/crypto/pkey_sysfs.c
@@ -29,13 +29,13 @@ static int sys_pkey_handler_gen_key(u32 keytype, u32 keysubtype,
 	rc = pkey_handler_gen_key(NULL, 0,
 				  keytype, keysubtype,
 				  keybitsize, flags,
-				  keybuf, keybuflen, keyinfo);
+				  keybuf, keybuflen, keyinfo, 0);
 	if (rc == -ENODEV) {
 		pkey_handler_request_modules();
 		rc = pkey_handler_gen_key(NULL, 0,
 					  keytype, keysubtype,
 					  keybitsize, flags,
-					  keybuf, keybuflen, keyinfo);
+					  keybuf, keybuflen, keyinfo, 0);
 	}
 
 	return rc;
diff --git a/drivers/s390/crypto/pkey_uv.c b/drivers/s390/crypto/pkey_uv.c
index 805817b14354..f36ff7531213 100644
--- a/drivers/s390/crypto/pkey_uv.c
+++ b/drivers/s390/crypto/pkey_uv.c
@@ -172,13 +172,19 @@ static int uv_get_size_and_type(u16 secret_type, u32 *pkeysize, u32 *pkeytype)
 static int uv_key2protkey(const struct pkey_apqn *_apqns __always_unused,
 			  size_t _nr_apqns __always_unused,
 			  const u8 *key, u32 keylen,
-			  u8 *protkey, u32 *protkeylen, u32 *keyinfo)
+			  u8 *protkey, u32 *protkeylen, u32 *keyinfo,
+			  u32 xflags)
 {
 	struct uvsecrettoken *t = (struct uvsecrettoken *)key;
 	u32 pkeysize, pkeytype;
 	u16 secret_type;
 	int rc;
 
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
 	rc = uv_get_size_and_type(t->secret_type, &pkeysize, &pkeytype);
 	if (rc)
 		goto out;
@@ -214,13 +220,19 @@ static int uv_key2protkey(const struct pkey_apqn *_apqns __always_unused,
 static int uv_verifykey(const u8 *key, u32 keylen,
 			u16 *_card __always_unused,
 			u16 *_dom __always_unused,
-			u32 *keytype, u32 *keybitsize, u32 *flags)
+			u32 *keytype, u32 *keybitsize, u32 *flags,
+			u32 xflags)
 {
 	struct uvsecrettoken *t = (struct uvsecrettoken *)key;
 	struct uv_secret_list_item_hdr secret_meta_data;
 	u32 pkeysize, pkeytype, bitsize;
 	int rc;
 
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
 	rc = uv_get_size_and_type(t->secret_type, &pkeysize, &pkeytype);
 	if (rc)
 		goto out;
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index ccf8206ae42d..57d77972da86 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -333,7 +333,7 @@ static inline void prep_xcrb(struct ica_xcRB *pxcrb,
  * Generate (random) CCA AES DATA secure key.
  */
 int cca_genseckey(u16 cardnr, u16 domain,
-		  u32 keybitsize, u8 *seckey)
+		  u32 keybitsize, u8 *seckey, u32 xflags)
 {
 	int i, rc, keysize;
 	int seckeysize;
@@ -373,7 +373,6 @@ int cca_genseckey(u16 cardnr, u16 domain,
 			} keyblock;
 		} lv3;
 	} __packed * prepparm;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -478,7 +477,7 @@ EXPORT_SYMBOL(cca_genseckey);
  * Generate an CCA AES DATA secure key with given key value.
  */
 int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
-		   const u8 *clrkey, u8 *seckey)
+		   const u8 *clrkey, u8 *seckey, u32 xflags)
 {
 	int rc, keysize, seckeysize;
 	u8 *mem, *ptr;
@@ -516,7 +515,6 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 			} keyblock;
 		} lv3;
 	} __packed * prepparm;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -620,7 +618,7 @@ EXPORT_SYMBOL(cca_clr2seckey);
  */
 int cca_sec2protkey(u16 cardnr, u16 domain,
 		    const u8 *seckey, u8 *protkey, u32 *protkeylen,
-		    u32 *protkeytype)
+		    u32 *protkeytype, u32 xflags)
 {
 	int rc;
 	u8 *mem, *ptr;
@@ -664,7 +662,6 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 			} ckb;
 		} lv3;
 	} __packed * prepparm;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -786,7 +783,7 @@ static const u8 aes_cipher_key_skeleton[] = {
  * Generate (random) CCA AES CIPHER secure key.
  */
 int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
-		     u8 *keybuf, u32 *keybufsize)
+		     u8 *keybuf, u32 *keybufsize, u32 xflags)
 {
 	int rc;
 	u8 *mem, *ptr;
@@ -860,7 +857,6 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 		} kb;
 	} __packed * prepparm;
 	struct cipherkeytoken *t;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -989,7 +985,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   const u8 *clr_key_value,
 			   int clr_key_bit_size,
 			   u8 *key_token,
-			   int *key_token_size)
+			   int *key_token_size,
+			   u32 xflags)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1038,7 +1035,6 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	} __packed * prepparm;
 	struct cipherkeytoken *t;
 	int complete = strncmp(rule_array_2, "COMPLETE", 8) ? 0 : 1;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -1138,14 +1134,13 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
  * Build CCA AES CIPHER secure key with a given clear key value.
  */
 int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
-		      const u8 *clrkey, u8 *keybuf, u32 *keybufsize)
+		      const u8 *clrkey, u8 *keybuf, u32 *keybufsize, u32 xflags)
 {
 	int rc;
 	void *mem;
 	int tokensize;
 	u8 *token, exorbuf[32];
 	struct cipherkeytoken *t;
-	u32 xflags = 0;
 
 	/* fill exorbuf with random data */
 	get_random_bytes(exorbuf, sizeof(exorbuf));
@@ -1182,28 +1177,28 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize);
+			     clrkey, keybitsize, token, &tokensize, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize);
+			     exorbuf, keybitsize, token, &tokensize, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize);
+			     NULL, keybitsize, token, &tokensize, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
@@ -1229,7 +1224,8 @@ EXPORT_SYMBOL(cca_clr2cipherkey);
  * Derive proteced key from CCA AES cipher secure key.
  */
 int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
-		       u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+		       u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		       u32 xflags)
 {
 	int rc;
 	u8 *mem, *ptr;
@@ -1279,7 +1275,6 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 		} kb;
 	} __packed * prepparm;
 	int keytoklen = ((struct cipherkeytoken *)ckey)->len;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -1396,7 +1391,7 @@ EXPORT_SYMBOL(cca_cipher2protkey);
  * Derive protected key from CCA ECC secure private key.
  */
 int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
-		    u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+		    u8 *protkey, u32 *protkeylen, u32 *protkeytype, u32 xflags)
 {
 	int rc;
 	u8 *mem, *ptr;
@@ -1444,7 +1439,6 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 		/* followed by a key block */
 	} __packed * prepparm;
 	int keylen = ((struct eccprivkeytoken *)key)->len;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(PARMBSIZE, &mem,
@@ -1547,7 +1541,8 @@ EXPORT_SYMBOL(cca_ecc2protkey);
 int cca_query_crypto_facility(u16 cardnr, u16 domain,
 			      const char *keyword,
 			      u8 *rarray, size_t *rarraylen,
-			      u8 *varray, size_t *varraylen)
+			      u8 *varray, size_t *varraylen,
+			      u32 xflags)
 {
 	int rc;
 	u16 len;
@@ -1569,7 +1564,6 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 		u8  subfunc_code[2];
 		u8  lvdata[];
 	} __packed * prepparm;
-	const u32 xflags = 0;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(parmbsize, &mem,
@@ -1758,7 +1752,7 @@ static int fetch_cca_info(u16 cardnr, u16 domain,
 
 	/* QF for this card/domain */
 	rc = cca_query_crypto_facility(cardnr, domain, "STATICSA",
-				       rarray, &rlen, varray, &vlen);
+				       rarray, &rlen, varray, &vlen, xflags);
 	if (rc == 0 && rlen >= 10 * 8 && vlen >= 204) {
 		memcpy(ci->serial, rarray, 8);
 		ci->new_asym_mk_state = (char)rarray[4 * 8];
@@ -1785,7 +1779,7 @@ static int fetch_cca_info(u16 cardnr, u16 domain,
 		goto out;
 	rlen = vlen = PAGE_SIZE / 2;
 	rc = cca_query_crypto_facility(cardnr, domain, "STATICSB",
-				       rarray, &rlen, varray, &vlen);
+				       rarray, &rlen, varray, &vlen, xflags);
 	if (rc == 0 && rlen >= 13 * 8 && vlen >= 240) {
 		ci->new_apka_mk_state = (char)rarray[10 * 8];
 		ci->cur_apka_mk_state = (char)rarray[11 * 8];
@@ -1827,13 +1821,12 @@ EXPORT_SYMBOL(cca_get_info);
  * Master Key Verification Pattern given.
  */
 static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
-		    int verify, int minhwtype)
+		    int verify, int minhwtype, u32 xflg)
 {
 	struct zcrypt_device_status_ext *device_status;
 	u16 card, dom;
 	struct cca_info ci;
 	int i, rc, oi = -1;
-	u32 xflg = 0; /* xflags */
 
 	/* mkvp must not be zero, minhwtype needs to be >= 0 */
 	if (mkvp == 0 || minhwtype < 0)
@@ -1925,7 +1918,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
  * Search for a matching crypto card based on the Master Key
  * Verification Pattern provided inside a secure key token.
  */
-int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify)
+int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain,
+		 int verify, u32 xflags)
 {
 	u64 mkvp;
 	int minhwtype = 0;
@@ -1946,19 +1940,18 @@ int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify)
 		return -EINVAL;
 	}
 
-	return findcard(mkvp, pcardnr, pdomain, verify, minhwtype);
+	return findcard(mkvp, pcardnr, pdomain, verify, minhwtype, xflags);
 }
 EXPORT_SYMBOL(cca_findcard);
 
 int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
-		  int verify)
+		  int verify, u32 xflags)
 {
 	struct zcrypt_device_status_ext *device_status;
 	int i, card, dom, curmatch, oldmatch, rc;
 	struct cca_info ci;
 	u32 _nr_apqns = 0;
-	u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.h b/drivers/s390/crypto/zcrypt_ccamisc.h
index 966f0eaf3c4c..0dd4c336abab 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.h
+++ b/drivers/s390/crypto/zcrypt_ccamisc.h
@@ -160,44 +160,47 @@ int cca_check_sececckeytoken(debug_info_t *dbg, int dbflvl,
 /*
  * Generate (random) CCA AES DATA secure key.
  */
-int cca_genseckey(u16 cardnr, u16 domain, u32 keybitsize, u8 *seckey);
+int cca_genseckey(u16 cardnr, u16 domain, u32 keybitsize, u8 *seckey,
+		  u32 xflags);
 
 /*
  * Generate CCA AES DATA secure key with given clear key value.
  */
 int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
-		   const u8 *clrkey, u8 *seckey);
+		   const u8 *clrkey, u8 *seckey, u32 xflags);
 
 /*
  * Derive proteced key from an CCA AES DATA secure key.
  */
 int cca_sec2protkey(u16 cardnr, u16 domain,
 		    const u8 *seckey, u8 *protkey, u32 *protkeylen,
-		    u32 *protkeytype);
+		    u32 *protkeytype, u32 xflags);
 
 /*
  * Generate (random) CCA AES CIPHER secure key.
  */
 int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
-		     u8 *keybuf, u32 *keybufsize);
+		     u8 *keybuf, u32 *keybufsize, u32 xflags);
 
 /*
  * Derive proteced key from CCA AES cipher secure key.
  */
 int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
-		       u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+		       u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		       u32 xflags);
 
 /*
  * Build CCA AES CIPHER secure key with a given clear key value.
  */
 int cca_clr2cipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
-		      const u8 *clrkey, u8 *keybuf, u32 *keybufsize);
+		      const u8 *clrkey, u8 *keybuf, u32 *keybufsize,
+		      u32 xflags);
 
 /*
  * Derive proteced key from CCA ECC secure private key.
  */
 int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
-		    u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+		    u8 *protkey, u32 *protkeylen, u32 *protkeytype, u32 xflags);
 
 /*
  * Query cryptographic facility from CCA adapter
@@ -205,7 +208,8 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 int cca_query_crypto_facility(u16 cardnr, u16 domain,
 			      const char *keyword,
 			      u8 *rarray, size_t *rarraylen,
-			      u8 *varray, size_t *varraylen);
+			      u8 *varray, size_t *varraylen,
+			      u32 xflags);
 
 /*
  * Search for a matching crypto card based on the Master Key
@@ -214,7 +218,8 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
  * Returns < 0 on failure, 0 if CURRENT MKVP matches and
  * 1 if OLD MKVP matches.
  */
-int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify);
+int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain,
+		 int verify, u32 xflags);
 
 /*
  * Build a list of cca apqns meeting the following constrains:
@@ -236,7 +241,7 @@ int cca_findcard(const u8 *key, u16 *pcardnr, u16 *pdomain, int verify);
  */
 int cca_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
-		  int verify);
+		  int verify, u32 xflags);
 
 #define AES_MK_SET  0
 #define APKA_MK_SET 1
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index a6ac0cac0c45..01e47708f7e9 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1454,13 +1454,12 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 
 int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		     const u8 *clrkey, u8 *keybuf, u32 *keybufsize,
-		     u32 keytype)
+		     u32 keytype, u32 xflags)
 {
 	int rc;
 	void *mem;
 	u8 encbuf[64], *kek;
 	size_t clrkeylen, keklen, encbuflen = sizeof(encbuf);
-	const u32 xflags = 0;
 
 	if (keybitsize == 128 || keybitsize == 192 || keybitsize == 256) {
 		clrkeylen = keybitsize / 8;
@@ -1521,7 +1520,8 @@ EXPORT_SYMBOL(ep11_clr2keyblob);
 
 int ep11_kblob2protkey(u16 card, u16 dom,
 		       const u8 *keyblob, u32 keybloblen,
-		       u8 *protkey, u32 *protkeylen, u32 *protkeytype)
+		       u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		       u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	struct ep11keyblob *key;
@@ -1537,7 +1537,6 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	} __packed * wki;
 	u8 *wkbuf = NULL;
 	int rc = -EIO;
-	const u32 xflags = 0;
 
 	if (ep11_kb_decode((u8 *)keyblob, keybloblen, &hdr, NULL, &key, &keylen))
 		return -EINVAL;
@@ -1643,14 +1642,13 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 EXPORT_SYMBOL(ep11_kblob2protkey);
 
 int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
-		   int minhwtype, int minapi, const u8 *wkvp)
+		   int minhwtype, int minapi, const u8 *wkvp, u32 xflags)
 {
 	struct zcrypt_device_status_ext *device_status;
 	int i, card, dom, rc;
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
 	u32 _nr_apqns = 0;
-	const u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 7ef036759dc8..34b47522a893 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -124,7 +124,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
  */
 int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 		     const u8 *clrkey, u8 *keybuf, u32 *keybufsize,
-		     u32 keytype);
+		     u32 keytype, u32 xflags);
 
 /*
  * Build a list of ep11 apqns meeting the following constrains:
@@ -144,13 +144,14 @@ int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
  * If no apqn meeting the criteria is found, -ENODEV is returned.
  */
 int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
-		   int minhwtype, int minapi, const u8 *wkvp);
+		   int minhwtype, int minapi, const u8 *wkvp, u32 xflags);
 
 /*
  * Derive proteced key from EP11 key blob (AES and ECC keys).
  */
 int ep11_kblob2protkey(u16 card, u16 dom, const u8 *key, u32 keylen,
-		       u8 *protkey, u32 *protkeylen, u32 *protkeytype);
+		       u8 *protkey, u32 *protkeylen, u32 *protkeytype,
+		       u32 xflags);
 
 int zcrypt_ep11misc_init(void);
 void zcrypt_ep11misc_exit(void);
-- 
2.43.0


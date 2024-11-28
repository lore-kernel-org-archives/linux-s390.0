Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFD1C1AAA;
	Thu, 28 Nov 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812178; cv=none; b=MsyMgOC+IsVU6crLPgF9zcDpJMPkDlO0WWYWjfynWt16XpkUhCsi1j6l2tsylK/vmULF3C2nbQ9HUdUUD1xpHFEX7A1QX3fVmdCnOMTGo5ZtpBUwHhC0gfuhN0twB8Tc58YnyaZHkPakeK/8/yQrCfxRjk3nndYNMoAgR/bxbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812178; c=relaxed/simple;
	bh=tKK8ruQDumGOJjndJKLB2AkpnJqV0FD4BSz5B3JLcHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl4wb6Vcm0na8n34/UzzHUycOgX5GbAozdMlIRgaT5cqwnpICFXSfHu/hP8lflya3QCZ8YkM2dO31iAbPz900Si747q+OxYhCmC4hxRxMihNQLEjINNm2tVTxRXB1j8CavKO07xeS4CbYUTI+IlDhj1tU9YJM3sUUlwjNrSZv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 19:42:53 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 19:42:52 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Harald Freudenberger
	<freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Holger
 Dengler" <dengler@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.6 3/3] s390/pkey: Wipe copies of protected- and secure-keys
Date: Thu, 28 Nov 2024 08:42:39 -0800
Message-ID: <20241128164239.21136-4-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128164239.21136-1-n.zhandarovich@fintech.ru>
References: <20241128164239.21136-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Holger Dengler <dengler@linux.ibm.com>

commit f2ebdadd85af4f4d0cae1e5d009c70eccc78c207 upstream.

Although the clear-key of neither protected- nor secure-keys is
accessible, this key material should only be visible to the calling
process. So wipe all copies of protected- or secure-keys from stack,
even in case of an error.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
[Nikita: small changes were made during cherry-picking due to
different debug macro use and similar discrepancies between branches]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. As no Fixes: tag was present, I decided against adding it myself
and leaving commit body intact.

 drivers/s390/crypto/pkey_api.c | 80 ++++++++++++++++------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 87df60710ad3..1da370bd9fd5 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1351,10 +1351,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = cca_genseckey(kgs.cardnr, kgs.domain,
 				   kgs.keytype, kgs.seckey.seckey);
 		DEBUG_DBG("%s cca_genseckey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(ugs, &kgs, sizeof(kgs)))
-			return -EFAULT;
+		if (!rc && copy_to_user(ugs, &kgs, sizeof(kgs)))
+			rc = -EFAULT;
+		memzero_explicit(&kgs, sizeof(kgs));
 		break;
 	}
 	case PKEY_CLR2SECK: {
@@ -1382,10 +1381,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				     ksp.seckey.seckey, ksp.protkey.protkey,
 				     &ksp.protkey.len, &ksp.protkey.type);
 		DEBUG_DBG("%s cca_sec2protkey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(usp, &ksp, sizeof(ksp)))
-			return -EFAULT;
+		if (!rc && copy_to_user(usp, &ksp, sizeof(ksp)))
+			rc = -EFAULT;
+		memzero_explicit(&ksp, sizeof(ksp));
 		break;
 	}
 	case PKEY_CLR2PROTK: {
@@ -1429,10 +1427,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_skey2pkey(ksp.seckey.seckey, ksp.protkey.protkey,
 				    &ksp.protkey.len, &ksp.protkey.type);
 		DEBUG_DBG("%s pkey_skey2pkey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(usp, &ksp, sizeof(ksp)))
-			return -EFAULT;
+		if (!rc && copy_to_user(usp, &ksp, sizeof(ksp)))
+			rc = -EFAULT;
+		memzero_explicit(&ksp, sizeof(ksp));
 		break;
 	}
 	case PKEY_VERIFYKEY: {
@@ -1444,10 +1441,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_verifykey(&kvk.seckey, &kvk.cardnr, &kvk.domain,
 				    &kvk.keysize, &kvk.attributes);
 		DEBUG_DBG("%s pkey_verifykey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(uvk, &kvk, sizeof(kvk)))
-			return -EFAULT;
+		if (!rc && copy_to_user(uvk, &kvk, sizeof(kvk)))
+			rc = -EFAULT;
+		memzero_explicit(&kvk, sizeof(kvk));
 		break;
 	}
 	case PKEY_GENPROTK: {
@@ -1460,10 +1456,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_genprotkey(kgp.keytype, kgp.protkey.protkey,
 				     &kgp.protkey.len, &kgp.protkey.type);
 		DEBUG_DBG("%s pkey_genprotkey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(ugp, &kgp, sizeof(kgp)))
-			return -EFAULT;
+		if (!rc && copy_to_user(ugp, &kgp, sizeof(kgp)))
+			rc = -EFAULT;
+		memzero_explicit(&kgp, sizeof(kgp));
 		break;
 	}
 	case PKEY_VERIFYPROTK: {
@@ -1475,6 +1470,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_verifyprotkey(kvp.protkey.protkey,
 					kvp.protkey.len, kvp.protkey.type);
 		DEBUG_DBG("%s pkey_verifyprotkey()=%d\n", __func__, rc);
+		memzero_explicit(&kvp, sizeof(kvp));
 		break;
 	}
 	case PKEY_KBLOB2PROTK: {
@@ -1492,10 +1488,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				       &ktp.protkey.len, &ktp.protkey.type);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
 		kfree_sensitive(kkey);
-		if (rc)
-			break;
-		if (copy_to_user(utp, &ktp, sizeof(ktp)))
-			return -EFAULT;
+		if (!rc && copy_to_user(utp, &ktp, sizeof(ktp)))
+			rc = -EFAULT;
+		memzero_explicit(&ktp, sizeof(ktp));
 		break;
 	}
 	case PKEY_GENSECK2: {
@@ -1521,23 +1516,23 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		DEBUG_DBG("%s pkey_genseckey2()=%d\n", __func__, rc);
 		kfree(apqns);
 		if (rc) {
-			kfree(kkey);
+			kfree_sensitive(kkey);
 			break;
 		}
 		if (kgs.key) {
 			if (kgs.keylen < klen) {
-				kfree(kkey);
+				kfree_sensitive(kkey);
 				return -EINVAL;
 			}
 			if (copy_to_user(kgs.key, kkey, klen)) {
-				kfree(kkey);
+				kfree_sensitive(kkey);
 				return -EFAULT;
 			}
 		}
 		kgs.keylen = klen;
 		if (copy_to_user(ugs, &kgs, sizeof(kgs)))
 			rc = -EFAULT;
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		break;
 	}
 	case PKEY_CLR2SECK2: {
@@ -1566,18 +1561,18 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		DEBUG_DBG("%s pkey_clr2seckey2()=%d\n", __func__, rc);
 		kfree(apqns);
 		if (rc) {
-			kfree(kkey);
+			kfree_sensitive(kkey);
 			memzero_explicit(&kcs, sizeof(kcs));
 			break;
 		}
 		if (kcs.key) {
 			if (kcs.keylen < klen) {
-				kfree(kkey);
+				kfree_sensitive(kkey);
 				memzero_explicit(&kcs, sizeof(kcs));
 				return -EINVAL;
 			}
 			if (copy_to_user(kcs.key, kkey, klen)) {
-				kfree(kkey);
+				kfree_sensitive(kkey);
 				memzero_explicit(&kcs, sizeof(kcs));
 				return -EFAULT;
 			}
@@ -1586,7 +1581,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (copy_to_user(ucs, &kcs, sizeof(kcs)))
 			rc = -EFAULT;
 		memzero_explicit(&kcs, sizeof(kcs));
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		break;
 	}
 	case PKEY_VERIFYKEY2: {
@@ -1603,7 +1598,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				     &kvk.cardnr, &kvk.domain,
 				     &kvk.type, &kvk.size, &kvk.flags);
 		DEBUG_DBG("%s pkey_verifykey2()=%d\n", __func__, rc);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc)
 			break;
 		if (copy_to_user(uvk, &kvk, sizeof(kvk)))
@@ -1634,10 +1629,9 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
 		kfree_sensitive(kkey);
-		if (rc)
-			break;
-		if (copy_to_user(utp, &ktp, sizeof(ktp)))
-			return -EFAULT;
+		if (!rc && copy_to_user(utp, &ktp, sizeof(ktp)))
+			rc = -EFAULT;
+		memzero_explicit(&ktp, sizeof(ktp));
 		break;
 	}
 	case PKEY_APQNS4K: {
@@ -1665,7 +1659,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_apqns4key(kkey, kak.keylen, kak.flags,
 				    apqns, &nr_apqns);
 		DEBUG_DBG("%s pkey_apqns4key()=%d\n", __func__, rc);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc && rc != -ENOSPC) {
 			kfree(apqns);
 			break;
@@ -1751,7 +1745,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		protkey = kmalloc(protkeylen, GFP_KERNEL);
 		if (!protkey) {
 			kfree(apqns);
-			kfree(kkey);
+			kfree_sensitive(kkey);
 			return -ENOMEM;
 		}
 		rc = pkey_keyblob2pkey3(apqns, ktp.apqn_entries,
@@ -1761,20 +1755,20 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		kfree(apqns);
 		kfree_sensitive(kkey);
 		if (rc) {
-			kfree(protkey);
+			kfree_sensitive(protkey);
 			break;
 		}
 		if (ktp.pkey && ktp.pkeylen) {
 			if (protkeylen > ktp.pkeylen) {
-				kfree(protkey);
+				kfree_sensitive(protkey);
 				return -EINVAL;
 			}
 			if (copy_to_user(ktp.pkey, protkey, protkeylen)) {
-				kfree(protkey);
+				kfree_sensitive(protkey);
 				return -EFAULT;
 			}
 		}
-		kfree(protkey);
+		kfree_sensitive(protkey);
 		ktp.pkeylen = protkeylen;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
 			return -EFAULT;
-- 
2.25.1


Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238681B0F38;
	Thu, 28 Nov 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803846; cv=none; b=ceFVIbTmhaFOjrJ8ngv6TSyimassWpLq7Iv1A7oDWMsMY1fn/BMeOhSOsqSeNPth2jGTcSPQtDzfBL1ebPNX/KB934Ix1CEgwF0IXRYY23w4CuTrA5rJm+JB2n2gAJ6M20tDMR0KDf6FraNGT7NqukyEK62ZI7LLFYp4k2c5Zm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803846; c=relaxed/simple;
	bh=iKOzv/SYPRSzm4/p02/l1iD0b4IFLrfS63AW4i5ixv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zw5w73e47iC8rwapWkk5CSIbT5KujR6zsd0rktf/HUk/6mJOzDg/GNTx/1uD8JGp1idCp/52eEhxvZ05YJM3w7PRVQnEvrXwHgtivsjYh0JKzZnR8GEvlRMJAtrvacASaWFijpMaN1aqi+mCvk/iFN7QgNmEI3GmSqek8LerkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 17:22:56 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 17:22:56 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Harald Freudenberger
	<freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Holger
 Dengler" <dengler@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15 2/3] s390/pkey: Wipe copies of clear-key structures on failure
Date: Thu, 28 Nov 2024 06:22:44 -0800
Message-ID: <20241128142245.18136-3-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128142245.18136-1-n.zhandarovich@fintech.ru>
References: <20241128142245.18136-1-n.zhandarovich@fintech.ru>
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

commit d65d76a44ffe74c73298ada25b0f578680576073 upstream.

Wipe all sensitive data from stack for all IOCTLs, which convert a
clear-key into a protected- or secure-key.

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

 drivers/s390/crypto/pkey_api.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index a41a0e2cbc10..778eddb911fd 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1152,9 +1152,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = cca_clr2seckey(kcs.cardnr, kcs.domain, kcs.keytype,
 				    kcs.clrkey.clrkey, kcs.seckey.seckey);
 		DEBUG_DBG("%s cca_clr2seckey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(ucs, &kcs, sizeof(kcs)))
+		if (!rc && copy_to_user(ucs, &kcs, sizeof(kcs)))
 			rc = -EFAULT;
 		memzero_explicit(&kcs, sizeof(kcs));
 		break;
@@ -1184,9 +1182,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_clr2protkey(kcp.keytype,
 				      &kcp.clrkey, &kcp.protkey);
 		DEBUG_DBG("%s pkey_clr2protkey()=%d\n", __func__, rc);
-		if (rc)
-			break;
-		if (copy_to_user(ucp, &kcp, sizeof(kcp)))
+		if (!rc && copy_to_user(ucp, &kcp, sizeof(kcp)))
 			rc = -EFAULT;
 		memzero_explicit(&kcp, sizeof(kcp));
 		break;
@@ -1330,11 +1326,13 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (copy_from_user(&kcs, ucs, sizeof(kcs)))
 			return -EFAULT;
 		apqns = _copy_apqns_from_user(kcs.apqns, kcs.apqn_entries);
-		if (IS_ERR(apqns))
+		if (IS_ERR(apqns)) {
+			memzero_explicit(&kcs, sizeof(kcs));
 			return PTR_ERR(apqns);
 		kkey = kmalloc(klen, GFP_KERNEL);
 		if (!kkey) {
 			kfree(apqns);
+			memzero_explicit(&kcs, sizeof(kcs));
 			return -ENOMEM;
 		}
 		rc = pkey_clr2seckey2(apqns, kcs.apqn_entries,
@@ -1344,15 +1342,18 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		kfree(apqns);
 		if (rc) {
 			kfree(kkey);
+			memzero_explicit(&kcs, sizeof(kcs));
 			break;
 		}
 		if (kcs.key) {
 			if (kcs.keylen < klen) {
 				kfree(kkey);
+				memzero_explicit(&kcs, sizeof(kcs));
 				return -EINVAL;
 			}
 			if (copy_to_user(kcs.key, kkey, klen)) {
 				kfree(kkey);
+				memzero_explicit(&kcs, sizeof(kcs));
 				return -EFAULT;
 			}
 		}
-- 
2.25.1


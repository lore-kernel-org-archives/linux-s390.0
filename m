Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD91B219F;
	Thu, 28 Nov 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803848; cv=none; b=X2p8/xDA4hllP6SexJrCG2kzbDx7kxKZKXq7Khxz2qX7UXkbv4z1DUrxM6iS0CBb3AIe9Q7tOnZ1Uy7T1z/aworzNh3lx7SebJOye55G+quCwt7hv0zp8kgma4Sr8K6rzsZEOYBli/G57HMgPdwDORH0mUMJ4A0HxMh2B81WjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803848; c=relaxed/simple;
	bh=cgcaN3o6WqlI2tjdDtPMS4LSyKTBy0Hk1efFqZX3g3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmD3H1LpeshwDBbu64RDlgg4G7FtcNQoIWlAGcFZpPlSFT+9vsNd5AB7Py/HeidOJDeQ/RFkTfKZxwvj5FggThul7m4vqowh0NjISeFzVI34Qt0FApDHp7yCNMsvUyQE1N9MnTgye27X799KnIe8XxjuAnuy1+ksgOex5jzuVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 17:22:52 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 17:22:52 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Harald Freudenberger
	<freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Holger
 Dengler" <dengler@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15 1/3] s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings
Date: Thu, 28 Nov 2024 06:22:43 -0800
Message-ID: <20241128142245.18136-2-n.zhandarovich@fintech.ru>
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

From: Jules Irenge <jbi.octave@gmail.com>

commit 22e6824622e8a8889df0f8fc4ed5aea0e702a694 upstream.

Replace memzero_explicit() and kfree() with kfree_sensitive() to fix
warnings reported by Coccinelle:

WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1506)
WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1643)
WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1770)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Link: https://lore.kernel.org/r/ZjqZkNi_JUJu73Rg@octinomon.home
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
[Nikita: small changes were made during cherry-picking due to
different debug macro use and similar discrepancies between branches]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. As no Fixes: tag was present, I decided against adding it myself
and leaving commit body intact.

 drivers/s390/crypto/pkey_api.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 362c97d9bd5b..a41a0e2cbc10 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1271,8 +1271,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(kkey);
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -1405,8 +1404,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -1532,8 +1530,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen);
 		DEBUG_DBG("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc) {
 			kfree(protkey);
 			break;
-- 
2.25.1


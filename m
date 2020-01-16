Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 131/205] s390/pkey: fix memory leak within _copy_apqns_from_user()
Date: Thu, 16 Jan 2020 11:41:46 -0500
Message-Id: <20200116164300.6705-131-sashal@kernel.org>
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Markus Elfring <Markus.Elfring@web.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit f9cac4fd8878929c6ebff0bd272317905d77c38a ]

Fixes: f2bbc96e7cfad ("s390/pkey: add CCA AES cipher key support")
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 9de3d46b3253..e17fac20127e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -740,8 +740,10 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 		kapqns = kmalloc(nbytes, GFP_KERNEL);
 		if (!kapqns)
 			return ERR_PTR(-ENOMEM);
-		if (copy_from_user(kapqns, uapqns, nbytes))
+		if (copy_from_user(kapqns, uapqns, nbytes)) {
+			kfree(kapqns);
 			return ERR_PTR(-EFAULT);
+		}
 	}
 
 	return kapqns;
-- 
2.20.1

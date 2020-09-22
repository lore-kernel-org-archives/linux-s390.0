Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVKbR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Sep 2020 06:31:17 -0400
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] s390/zcrypt: Fix a size determination in zcrypt_unlocked_ioctl()
Date: Tue, 22 Sep 2020 18:30:59 +0800
Message-Id: <20200922103059.859-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>

With new ioctl(ZCRYPT_PERDEV_REQCNT) introduced, kernel use dynamic
allocation for the 256 element array of unsigned integers for the number
of successfully completed requests per device. It's not a static array of
64 elements any more.

Fixes: af4a72276d49 ("s390/zcrypt: Support up to 256 crypto adapters.")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/s390/crypto/zcrypt_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4dbbfd88262c..5c3f3f89e2f3 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1449,7 +1449,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (!reqcnt)
 			return -ENOMEM;
 		zcrypt_perdev_reqcnt(reqcnt, AP_DEVICES);
-		if (copy_to_user((int __user *) arg, reqcnt, sizeof(reqcnt)))
+		if (copy_to_user((int __user *) arg, reqcnt, sizeof(u32) * AP_DEVICES))
 			rc = -EFAULT;
 		kfree(reqcnt);
 		return rc;
-- 
2.25.1

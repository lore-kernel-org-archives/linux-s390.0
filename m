Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726305AbgIZJDa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 05:03:30 -0400
Date: Sat, 26 Sep 2020 11:03:22 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9-rc7
Message-ID: <your-ad-here.call-01601111002-ext-0188@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc7.

Thank you,
Vasily

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-7

for you to fetch changes up to f7e80983f0cf470bb82036e73bff4d5a7daf8fc2:

  s390/zcrypt: Fix ZCRYPT_PERDEV_REQCNT ioctl (2020-09-24 09:57:24 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc7

- Fix truncated ZCRYPT_PERDEV_REQCNT ioctl result. Copy entire reqcnt list.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/zcrypt: Fix ZCRYPT_PERDEV_REQCNT ioctl

 drivers/s390/crypto/zcrypt_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4dbbfd88262c..f314936b5462 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1449,7 +1449,8 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (!reqcnt)
 			return -ENOMEM;
 		zcrypt_perdev_reqcnt(reqcnt, AP_DEVICES);
-		if (copy_to_user((int __user *) arg, reqcnt, sizeof(reqcnt)))
+		if (copy_to_user((int __user *) arg, reqcnt,
+				 sizeof(u32) * AP_DEVICES))
 			rc = -EFAULT;
 		kfree(reqcnt);
 		return rc;

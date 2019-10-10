Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37325 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388023AbfJJNOj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 09:14:39 -0400
From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] s390/zcrypt: fix memleak at release
Date: Thu, 10 Oct 2019 15:13:33 +0200
Message-Id: <20191010131333.23635-5-johan@kernel.org>
In-Reply-To: <20191010131333.23635-1-johan@kernel.org>
References: <20191010131333.23635-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

If a process is interrupted while accessing the crypto device and the
global ap_perms_mutex is contented, release() could return early and
fail to free related resources.

Fixes: 00fab2350e6b ("s390/zcrypt: multiple zcrypt device nodes support")
Cc: stable <stable@vger.kernel.org>     # 4.19
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/s390/crypto/zcrypt_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 45bdb47f84c1..9157e728a362 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -522,8 +522,7 @@ static int zcrypt_release(struct inode *inode, struct file *filp)
 	if (filp->f_inode->i_cdev == &zcrypt_cdev) {
 		struct zcdn_device *zcdndev;
 
-		if (mutex_lock_interruptible(&ap_perms_mutex))
-			return -ERESTARTSYS;
+		mutex_lock(&ap_perms_mutex);
 		zcdndev = find_zcdndev_by_devt(filp->f_inode->i_rdev);
 		mutex_unlock(&ap_perms_mutex);
 		if (zcdndev) {
-- 
2.23.0

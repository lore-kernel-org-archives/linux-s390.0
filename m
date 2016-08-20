Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] s390/tape: Use memdup_user() rather than duplicating its
 implementation
References: <566ABCD9.1060404@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <6b4cac6d-415c-b1e0-9b40-0344ac6f0351@users.sourceforge.net>
Date: Sat, 20 Aug 2016 19:32:03 +0200
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Aug 2016 19:25:34 +0200

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/char/tape_3590.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index d3d1936..e352047 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -312,15 +312,10 @@ static int tape_3592_ioctl_kekl_set(struct tape_device *device,
 		return -ENOSYS;
 	if (!crypt_enabled(device))
 		return -EUNATCH;
-	ext_kekls = kmalloc(sizeof(*ext_kekls), GFP_KERNEL);
-	if (!ext_kekls)
-		return -ENOMEM;
-	if (copy_from_user(ext_kekls, (char __user *)arg, sizeof(*ext_kekls))) {
-		rc = -EFAULT;
-		goto out;
-	}
+	ext_kekls = memdup_user((char __user *)arg, sizeof(*ext_kekls));
+	if (IS_ERR(ext_kekls))
+		return PTR_ERR(ext_kekls);
 	rc = tape_3592_kekl_set(device, ext_kekls);
-out:
 	kfree(ext_kekls);
 	return rc;
 }
-- 
2.9.3

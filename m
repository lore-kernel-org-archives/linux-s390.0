Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 1/2] s390/sclp_async: Use kstrtoul_from_user
Date: Mon,  6 Jun 2011 23:07:53 +0200
Message-Id: <1307394474-747-1-git-send-email-peterhuewe@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, Jan Glauber <jang@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Frank Blaschka <frank.blaschka@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch replaces the code for getting an unsigned long from a
userspace buffer by a simple call to kstroul_from_user.
This makes it easier to read and less error prone.

Kernel Version: v3.0-rc2

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/s390/char/sclp_async.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_async.c b/drivers/s390/char/sclp_async.c
index 7ad30e7..012d1a8 100644
--- a/drivers/s390/char/sclp_async.c
+++ b/drivers/s390/char/sclp_async.c
@@ -82,12 +82,10 @@ static int proc_handler_callhome(struct ctl_table *ctl, int write,
 			return -EFAULT;
 	} else {
 		len = *count;
-		rc = copy_from_user(buf, buffer, sizeof(buf));
-		if (rc != 0)
-			return -EFAULT;
-		buf[sizeof(buf) - 1] = '\0';
-		if (strict_strtoul(buf, 0, &val) != 0)
-			return -EINVAL;
+		rc = kstrtoul_from_user(buffer, len, 0, &val);
+		if (rc)
+			return rc;
+
 		if (val != 0 && val != 1)
 			return -EINVAL;
 		callhome_enabled = val;
-- 
1.7.3.4

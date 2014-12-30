From: Syam Sidhardhan <s.syam@samsung.com>
Date: Tue, 30 Dec 2014 11:29:01 +0000
Subject: [PATCH 1/2] s390/hmcdrv: Remove unnecessary version.h inclusion
Message-Id: <1419938221-20537-1-git-send-email-s.syam@samsung.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

version.h inclusion is not necessary as detected by versioncheck.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/s390/char/hmcdrv_mod.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/hmcdrv_mod.c b/drivers/s390/char/hmcdrv_mod.c
index 505c6a7..251a318 100644
--- a/drivers/s390/char/hmcdrv_mod.c
+++ b/drivers/s390/char/hmcdrv_mod.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/stat.h>
 
 #include "hmcdrv_ftp.h"
-- 
1.7.9.5

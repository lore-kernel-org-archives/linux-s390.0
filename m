From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Sat, 23 Aug 2008 05:56:28 +0000
Subject: s390/net/ctcm: remove unused #include <version.h>
Message-Id: <20080823133231.1289.WEIYI.HUANG@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The drivers below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  drivers/s390/net/ctcm_mpc.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 49ae1cd..2de1e2f 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -19,7 +19,6 @@
 #undef DEBUGDATA
 #undef DEBUGCCW

-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>

From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Sat, 21 Mar 2009 05:50:33 +0000
Subject: [PATCH] [S390] remove duplicated #include's
Message-Id: <1237614633-3796-1-git-send-email-weiyi.huang@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Remove duplicated #include's in arch/s390/kernel/ipl.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/s390/kernel/ipl.c      |    1 -
 arch/s390/kernel/sys_s390.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 2dcf590..bf3d2e3 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -23,7 +23,6 @@
 #include <asm/ebcdic.h>
 #include <asm/reset.h>
 #include <asm/sclp.h>
-#include <asm/setup.h>
 
 #define IPL_PARM_BLOCK_VERSION 0
 
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index c7ae4b1..e9d94f6 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -29,7 +29,6 @@
 #include <linux/personality.h>
 #include <linux/unistd.h>
 #include <linux/ipc.h>
-#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 #include "entry.h"
 
-- 
1.6.0.4

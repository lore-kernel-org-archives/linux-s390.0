From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Wed, 23 Jul 2008 22:10:42 +0000
Subject: arch/s390/kernel/ipl.c: removed duplicated include
Message-Id: <20080724061036.1B4D.WEIYI.HUANG@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Removed duplicated include <asm/setup.h> in 
arch/s390/kernel/ipl.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 54b2779..43aa9ef 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -23,7 +23,6 @@
 #include <asm/ebcdic.h>
 #include <asm/reset.h>
 #include <asm/sclp.h>
-#include <asm/setup.h>

 #define IPL_PARM_BLOCK_VERSION 0

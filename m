From: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Date: Fri, 13 Jun 2008 14:14:22 +0000
Subject: [PATCH] add types.h include to dasd.h
Message-Id: <485280BE.1040509@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


dasd.h uses __u16 and __u8 types but doesn't include linux/types.h.
It fixes probable compiler errors if dasd.h is the first/unique included file.
Thanks.

Signed-off-by: Edjunior B. Machado <emachado@linux.vnet.ibm.com>
---
 include/asm-s390/dasd.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-s390/dasd.h b/include/asm-s390/dasd.h
index 3f002e1..d5a191a 100644
--- a/include/asm-s390/dasd.h
+++ b/include/asm-s390/dasd.h
@@ -13,6 +13,7 @@
 #ifndef DASD_H
 #define DASD_H
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define DASD_IOCTL_LETTER 'D'
 
-- 
Edjunior Barbosa Machado
IBM Linux Technology Center
Linux Defect Support Team

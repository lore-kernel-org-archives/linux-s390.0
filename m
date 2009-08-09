From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Sun, 09 Aug 2009 15:12:43 +0000
Subject: [PATCH] S390: includecheck fix for sys_s390.c
Message-Id: <1249830043.2957.26.camel@ht.satnam>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


fix the following 'make includecheck' warning:

  arch/s390/kernel/sys_s390.c: linux/syscalls.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/s390/kernel/sys_s390.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

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
1.6.0.6

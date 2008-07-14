Return-Path: <linux-kernel-owner+w=401wt.eu-S1754799AbYGNC6F@vger.kernel.org>
Message-Id: <20080714025737.954072047@gmail.com>
References: <20080714025631.338886297@gmail.com>
Date: Mon, 14 Jul 2008 11:56:32 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [patch -mmotm 1/6] move memory_read_from_buffer() from fs.h to string.h
Content-Disposition: inline; filename=move-memory-read-from-buffer-into-string-h.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Zhang Rui <rui.zhang@intel.com>, Bob Moore <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

James Bottomley warns that inclusion of linux/fs.h in a low level driver
was always a danger signal. This patch moves memory_read_from_buffer()
from fs.h to string.h and remove inclusion of linux/fs.h in existing
memory_read_from_buffer() user.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/ipl.c      |    1 -
 drivers/zorro/zorro-sysfs.c |    1 -
 include/linux/fs.h          |    2 --
 include/linux/string.h      |    3 +++
 4 files changed, 3 insertions(+), 4 deletions(-)

Index: 2.6-mmotm/include/linux/fs.h
===================================================================
--- 2.6-mmotm.orig/include/linux/fs.h
+++ 2.6-mmotm/include/linux/fs.h
@@ -2028,8 +2028,6 @@ extern void simple_release_fs(struct vfs
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
-extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
-			const void *from, size_t available);
 
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
Index: 2.6-mmotm/include/linux/string.h
===================================================================
--- 2.6-mmotm.orig/include/linux/string.h
+++ 2.6-mmotm/include/linux/string.h
@@ -111,5 +111,8 @@ extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
 
+extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
+			const void *from, size_t available);
+
 #endif
 #endif /* _LINUX_STRING_H_ */
Index: 2.6-mmotm/drivers/zorro/zorro-sysfs.c
===================================================================
--- 2.6-mmotm.orig/drivers/zorro/zorro-sysfs.c
+++ 2.6-mmotm/drivers/zorro/zorro-sysfs.c
@@ -15,7 +15,6 @@
 #include <linux/zorro.h>
 #include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/fs.h>
 
 #include "zorro.h"
 
Index: 2.6-mmotm/arch/s390/kernel/ipl.c
===================================================================
--- 2.6-mmotm.orig/arch/s390/kernel/ipl.c
+++ 2.6-mmotm/arch/s390/kernel/ipl.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/ctype.h>
-#include <linux/fs.h>
 #include <asm/ipl.h>
 #include <asm/smp.h>
 #include <asm/setup.h>

-- 

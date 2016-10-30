Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/9] s390: char: make zcore explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:25 -0400
Message-ID: <20161030203732.26405-3-paul.gortmaker@windriver.com>
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

arch/s390/Kconfig:config CRASH_DUMP
arch/s390/Kconfig:      bool "kernel crash dumps"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init wasn't even being used by this file, the init
ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

We don't replace module.h with init.h since the file already has that.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/char/zcore.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 16992e2a40ad..5aea89a92ff4 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -7,6 +7,7 @@
  *
  * Copyright IBM Corp. 2003, 2008
  * Author(s): Michael Holzheu
+ * License: GPL
  */
 
 #define KMSG_COMPONENT "zdump"
@@ -16,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
 #include <linux/debugfs.h>
-#include <linux/module.h>
 #include <linux/memblock.h>
 
 #include <asm/asm-offsets.h>
@@ -364,22 +364,4 @@ static int __init zcore_init(void)
 	diag308(DIAG308_REL_HSA, NULL);
 	return rc;
 }
-
-static void __exit zcore_exit(void)
-{
-	debug_unregister(zcore_dbf);
-	sclp_sdias_exit();
-	free_page((unsigned long) ipl_block);
-	debugfs_remove(zcore_hsa_file);
-	debugfs_remove(zcore_reipl_file);
-	debugfs_remove(zcore_memmap_file);
-	debugfs_remove(zcore_dir);
-	diag308(DIAG308_REL_HSA, NULL);
-}
-
-MODULE_AUTHOR("Copyright IBM Corp. 2003,2008");
-MODULE_DESCRIPTION("zcore module for zfcpdump support");
-MODULE_LICENSE("GPL");
-
 subsys_initcall(zcore_init);
-module_exit(zcore_exit);
-- 
2.10.1

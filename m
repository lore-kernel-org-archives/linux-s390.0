Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/9] s390: char: make con3215 explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:26 -0400
Message-ID: <20161030203732.26405-4-paul.gortmaker@windriver.com>
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

drivers/s390/char/Kconfig:config TN3215
drivers/s390/char/Kconfig:      def_bool y

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/char/con3215.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 931d10e86837..1b8d825623bd 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -9,7 +9,6 @@
  *	      Dan Morrison, IBM Corporation <dmorriso@cse.buffalo.edu>
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/tty.h>
@@ -1215,13 +1214,4 @@ static int __init tty3215_init(void)
 	tty3215_driver = driver;
 	return 0;
 }
-
-static void __exit tty3215_exit(void)
-{
-	tty_unregister_driver(tty3215_driver);
-	put_tty_driver(tty3215_driver);
-	ccw_driver_unregister(&raw3215_ccw_driver);
-}
-
-module_init(tty3215_init);
-module_exit(tty3215_exit);
+device_initcall(tty3215_init);
-- 
2.10.1

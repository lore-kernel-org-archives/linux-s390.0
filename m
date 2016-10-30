Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/9] s390: char: make sclp_tty explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:27 -0400
Message-ID: <20161030203732.26405-5-paul.gortmaker@windriver.com>
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/s390/char/Kconfig:config SCLP_TTY
drivers/s390/char/Kconfig:      def_bool y

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/char/sclp_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 3c6e174e19b6..9259017a1295 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -7,7 +7,6 @@
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
-#include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
@@ -573,4 +572,4 @@ sclp_tty_init(void)
 	sclp_tty_driver = driver;
 	return 0;
 }
-module_init(sclp_tty_init);
+device_initcall(sclp_tty_init);
-- 
2.10.1

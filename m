Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 8/9] s390: kernel: make lgr explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:31 -0400
Message-ID: <20161030203732.26405-9-paul.gortmaker@windriver.com>
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

The Makefile currently controlling compilation of this code is obj-y
meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We replace module.h with init.h and export.h since the file does
export some symbols.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/s390/kernel/lgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/lgr.c b/arch/s390/kernel/lgr.c
index 6ea6d69339b5..ae7dff110054 100644
--- a/arch/s390/kernel/lgr.c
+++ b/arch/s390/kernel/lgr.c
@@ -5,7 +5,8 @@
  * Author(s): Michael Holzheu <holzheu@linux.vnet.ibm.com>
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <asm/facility.h>
@@ -183,4 +184,4 @@ static int __init lgr_init(void)
 	lgr_timer_set();
 	return 0;
 }
-module_init(lgr_init);
+device_initcall(lgr_init);
-- 
2.10.1

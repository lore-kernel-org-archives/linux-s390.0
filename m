Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] s390: char: make slp_ctl explicitly non-modular
Date: Sat, 29 Oct 2016 16:38:43 -0400
Message-ID: <20161029203843.515-4-paul.gortmaker@windriver.com>
In-Reply-To: <20161029203843.515-1-paul.gortmaker@windriver.com>
References: <20161029203843.515-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Makefile currently controlling compilation of this code is obj-y,
meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular usage, so that when reading
the driver there is no doubt it is builtin-only.

Since module_misc_device translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/char/sclp_ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ctl.c b/drivers/s390/char/sclp_ctl.c
index 554eaa1e347d..78a7e4f94721 100644
--- a/drivers/s390/char/sclp_ctl.c
+++ b/drivers/s390/char/sclp_ctl.c
@@ -10,7 +10,7 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/gfp.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/ioctl.h>
 #include <linux/fs.h>
 #include <asm/compat.h>
@@ -126,4 +126,4 @@ static struct miscdevice sclp_ctl_device = {
 	.name = "sclp",
 	.fops = &sclp_ctl_fops,
 };
-module_misc_device(sclp_ctl_device);
+builtin_misc_device(sclp_ctl_device);
-- 
2.10.1

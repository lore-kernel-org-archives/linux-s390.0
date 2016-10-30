Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/9] s390: char: make slcp_quiesce explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:28 -0400
Message-ID: <20161030203732.26405-6-paul.gortmaker@windriver.com>
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

The Makefile currently controlling compilation of this code is obj-y,
meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/char/sclp_quiesce.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/char/sclp_quiesce.c b/drivers/s390/char/sclp_quiesce.c
index 475e470d9768..e4958511168a 100644
--- a/drivers/s390/char/sclp_quiesce.c
+++ b/drivers/s390/char/sclp_quiesce.c
@@ -6,7 +6,6 @@
  *             Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
@@ -80,5 +79,4 @@ static int __init sclp_quiesce_init(void)
 {
 	return sclp_register(&sclp_quiesce_event);
 }
-
-module_init(sclp_quiesce_init);
+device_initcall(sclp_quiesce_init);
-- 
2.10.1

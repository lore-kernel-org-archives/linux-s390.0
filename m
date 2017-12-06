Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 17/45] drivers: s390: remove duplicate includes
Date: Wed,  6 Dec 2017 22:35:46 +0530
Message-Id: <1512579946-5675-1-git-send-email-pravin.shedge4linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, pravin.shedge4linux@gmail.com
List-ID: <linux-s390.vger.kernel.org>

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/s390/block/dasd_diag.c  | 1 -
 drivers/s390/net/qeth_l2_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index f035c2f..131f198 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -27,7 +27,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/vtoc.h>
-#include <asm/diag.h>
 
 #include "dasd_int.h"
 #include "dasd_diag.h"
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 93d7e34..1467858 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/hashtable.h>
-#include <linux/string.h>
 #include <asm/setup.h>
 #include "qeth_core.h"
 #include "qeth_l2.h"
-- 
2.7.4

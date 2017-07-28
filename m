From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 03/22] zfcp: Remove unneeded linux/miscdevice.h include
Date: Fri, 28 Jul 2017 12:30:49 +0200
Message-ID: <c4922afd6accd970bfadf89f438aa01fd979c3cb.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Corentin Labbe <clabbe.montjoie@gmail.com>

drivers/s390/scsi/zfcp_aux.c does not contain any miscdevice so the
inclusion of linux/miscdevice.h is unnecessary.

[maier@linux.vnet.ibm.com: just for the records, this is in fact a
 minor missing code cleanup of the following older "feature"
 which also dropped the only former use of a misc device in zfcp:
 commit 663e0890e31c ("[SCSI] zfcp: remove access control tables
				    interface")
 commit b5dc3c4800cc ("[SCSI] zfcp: remove access control tables
				    interface (keep sysfs files)")
 commit 1b33ef23946a ("zfcp: remove access control tables interface
			     (port leftovers)")]

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_aux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index bcc8f3dfd4c4..82ac331d9125 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -29,7 +29,6 @@
 #define KMSG_COMPONENT "zfcp"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
-#include <linux/miscdevice.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-- 
2.11.2

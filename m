Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/2] s390: zfcp: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 15:18:24 +0100
Message-Id: <20161215141824.3297-2-clabbe.montjoie@gmail.com>
In-Reply-To: <20161215141824.3297-1-clabbe.montjoie@gmail.com>
References: <20161215141824.3297-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: maier@linux.vnet.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

drivers/s390/scsi/zfcp_aux.c does not contain any miscdevice so the
inclusion of linux/miscdevice.h is uncessary.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/s390/scsi/zfcp_aux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index bcc8f3d..82ac331 100644
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
2.10.2

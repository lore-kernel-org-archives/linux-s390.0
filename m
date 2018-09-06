Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] scsi: zfcp: remove redundant put_device
Date: Thu,  6 Sep 2018 14:16:27 +0800
Message-Id: <1536214587-32500-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

device_unregister will put device, do not need to do it one more time

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/s390/scsi/zfcp_unit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
index 1bf0a09..6b50084 100644
--- a/drivers/s390/scsi/zfcp_unit.c
+++ b/drivers/s390/scsi/zfcp_unit.c
@@ -249,8 +249,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
 		scsi_device_put(sdev);
 	}
 
-	put_device(&unit->dev);
-
 	device_unregister(&unit->dev);
 
 	return 0;
-- 
1.9.1

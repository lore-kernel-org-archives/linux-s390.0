From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 05/11] zfcp: fix compile warning
Date: Fri, 19 Dec 2008 16:56:56 +0100
Message-ID: <20081219155753.319947000@de.ibm.com>
References: <20081219155651.010878000@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline; filename=716-zfcp-warning.diff
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Christof Schmitt <christof.schmitt@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Get rid of this one:

drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_thread':
drivers/s390/scsi/zfcp_erp.c:1400: warning: ignoring return value of
'down_interruptible', declared with attribute warn_unused_result

zfcp_erp_thread is a kernel thread which can't receive any signals.
So introduce a dummy variable and get rid of the warning.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
---

 drivers/s390/scsi/zfcp_erp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/scsi/zfcp_erp.c	2008-12-19 14:38:13.000000000 +0100
+++ b/drivers/s390/scsi/zfcp_erp.c	2008-12-19 14:38:32.000000000 +0100
@@ -1379,6 +1379,7 @@ static int zfcp_erp_thread(void *data)
 	struct list_head *next;
 	struct zfcp_erp_action *act;
 	unsigned long flags;
+	int ignore;
 
 	daemonize("zfcperp%s", dev_name(&adapter->ccw_device->dev));
 	/* Block all signals */
@@ -1401,7 +1402,7 @@ static int zfcp_erp_thread(void *data)
 		}
 
 		zfcp_rec_dbf_event_thread_lock(4, adapter);
-		down_interruptible(&adapter->erp_ready_sem);
+		ignore = down_interruptible(&adapter->erp_ready_sem);
 		zfcp_rec_dbf_event_thread_lock(5, adapter);
 	}
 

-- 

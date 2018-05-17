From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:02 +0000
Subject: [PATCH 20/25] zfcp: explicitly support initiator in scsi_host_template
Message-Id: <20180517171507.18237-21-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

While the default did already correctly print "Initiator"
let's make it explicit and convert zfcp to the feature.

$ cat /sys/class/scsi_host/host0/supported_mode
Initiator

$ cat /sys/class/scsi_host/host0/active_mode
Initiator

The default worked, because not setting the field has it initialized
to zero == MODE_UNKNOWN. scsi_host_alloc() sets shost->active_mode =
MODE_INITIATOR in this case. The sysfs accessor function
show_shost_supported_mode() assumes MODE_INITIATOR in this case.
This default behavior was introduced with v2.6.24 commit 7a39ac3f25be
("[SCSI] make supported_mode default to initiator.").
The feature flag was introduced with v2.6.24 commit 5dc2b89e1242
("[SCSI] add supported_mode and active_mode attributes to the host").
So there was no release where zfcp would have shown "unknown".

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index b4e1f1b82503..f69ef78ea930 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -401,6 +401,7 @@ static struct scsi_host_template zfcp_scsi_host_template = {
 	.shost_attrs		 = zfcp_sysfs_shost_attrs,
 	.sdev_attrs		 = zfcp_sysfs_sdev_attrs,
 	.track_queue_depth	 = 1,
+	.supported_mode		 = MODE_INITIATOR,
 };
 
 /**
-- 
2.16.3

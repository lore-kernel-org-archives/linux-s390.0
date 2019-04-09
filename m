From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:51 +0000
Subject: [PATCH 08/10] zfcp: move maximum age of diagnostic buffers into a module-parameter
Message-Id: <cd658e69308e7be750320ce7cefccb1420d1ff45.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replace the static define (ZFCP_DIAG_MAX_AGE) with a module parameter.
This way users can choose how much time should pass between refreshes of
diagnostic buffers. The default remains to be 5s, like it was before.

By setting the new module parameter to 0, the caching of diagnostic
buffers for userspace accesses can also be completely removed.

This parameter affects all diagnostic buffers in the same way.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_diag.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_diag.c b/drivers/s390/scsi/zfcp_diag.c
index 001ab4978bfa..54458c2bf843 100644
--- a/drivers/s390/scsi/zfcp_diag.c
+++ b/drivers/s390/scsi/zfcp_diag.c
@@ -20,7 +20,10 @@
 #include "zfcp_def.h"
 
 /* Max age of data in a diagnostics buffer before it needs a refresh (in ms). */
-#define ZFCP_DIAG_MAX_AGE (5 * 1000)
+static unsigned int zfcp_diag_max_age = (5 * 1000);
+module_param_named(diag_max_age, zfcp_diag_max_age, uint, 0600);
+MODULE_PARM_DESC(diag_max_age,
+	"How much time (in ms) can pass before a diagnostics buffer needs a refresh (default 5s)");
 
 static DECLARE_WAIT_QUEUE_HEAD(__zfcp_diag_publish_wait);
 
@@ -40,7 +43,7 @@ int zfcp_diag_adapter_setup(struct zfcp_adapter *const adapter)
 {
 	/* set the timestamp so that the first test on age will always fail */
 	const unsigned long initial_timestamp =
-		jiffies - msecs_to_jiffies(ZFCP_DIAG_MAX_AGE);
+		jiffies - msecs_to_jiffies(zfcp_diag_max_age);
 	struct zfcp_diag_adapter *diag;
 	struct zfcp_diag_header *hdr;
 
@@ -229,7 +232,7 @@ __zfcp_diag_test_buffer_age_isfresh(const struct zfcp_diag_header *const hdr)
 	if (!time_after_eq(now, hdr->timestamp))
 		return false;
 
-	if (jiffies_to_msecs(now - hdr->timestamp) >= ZFCP_DIAG_MAX_AGE)
+	if (jiffies_to_msecs(now - hdr->timestamp) >= zfcp_diag_max_age)
 		return false;
 
 	return true;
-- 
2.16.4

From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 06 Dec 2018 16:31:21 +0000
Subject: [PATCH 2/2] zfcp: improve kdoc for return of zfcp_status_read_refill()
Message-Id: <20181206163121.32160-3-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Complements

v2.6.35 commit 64deb6efdc55
("[SCSI] zfcp: Use status_read_buf_num provided by FCP channel")
which replaced the hardcoded 16 with a variable value

Also complements already existing fixups for above commit

v2.6.35 commit 8d88cf3f3b9a
("[SCSI] zfcp: Update status read mempool")
v3.10   commit 9edf7d75ee5f
("[SCSI] zfcp: status read buffers on first adapter open with link down")

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_aux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 882789fff574..9cf30d124b9e 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -264,10 +264,10 @@ static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
  * zfcp_status_read_refill - refill the long running status_read_requests
  * @adapter: ptr to struct zfcp_adapter for which the buffers should be refilled
  *
- * Returns: 0 on success, 1 otherwise
- *
- * if there are 16 or more status_read requests missing an adapter_reopen
- * is triggered
+ * Return:
+ * * 0 on success meaning at least one status read is pending
+ * * 1 if posting failed and not a single status read buffer is pending,
+ *     also triggers adapter reopen recovery
  */
 int zfcp_status_read_refill(struct zfcp_adapter *adapter)
 {
-- 
2.16.4

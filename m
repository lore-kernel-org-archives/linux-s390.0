Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] s390: zfcp_aux: remove unnecessary null pointer check before mempool_destroy
Date: Sat, 8 Sep 2018 17:41:45 +0800
Message-ID: <1536399705-21676-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: maier@linux.ibm.com, bblock@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

mempool_destroy has taken null pointer check into account. so remove the
redundant check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 94f4d8f..e06c3f2 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers(struct zfcp_adapter *adapter)
 
 static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
 {
-	if (adapter->pool.erp_req)
-		mempool_destroy(adapter->pool.erp_req);
-	if (adapter->pool.scsi_req)
-		mempool_destroy(adapter->pool.scsi_req);
-	if (adapter->pool.scsi_abort)
-		mempool_destroy(adapter->pool.scsi_abort);
-	if (adapter->pool.qtcb_pool)
-		mempool_destroy(adapter->pool.qtcb_pool);
-	if (adapter->pool.status_read_req)
-		mempool_destroy(adapter->pool.status_read_req);
-	if (adapter->pool.sr_data)
-		mempool_destroy(adapter->pool.sr_data);
-	if (adapter->pool.gid_pn)
-		mempool_destroy(adapter->pool.gid_pn);
+	mempool_destroy(adapter->pool.erp_req);
+	mempool_destroy(adapter->pool.scsi_req);
+	mempool_destroy(adapter->pool.scsi_abort);
+	mempool_destroy(adapter->pool.qtcb_pool);
+	mempool_destroy(adapter->pool.status_read_req);
+	mempool_destroy(adapter->pool.sr_data);
+	mempool_destroy(adapter->pool.gid_pn);
 }
 
 /**
-- 
1.7.12.4

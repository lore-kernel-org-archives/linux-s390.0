Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: [PATCH] [SCSI] zfcp: NULL check before some freeing functions is
 not needed.
From: Thomas Meyer <thomas@m3y3r.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1543760930051-347492467-5-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
Date: Sun, 02 Dec 2018 21:52:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: maier@linux.ibm.com, bblock@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers
 
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

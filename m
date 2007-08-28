From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:11:19 +0000
Subject: [PATCH 1/10] zfcp: fix memory leak.
Message-Id: <200708280911.19836.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Subject: [PATCH] zfcp: fix memory leak.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Singed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_scsi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2007-08-27 13:22:18.000000000 +0200
@@ -764,7 +764,9 @@ zfcp_reset_fc_host_stats(struct Scsi_Hos
 		return;
 
 	ret = zfcp_fsf_exchange_port_data(NULL, adapter, data);
-	if (ret == 0) {
+	if (ret) {
+		kfree(data);
+	} else {
 		adapter->stats_reset = jiffies/HZ;
 		old_data = adapter->stats_reset_data;
 		adapter->stats_reset_data = data; /* finally freed in

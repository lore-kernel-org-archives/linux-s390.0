From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:06 +0000
Subject: [PATCH 24/25] zfcp: add port speed capabilities
Message-Id: <20180517171507.18237-25-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Jens Remus <jremus@linux.ibm.com>

Add port speed capabilities as defined in FC-LS RPSC ELS that have a
counterpart FC_PORTSPEED_* defined in scsi/scsi_transport_fc.h.

Suggested-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Acked-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 049fdd968130..3c86e27f094d 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -4,7 +4,7 @@
  *
  * Implementation of FSF commands.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -437,6 +437,9 @@ void zfcp_fsf_req_dismiss_all(struct zfcp_adapter *adapter)
 #define ZFCP_FSF_PORTSPEED_10GBIT	(1 <<  3)
 #define ZFCP_FSF_PORTSPEED_8GBIT	(1 <<  4)
 #define ZFCP_FSF_PORTSPEED_16GBIT	(1 <<  5)
+#define ZFCP_FSF_PORTSPEED_32GBIT	(1 <<  6)
+#define ZFCP_FSF_PORTSPEED_64GBIT	(1 <<  7)
+#define ZFCP_FSF_PORTSPEED_128GBIT	(1 <<  8)
 #define ZFCP_FSF_PORTSPEED_NOT_NEGOTIATED (1 << 15)
 
 static u32 zfcp_fsf_convert_portspeed(u32 fsf_speed)
@@ -454,6 +457,12 @@ static u32 zfcp_fsf_convert_portspeed(u32 fsf_speed)
 		fdmi_speed |= FC_PORTSPEED_8GBIT;
 	if (fsf_speed & ZFCP_FSF_PORTSPEED_16GBIT)
 		fdmi_speed |= FC_PORTSPEED_16GBIT;
+	if (fsf_speed & ZFCP_FSF_PORTSPEED_32GBIT)
+		fdmi_speed |= FC_PORTSPEED_32GBIT;
+	if (fsf_speed & ZFCP_FSF_PORTSPEED_64GBIT)
+		fdmi_speed |= FC_PORTSPEED_64GBIT;
+	if (fsf_speed & ZFCP_FSF_PORTSPEED_128GBIT)
+		fdmi_speed |= FC_PORTSPEED_128GBIT;
 	if (fsf_speed & ZFCP_FSF_PORTSPEED_NOT_NEGOTIATED)
 		fdmi_speed |= FC_PORTSPEED_NOT_NEGOTIATED;
 	return fdmi_speed;
-- 
2.16.3

From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:30:42 +0000
Subject: [PATCH 4/10] zfcp: avoid if (whatever) ; constructs.
Message-Id: <200708280930.42822.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Avoid "if (whatever) ;" constructs since they seem to confuse people,
even if there is a comment.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_erp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	2007-08-27 13:22:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c	2007-08-27 13:22:20.000000000 +0200
@@ -1687,8 +1687,8 @@ zfcp_erp_strategy_followup_actions(int a
 		break;
 
 	case ZFCP_ERP_ACTION_REOPEN_UNIT:
-		if (status == ZFCP_ERP_SUCCEEDED) ;	/* no further action */
-		else
+		/* Nothing to do if status == ZFCP_ERP_SUCCEEDED */
+		if (status != ZFCP_ERP_SUCCEEDED)
 			zfcp_erp_port_reopen_internal(unit->port, 0);
 		break;
 	}

From: Swen Schillig <swen@vnet.ibm.com>
Subject: [PATCH 5/5] zfcp: clear boxed flag on unit reopen.
Date: Tue, 8 May 2007 11:19:57 +0200
Message-ID: <200705081119.57569.swen@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The boxed flag for units was never cleared. This doesn't hurt, but on
ACL updates the error recovery could reopen more units than needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_fsf.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.orig/drivers/s390/scsi/zfcp_fsf.c	2007-05-07 16:26:34.000000000 +0200
+++ linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2007-05-07 16:34:16.000000000 +0200
@@ -3043,6 +3043,7 @@
 	queue_designator = &header->fsf_status_qual.fsf_queue_designator;

 	atomic_clear_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED |
+			  ZFCP_STATUS_COMMON_ACCESS_BOXED |
 			  ZFCP_STATUS_UNIT_SHARED |
 			  ZFCP_STATUS_UNIT_READONLY,
 			  &unit->status);


-------------------------------------------------------

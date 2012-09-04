From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH 5/8] zfcp: remove invalid reference to list iterator variable
Date: Tue, 04 Sep 2012 15:23:33 +0200
Message-ID: <20120904132348.738575595@linux.vnet.ibm.com>
References: <20120904132328.564402930@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline; filename=709-zfcp-remove-invalid-reference-to-list-iterator-variable.patch
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Julia Lawall <Julia.Lawall@lip6.fr>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <Julia.Lawall@lip6.fr>

If list_for_each_entry, etc complete a traversal of the list, the iterator
variable ends up pointing to an address at an offset from the list head,
and not a meaningful structure.  Thus this value should not be used after
the end of the iterator.  Replace port->adapter->scsi_host by
adapter->scsi_host.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).

Oversight in upsteam commit of v2.6.37
a1ca48319a9aa1c5b57ce142f538e76050bb8972
"[SCSI] zfcp: Move ACL/CFDC code to zfcp_cfdc.c"
which merged the content of zfcp_erp_port_access_changed().

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org> #2.6.37+
---
 drivers/s390/scsi/zfcp_cfdc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/scsi/zfcp_cfdc.c
+++ b/drivers/s390/scsi/zfcp_cfdc.c
@@ -293,7 +293,7 @@ void zfcp_cfdc_adapter_access_changed(st
 	}
 	read_unlock_irqrestore(&adapter->port_list_lock, flags);
 
-	shost_for_each_device(sdev, port->adapter->scsi_host) {
+	shost_for_each_device(sdev, adapter->scsi_host) {
 		zfcp_sdev = sdev_to_zfcp(sdev);
 		status = atomic_read(&zfcp_sdev->status);
 		if ((status & ZFCP_STATUS_COMMON_ACCESS_DENIED) ||

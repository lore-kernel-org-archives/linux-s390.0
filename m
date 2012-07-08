Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 7/7] drivers/s390/scsi/zfcp_cfdc.c: remove invalid reference to list iterator variable
Date: Sun,  8 Jul 2012 13:37:44 +0200
Message-Id: <1341747464-1772-8-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1341747464-1772-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1341747464-1772-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: kernel-janitors@vger.kernel.org, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <Julia.Lawall@lip6.fr>

If list_for_each_entry, etc complete a traversal of the list, the iterator
variable ends up pointing to an address at an offset from the list head,
and not a meaningful structure.  Thus this value should not be used after
the end of the iterator.  Replace port->adapter->scsi_host by
adapter->scsi_host.

This problem was found using Coccinelle (http://coccinelle.lip6.fr/).

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
This is not tested, an I am not sure that this is the right change.
Indeed, I'm not at all sure how the original code could have worked, since
port->adapter->scsi_host should be a completely random value.

 drivers/s390/scsi/zfcp_cfdc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_cfdc.c b/drivers/s390/scsi/zfcp_cfdc.c
index fab2c25..8ed63aa 100644
--- a/drivers/s390/scsi/zfcp_cfdc.c
+++ b/drivers/s390/scsi/zfcp_cfdc.c
@@ -293,7 +293,7 @@ void zfcp_cfdc_adapter_access_changed(struct zfcp_adapter *adapter)
 	}
 	read_unlock_irqrestore(&adapter->port_list_lock, flags);
 
-	shost_for_each_device(sdev, port->adapter->scsi_host) {
+	shost_for_each_device(sdev, adapter->scsi_host) {
 		zfcp_sdev = sdev_to_zfcp(sdev);
 		status = atomic_read(&zfcp_sdev->status);
 		if ((status & ZFCP_STATUS_COMMON_ACCESS_DENIED) ||

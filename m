Return-Path: <linux-kernel-owner+w=401wt.eu-S1752682AbXJWG3k@vger.kernel.org>
Date: Tue, 23 Oct 2007 08:28:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 04/10] [SG] Update drivers to use sg helpers
Message-ID: <20071023062857.GB24546@osiris.boeblingen.de.ibm.com>
References: <1193076664-13652-1-git-send-email-jens.axboe@oracle.com> <1193076664-13652-5-git-send-email-jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1193076664-13652-5-git-send-email-jens.axboe@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@elte.hu, Christoph Schmitt <schmichr@de.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 22, 2007 at 08:10:58PM +0200, Jens Axboe wrote:
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> ---

You forgot s390's zfcp driver. But unfortunately the trivial fix below
doesn't work. No more I/O possible. Swen and/or Christof could you
provide a correct fix for this please? Thanks!

---
 drivers/s390/scsi/zfcp_def.h |    4 ++--
 drivers/s390/scsi/zfcp_erp.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/s390/scsi/zfcp_def.h
===================================================================
--- linux-2.6.orig/drivers/s390/scsi/zfcp_def.h
+++ linux-2.6/drivers/s390/scsi/zfcp_def.h
@@ -63,7 +63,7 @@
 static inline void *
 zfcp_sg_to_address(struct scatterlist *list)
 {
-	return (void *) (page_address(list->page) + list->offset);
+	return (void *) (page_address(sg_page(list) + list->offset));
 }
 
 /**
@@ -74,7 +74,7 @@ zfcp_sg_to_address(struct scatterlist *l
 static inline void
 zfcp_address_to_sg(void *address, struct scatterlist *list)
 {
-	list->page = virt_to_page(address);
+	sg_set_page(list, virt_to_page(address));
 	list->offset = ((unsigned long) address) & (PAGE_SIZE - 1);
 }
 
Index: linux-2.6/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- linux-2.6.orig/drivers/s390/scsi/zfcp_erp.c
+++ linux-2.6/drivers/s390/scsi/zfcp_erp.c
@@ -363,7 +363,7 @@ zfcp_erp_adisc(struct zfcp_port *port)
 	retval = -ENOMEM;
  freemem:
 	if (address != NULL)
-		__free_pages(send_els->req->page, 0);
+		__free_pages(sg_page(send_els->req), 0);
 	if (send_els != NULL) {
 		kfree(send_els->req);
 		kfree(send_els->resp);
@@ -437,7 +437,7 @@ zfcp_erp_adisc_handler(unsigned long dat
 
  out:
 	zfcp_port_put(port);
-	__free_pages(send_els->req->page, 0);
+	__free_pages(sg_page(send_els->req), 0);
 	kfree(send_els->req);
 	kfree(send_els->resp);
 	kfree(send_els);

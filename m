Return-Path: <linux-kernel-owner+w=401wt.eu-S1756662AbXJXF3R@vger.kernel.org>
Date: Wed, 24 Oct 2007 07:29:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] sg: add missing sg_init_table calls to zfcp
Message-ID: <20071024052900.GB12335@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Christoph Schmitt <schmichr@de.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

CONFIG_DEBUG_SG reveals two missing sg_init_table calls. Add them.

kernel BUG at include/linux/scatterlist.h:50!
illegal operation: 0001 [#1]
[...]
Call Trace:
([<000000000026f184>] zfcp_ns_gid_pn_request+0x4c/0x2a0)
 [<0000000000276dd4>] zfcp_erp_strategy_do_action+0x1410/0x1938
 [<0000000000278412>] zfcp_erp_thread+0x4fa/0x1430
 [<000000000001990a>] kernel_thread_starter+0x6/0xc
 [<0000000000019904>] kernel_thread_starter+0x0/0xc

Cc: Swen Schillig <swen@vnet.ibm.com>
Cc: Christof Schmitt <christof.schmitt@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Jens, could you please push this one via your tree? Thanks!

 drivers/s390/scsi/zfcp_aux.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- linux-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ linux-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -1518,6 +1518,8 @@ zfcp_gid_pn_buffers_alloc(struct zfcp_gi
                 return -ENOMEM;
 
 	memset(data, 0, sizeof(*data));
+	sg_init_table(&data->req , 1);
+	sg_init_table(&data->resp , 1);
         data->ct.req = &data->req;
         data->ct.resp = &data->resp;
 	data->ct.req_count = data->ct.resp_count = 1;

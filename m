From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH RESEND 4/4] zfcp: enable FCP hardware data router by default
Date: Thu, 22 Aug 2013 17:49:34 +0200
Message-ID: <1377186574-26954-5-git-send-email-maier@linux.vnet.ibm.com>
References: <1377099366.2011.23.camel@dabdike.int.hansenpartnership.com>
 <1377186574-26954-1-git-send-email-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1377186574-26954-1-git-send-email-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Enabling the data router support by default
can increase performance in certain situations.
It is safe to do so and tolerated in LPAR and under z/VM
in case there is no data router support in that environment.

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_qdio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -16,9 +16,9 @@
 
 #define QBUFF_PER_PAGE		(PAGE_SIZE / sizeof(struct qdio_buffer))
 
-static bool enable_multibuffer;
+static bool enable_multibuffer = 1;
 module_param_named(datarouter, enable_multibuffer, bool, 0400);
-MODULE_PARM_DESC(datarouter, "Enable hardware data router support");
+MODULE_PARM_DESC(datarouter, "Enable hardware data router support (default on)");
 
 static int zfcp_qdio_buffers_enqueue(struct qdio_buffer **sbal)
 {

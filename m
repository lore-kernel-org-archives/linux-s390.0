Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 06/12] [S390] dasd: drop unneeded newline
Date: Wed, 27 Dec 2017 15:51:39 +0100
Message-Id: <1514386305-7402-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: kernel-janitors@vger.kernel.org, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

DBF_DEV_EVENT prints a newline at the end of the message string,
so the message string does not need to include a newline explicitly.
Done using Coccinelle.

The two strings are also concatenated into one for easier grepping.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/s390/block/dasd_diag.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index f035c2f..96c507a 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -329,8 +329,7 @@ static void dasd_ext_handler(struct ext_code ext_code,
 		private = kzalloc(sizeof(*private), GFP_KERNEL);
 		if (private == NULL) {
 			DBF_DEV_EVENT(DBF_WARNING, device, "%s",
-				"Allocating memory for private DASD data "
-				      "failed\n");
+				"Allocating memory for private DASD data failed");
 			return -ENOMEM;
 		}
 		ccw_device_get_id(device->cdev, &private->dev_id);

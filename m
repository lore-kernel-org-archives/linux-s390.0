Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] s390/dasd: fix spelling mistake: "supportet" -> "supported"
Date: Thu, 23 Feb 2017 11:06:09 +0000
Message-Id: <20170223110609.12675-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in literal string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/s390/block/dasd_eckd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 0f17137..0b38217 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4864,7 +4864,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 			break;
 		case 3: /* tsa_intrg */
 			len += sprintf(page + len, PRINTK_HEADER
-				      " tsb->tsa.intrg.: not supportet yet\n");
+				      " tsb->tsa.intrg.: not supported yet\n");
 			break;
 		}
 
-- 
2.10.2

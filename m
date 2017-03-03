Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] s390: scsi, use setup_timer instead of init_timer
Date: Fri,  3 Mar 2017 13:46:00 +0100
Message-Id: <20170303124600.30225-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: maier@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Koren=C4=8Dik?= <xkorenc1@fi.muni.cz>, Jiri Slaby <jslaby@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Lukáš Korenčik <xkorenc1@fi.muni.cz>

Use inicialization with setup_timer function instead of using
init_timer function and data fields. It improves readability.

Signed-off-by: Lukáš Korenčik <xkorenc1@fi.muni.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: <linux-s390@vger.kernel.org>
---
 drivers/s390/scsi/zfcp_erp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 7ccfce559034..14c0cbe335b3 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -572,9 +572,8 @@ static void zfcp_erp_memwait_handler(unsigned long data)
 
 static void zfcp_erp_strategy_memwait(struct zfcp_erp_action *erp_action)
 {
-	init_timer(&erp_action->timer);
-	erp_action->timer.function = zfcp_erp_memwait_handler;
-	erp_action->timer.data = (unsigned long) erp_action;
+	setup_timer(&erp_action->timer, zfcp_erp_memwait_handler,
+		(unsigned long) erp_action);
 	erp_action->timer.expires = jiffies + HZ;
 	add_timer(&erp_action->timer);
 }
-- 
2.12.0

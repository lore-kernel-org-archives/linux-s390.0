From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 02/22] zfcp: use setup_timer instead of init_timer
Date: Fri, 28 Jul 2017 12:30:48 +0200
Message-ID: <d820492c73697e8a187735b03e14e54657333208.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Koren=C4=8Dik?= <xkorenc1@fi.muni.cz>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Lukáš Korenčik <xkorenc1@fi.muni.cz>

Use initialization with setup_timer function instead of using
init_timer function and data fields. It improves readability.

Signed-off-by: Lukáš Korenčik <xkorenc1@fi.muni.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 7ccfce559034..37408f5f81ce 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -572,9 +572,8 @@ static void zfcp_erp_memwait_handler(unsigned long data)
 
 static void zfcp_erp_strategy_memwait(struct zfcp_erp_action *erp_action)
 {
-	init_timer(&erp_action->timer);
-	erp_action->timer.function = zfcp_erp_memwait_handler;
-	erp_action->timer.data = (unsigned long) erp_action;
+	setup_timer(&erp_action->timer, zfcp_erp_memwait_handler,
+		    (unsigned long) erp_action);
 	erp_action->timer.expires = jiffies + HZ;
 	add_timer(&erp_action->timer);
 }
-- 
2.11.2

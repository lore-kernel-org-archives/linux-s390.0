Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/2] 390/qeth: Delete an unnecessary variable initialisation
 in qeth_core_set_online()
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688F13A.70601@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688F198.4040109@users.sourceforge.net>
Date: Sun, 3 Jan 2016 11:02:00 +0100
MIME-Version: 1.0
In-Reply-To: <5688F13A.70601@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Jan 2016 10:48:05 +0100

Omit explicit initialisation at the beginning for one local variable
that is redefined before its first use.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7871537..54fde2e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5637,7 +5637,7 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 static int qeth_core_set_online(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	int rc = 0;
+	int rc;
 	int def_discipline;
 
 	if (!card->discipline) {
-- 
2.6.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/2] 390/qeth: Refactoring for qeth_core_set_online()
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688F13A.70601@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688F1D0.3090502@users.sourceforge.net>
Date: Sun, 3 Jan 2016 11:02:56 +0100
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
Date: Sun, 3 Jan 2016 10:50:11 +0100

Reduce the scope for the local variable "def_discipline" to one branch
of an if statement.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/net/qeth_core_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 54fde2e..3261977 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5638,9 +5638,10 @@ static int qeth_core_set_online(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc;
-	int def_discipline;
 
 	if (!card->discipline) {
+		int def_discipline;
+
 		if (card->info.type == QETH_CARD_TYPE_IQD)
 			def_discipline = QETH_DISCIPLINE_LAYER3;
 		else
-- 
2.6.3

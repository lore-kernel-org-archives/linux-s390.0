Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] qeth: don't rely on signedness of char
Date: Sat,  5 Dec 2015 22:32:52 +0100
Message-Id: <1449351173-6915-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

AFAICT, char is unsigned on s390. Relying on that is a little
subtle. The problem here is that if char happens to be signed and
e.g. card->info.mcl_level[2] contains the value -16, the formatted
output will be "fffffff0", thus overflowing card->info.mcl_level
(which has size 5). To help future readers, simply do an explicit mask
so that the value passed to sprintf is in 0-255. If char is indeed
unsigned, gcc should be able to elide the masking.

In any case, the subsequent 0-termination is redundant, since sprintf
has done that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/s390/net/qeth_core_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 31ac53fa5cee..84bc4b862fbb 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2682,10 +2682,8 @@ void qeth_print_status_message(struct qeth_card *card)
 		 * */
 		if (!card->info.mcl_level[0]) {
 			sprintf(card->info.mcl_level, "%02x%02x",
-				card->info.mcl_level[2],
-				card->info.mcl_level[3]);
-
-			card->info.mcl_level[QETH_MCL_LENGTH] = 0;
+				card->info.mcl_level[2] & 0xff,
+				card->info.mcl_level[3] & 0xff);
 			break;
 		}
 		/* fallthrough */
-- 
2.6.1

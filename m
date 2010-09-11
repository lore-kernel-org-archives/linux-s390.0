Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] drivers: s390: remove custom implementation of hex_to_bin()
Date: Sat, 11 Sep 2010 16:36:38 +0300
Message-Id: <1284212198-25849-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/cio/blacklist.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 13cb601..76058a5 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -79,17 +79,15 @@ static int pure_hex(char **cp, unsigned int *val, int min_digit,
 		    int max_digit, int max_val)
 {
 	int diff;
-	unsigned int value;
 
 	diff = 0;
 	*val = 0;
 
-	while (isxdigit(**cp) && (diff <= max_digit)) {
+	while (diff <= max_digit) {
+		int value = hex_to_bin(**cp);
 
-		if (isdigit(**cp))
-			value = **cp - '0';
-		else
-			value = tolower(**cp) - 'a' + 10;
+		if (value < 0)
+			break;
 		*val = *val * 16 + value;
 		(*cp)++;
 		diff++;
-- 
1.7.2.2

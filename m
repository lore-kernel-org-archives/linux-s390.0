Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stefan Weil <weil@mail.berlios.de>
Subject: [PATCH 1/2] s390: Fix wrong size in memcmp (netiucv)
Date: Sat, 29 Jan 2011 22:33:27 +0100
Message-Id: <1296336808-2809-1-git-send-email-weil@mail.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux390@de.ibm.com
Cc: Stefan Weil <weil@mail.berlios.de>, Ursula Braun <ursula.braun@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This error was reported by cppcheck:
drivers/s390/net/netiucv.c:568: error: Using sizeof for array given as function argument returns the size of pointer.

sizeof(ipuser) did not result in 16 (as many programmers would have
expected) but sizeof(u8 *), so it is 4 or 8, too small here.

Cc: Ursula Braun <ursula.braun@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Weil <weil@mail.berlios.de>
---
 drivers/s390/net/netiucv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 65ebee0..b6a6356 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -565,7 +565,7 @@ static int netiucv_callback_connreq(struct iucv_path *path,
 	struct iucv_event ev;
 	int rc;
 
-	if (memcmp(iucvMagic, ipuser, sizeof(ipuser)))
+	if (memcmp(iucvMagic, ipuser, 16))
 		/* ipuser must match iucvMagic. */
 		return -EINVAL;
 	rc = -EINVAL;
-- 
1.7.2.3

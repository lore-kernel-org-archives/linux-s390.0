Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [PATCH 11/15] drivers/s390: Replace hardcoding of 19 with MAX_NICE.
Date: Tue, 11 Mar 2014 12:59:26 +0800
Message-Id: <218fc526ce96a71a2e1cc186762cfca7ed0bdc04.1394513466.git.yangds.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1394513466.git.yangds.fnst@cn.fujitsu.com>
References: <cover.1394513466.git.yangds.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: joe@perches.com, peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de, Dongsheng Yang <yangds.fnst@cn.fujitsu.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
cc: linux-s390@vger.kernel.org
cc: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index ab3baa7..8eec165 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1803,7 +1803,7 @@ static int ap_poll_thread(void *data)
 	int requests;
 	struct ap_device *ap_dev;
 
-	set_user_nice(current, 19);
+	set_user_nice(current, MAX_NICE);
 	while (1) {
 		if (ap_suspend_flag)
 			return 0;
-- 
1.8.2.1

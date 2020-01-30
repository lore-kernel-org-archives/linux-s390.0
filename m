Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390: Cleanup removed IOSCHED_DEADLINE
Date: Thu, 30 Jan 2020 20:25:57 +0100
Message-Id: <20200130192557.3320-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
remove legacy IO schedulers").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/s390/block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index a8682f69effc..1f06b19cb290 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -26,7 +26,7 @@ config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
 	depends on CCW && BLOCK
-	select IOSCHED_DEADLINE
+	select MQ_IOSCHED_DEADLINE
 	help
 	  Enable this option if you want to access DASDs directly utilizing
 	  S/390s channel subsystem commands. This is necessary for running
-- 
2.17.1

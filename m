Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] s390: lib: Export __delay
Date: Tue,  4 Aug 2015 23:38:23 -0700
Message-Id: <1438756703-2586-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Radha Mohan Chintakuntla <rchintakuntla@cavium.com>, David Daney <david.daney@cavium.com>
List-ID: <linux-s390.vger.kernel.org>

__delay is exported by most architectures, and may be used in modules.
Since it is not exported for s390, s390:allmodconfig currently fails
to build with

ERROR: "__delay" [drivers/net/phy/mdio-octeon.ko] undefined!

Fixes: a6d678645210 ("net: mdio-octeon: Modify driver to work on both
	ThunderX and Octeon")
Cc: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/s390/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 16dc42d83f93..246a7eb4b680 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -26,6 +26,7 @@ void __delay(unsigned long loops)
          */
 	asm volatile("0: brct %0,0b" : : "d" ((loops/2) + 1));
 }
+EXPORT_SYMBOL(__delay);
 
 static void __udelay_disabled(unsigned long long usecs)
 {
-- 
2.1.4

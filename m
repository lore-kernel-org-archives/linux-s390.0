From: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Subject: [PATCH 4/7] drivers: zorro: Avoids building proc.o if CONFIG_ZORRO
 is disabled
Date: Tue, 25 Sep 2018 22:52:42 -0300
Message-ID: <20180926015242.GA14980@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Avoids building proc.o if 'make drivers/zorro/' is called and
CONFIG_ZORRO is disabled, even if CONFIG_PROC_FS is enabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/zorro/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
index b360ac4ea846..4e5c7045ac7a 100644
--- a/drivers/zorro/Makefile
+++ b/drivers/zorro/Makefile
@@ -4,8 +4,8 @@
 #
 
 obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
-obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_ZORRO_NAMES) +=  names.o
+zorro-$(CONFIG_PROC_FS)	+= proc.o
 
 hostprogs-y 		:= gen-devlist
 
-- 
2.19.0

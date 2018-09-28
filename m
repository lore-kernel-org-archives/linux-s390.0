From: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
Subject: [PATCH v3 4/7] drivers: zorro: Avoids building proc.o if CONFIG_ZORRO is disabled
Date: Thu, 27 Sep 2018 23:08:13 -0300
Message-ID: <20180928020816.11251-5-leobras.c@gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928020816.11251-1-leobras.c@gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Avoids building proc.o if 'make drivers/zorro/' is called and
CONFIG_ZORRO is disabled, even if CONFIG_PROC_FS is enabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/zorro/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
index b360ac4ea846..d580f9f08e0a 100644
--- a/drivers/zorro/Makefile
+++ b/drivers/zorro/Makefile
@@ -3,9 +3,10 @@
 # Makefile for the Zorro bus specific drivers.
 #
 
-obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
-obj-$(CONFIG_PROC_FS)	+= proc.o
-obj-$(CONFIG_ZORRO_NAMES) +=  names.o
+obj-$(CONFIG_ZORRO) 		:= zorro_all.o
+zorro_all-y			+= zorro.o zorro-driver.o zorro-sysfs.o
+zorro_all-$(CONFIG_ZORRO_NAMES) += names.o
+zorro_all-$(CONFIG_PROC_FS)	+= proc.o
 
 hostprogs-y 		:= gen-devlist
 
-- 
2.19.0

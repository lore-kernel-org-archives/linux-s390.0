From: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Subject: [PATCH 3/7] drivers: parisc: Avoids building driver if CONFIG_PARISC
 is disabled
Date: Tue, 25 Sep 2018 22:52:29 -0300
Message-ID: <20180926015229.GA14967@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Avoids building driver if 'make drivers/parisc/' is called and
CONFIG_PARISC is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/parisc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
index 3cd5e6cb8478..80049d763aa0 100644
--- a/drivers/parisc/Makefile
+++ b/drivers/parisc/Makefile
@@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)		+= eisa.o eisa_enumerator.o eisa_eeprom.o
 obj-$(CONFIG_SUPERIO)		+= superio.o
 obj-$(CONFIG_CHASSIS_LCD_LED)	+= led.o
 obj-$(CONFIG_PDC_STABLE)	+= pdc_stable.o
-obj-y				+= power.o
+obj-$(CONFIG_PARISC)		+= power.o
 
-- 
2.19.0

From: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
Subject: [PATCH 2/7] drivers: nubus: Avoids building driver if CONFIG_NUBUS
 is disabled
Date: Tue, 25 Sep 2018 22:52:18 -0300
Message-ID: <20180926015218.GA14964@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: lkcamp@lists.libreplanetbr.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Avoids building driver if 'make drivers/nubus/' is called and
CONFIG_NUBUS is disabled.
Avoids building proc.o if CONFIG_PROC_FS is enabled but
CONFIG_NUBUS is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/nubus/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
index 6d063cde39d1..827301c4a84f 100644
--- a/drivers/nubus/Makefile
+++ b/drivers/nubus/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the nubus specific drivers.
 #
 
-obj-y := nubus.o bus.o
-
-obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_NUBUS) := nubus.o
+nubus-y := bus.o
+nubus-$(CONFIG_PROC_FS) += proc.o
-- 
2.19.0

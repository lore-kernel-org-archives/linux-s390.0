From: =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
Subject: [PATCH v3 1/7] drivers: dio: Avoids building driver if CONFIG_DIO is disabled
Date: Thu, 27 Sep 2018 23:08:10 -0300
Message-ID: <20180928020816.11251-2-leobras.c@gmail.com>
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

Avoids building driver if 'make drivers/dio/' is called and
CONFIG_DIO is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/dio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/Makefile b/drivers/dio/Makefile
index ae92d17083f2..8fc80e805b90 100644
--- a/drivers/dio/Makefile
+++ b/drivers/dio/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := dio.o dio-driver.o dio-sysfs.o
+obj-$(CONFIG_DIO) := dio.o dio-driver.o dio-sysfs.o
-- 
2.19.0

Return-Path: <linux-kernel-owner+w=401wt.eu-S2992996AbXDTLfM@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:35:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 8/8] Kconfig: broadcom 4400 dependency.
Message-ID: <20070420113524.GI3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make the broadcom 4400 driver dependent on SSB. With the select statement
for SSB the config option for the driver is always present even if the
target of selection (SSB) is not available. 
Goes on top of git-wireless.patch.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/net/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/net/Kconfig linux-2.6-patched/drivers/net/Kconfig
--- linux-2.6/drivers/net/Kconfig	2007-04-19 16:19:36.000000000 +0200
+++ linux-2.6-patched/drivers/net/Kconfig	2007-04-19 16:20:01.000000000 +0200
@@ -1432,7 +1432,7 @@ config APRICOT
 
 config B44
 	tristate "Broadcom 4400 ethernet support"
-	select SSB
+	depends on SSB
 	select MII
 	help
 	  If you have a network (Ethernet) controller of this type, say Y and

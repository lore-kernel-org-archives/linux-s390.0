Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbXDWOOp@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:14:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 9/9] Kconfig: broadcom 4400 dependency.
Message-ID: <20070423141427.GJ21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

[PATCH 9/9] Kconfig: broadcom 4400 dependency.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add HAS_IOMEM dependency to the B44 "Broadcom 4400 ethernet support"
config option. This hides the option for s390.
Goes on top of git-wireless.patch.

Cc: Michael Buesch <mb@bu3sch.de>
Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/net/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/net/Kconfig linux-2.6-patched/drivers/net/Kconfig
--- linux-2.6/drivers/net/Kconfig	2007-04-23 15:51:44.000000000 +0200
+++ linux-2.6-patched/drivers/net/Kconfig	2007-04-23 15:53:16.000000000 +0200
@@ -1432,6 +1432,7 @@ config APRICOT
 
 config B44
 	tristate "Broadcom 4400 ethernet support"
+	depends on HAS_IOMEM
 	select SSB
 	select MII
 	help

Return-Path: <linux-kernel-owner+w=401wt.eu-S1761401AbXEJOAF@vger.kernel.org>
Message-Id: <20070510135646.171836016@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:52:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/15] Kconfig: no wireless on s390.
Content-Disposition: inline; filename=105-kconfig-wlan.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "John W. Linville" <linville@tuxdriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Hide the config menues for wireless on s390.

Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/net/wireless/Kconfig |    1 +
 net/Kconfig                  |    1 +
 2 files changed, 2 insertions(+)

Index: quilt-2.6/drivers/net/wireless/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/net/wireless/Kconfig
+++ quilt-2.6/drivers/net/wireless/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Wireless LAN"
+	depends on !S390
 
 config WLAN_PRE80211
 	bool "Wireless LAN (pre-802.11)"
Index: quilt-2.6/net/Kconfig
===================================================================
--- quilt-2.6.orig/net/Kconfig
+++ quilt-2.6/net/Kconfig
@@ -218,6 +218,7 @@ config FIB_RULES
 	bool
 
 menu "Wireless"
+	depends on !S390
 
 source "net/wireless/Kconfig"
 source "net/mac80211/Kconfig"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

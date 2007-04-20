Return-Path: <linux-kernel-owner+w=401wt.eu-S2993053AbXDTLdw@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:34:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 5/8] Kconfig: no wireless on s390.
Message-ID: <20070420113404.GF3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Hide the config menues for wireless on s390.
Goes on top of git-wireless.patch.

Cc: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/net/wireless/Kconfig |    1 +
 net/Kconfig                  |    1 +
 2 files changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/net/wireless/Kconfig linux-2.6-patched/drivers/net/wireless/Kconfig
--- linux-2.6/drivers/net/wireless/Kconfig	2007-04-19 15:24:39.000000000 +0200
+++ linux-2.6-patched/drivers/net/wireless/Kconfig	2007-04-19 15:52:22.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Wireless LAN"
+	depends on !S390
 
 config WLAN_PRE80211
 	bool "Wireless LAN (pre-802.11)"
diff -urpN linux-2.6/net/Kconfig linux-2.6-patched/net/Kconfig
--- linux-2.6/net/Kconfig	2007-04-19 15:24:49.000000000 +0200
+++ linux-2.6-patched/net/Kconfig	2007-04-19 15:52:22.000000000 +0200
@@ -217,6 +217,7 @@ config FIB_RULES
 	bool
 
 menu "Wireless"
+	depends on !S390
 
 source "net/wireless/Kconfig"
 source "net/mac80211/Kconfig"

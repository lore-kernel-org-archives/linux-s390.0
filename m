From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 4/5] lcs: avoid/reduce unused s390dbf debug areas.
Date: Fri, 08 Feb 2008 13:09:04 +0100
Message-ID: <20080208121514.540605000@linux.vnet.ibm.com>
References: <20080208120900.295604000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=760-lcs-dbf.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Tiedemann <ptiedem@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Tiedemann <ptiedem@de.ibm.com>

Since lcs makes use of 1 debug area only, the number of debug areas
is reduced, while the number of pages per area is increased.

Signed-off-by: Peter Tiedemann <ptiedem@de.ibm.com>
Signed-off-by: Ursula Braun <braunu@de.ibm.com>
---

 drivers/s390/net/lcs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-uschi/drivers/s390/net/lcs.c
===================================================================
--- linux-2.6-uschi.orig/drivers/s390/net/lcs.c
+++ linux-2.6-uschi/drivers/s390/net/lcs.c
@@ -94,7 +94,7 @@ static int
 lcs_register_debug_facility(void)
 {
 	lcs_dbf_setup = debug_register("lcs_setup", 2, 1, 8);
-	lcs_dbf_trace = debug_register("lcs_trace", 2, 2, 8);
+	lcs_dbf_trace = debug_register("lcs_trace", 4, 1, 8);
 	if (lcs_dbf_setup == NULL || lcs_dbf_trace == NULL) {
 		PRINT_ERR("Not enough memory for debug facility.\n");
 		lcs_unregister_debug_facility();

-- 

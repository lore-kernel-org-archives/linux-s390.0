From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/5] qeth: remove extraneous length from %pM format
Date: Tue, 15 Sep 2015 12:32:14 +0200
Message-ID: <1442313138-64526-2-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1442313138-64526-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1442313138-64526-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com, Eugene Crosser <Eugene.Crosser@ru.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

Length specifier in the %pM format is not supported (at least, not
documented). Remove it, and also an extraneous '&' for the array.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/s390/net/qeth_l2_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index a855669..693c6dbd 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1452,8 +1452,8 @@ static void qeth_bridge_emit_host_event(struct qeth_card *card,
 			env[i] = str[i]; i++;
 		}
 		if (code & IPA_ADDR_CHANGE_CODE_MACADDR) {
-			snprintf(str[i], sizeof(str[i]), "MAC=%pM6",
-				&addr_lnid->mac);
+			snprintf(str[i], sizeof(str[i]), "MAC=%pM",
+				addr_lnid->mac);
 			env[i] = str[i]; i++;
 		}
 		snprintf(str[i], sizeof(str[i]), "NTOK_BUSID=%x.%x.%04x",
-- 
2.3.8

From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] net/iucv: declare iucv_path_table_empty() as static
Date: Wed,  5 Sep 2018 16:55:12 +0200
Message-ID: <20180905145512.30165-4-jwi@linux.ibm.com>
References: <20180905145512.30165-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180905145512.30165-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Fixes a compile warning.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/iucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 8f7ef167c45a..eb502c6290c2 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1874,7 +1874,7 @@ static void iucv_pm_complete(struct device *dev)
  * Returns 0 if there are still iucv pathes defined
  *	   1 if there are no iucv pathes defined
  */
-int iucv_path_table_empty(void)
+static int iucv_path_table_empty(void)
 {
 	int i;
 
-- 
2.16.4

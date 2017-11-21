From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 2/2] net/smc: Fix preinitialization of buf_desc in __smc_buf_create()
Date: Tue, 21 Nov 2017 13:23:54 +0100
Message-ID: <20171121122354.44006-3-ubraun@linux.vnet.ibm.com>
References: <20171121122354.44006-1-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171121122354.44006-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, geert@linux-m68k.org, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Geert Uytterhoeven <geert@linux-m68k.org>

With gcc-4.1.2:

    net/smc/smc_core.c: In function ‘__smc_buf_create’:
    net/smc/smc_core.c:567: warning: ‘bufsize’ may be used uninitialized in this function

Indeed, if the for-loop is never executed, bufsize is used
uninitialized.  In addition, buf_desc is stored for later use, while it
is still a NULL pointer.

Before, error handling was done by checking if buf_desc is non-NULL.
The cleanup changed this to an error check, but forgot to update the
preinitialization of buf_desc to an error pointer.

Update the preinitializatin of buf_desc to fix this.

Fixes: b33982c3a6838d13 ("net/smc: cleanup function __smc_buf_create()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3b5e5d4bc763..94f21116dac5 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -562,7 +562,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_rmb)
 {
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
-	struct smc_buf_desc *buf_desc = NULL;
+	struct smc_buf_desc *buf_desc = ERR_PTR(-ENOMEM);
 	struct list_head *buf_list;
 	int bufsize, bufsize_short;
 	int sk_buf_size;
-- 
2.13.5

From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 7/9] net/smc: do a few smc_core.c cleanups
Date: Fri, 18 May 2018 09:34:16 +0200
Message-ID: <20180518073418.91878-8-ubraun@linux.ibm.com>
References: <20180518073418.91878-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180518073418.91878-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

This patch consists of Christmas tree fixes and removal of an unneeded
function parameter.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 66afa086ae72..c63cf7b07ccc 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -474,10 +474,10 @@ int smc_conn_create(struct smc_sock *smc,
 		    struct smc_clc_msg_local *lcl, int srv_first_contact)
 {
 	struct smc_connection *conn = &smc->conn;
+	int local_contact = SMC_FIRST_CONTACT;
 	struct smc_link_group *lgr;
 	unsigned short vlan_id;
 	enum smc_lgr_role role;
-	int local_contact = SMC_FIRST_CONTACT;
 	int rc = 0;
 
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
@@ -573,11 +573,9 @@ int smc_uncompress_bufsize(u8 compressed)
 /* try to reuse a sndbuf or rmb description slot for a certain
  * buffer size; if not available, return NULL
  */
-static inline
-struct smc_buf_desc *smc_buf_get_slot(struct smc_link_group *lgr,
-				      int compressed_bufsize,
-				      rwlock_t *lock,
-				      struct list_head *buf_list)
+static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
+					     rwlock_t *lock,
+					     struct list_head *buf_list)
 {
 	struct smc_buf_desc *buf_slot;
 
@@ -662,9 +660,9 @@ static struct smc_buf_desc *smc_new_buf_create(struct smc_link_group *lgr,
 
 static int __smc_buf_create(struct smc_sock *smc, bool is_rmb)
 {
+	struct smc_buf_desc *buf_desc = ERR_PTR(-ENOMEM);
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
-	struct smc_buf_desc *buf_desc = ERR_PTR(-ENOMEM);
 	struct list_head *buf_list;
 	int bufsize, bufsize_short;
 	int sk_buf_size;
@@ -692,7 +690,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_rmb)
 			continue;
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(lgr, bufsize_short, lock, buf_list);
+		buf_desc = smc_buf_get_slot(bufsize_short, lock, buf_list);
 		if (buf_desc) {
 			memset(buf_desc->cpu_addr, 0, bufsize);
 			break; /* found reusable slot */
-- 
2.16.3

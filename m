From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 03/10] net/smc: remove sock_error detour in clc-functions
Date: Thu, 22 Nov 2018 10:26:36 +0100
Message-ID: <20181122092643.26820-4-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

There is no need to store the return value in sk_err, if it is
afterwards cleared again with sock_error(). This patch sets the
return value directly. Just cleanup, no functional change.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 89c3a8c7859a..7278ec0cfa58 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -374,10 +374,8 @@ int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info)
 	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
 			     sizeof(struct smc_clc_msg_decline));
 	if (len < sizeof(struct smc_clc_msg_decline))
-		smc->sk.sk_err = EPROTO;
-	if (len < 0)
-		smc->sk.sk_err = -len;
-	return sock_error(&smc->sk);
+		len = -EPROTO;
+	return len > 0 ? 0 : len;
 }
 
 /* send CLC PROPOSAL message across internal TCP socket */
@@ -536,7 +534,6 @@ int smc_clc_send_accept(struct smc_sock *new_smc, int srv_first_contact)
 	struct smc_link *link;
 	struct msghdr msg;
 	struct kvec vec;
-	int rc = 0;
 	int len;
 
 	memset(&aclc, 0, sizeof(aclc));
@@ -589,13 +586,8 @@ int smc_clc_send_accept(struct smc_sock *new_smc, int srv_first_contact)
 	vec.iov_len = ntohs(aclc.hdr.length);
 	len = kernel_sendmsg(new_smc->clcsock, &msg, &vec, 1,
 			     ntohs(aclc.hdr.length));
-	if (len < ntohs(aclc.hdr.length)) {
-		if (len >= 0)
-			new_smc->sk.sk_err = EPROTO;
-		else
-			new_smc->sk.sk_err = new_smc->clcsock->sk->sk_err;
-		rc = sock_error(&new_smc->sk);
-	}
+	if (len < ntohs(aclc.hdr.length))
+		len = len >= 0 ? -EPROTO : -new_smc->clcsock->sk->sk_err;
 
-	return rc;
+	return len > 0 ? 0 : len;
 }
-- 
2.16.4

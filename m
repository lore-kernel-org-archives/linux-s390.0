Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/5] net/smc: move netinfo function to file smc_clc.c
Date: Wed, 21 Feb 2018 12:32:33 +0100
In-Reply-To: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
References: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180221113235.46702-4-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

The function smc_netinfo_by_tcpsk() belongs to CLC handling.
Move it to smc_clc.c and rename to smc_clc_netinfo_by_tcpsk.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c  | 42 +-----------------------------------------
 net/smc/smc.h     |  2 --
 net/smc/smc_clc.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 net/smc/smc_clc.h |  2 ++
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b1961a789837..b90cbfdb9916 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -24,7 +24,6 @@
 
 #include <linux/module.h>
 #include <linux/socket.h>
-#include <linux/inetdevice.h>
 #include <linux/workqueue.h>
 #include <linux/in.h>
 #include <linux/sched/signal.h>
@@ -273,45 +272,6 @@ static void smc_copy_sock_settings_to_smc(struct smc_sock *smc)
 	smc_copy_sock_settings(&smc->sk, smc->clcsock->sk, SK_FLAGS_CLC_TO_SMC);
 }
 
-/* determine subnet and mask of internal TCP socket */
-int smc_netinfo_by_tcpsk(struct socket *clcsock,
-			 __be32 *subnet, u8 *prefix_len)
-{
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
-	struct in_device *in_dev;
-	struct sockaddr_in addr;
-	int rc = -ENOENT;
-
-	if (!dst) {
-		rc = -ENOTCONN;
-		goto out;
-	}
-	if (!dst->dev) {
-		rc = -ENODEV;
-		goto out_rel;
-	}
-
-	/* get address to which the internal TCP socket is bound */
-	kernel_getsockname(clcsock, (struct sockaddr *)&addr);
-	/* analyze IPv4 specific data of net_device belonging to TCP socket */
-	rcu_read_lock();
-	in_dev = __in_dev_get_rcu(dst->dev);
-	for_ifa(in_dev) {
-		if (!inet_ifa_match(addr.sin_addr.s_addr, ifa))
-			continue;
-		*prefix_len = inet_mask_len(ifa->ifa_mask);
-		*subnet = ifa->ifa_address & ifa->ifa_mask;
-		rc = 0;
-		break;
-	} endfor_ifa(in_dev);
-	rcu_read_unlock();
-
-out_rel:
-	dst_release(dst);
-out:
-	return rc;
-}
-
 static int smc_clnt_conf_first_link(struct smc_sock *smc)
 {
 	struct smc_link_group *lgr = smc->conn.lgr;
@@ -808,7 +768,7 @@ static void smc_listen_work(struct work_struct *work)
 	}
 
 	/* determine subnet and mask from internal TCP socket */
-	rc = smc_netinfo_by_tcpsk(newclcsock, &subnet, &prefix_len);
+	rc = smc_clc_netinfo_by_tcpsk(newclcsock, &subnet, &prefix_len);
 	if (rc) {
 		reason_code = SMC_CLC_DECL_CNFERR; /* configuration error */
 		goto decline_rdma;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 9518986c97b1..9895c190d146 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -263,8 +263,6 @@ static inline bool using_ipsec(struct smc_sock *smc)
 
 struct smc_clc_msg_local;
 
-int smc_netinfo_by_tcpsk(struct socket *clcsock, __be32 *subnet,
-			 u8 *prefix_len);
 void smc_conn_free(struct smc_connection *conn);
 int smc_conn_create(struct smc_sock *smc, __be32 peer_in_addr,
 		    struct smc_ib_device *smcibdev, u8 ibport,
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index dff318a2d5bf..874c5a75d6dd 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/in.h>
+#include <linux/inetdevice.h>
 #include <linux/if_ether.h>
 #include <linux/sched/signal.h>
 
@@ -73,6 +74,45 @@ static bool smc_clc_msg_hdr_valid(struct smc_clc_msg_hdr *clcm)
 	return true;
 }
 
+/* determine subnet and mask of internal TCP socket */
+int smc_clc_netinfo_by_tcpsk(struct socket *clcsock,
+			     __be32 *subnet, u8 *prefix_len)
+{
+	struct dst_entry *dst = sk_dst_get(clcsock->sk);
+	struct in_device *in_dev;
+	struct sockaddr_in addr;
+	int rc = -ENOENT;
+
+	if (!dst) {
+		rc = -ENOTCONN;
+		goto out;
+	}
+	if (!dst->dev) {
+		rc = -ENODEV;
+		goto out_rel;
+	}
+
+	/* get address to which the internal TCP socket is bound */
+	kernel_getsockname(clcsock, (struct sockaddr *)&addr);
+	/* analyze IPv4 specific data of net_device belonging to TCP socket */
+	rcu_read_lock();
+	in_dev = __in_dev_get_rcu(dst->dev);
+	for_ifa(in_dev) {
+		if (!inet_ifa_match(addr.sin_addr.s_addr, ifa))
+			continue;
+		*prefix_len = inet_mask_len(ifa->ifa_mask);
+		*subnet = ifa->ifa_address & ifa->ifa_mask;
+		rc = 0;
+		break;
+	} endfor_ifa(in_dev);
+	rcu_read_unlock();
+
+out_rel:
+	dst_release(dst);
+out:
+	return rc;
+}
+
 /* Wait for data on the tcp-socket, analyze received data
  * Returns:
  * 0 if success and it was not a decline that we received.
@@ -214,8 +254,8 @@ int smc_clc_send_proposal(struct smc_sock *smc,
 
 	memset(&pclc_prfx, 0, sizeof(pclc_prfx));
 	/* determine subnet and mask from internal TCP socket */
-	rc = smc_netinfo_by_tcpsk(smc->clcsock, &pclc_prfx.outgoing_subnet,
-				  &pclc_prfx.prefix_len);
+	rc = smc_clc_netinfo_by_tcpsk(smc->clcsock, &pclc_prfx.outgoing_subnet,
+				      &pclc_prfx.prefix_len);
 	if (rc)
 		return SMC_CLC_DECL_CNFERR; /* configuration error */
 	pclc_prfx.ipv6_prefixes_cnt = 0;
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index aab3aae2a2ce..a20fc75efb24 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -121,6 +121,8 @@ smc_clc_proposal_get_prefix(struct smc_clc_msg_proposal *pclc)
 	       ((u8 *)pclc + sizeof(*pclc) + ntohs(pclc->iparea_offset));
 }
 
+int smc_clc_netinfo_by_tcpsk(struct socket *clcsock, __be32 *subnet,
+			     u8 *prefix_len);
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		     u8 expected_type);
 int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info);
-- 
2.13.5

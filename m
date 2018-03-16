Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/3] net/smc: restructure netinfo for CLC proposal msgs
Date: Fri, 16 Mar 2018 15:06:39 +0100
In-Reply-To: <20180316140641.7059-1-ubraun@linux.vnet.ibm.com>
References: <20180316140641.7059-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180316140641.7059-2-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

Introduce functions smc_clc_prfx_set to retrieve IP information for the
CLC proposal msg and smc_clc_prfx_match to match the contents of a
proposal message against the IP addresses of the net device. The new
functions replace the functionality provided by smc_clc_netinfo_by_tcpsk,
which is removed by this patch. The match functionality is extended to
scan all ipv4 addresses of the net device for a match against the
ipv4 subnet from the proposal msg.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c  |  14 ++------
 net/smc/smc_clc.c | 100 +++++++++++++++++++++++++++++++++++++++++-------------
 net/smc/smc_clc.h |   4 +--
 3 files changed, 82 insertions(+), 36 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 649489f825a5..949a2714a453 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -767,8 +767,6 @@ static void smc_listen_work(struct work_struct *work)
 	struct smc_link *link;
 	int reason_code = 0;
 	int rc = 0;
-	__be32 subnet;
-	u8 prefix_len;
 	u8 ibport;
 
 	/* check if peer is smc capable */
@@ -803,17 +801,11 @@ static void smc_listen_work(struct work_struct *work)
 		goto decline_rdma;
 	}
 
-	/* determine subnet and mask from internal TCP socket */
-	rc = smc_clc_netinfo_by_tcpsk(newclcsock, &subnet, &prefix_len);
-	if (rc) {
-		reason_code = SMC_CLC_DECL_CNFERR; /* configuration error */
-		goto decline_rdma;
-	}
-
 	pclc = (struct smc_clc_msg_proposal *)&buf;
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
-	if (pclc_prfx->outgoing_subnet != subnet ||
-	    pclc_prfx->prefix_len != prefix_len) {
+
+	rc = smc_clc_prfx_match(newclcsock, pclc_prfx);
+	if (rc) {
 		reason_code = SMC_CLC_DECL_CNFERR; /* configuration error */
 		goto decline_rdma;
 	}
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 874c5a75d6dd..dc3a2235978d 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -74,15 +74,35 @@ static bool smc_clc_msg_hdr_valid(struct smc_clc_msg_hdr *clcm)
 	return true;
 }
 
-/* determine subnet and mask of internal TCP socket */
-int smc_clc_netinfo_by_tcpsk(struct socket *clcsock,
-			     __be32 *subnet, u8 *prefix_len)
+/* find ipv4 addr on device and get the prefix len, fill CLC proposal msg */
+static int smc_clc_prfx_set4_rcu(struct dst_entry *dst, __be32 ipv4,
+				 struct smc_clc_msg_proposal_prefix *prop)
+{
+	struct in_device *in_dev = __in_dev_get_rcu(dst->dev);
+
+	if (!in_dev)
+		return -ENODEV;
+	for_ifa(in_dev) {
+		if (!inet_ifa_match(ipv4, ifa))
+			continue;
+		prop->prefix_len = inet_mask_len(ifa->ifa_mask);
+		prop->outgoing_subnet = ifa->ifa_address & ifa->ifa_mask;
+		/* prop->ipv6_prefixes_cnt = 0; already done by memset before */
+		return 0;
+	} endfor_ifa(in_dev);
+	return -ENOENT;
+}
+
+/* retrieve and set prefixes in CLC proposal msg */
+static int smc_clc_prfx_set(struct socket *clcsock,
+			    struct smc_clc_msg_proposal_prefix *prop)
 {
 	struct dst_entry *dst = sk_dst_get(clcsock->sk);
-	struct in_device *in_dev;
-	struct sockaddr_in addr;
+	struct sockaddr_storage addrs;
+	struct sockaddr_in *addr;
 	int rc = -ENOENT;
 
+	memset(prop, 0, sizeof(*prop));
 	if (!dst) {
 		rc = -ENOTCONN;
 		goto out;
@@ -91,22 +111,58 @@ int smc_clc_netinfo_by_tcpsk(struct socket *clcsock,
 		rc = -ENODEV;
 		goto out_rel;
 	}
-
 	/* get address to which the internal TCP socket is bound */
-	kernel_getsockname(clcsock, (struct sockaddr *)&addr);
-	/* analyze IPv4 specific data of net_device belonging to TCP socket */
+	kernel_getsockname(clcsock, (struct sockaddr *)&addrs);
+	/* analyze IP specific data of net_device belonging to TCP socket */
 	rcu_read_lock();
-	in_dev = __in_dev_get_rcu(dst->dev);
+	if (addrs.ss_family == PF_INET) {
+		/* IPv4 */
+		addr = (struct sockaddr_in *)&addrs;
+		rc = smc_clc_prfx_set4_rcu(dst, addr->sin_addr.s_addr, prop);
+	}
+	rcu_read_unlock();
+out_rel:
+	dst_release(dst);
+out:
+	return rc;
+}
+
+/* match ipv4 addrs of dev against addr in CLC proposal */
+static int smc_clc_prfx_match4_rcu(struct net_device *dev,
+				   struct smc_clc_msg_proposal_prefix *prop)
+{
+	struct in_device *in_dev = __in_dev_get_rcu(dev);
+
+	if (!in_dev)
+		return -ENODEV;
 	for_ifa(in_dev) {
-		if (!inet_ifa_match(addr.sin_addr.s_addr, ifa))
-			continue;
-		*prefix_len = inet_mask_len(ifa->ifa_mask);
-		*subnet = ifa->ifa_address & ifa->ifa_mask;
-		rc = 0;
-		break;
+		if (prop->prefix_len == inet_mask_len(ifa->ifa_mask) &&
+		    inet_ifa_match(prop->outgoing_subnet, ifa))
+			return 0;
 	} endfor_ifa(in_dev);
-	rcu_read_unlock();
 
+	return -ENOENT;
+}
+
+/* check if proposed prefixes match one of our device prefixes */
+int smc_clc_prfx_match(struct socket *clcsock,
+		       struct smc_clc_msg_proposal_prefix *prop)
+{
+	struct dst_entry *dst = sk_dst_get(clcsock->sk);
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
+	rcu_read_lock();
+	if (!prop->ipv6_prefixes_cnt)
+		rc = smc_clc_prfx_match4_rcu(dst->dev, prop);
+	rcu_read_unlock();
 out_rel:
 	dst_release(dst);
 out:
@@ -240,6 +296,11 @@ int smc_clc_send_proposal(struct smc_sock *smc,
 	struct msghdr msg;
 	int len, plen, rc;
 
+	/* retrieve ip prefixes for CLC proposal msg */
+	rc = smc_clc_prfx_set(smc->clcsock, &pclc_prfx);
+	if (rc)
+		return SMC_CLC_DECL_CNFERR; /* configuration error */
+
 	/* send SMC Proposal CLC message */
 	plen = sizeof(pclc) + sizeof(pclc_prfx) + sizeof(trl);
 	memset(&pclc, 0, sizeof(pclc));
@@ -252,13 +313,6 @@ int smc_clc_send_proposal(struct smc_sock *smc,
 	memcpy(&pclc.lcl.mac, &smcibdev->mac[ibport - 1], ETH_ALEN);
 	pclc.iparea_offset = htons(0);
 
-	memset(&pclc_prfx, 0, sizeof(pclc_prfx));
-	/* determine subnet and mask from internal TCP socket */
-	rc = smc_clc_netinfo_by_tcpsk(smc->clcsock, &pclc_prfx.outgoing_subnet,
-				      &pclc_prfx.prefix_len);
-	if (rc)
-		return SMC_CLC_DECL_CNFERR; /* configuration error */
-	pclc_prfx.ipv6_prefixes_cnt = 0;
 	memcpy(trl.eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
 	memset(&msg, 0, sizeof(msg));
 	vec[0].iov_base = &pclc;
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 20e048beac30..5ddb0d22eb8a 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -122,8 +122,8 @@ smc_clc_proposal_get_prefix(struct smc_clc_msg_proposal *pclc)
 	       ((u8 *)pclc + sizeof(*pclc) + ntohs(pclc->iparea_offset));
 }
 
-int smc_clc_netinfo_by_tcpsk(struct socket *clcsock, __be32 *subnet,
-			     u8 *prefix_len);
+int smc_clc_prfx_match(struct socket *clcsock,
+		       struct smc_clc_msg_proposal_prefix *prop);
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		     u8 expected_type);
 int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info);
-- 
2.13.5

From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next v2 2/4] net/smc: ipv6 support for smc_diag.c
Date: Wed,  2 May 2018 16:56:45 +0200
Message-ID: <20180502145647.36147-3-ubraun@linux.ibm.com>
References: <20180502145647.36147-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180502145647.36147-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Update smc_diag.c to support ipv6 addresses on the diagnosis interface.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_diag.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 427b91c1c964..05dd7e6d314d 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -38,17 +38,27 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
 
-	r->diag_family = sk->sk_family;
 	if (!smc->clcsock)
 		return;
 	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
 	r->id.idiag_dport = smc->clcsock->sk->sk_dport;
 	r->id.idiag_if = smc->clcsock->sk->sk_bound_dev_if;
 	sock_diag_save_cookie(sk, r->id.idiag_cookie);
-	memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
-	memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
-	r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
-	r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
+	if (sk->sk_protocol == SMCPROTO_SMC) {
+		r->diag_family = PF_INET;
+		memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
+		memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
+		r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
+		r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (sk->sk_protocol == SMCPROTO_SMC6) {
+		r->diag_family = PF_INET6;
+		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
+		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
+		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
+		       sizeof(smc->clcsock->sk->sk_v6_daddr));
+#endif
+	}
 }
 
 static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
@@ -153,7 +163,8 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
+static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
+			       struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *bc = NULL;
@@ -161,8 +172,8 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct sock *sk;
 	int rc = 0;
 
-	read_lock(&smc_proto.h.smc_hash->lock);
-	head = &smc_proto.h.smc_hash->ht;
+	read_lock(&prot->h.smc_hash->lock);
+	head = &prot->h.smc_hash->ht;
 	if (hlist_empty(head))
 		goto out;
 
@@ -175,7 +186,17 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 out:
-	read_unlock(&smc_proto.h.smc_hash->lock);
+	read_unlock(&prot->h.smc_hash->lock);
+	return rc;
+}
+
+static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int rc = 0;
+
+	rc = smc_diag_dump_proto(&smc_proto, skb, cb);
+	if (!rc)
+		rc = smc_diag_dump_proto(&smc_proto6, skb, cb);
 	return rc;
 }
 
-- 
2.13.5

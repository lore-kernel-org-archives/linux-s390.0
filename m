Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/3] net/smc: enable ipv6 support for smc
Date: Fri, 16 Mar 2018 15:06:41 +0100
In-Reply-To: <20180316140641.7059-1-ubraun@linux.vnet.ibm.com>
References: <20180316140641.7059-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180316140641.7059-4-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

Add ipv6 support to the smc socket layer functions. Make use of the
updated clc layer functions to retrieve and match ipv6 information.
The indicator for ipv4 or ipv6 is the protocol constant that is provided
in the socket() call with address family AF_SMC.

Based-on-patch-by: Takanori Ueda <tkueda@jp.ibm.com>

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 64 ++++++++++++++++++++++++++++++++++++++++++--------------
 net/smc/smc.h    |  4 +++-
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 949a2714a453..86913eb5cfa0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -7,12 +7,11 @@
  *  applicable with RoCE-cards only
  *
  *  Initial restrictions:
- *    - IPv6 support postponed
  *    - support for alternate links postponed
  *    - partial support for non-blocking sockets only
  *    - support for urgent data postponed
  *
- *  Copyright IBM Corp. 2016
+ *  Copyright IBM Corp. 2016, 2018
  *
  *  Author(s):  Ursula Braun <ubraun@linux.vnet.ibm.com>
  *              based on prototype from Frank Blaschka
@@ -64,6 +63,10 @@ static struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
 };
 
+static struct smc_hashinfo smc_v6_hashinfo = {
+	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
+};
+
 int smc_hash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
@@ -103,6 +106,18 @@ struct proto smc_proto = {
 };
 EXPORT_SYMBOL_GPL(smc_proto);
 
+struct proto smc_proto6 = {
+	.name		= "SMC6",
+	.owner		= THIS_MODULE,
+	.keepalive	= smc_set_keepalive,
+	.hash		= smc_hash_sk,
+	.unhash		= smc_unhash_sk,
+	.obj_size	= sizeof(struct smc_sock),
+	.h.smc_hash	= &smc_v6_hashinfo,
+	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+};
+EXPORT_SYMBOL_GPL(smc_proto6);
+
 static int smc_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -159,19 +174,22 @@ static void smc_destruct(struct sock *sk)
 	sk_refcnt_debug_dec(sk);
 }
 
-static struct sock *smc_sock_alloc(struct net *net, struct socket *sock)
+static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
+				   int protocol)
 {
 	struct smc_sock *smc;
+	struct proto *prot;
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, &smc_proto, 0);
+	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
+	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
 	if (!sk)
 		return NULL;
 
 	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
 	sk->sk_state = SMC_INIT;
 	sk->sk_destruct = smc_destruct;
-	sk->sk_protocol = SMCPROTO_SMC;
+	sk->sk_protocol = protocol;
 	smc = smc_sk(sk);
 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
 	INIT_LIST_HEAD(&smc->accept_q);
@@ -198,10 +216,13 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 
 	rc = -EAFNOSUPPORT;
+	if (addr->sin_family != AF_INET &&
+	    addr->sin_family != AF_INET6 &&
+	    addr->sin_family != AF_UNSPEC)
+		goto out;
 	/* accept AF_UNSPEC (mapped to AF_INET) only if s_addr is INADDR_ANY */
-	if ((addr->sin_family != AF_INET) &&
-	    ((addr->sin_family != AF_UNSPEC) ||
-	     (addr->sin_addr.s_addr != htonl(INADDR_ANY))))
+	if (addr->sin_family == AF_UNSPEC &&
+	    addr->sin_addr.s_addr != htonl(INADDR_ANY))
 		goto out;
 
 	lock_sock(sk);
@@ -529,7 +550,7 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 	/* separate smc parameter checking to be safe */
 	if (alen < sizeof(addr->sa_family))
 		goto out_err;
-	if (addr->sa_family != AF_INET)
+	if (addr->sa_family != AF_INET && addr->sa_family != AF_INET6)
 		goto out_err;
 
 	lock_sock(sk);
@@ -571,7 +592,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	int rc;
 
 	release_sock(lsk);
-	new_sk = smc_sock_alloc(sock_net(lsk), NULL);
+	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
 	if (!new_sk) {
 		rc = -ENOMEM;
 		lsk->sk_err = ENOMEM;
@@ -1367,6 +1388,7 @@ static const struct proto_ops smc_sock_ops = {
 static int smc_create(struct net *net, struct socket *sock, int protocol,
 		      int kern)
 {
+	int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
 	struct smc_sock *smc;
 	struct sock *sk;
 	int rc;
@@ -1376,20 +1398,20 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 		goto out;
 
 	rc = -EPROTONOSUPPORT;
-	if ((protocol != IPPROTO_IP) && (protocol != IPPROTO_TCP))
+	if (protocol != SMCPROTO_SMC && protocol != SMCPROTO_SMC6)
 		goto out;
 
 	rc = -ENOBUFS;
 	sock->ops = &smc_sock_ops;
-	sk = smc_sock_alloc(net, sock);
+	sk = smc_sock_alloc(net, sock, protocol);
 	if (!sk)
 		goto out;
 
 	/* create internal TCP socket for CLC handshake and fallback */
 	smc = smc_sk(sk);
 	smc->use_fallback = false; /* assume rdma capability first */
-	rc = sock_create_kern(net, PF_INET, SOCK_STREAM,
-			      IPPROTO_TCP, &smc->clcsock);
+	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+			      &smc->clcsock);
 	if (rc) {
 		sk_common_release(sk);
 		goto out;
@@ -1429,16 +1451,23 @@ static int __init smc_init(void)
 
 	rc = proto_register(&smc_proto, 1);
 	if (rc) {
-		pr_err("%s: proto_register fails with %d\n", __func__, rc);
+		pr_err("%s: proto_register(v4) fails with %d\n", __func__, rc);
 		goto out_pnet;
 	}
 
+	rc = proto_register(&smc_proto6, 1);
+	if (rc) {
+		pr_err("%s: proto_register(v6) fails with %d\n", __func__, rc);
+		goto out_proto;
+	}
+
 	rc = sock_register(&smc_sock_family_ops);
 	if (rc) {
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
-		goto out_proto;
+		goto out_proto6;
 	}
 	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
+	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
@@ -1451,6 +1480,8 @@ static int __init smc_init(void)
 
 out_sock:
 	sock_unregister(PF_SMC);
+out_proto6:
+	proto_unregister(&smc_proto6);
 out_proto:
 	proto_unregister(&smc_proto);
 out_pnet:
@@ -1475,6 +1506,7 @@ static void __exit smc_exit(void)
 	static_branch_disable(&tcp_have_smc);
 	smc_ib_unregister_client();
 	sock_unregister(PF_SMC);
+	proto_unregister(&smc_proto6);
 	proto_unregister(&smc_proto);
 	smc_pnet_exit();
 }
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 268cdf11533c..e4829a2f46ba 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -18,11 +18,13 @@
 
 #include "smc_ib.h"
 
-#define SMCPROTO_SMC		0	/* SMC protocol */
+#define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
+#define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
 
 #define SMC_MAX_PORTS		2	/* Max # of ports */
 
 extern struct proto smc_proto;
+extern struct proto smc_proto6;
 
 #ifdef ATOMIC64_INIT
 #define KERNEL_HAS_ATOMIC64
-- 
2.13.5

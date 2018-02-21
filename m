Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/5] net/smc: remove unused fields from smc structures
Date: Wed, 21 Feb 2018 12:32:34 +0100
In-Reply-To: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
References: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
Message-Id: <20180221113235.46702-5-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.vnet.ibm.com>

The daddr field holds the destination IPv4 address. The field was set but
never used and can be removed. The addr field was a left-over from an
earlier version of non-blocking connects and can be removed.
The result of the call to kernel_getpeername is not used, the call can be
removed. Non-blocking connects are working, so remove restriction comment.

Signed-off-by: Karsten Graul <kgraul@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c   | 15 ++++-----------
 net/smc/smc.h      |  3 +--
 net/smc/smc_core.c |  7 +++----
 net/smc/smc_core.h |  1 -
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b90cbfdb9916..cda3d5314e3f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -7,7 +7,6 @@
  *  applicable with RoCE-cards only
  *
  *  Initial restrictions:
- *    - non-blocking connect postponed
  *    - IPv6 support postponed
  *    - support for alternate links postponed
  *    - partial support for non-blocking sockets only
@@ -345,7 +344,6 @@ static void smc_lgr_forget(struct smc_link_group *lgr)
 /* setup for RDMA connection of client */
 static int smc_connect_rdma(struct smc_sock *smc)
 {
-	struct sockaddr_in *inaddr = (struct sockaddr_in *)smc->addr;
 	struct smc_clc_msg_accept_confirm aclc;
 	int local_contact = SMC_FIRST_CONTACT;
 	struct smc_ib_device *smcibdev;
@@ -399,8 +397,8 @@ static int smc_connect_rdma(struct smc_sock *smc)
 
 	srv_first_contact = aclc.hdr.flag;
 	mutex_lock(&smc_create_lgr_pending);
-	local_contact = smc_conn_create(smc, inaddr->sin_addr.s_addr, smcibdev,
-					ibport, &aclc.lcl, srv_first_contact);
+	local_contact = smc_conn_create(smc, smcibdev, ibport, &aclc.lcl,
+					srv_first_contact);
 	if (local_contact < 0) {
 		rc = local_contact;
 		if (rc == -ENOMEM)
@@ -518,7 +516,6 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		goto out_err;
 	if (addr->sa_family != AF_INET)
 		goto out_err;
-	smc->addr = addr;	/* needed for nonblocking connect */
 
 	lock_sock(sk);
 	switch (sk->sk_state) {
@@ -726,7 +723,6 @@ static void smc_listen_work(struct work_struct *work)
 	struct sock *newsmcsk = &new_smc->sk;
 	struct smc_clc_msg_proposal *pclc;
 	struct smc_ib_device *smcibdev;
-	struct sockaddr_in peeraddr;
 	u8 buf[SMC_CLC_MAX_LEN];
 	struct smc_link *link;
 	int reason_code = 0;
@@ -782,13 +778,10 @@ static void smc_listen_work(struct work_struct *work)
 		goto decline_rdma;
 	}
 
-	/* get address of the peer connected to the internal TCP socket */
-	kernel_getpeername(newclcsock, (struct sockaddr *)&peeraddr);
-
 	/* allocate connection / link group */
 	mutex_lock(&smc_create_lgr_pending);
-	local_contact = smc_conn_create(new_smc, peeraddr.sin_addr.s_addr,
-					smcibdev, ibport, &pclc->lcl, 0);
+	local_contact = smc_conn_create(new_smc, smcibdev, ibport, &pclc->lcl,
+					0);
 	if (local_contact < 0) {
 		rc = local_contact;
 		if (rc == -ENOMEM)
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 9895c190d146..268cdf11533c 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -172,7 +172,6 @@ struct smc_sock {				/* smc sock container */
 	struct sock		sk;
 	struct socket		*clcsock;	/* internal tcp socket */
 	struct smc_connection	conn;		/* smc connection */
-	struct sockaddr		*addr;		/* inet connect address */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	tcp_listen_work;/* handle tcp socket accepts */
 	struct work_struct	smc_listen_work;/* prepare new accept socket */
@@ -264,7 +263,7 @@ static inline bool using_ipsec(struct smc_sock *smc)
 struct smc_clc_msg_local;
 
 void smc_conn_free(struct smc_connection *conn);
-int smc_conn_create(struct smc_sock *smc, __be32 peer_in_addr,
+int smc_conn_create(struct smc_sock *smc,
 		    struct smc_ib_device *smcibdev, u8 ibport,
 		    struct smc_clc_msg_local *lcl, int srv_first_contact);
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2424c7100aaf..bc11d06e38ae 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -144,7 +144,7 @@ static void smc_lgr_free_work(struct work_struct *work)
 }
 
 /* create a new SMC link group */
-static int smc_lgr_create(struct smc_sock *smc, __be32 peer_in_addr,
+static int smc_lgr_create(struct smc_sock *smc,
 			  struct smc_ib_device *smcibdev, u8 ibport,
 			  char *peer_systemid, unsigned short vlan_id)
 {
@@ -161,7 +161,6 @@ static int smc_lgr_create(struct smc_sock *smc, __be32 peer_in_addr,
 	}
 	lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 	lgr->sync_err = false;
-	lgr->daddr = peer_in_addr;
 	memcpy(lgr->peer_systemid, peer_systemid, SMC_SYSTEMID_LEN);
 	lgr->vlan_id = vlan_id;
 	rwlock_init(&lgr->sndbufs_lock);
@@ -400,7 +399,7 @@ static int smc_link_determine_gid(struct smc_link_group *lgr)
 }
 
 /* create a new SMC connection (and a new link group if necessary) */
-int smc_conn_create(struct smc_sock *smc, __be32 peer_in_addr,
+int smc_conn_create(struct smc_sock *smc,
 		    struct smc_ib_device *smcibdev, u8 ibport,
 		    struct smc_clc_msg_local *lcl, int srv_first_contact)
 {
@@ -457,7 +456,7 @@ int smc_conn_create(struct smc_sock *smc, __be32 peer_in_addr,
 
 create:
 	if (local_contact == SMC_FIRST_CONTACT) {
-		rc = smc_lgr_create(smc, peer_in_addr, smcibdev, ibport,
+		rc = smc_lgr_create(smc, smcibdev, ibport,
 				    lcl->id_for_peer, vlan_id);
 		if (rc)
 			goto out;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index fe691bf9af91..7852c3fabf12 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -124,7 +124,6 @@ struct smc_rtoken {				/* address/key of remote RMB */
 struct smc_link_group {
 	struct list_head	list;
 	enum smc_lgr_role	role;		/* client or server */
-	__be32			daddr;		/* destination ip address */
 	struct smc_link		lnk[SMC_LINKS_PER_LGR_MAX];	/* smc link */
 	char			peer_systemid[SMC_SYSTEMID_LEN];
 						/* unique system_id of peer */
-- 
2.13.5

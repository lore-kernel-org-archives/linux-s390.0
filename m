From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 06/10] net/smc: short wait for late smc_clc_wait_msg
Date: Thu, 22 Nov 2018 10:26:39 +0100
Message-ID: <20181122092643.26820-7-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

After sending one of the initial LLC messages CONFIRM LINK or
ADD LINK, there is already a wait for the LLC response. It does
not make sense to wait another long time for a CLC DECLINE. Thus
this patch introduces a shorter wait time for these cases.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  | 15 ++++++++-------
 net/smc/smc_clc.c |  6 +++---
 net/smc/smc_clc.h |  3 ++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 66836cfbc587..93f7ff8f6e88 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -335,7 +335,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 		struct smc_clc_msg_decline dclc;
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
-				      SMC_CLC_DECLINE);
+				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
 		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
 	}
 
@@ -363,7 +363,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 		struct smc_clc_msg_decline dclc;
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
-				      SMC_CLC_DECLINE);
+				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
 		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_AL : rc;
 	}
 
@@ -533,7 +533,8 @@ static int smc_connect_clc(struct smc_sock *smc, int smc_type,
 	if (rc)
 		return rc;
 	/* receive SMC Accept CLC message */
-	return smc_clc_wait_msg(smc, aclc, sizeof(*aclc), SMC_CLC_ACCEPT);
+	return smc_clc_wait_msg(smc, aclc, sizeof(*aclc), SMC_CLC_ACCEPT,
+				CLC_WAIT_TIME);
 }
 
 /* setup for RDMA connection of client */
@@ -965,7 +966,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 		struct smc_clc_msg_decline dclc;
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
-				      SMC_CLC_DECLINE);
+				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
 		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
 	}
 
@@ -986,7 +987,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 		struct smc_clc_msg_decline dclc;
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
-				      SMC_CLC_DECLINE);
+				      SMC_CLC_DECLINE, CLC_WAIT_TIME_SHORT);
 		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_AL : rc;
 	}
 
@@ -1222,7 +1223,7 @@ static void smc_listen_work(struct work_struct *work)
 	 */
 	pclc = (struct smc_clc_msg_proposal *)&buf;
 	reason_code = smc_clc_wait_msg(new_smc, pclc, SMC_CLC_MAX_LEN,
-				       SMC_CLC_PROPOSAL);
+				       SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
 	if (reason_code) {
 		smc_listen_decline(new_smc, reason_code, 0);
 		return;
@@ -1272,7 +1273,7 @@ static void smc_listen_work(struct work_struct *work)
 
 	/* receive SMC Confirm CLC message */
 	reason_code = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
-				       SMC_CLC_CONFIRM);
+				       SMC_CLC_CONFIRM, CLC_WAIT_TIME);
 	if (reason_code) {
 		mutex_unlock(&smc_create_lgr_pending);
 		smc_listen_decline(new_smc, reason_code, local_contact);
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 62043d69e3a3..776e9dfc915d 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -265,7 +265,7 @@ int smc_clc_prfx_match(struct socket *clcsock,
  * clcsock error, -EINTR, -ECONNRESET, -EPROTO otherwise.
  */
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
-		     u8 expected_type)
+		     u8 expected_type, unsigned long timeout)
 {
 	long rcvtimeo = smc->clcsock->sk->sk_rcvtimeo;
 	struct sock *clc_sk = smc->clcsock->sk;
@@ -285,7 +285,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	 * sizeof(struct smc_clc_msg_hdr)
 	 */
 	krflags = MSG_PEEK | MSG_WAITALL;
-	smc->clcsock->sk->sk_rcvtimeo = CLC_WAIT_TIME;
+	clc_sk->sk_rcvtimeo = timeout;
 	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1,
 			sizeof(struct smc_clc_msg_hdr));
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
@@ -351,7 +351,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	}
 
 out:
-	smc->clcsock->sk->sk_rcvtimeo = rcvtimeo;
+	clc_sk->sk_rcvtimeo = rcvtimeo;
 	return reason_code;
 }
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 18da89b681c2..24658e8c0de4 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -27,6 +27,7 @@
 #define SMC_TYPE_D		1		/* SMC-D only		      */
 #define SMC_TYPE_B		3		/* SMC-R and SMC-D	      */
 #define CLC_WAIT_TIME		(6 * HZ)	/* max. wait time on clcsock  */
+#define CLC_WAIT_TIME_SHORT	HZ		/* short wait time on clcsock */
 #define SMC_CLC_DECL_MEM	0x01010000  /* insufficient memory resources  */
 #define SMC_CLC_DECL_TIMEOUT_CL	0x02010000  /* timeout w4 QP confirm link     */
 #define SMC_CLC_DECL_TIMEOUT_AL	0x02020000  /* timeout w4 QP add link	      */
@@ -182,7 +183,7 @@ struct smcd_dev;
 int smc_clc_prfx_match(struct socket *clcsock,
 		       struct smc_clc_msg_proposal_prefix *prop);
 int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
-		     u8 expected_type);
+		     u8 expected_type, unsigned long timeout);
 int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info);
 int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
 			  struct smc_ib_device *smcibdev, u8 ibport, u8 gid[],
-- 
2.16.4

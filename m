From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 04/10] net/smc: allow fallback after clc timeouts
Date: Thu, 22 Nov 2018 10:26:37 +0100
Message-ID: <20181122092643.26820-5-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If connection initialization fails for the LLC CONFIRM LINK or the
LLC ADD LINK step, fallback to TCP should be enabled. Thus
the negative return code -EAGAIN should switch to a positive timeout
reason code in these cases, and the internal CLC socket should
not have a set sk_err.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  | 8 ++++----
 net/smc/smc_clc.c | 9 +++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d9b1a0e4446c..66836cfbc587 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -336,7 +336,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
 				      SMC_CLC_DECLINE);
-		return rc;
+		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
 	}
 
 	if (link->llc_confirm_rc)
@@ -364,7 +364,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
 				      SMC_CLC_DECLINE);
-		return rc;
+		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_AL : rc;
 	}
 
 	/* send add link reject message, only one link supported for now */
@@ -966,7 +966,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
 				      SMC_CLC_DECLINE);
-		return rc;
+		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_CL : rc;
 	}
 
 	if (link->llc_confirm_resp_rc)
@@ -987,7 +987,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 
 		rc = smc_clc_wait_msg(smc, &dclc, sizeof(dclc),
 				      SMC_CLC_DECLINE);
-		return rc;
+		return rc == -EAGAIN ? SMC_CLC_DECL_TIMEOUT_AL : rc;
 	}
 
 	smc_llc_link_active(link, net->ipv4.sysctl_tcp_keepalive_time);
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 7278ec0cfa58..62043d69e3a3 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -297,7 +297,11 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	}
 	if (clc_sk->sk_err) {
 		reason_code = -clc_sk->sk_err;
-		smc->sk.sk_err = clc_sk->sk_err;
+		if (clc_sk->sk_err == EAGAIN &&
+		    expected_type == SMC_CLC_DECLINE)
+			clc_sk->sk_err = 0; /* reset for fallback usage */
+		else
+			smc->sk.sk_err = clc_sk->sk_err;
 		goto out;
 	}
 	if (!len) { /* peer has performed orderly shutdown */
@@ -306,7 +310,8 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		goto out;
 	}
 	if (len < 0) {
-		smc->sk.sk_err = -len;
+		if (len != -EAGAIN || expected_type != SMC_CLC_DECLINE)
+			smc->sk.sk_err = -len;
 		reason_code = len;
 		goto out;
 	}
-- 
2.16.4

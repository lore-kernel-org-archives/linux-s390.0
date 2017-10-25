From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V3 net-next 3/3] smc: add SMC rendezvous protocol
Date: Wed, 25 Oct 2017 11:01:46 +0200
Message-ID: <20171025090146.83471-4-ubraun@linux.vnet.ibm.com>
References: <20171025090146.83471-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171025090146.83471-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The SMC protocol [1] uses a rendezvous protocol to negotiate SMC
capability between peers. The current Linux implementation does not yet
use this rendezvous protocol and, thus, is not compliant to RFC7609 and
incompatible with other SMC implementations like in zOS.
This patch adds support for the SMC rendezvous protocol. It uses a new
TCP experimental option. With this option, SMC capabilities are
exchanged between the peers during the TCP three way handshake.

[1] SMC-R Informational RFC: http://www.rfc-editor.org/info/rfc7609

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/af_smc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 70f7640f5090..6451c5013e06 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -390,6 +390,12 @@ static int smc_connect_rdma(struct smc_sock *smc)
 	int rc = 0;
 	u8 ibport;
 
+	if (!tcp_sk(smc->clcsock->sk)->syn_smc) {
+		/* peer has not signalled SMC-capability */
+		smc->use_fallback = true;
+		goto out_connected;
+	}
+
 	/* IPSec connections opt out of SMC-R optimizations */
 	if (using_ipsec(smc)) {
 		reason_code = SMC_CLC_DECL_IPSEC;
@@ -555,6 +561,7 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 	}
 
 	smc_copy_sock_settings_to_clc(smc);
+	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 	rc = kernel_connect(smc->clcsock, addr, alen, flags);
 	if (rc)
 		goto out;
@@ -759,6 +766,12 @@ static void smc_listen_work(struct work_struct *work)
 	u8 prefix_len;
 	u8 ibport;
 
+	/* check if peer is smc capable */
+	if (!tcp_sk(newclcsock->sk)->syn_smc) {
+		new_smc->use_fallback = true;
+		goto out_connected;
+	}
+
 	/* do inband token exchange -
 	 *wait for and receive SMC Proposal CLC message
 	 */
@@ -967,6 +980,7 @@ static int smc_listen(struct socket *sock, int backlog)
 	 * them to the clc socket -- copy smc socket options to clc socket
 	 */
 	smc_copy_sock_settings_to_clc(smc);
+	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc)
@@ -1409,6 +1423,7 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 
+	static_branch_enable(&tcp_have_smc);
 	return 0;
 
 out_sock:
@@ -1433,6 +1448,7 @@ static void __exit smc_exit(void)
 		list_del_init(&lgr->list);
 		smc_lgr_free(lgr); /* free link group */
 	}
+	static_branch_disable(&tcp_have_smc);
 	smc_ib_unregister_client();
 	sock_unregister(PF_SMC);
 	proto_unregister(&smc_proto);
-- 
2.13.5

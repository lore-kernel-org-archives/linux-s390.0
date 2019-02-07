Return-Path: <SRS0=t9U+=QO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 7/7] net/smc: original socket family in inet_sock_diag
Date: Thu,  7 Feb 2019 15:56:20 +0100
In-Reply-To: <20190207145620.92811-1-ubraun@linux.ibm.com>
References: <20190207145620.92811-1-ubraun@linux.ibm.com>
Message-Id: <20190207145620.92811-8-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Commit ed75986f4aae ("net/smc: ipv6 support for smc_diag.c") changed the
value of the diag_family field. The idea was to indicate the family of
the IP address in the inet_diag_sockid field. But the change makes it
impossible to distinguish an inet_sock_diag response message from SMC
sock_diag response. This patch restores the original behaviour and sends
AF_SMC as value of the diag_family field.

Fixes: ed75986f4aae ("net/smc: ipv6 support for smc_diag.c")
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_diag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index dbf64a93d68a..371b4cf31fcd 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -38,6 +38,7 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
 
+	r->diag_family = sk->sk_family;
 	if (!smc->clcsock)
 		return;
 	r->id.idiag_sport = htons(smc->clcsock->sk->sk_num);
@@ -45,14 +46,12 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 	r->id.idiag_if = smc->clcsock->sk->sk_bound_dev_if;
 	sock_diag_save_cookie(sk, r->id.idiag_cookie);
 	if (sk->sk_protocol == SMCPROTO_SMC) {
-		r->diag_family = PF_INET;
 		memset(&r->id.idiag_src, 0, sizeof(r->id.idiag_src));
 		memset(&r->id.idiag_dst, 0, sizeof(r->id.idiag_dst));
 		r->id.idiag_src[0] = smc->clcsock->sk->sk_rcv_saddr;
 		r->id.idiag_dst[0] = smc->clcsock->sk->sk_daddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (sk->sk_protocol == SMCPROTO_SMC6) {
-		r->diag_family = PF_INET6;
 		memcpy(&r->id.idiag_src, &smc->clcsock->sk->sk_v6_rcv_saddr,
 		       sizeof(smc->clcsock->sk->sk_v6_rcv_saddr));
 		memcpy(&r->id.idiag_dst, &smc->clcsock->sk->sk_v6_daddr,
-- 
2.16.4

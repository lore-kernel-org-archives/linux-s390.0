From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/4] net/smc: return 0 for ioctl calls in states INIT and CLOSED
Date: Wed, 23 May 2018 16:38:09 +0200
Message-ID: <20180523143812.25824-2-ubraun@linux.ibm.com>
References: <20180523143812.25824-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180523143812.25824-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

A connected SMC-socket contains addresses of descriptors for the
send buffer and the rmb (receive buffer). Fields of these descriptors
are used to determine the answer for certain ioctl requests.
Add extra handling for unconnected SMC socket states without valid
buffer descriptor addresses.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Reported-by: syzbot+e6714328fda813fc670f@syzkaller.appspotmail.com
---
 net/smc/af_smc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 48530dab5c94..f2d925921d81 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1490,20 +1490,32 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 	case SIOCINQ: /* same as FIONREAD */
 		if (smc->sk.sk_state == SMC_LISTEN)
 			return -EINVAL;
-		answ = atomic_read(&smc->conn.bytes_to_rcv);
+		if (smc->sk.sk_state == SMC_INIT ||
+		    smc->sk.sk_state == SMC_CLOSED)
+			answ = 0;
+		else
+			answ = atomic_read(&smc->conn.bytes_to_rcv);
 		break;
 	case SIOCOUTQ:
 		/* output queue size (not send + not acked) */
 		if (smc->sk.sk_state == SMC_LISTEN)
 			return -EINVAL;
-		answ = smc->conn.sndbuf_desc->len -
+		if (smc->sk.sk_state == SMC_INIT ||
+		    smc->sk.sk_state == SMC_CLOSED)
+			answ = 0;
+		else
+			answ = smc->conn.sndbuf_desc->len -
 					atomic_read(&smc->conn.sndbuf_space);
 		break;
 	case SIOCOUTQNSD:
 		/* output queue size (not send only) */
 		if (smc->sk.sk_state == SMC_LISTEN)
 			return -EINVAL;
-		answ = smc_tx_prepared_sends(&smc->conn);
+		if (smc->sk.sk_state == SMC_INIT ||
+		    smc->sk.sk_state == SMC_CLOSED)
+			answ = 0;
+		else
+			answ = smc_tx_prepared_sends(&smc->conn);
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.16.3

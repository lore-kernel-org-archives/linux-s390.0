Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 5/9] net/smc: recvmsg and splice_read should return 0 after shutdown
Date: Wed, 30 Jan 2019 18:51:04 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-6-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When a socket was connected and is now shut down for read, return 0 to
indicate end of data in recvmsg and splice_read (like TCP) and do not
return ENOTCONN. This behavior is required by the socket api.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c4e56602e0c6..b04a813fc865 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1505,6 +1505,11 @@ static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
+	if (sk->sk_state == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
+		/* socket was connected before, no more data to read */
+		rc = 0;
+		goto out;
+	}
 	if ((sk->sk_state == SMC_INIT) ||
 	    (sk->sk_state == SMC_LISTEN) ||
 	    (sk->sk_state == SMC_CLOSED))
@@ -1840,7 +1845,11 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-
+	if (sk->sk_state == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
+		/* socket was connected before, no more data to read */
+		rc = 0;
+		goto out;
+	}
 	if (sk->sk_state == SMC_INIT ||
 	    sk->sk_state == SMC_LISTEN ||
 	    sk->sk_state == SMC_CLOSED)
-- 
2.16.4

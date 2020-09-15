Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12536 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgIOU6E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 16:58:04 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: check variable before dereferencing in smc_close.c
Date: Tue, 15 Sep 2020 22:57:09 +0200
Message-Id: <20200915205709.50325-2-kgraul@linux.ibm.com>
In-Reply-To: <20200915205709.50325-1-kgraul@linux.ibm.com>
References: <20200915205709.50325-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

smc->clcsock and smc->clcsock->sk are used before the check if they can
be dereferenced. Fix this by checking the variables first.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_close.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10d05a6d34fc..0f9ffba07d26 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -208,11 +208,12 @@ int smc_close_active(struct smc_sock *smc)
 		break;
 	case SMC_LISTEN:
 		sk->sk_state = SMC_CLOSED;
-		smc->clcsock->sk->sk_data_ready = smc->clcsk_data_ready;
-		smc->clcsock->sk->sk_user_data = NULL;
 		sk->sk_state_change(sk); /* wake up accept */
-		if (smc->clcsock && smc->clcsock->sk)
+		if (smc->clcsock && smc->clcsock->sk) {
+			smc->clcsock->sk->sk_data_ready = smc->clcsk_data_ready;
+			smc->clcsock->sk->sk_user_data = NULL;
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
+		}
 		smc_close_cleanup_listen(sk);
 		release_sock(sk);
 		flush_work(&smc->tcp_listen_work);
-- 
2.17.1

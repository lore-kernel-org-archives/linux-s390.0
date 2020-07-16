Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729130AbgGPPiG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 11:38:06 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 10/10] net/smc: fix restoring of fallback changes
Date: Thu, 16 Jul 2020 17:37:46 +0200
Message-Id: <20200716153746.77303-11-kgraul@linux.ibm.com>
In-Reply-To: <20200716153746.77303-1-kgraul@linux.ibm.com>
References: <20200716153746.77303-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When a listen socket is closed then all non-accepted sockets in its
accept queue are to be released. Inside __smc_release() the helper
smc_restore_fallback_changes() restores the changes done to the socket
without to check if the clcsocket has a file set. This can result in
a crash. Fix this by checking the file pointer first.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: f536dffc0b79 ("net/smc: fix closing of fallback SMC sockets")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d091509b5982..1163d51196da 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -126,8 +126,10 @@ EXPORT_SYMBOL_GPL(smc_proto6);
 
 static void smc_restore_fallback_changes(struct smc_sock *smc)
 {
-	smc->clcsock->file->private_data = smc->sk.sk_socket;
-	smc->clcsock->file = NULL;
+	if (smc->clcsock->file) { /* non-accepted sockets have no file yet */
+		smc->clcsock->file->private_data = smc->sk.sk_socket;
+		smc->clcsock->file = NULL;
+	}
 }
 
 static int __smc_release(struct smc_sock *smc)
-- 
2.17.1

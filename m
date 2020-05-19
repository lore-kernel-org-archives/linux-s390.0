Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgESTKX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 15:10:23 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/5] net/af_iucv: remove a redundant zero initialization
Date: Tue, 19 May 2020 21:10:11 +0200
Message-Id: <20200519191012.65438-5-jwi@linux.ibm.com>
In-Reply-To: <20200519191012.65438-1-jwi@linux.ibm.com>
References: <20200519191012.65438-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

txmsg is declared as {0}, no need to clear individual fields later on.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index b02470a04c50..799dcf5483de 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -996,7 +996,6 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	/* initialize defaults */
 	cmsg_done   = 0;	/* check for duplicate headers */
-	txmsg.class = 0;
 
 	/* iterate over control messages */
 	for_each_cmsghdr(cmsg, msg) {
-- 
2.17.1

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732791AbgJARVj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:21:39 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/2] net/af_iucv: right-size the uid variable in iucv_sock_bind()
Date: Thu,  1 Oct 2020 19:21:26 +0200
Message-Id: <20201001172127.98541-2-jwi@linux.ibm.com>
In-Reply-To: <20201001172127.98541-1-jwi@linux.ibm.com>
References: <20201001172127.98541-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

smatch complains about
net/iucv/af_iucv.c:624 iucv_sock_bind() error: memcpy() 'sa->siucv_user_id' too small (8 vs 9)

Which is absolutely correct - the memcpy() takes 9 bytes (sizeof(uid))
from an 8-byte field (sa->siucv_user_id).
Luckily the sockaddr_iucv struct contains more data after the
.siucv_user_id field, and we checked the size of the passed data earlier
on. So the memcpy() won't accidentally read from an invalid location.

Fix the warning by reducing the size of the uid variable to what's
actually needed, and thus reducing the amount of copied data.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/iucv/af_iucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index a95af62acb52..d80572074667 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -588,11 +588,11 @@ static int iucv_sock_bind(struct socket *sock, struct sockaddr *addr,
 			  int addr_len)
 {
 	struct sockaddr_iucv *sa = (struct sockaddr_iucv *) addr;
+	char uid[sizeof(sa->siucv_user_id)];
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv;
 	int err = 0;
 	struct net_device *dev;
-	char uid[9];
 
 	/* Verify the input sockaddr */
 	if (addr_len < sizeof(struct sockaddr_iucv) ||
-- 
2.17.1

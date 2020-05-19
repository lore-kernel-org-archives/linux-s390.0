Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727047AbgESTKY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 15:10:24 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/5] net/af_iucv: replace open-coded U16_MAX
Date: Tue, 19 May 2020 21:10:10 +0200
Message-Id: <20200519191012.65438-4-jwi@linux.ibm.com>
In-Reply-To: <20200519191012.65438-1-jwi@linux.ibm.com>
References: <20200519191012.65438-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Improve the readability of a range check.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 84bd18fea1d6..b02470a04c50 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -1559,7 +1560,7 @@ static int iucv_sock_setsockopt(struct socket *sock, int level, int optname,
 		switch (sk->sk_state) {
 		case IUCV_OPEN:
 		case IUCV_BOUND:
-			if (val < 1 || val > (u16)(~0))
+			if (val < 1 || val > U16_MAX)
 				rc = -EINVAL;
 			else
 				iucv->msglimit = val;
-- 
2.17.1

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgIWIhN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 04:37:13 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/9] s390/qeth: don't init refcount twice for mcast IPs
Date: Wed, 23 Sep 2020 10:36:52 +0200
Message-Id: <20200923083700.44624-2-jwi@linux.ibm.com>
In-Reply-To: <20200923083700.44624-1-jwi@linux.ibm.com>
References: <20200923083700.44624-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

mcast IP objects are allocated within qeth_l3_add_mcast_rtnl(),
with .ref_counter already set to 1 via qeth_l3_init_ipaddr().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 33fdad1a6887..903d7b6f511f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1235,7 +1235,6 @@ static void qeth_l3_rx_mode_work(struct work_struct *work)
 					kfree(addr);
 					break;
 				}
-				addr->ref_counter = 1;
 				fallthrough;
 			default:
 				/* for next call to set_rx_mode(): */
-- 
2.17.1

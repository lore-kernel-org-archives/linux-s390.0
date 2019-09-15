Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfIORVN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 15 Sep 2019 13:21:13 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8FHGxoD090782
        for <linux-s390@vger.kernel.org>; Sun, 15 Sep 2019 13:21:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v0uus268v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 15 Sep 2019 13:21:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Sun, 15 Sep 2019 18:21:10 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next] =?UTF-8?q?s390/ctcm:=20Delete=20unnecessary=20ch?= =?UTF-8?q?ecks=20before=20the=20macro=20call=20=E2=80=9Cdev=5Fkfree=5Fskb?= =?UTF-8?q?=E2=80=9D?=
Date: Sun, 15 Sep 2019 19:21:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20190915172105.42024-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Markus Elfring <elfring@users.sourceforge.net>, Julian Wiedmann <jwi@linux.ibm.com>

From: Markus Elfring <elfring@users.sourceforge.net>

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the shown calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 2117870ed855..437a6d822105 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1072,10 +1072,8 @@ static void ctcm_free_netdevice(struct net_device *dev)
 		if (grp) {
 			if (grp->fsm)
 				kfree_fsm(grp->fsm);
-			if (grp->xid_skb)
-				dev_kfree_skb(grp->xid_skb);
-			if (grp->rcvd_xid_skb)
-				dev_kfree_skb(grp->rcvd_xid_skb);
+			dev_kfree_skb(grp->xid_skb);
+			dev_kfree_skb(grp->rcvd_xid_skb);
 			tasklet_kill(&grp->mpc_tasklet2);
 			kfree(grp);
 			priv->mpcg = NULL;
-- 
2.17.1

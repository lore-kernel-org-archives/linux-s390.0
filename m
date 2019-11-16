Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbfKPQrr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 Nov 2019 11:47:47 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGGl5jA108260
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wae50srdq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:46 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Sat, 16 Nov 2019 16:47:44 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/4] net/smc: guarantee removal of link groups in reboot
Date: Sat, 16 Nov 2019 17:47:30 +0100
In-Reply-To: <20191116164732.47059-1-kgraul@linux.ibm.com>
References: <20191116164732.47059-1-kgraul@linux.ibm.com>
Message-Id: <20191116164732.47059-3-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

When rebooting it should be guaranteed all link groups are cleaned
up and freed.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index cf34b9d96595..bb92c7c6214c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
+#include <linux/reboot.h>
 #include <net/tcp.h>
 #include <net/sock.h>
 #include <rdma/ib_verbs.h>
@@ -1282,14 +1283,27 @@ static void smc_lgrs_shutdown(void)
 	spin_unlock(&smcd_dev_list.lock);
 }
 
+static int smc_core_reboot_event(struct notifier_block *this,
+				 unsigned long event, void *ptr)
+{
+	smc_lgrs_shutdown();
+
+	return 0;
+}
+
+static struct notifier_block smc_reboot_notifier = {
+	.notifier_call = smc_core_reboot_event,
+};
+
 int __init smc_core_init(void)
 {
 	atomic_set(&lgr_cnt, 0);
-	return 0;
+	return register_reboot_notifier(&smc_reboot_notifier);
 }
 
 /* Called (from smc_exit) when module is removed */
 void smc_core_exit(void)
 {
+	unregister_reboot_notifier(&smc_reboot_notifier);
 	smc_lgrs_shutdown();
 }
-- 
2.17.1

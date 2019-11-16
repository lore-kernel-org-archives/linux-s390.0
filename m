Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727629AbfKPQrq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 Nov 2019 11:47:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGGl676113438
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:44 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wae609fv2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:44 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Sat, 16 Nov 2019 16:47:43 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 3/4] net/smc: use rcu_barrier() on module unload
Date: Sat, 16 Nov 2019 17:47:31 +0100
In-Reply-To: <20191116164732.47059-1-kgraul@linux.ibm.com>
References: <20191116164732.47059-1-kgraul@linux.ibm.com>
Message-Id: <20191116164732.47059-4-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Add rcu_barrier() to make sure no RCU readers or callbacks are
pending when the module is unloaded.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 42b7fb8ab22b..cde4dc0ed173 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -25,6 +25,7 @@
 #include <linux/in.h>
 #include <linux/sched/signal.h>
 #include <linux/if_vlan.h>
+#include <linux/rcupdate_wait.h>
 
 #include <net/sock.h>
 #include <net/tcp.h>
@@ -2111,6 +2112,7 @@ static void __exit smc_exit(void)
 	proto_unregister(&smc_proto);
 	smc_pnet_exit();
 	unregister_pernet_subsys(&smc_net_ops);
+	rcu_barrier();
 }
 
 module_init(smc_init);
-- 
2.17.1

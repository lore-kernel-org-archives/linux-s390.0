Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729768AbgB0RI3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 12:08:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RH71nG063893
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcnhtta7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Feb 2020 17:08:26 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/8] s390/qeth: remove unused cmd definitions
Date: Thu, 27 Feb 2020 18:08:12 +0100
In-Reply-To: <20200227170816.101286-1-jwi@linux.ibm.com>
References: <20200227170816.101286-1-jwi@linux.ibm.com>
Message-Id: <20200227170816.101286-5-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Looks like these were never used, ever since the driver was initially
added.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core_mpc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 3a3cebdaf948..6f304fdbb073 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -93,10 +93,6 @@ enum qeth_link_types {
 	QETH_LINK_TYPE_LANE         = 0x88,
 };
 
-/*
- * Routing stuff
- */
-#define RESET_ROUTING_FLAG 0x10 /* indicate that routing type shall be set */
 enum qeth_routing_types {
 	/* TODO: set to bit flag used in IPA Command */
 	NO_ROUTER		= 0,
@@ -427,7 +423,6 @@ struct qeth_ipacmd_setassparms {
 		struct qeth_arp_cache_entry arp_entry;
 		struct qeth_arp_query_data query_arp;
 		struct qeth_tso_start_data tso;
-		__u8 ip[16];
 	} data;
 } __attribute__ ((packed));
 
-- 
2.17.1

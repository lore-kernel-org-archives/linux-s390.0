Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728816AbgBQPZJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:09 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFKRrF073968
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y7uafne3n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:05 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 6/6] net/smc: reduce port_event scheduling
Date: Mon, 17 Feb 2020 16:24:55 +0100
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
Message-Id: <20200217152455.15341-7-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

IB event handlers schedule the port event worker for further
processing of port state changes. This patch reduces the number of
schedules to avoid duplicate processing of the same port change.

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_ib.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 548632621f4b..6756bd5a3fe4 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -257,6 +257,7 @@ static void smc_ib_global_event_handler(struct ib_event_handler *handler,
 					struct ib_event *ibevent)
 {
 	struct smc_ib_device *smcibdev;
+	bool schedule = false;
 	u8 port_idx;
 
 	smcibdev = container_of(handler, struct smc_ib_device, event_handler);
@@ -266,22 +267,35 @@ static void smc_ib_global_event_handler(struct ib_event_handler *handler,
 		/* terminate all ports on device */
 		for (port_idx = 0; port_idx < SMC_MAX_PORTS; port_idx++) {
 			set_bit(port_idx, &smcibdev->port_event_mask);
-			set_bit(port_idx, smcibdev->ports_going_away);
+			if (!test_and_set_bit(port_idx,
+					      smcibdev->ports_going_away))
+				schedule = true;
 		}
-		schedule_work(&smcibdev->port_event_work);
+		if (schedule)
+			schedule_work(&smcibdev->port_event_work);
 		break;
-	case IB_EVENT_PORT_ERR:
 	case IB_EVENT_PORT_ACTIVE:
-	case IB_EVENT_GID_CHANGE:
 		port_idx = ibevent->element.port_num - 1;
-		if (port_idx < SMC_MAX_PORTS) {
-			set_bit(port_idx, &smcibdev->port_event_mask);
-			if (ibevent->event == IB_EVENT_PORT_ERR)
-				set_bit(port_idx, smcibdev->ports_going_away);
-			else if (ibevent->event == IB_EVENT_PORT_ACTIVE)
-				clear_bit(port_idx, smcibdev->ports_going_away);
+		if (port_idx >= SMC_MAX_PORTS)
+			break;
+		set_bit(port_idx, &smcibdev->port_event_mask);
+		if (test_and_clear_bit(port_idx, smcibdev->ports_going_away))
+			schedule_work(&smcibdev->port_event_work);
+		break;
+	case IB_EVENT_PORT_ERR:
+		port_idx = ibevent->element.port_num - 1;
+		if (port_idx >= SMC_MAX_PORTS)
+			break;
+		set_bit(port_idx, &smcibdev->port_event_mask);
+		if (!test_and_set_bit(port_idx, smcibdev->ports_going_away))
 			schedule_work(&smcibdev->port_event_work);
-		}
+		break;
+	case IB_EVENT_GID_CHANGE:
+		port_idx = ibevent->element.port_num - 1;
+		if (port_idx >= SMC_MAX_PORTS)
+			break;
+		set_bit(port_idx, &smcibdev->port_event_mask);
+		schedule_work(&smcibdev->port_event_work);
 		break;
 	default:
 		break;
@@ -316,11 +330,11 @@ static void smc_ib_qp_event_handler(struct ib_event *ibevent, void *priv)
 	case IB_EVENT_QP_FATAL:
 	case IB_EVENT_QP_ACCESS_ERR:
 		port_idx = ibevent->element.qp->port - 1;
-		if (port_idx < SMC_MAX_PORTS) {
-			set_bit(port_idx, &smcibdev->port_event_mask);
-			set_bit(port_idx, smcibdev->ports_going_away);
+		if (port_idx >= SMC_MAX_PORTS)
+			break;
+		set_bit(port_idx, &smcibdev->port_event_mask);
+		if (!test_and_set_bit(port_idx, smcibdev->ports_going_away))
 			schedule_work(&smcibdev->port_event_work);
-		}
 		break;
 	default:
 		break;
-- 
2.17.1

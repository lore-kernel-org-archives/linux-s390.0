Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF94EB64DD
	for <linux-s390@archiver.kernel.org>; Tue,  1 Aug 2023 08:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjHAIAm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 1 Aug 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjHAIAl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Aug 2023 04:00:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16601FC8;
        Tue,  1 Aug 2023 01:00:39 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3717pLdi021427;
        Tue, 1 Aug 2023 08:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8H3045uvkrH7V0tkADjeYa6U1lukkigpTkQ7bCBXPVc=;
 b=R4X6GxPxUZIeqQ7RQzeNH53RSazJVjF6LZ/0UpdBa25x+IwUbM19Qplz1yJxYfeVCxCc
 lx9oMMnXYUq0rz8Pgk2fZFi2OcoOvY/UwBJEZ8wmD3aRayWxNl/0QtIWAuCSoOLLE6Nv
 YeIjyt15T0fTRQ/DaReqADKbFLKq5IuzKzPlJxfyY9T5YNVmw/MFytGDcRuy/rraCVJV
 Qraeg9e8rb/vS96W67gnAewYC7ZCE3n1aN/PORcRgKbtU5b79DNG2bqe9xI+xXreOvT+
 dwpFgGog4iJOoZEJzlpyvWCbshsExDFl4ZL2XUPBCPerplLH34woksGHayD0WdldC6Ne Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6x16g6pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:00:30 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3717pUCO021586;
        Tue, 1 Aug 2023 08:00:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6x16g6me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:00:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3717tHVZ017132;
        Tue, 1 Aug 2023 08:00:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fajhmgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:00:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37180PWa10683134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Aug 2023 08:00:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12C8A2004F;
        Tue,  1 Aug 2023 08:00:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02A572004E;
        Tue,  1 Aug 2023 08:00:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Aug 2023 08:00:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id C32EAE138D; Tue,  1 Aug 2023 10:00:24 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Subject: [PATCH net] s390/qeth: Don't call dev_close/dev_open (DOWN/UP)
Date:   Tue,  1 Aug 2023 10:00:16 +0200
Message-Id: <20230801080016.744474-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: odoHh2QCZMfMOhRjekyQ9LkRgkQ5Lbv9
X-Proofpoint-GUID: tMfGS2qZGq6etMmgUmcqQ1lSIXo3Xe2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010068
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

dev_close() and dev_open() are issued to change the interface state to DOWN
or UP (dev->flags IFF_UP). When the netdev is set DOWN it loses e.g its
Ipv6 addresses and routes. We don't want this in cases of device recovery
(triggered by hardware or software) or when the qeth device is set
offline.

Setting a qeth device offline or online and device recovery actions call
netif_device_detach() and/or netif_device_attach(). That will reset or
set the LOWER_UP indication i.e. change the dev->state Bit
__LINK_STATE_PRESENT. That is enough to e.g. cause bond failovers, and
still preserves the interface settings that are handled by the network
stack.

Don't call dev_open() nor dev_close() from the qeth device driver. Let the
network stack handle this.

Fixes: d4560150cb47 ("s390/qeth: call dev_close() during recovery")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 2 --
 drivers/s390/net/qeth_l2_main.c   | 9 ++++++---
 drivers/s390/net/qeth_l3_main.c   | 8 +++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 1d195429753d..613eab729704 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -716,7 +716,6 @@ struct qeth_card_info {
 	u16 chid;
 	u8 ids_valid:1; /* cssid,iid,chid */
 	u8 dev_addr_is_registered:1;
-	u8 open_when_online:1;
 	u8 promisc_mode:1;
 	u8 use_v1_blkt:1;
 	u8 is_vm_nic:1;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 1d5b207c2b9e..cd783290bde5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5373,8 +5373,6 @@ int qeth_set_offline(struct qeth_card *card, const struct qeth_discipline *disc,
 	qeth_clear_ipacmd_list(card);
 
 	rtnl_lock();
-	card->info.open_when_online = card->dev->flags & IFF_UP;
-	dev_close(card->dev);
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 9f13ed170a43..75910c0bcc2b 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2388,9 +2388,12 @@ static int qeth_l2_set_online(struct qeth_card *card, bool carrier_ok)
 		qeth_enable_hw_features(dev);
 		qeth_l2_enable_brport_features(card);
 
-		if (card->info.open_when_online) {
-			card->info.open_when_online = 0;
-			dev_open(dev, NULL);
+		if (netif_running(dev)) {
+			local_bh_disable();
+			napi_schedule(&card->napi);
+			/* kick-start the NAPI softirq: */
+			local_bh_enable();
+			qeth_l2_set_rx_mode(dev);
 		}
 		rtnl_unlock();
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index af4e60d2917e..b92a32b4b114 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2018,9 +2018,11 @@ static int qeth_l3_set_online(struct qeth_card *card, bool carrier_ok)
 		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
-		if (card->info.open_when_online) {
-			card->info.open_when_online = 0;
-			dev_open(dev, NULL);
+		if (netif_running(dev)) {
+			local_bh_disable();
+			napi_schedule(&card->napi);
+			/* kick-start the NAPI softirq: */
+			local_bh_enable();
 		}
 		rtnl_unlock();
 	}
-- 
2.39.2


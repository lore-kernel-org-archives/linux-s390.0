Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9D3C001DE
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 13:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGXNQR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjGXNQQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 09:16:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF4DD;
        Mon, 24 Jul 2023 06:16:15 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OD9GFN025220;
        Mon, 24 Jul 2023 13:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=GZ38s4l7BD35jhBNpdOBoSVAuAi8nL+7mdh2cicayvs=;
 b=QGUGj5DKpp20KMHDdc2jpDlHU/HojBA/aSo5l1azZeyMQMzJTTQG8ge54p12SN/35MWM
 XjncauQosdCnEMxPRLAUfJ70pyUi9jFaa3oNA3fgepq4D8M9G2xB5ztSRBPa+OlH1dkW
 PiVeOHUeRPBaqruosxWKEP+txFQ65iIbORdJte2XSYwYubz7zEwAkWKfXLynzUS0CzBB
 a7KfBL+aeCyaAdngcFi10XQq8ScRFVIlwrbVh6Y7Sc/5RgLO+kT4MWzOGYc6ABKKOhMG
 0j363oKuGNJ0cdbaa5C+R+T1TSNv/tVrn7IkvJSj15nIkvJQTETZfqGoTzHq56MrjfHF rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1s62sbn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 13:16:01 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36ODA13D030136;
        Mon, 24 Jul 2023 13:16:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1s62sbmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 13:16:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCXkLk026200;
        Mon, 24 Jul 2023 13:16:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0serkq85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 13:16:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36ODFvgg28050046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:15:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37A5D2005A;
        Mon, 24 Jul 2023 13:15:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225B420043;
        Mon, 24 Jul 2023 13:15:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Jul 2023 13:15:57 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id C6020E0875; Mon, 24 Jul 2023 15:15:56 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net] s390/lcs: Remove FDDI option
Date:   Mon, 24 Jul 2023 15:15:46 +0200
Message-Id: <20230724131546.3597001-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7czs-R7QrH8z6oXtf_Sk2VAnJfFcwk7y
X-Proofpoint-ORIG-GUID: Ie3cqatDmXXW5iIra6qY_swGOOj4gM-N
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240116
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The last s390 machine that supported FDDI was z900 ('7th generation',
released in 2000). The oldest machine generation currently supported by
the Linux kernel is MARCH_Z10 (released 2008). If there is still a usecase
for connecting a Linux on s390 instance to a LAN Channel Station (LCS), it
can only do so via Ethernet.

Randy Dunlap[1] found that LCS over FDDI has never worked, when FDDI
was compiled as module. Instead of fixing that, remove the FDDI option
from the lcs driver.

While at it, make the CONFIG_LCS description a bit more helpful.

References:
[1] https://lore.kernel.org/netdev/20230621213742.8245-1-rdunlap@infradead.org/

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/s390/net/Kconfig |  5 ++---
 drivers/s390/net/lcs.c   | 39 ++++++---------------------------------
 2 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 9c67b97faba2..74760c1a163b 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -5,12 +5,11 @@ menu "S/390 network device drivers"
 config LCS
 	def_tristate m
 	prompt "Lan Channel Station Interface"
-	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+	depends on CCW && NETDEVICES && ETHERNET
 	help
 	  Select this option if you want to use LCS networking on IBM System z.
-	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
 	  To compile as a module, choose M. The module name is lcs.
-	  If you do not know what it is, it's safe to choose Y.
+	  If you do not use LCS, choose N.
 
 config CTCM
 	def_tristate m
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 9fd8e6f07a03..a1f2acd6fb8f 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -17,7 +17,6 @@
 #include <linux/if.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/fddidevice.h>
 #include <linux/inetdevice.h>
 #include <linux/in.h>
 #include <linux/igmp.h>
@@ -36,10 +35,6 @@
 #include "lcs.h"
 
 
-#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
-#error Cannot compile lcs.c without some net devices switched on.
-#endif
-
 /*
  * initialization string for output
  */
@@ -1601,19 +1596,11 @@ lcs_startlan_auto(struct lcs_card *card)
 	int rc;
 
 	LCS_DBF_TEXT(2, trace, "strtauto");
-#ifdef CONFIG_ETHERNET
 	card->lan_type = LCS_FRAME_TYPE_ENET;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
 		return 0;
 
-#endif
-#ifdef CONFIG_FDDI
-	card->lan_type = LCS_FRAME_TYPE_FDDI;
-	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
-	if (rc == 0)
-		return 0;
-#endif
 	return -EIO;
 }
 
@@ -1806,22 +1793,16 @@ lcs_get_frames_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
 			card->stats.rx_errors++;
 			return;
 		}
-		/* What kind of frame is it? */
-		if (lcs_hdr->type == LCS_FRAME_TYPE_CONTROL) {
-			/* Control frame. */
+		if (lcs_hdr->type == LCS_FRAME_TYPE_CONTROL)
 			lcs_get_control(card, (struct lcs_cmd *) lcs_hdr);
-		} else if (lcs_hdr->type == LCS_FRAME_TYPE_ENET ||
-			   lcs_hdr->type == LCS_FRAME_TYPE_TR ||
-			   lcs_hdr->type == LCS_FRAME_TYPE_FDDI) {
-			/* Normal network packet. */
+		else if (lcs_hdr->type == LCS_FRAME_TYPE_ENET)
 			lcs_get_skb(card, (char *)(lcs_hdr + 1),
 				    lcs_hdr->offset - offset -
 				    sizeof(struct lcs_header));
-		} else {
-			/* Unknown frame type. */
-			; // FIXME: error message ?
-		}
-		/* Proceed to next frame. */
+		else
+			dev_info_once(&card->dev->dev,
+				      "Unknown frame type %d\n",
+				      lcs_hdr->type);
 		offset = lcs_hdr->offset;
 		lcs_hdr->offset = LCS_ILLEGAL_OFFSET;
 		lcs_hdr = (struct lcs_header *) (buffer->data + offset);
@@ -2140,18 +2121,10 @@ lcs_new_device(struct ccwgroup_device *ccwgdev)
 		goto netdev_out;
 	}
 	switch (card->lan_type) {
-#ifdef CONFIG_ETHERNET
 	case LCS_FRAME_TYPE_ENET:
 		card->lan_type_trans = eth_type_trans;
 		dev = alloc_etherdev(0);
 		break;
-#endif
-#ifdef CONFIG_FDDI
-	case LCS_FRAME_TYPE_FDDI:
-		card->lan_type_trans = fddi_type_trans;
-		dev = alloc_fddidev(0);
-		break;
-#endif
 	default:
 		LCS_DBF_TEXT(3, setup, "errinit");
 		pr_err(" Initialization failed\n");
-- 
2.39.2


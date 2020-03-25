Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbgCYJfS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:18 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9X6jr190866
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejxcrjd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:11 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 09/11] s390/qeth: fine-tune MAC Address-related errnos
Date: Wed, 25 Mar 2020 10:35:05 +0100
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Message-Id: <20200325093507.20831-10-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Return the correct errnos when .ndo_set_mac_address fails to set a new
MAC address.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 249b00d91d46..766ea0d07a24 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -52,11 +52,11 @@ static int qeth_l2_setdelmac_makerc(struct qeth_card *card, u16 retcode)
 		break;
 	case IPA_RC_L2_DUP_MAC:
 	case IPA_RC_L2_DUP_LAYER3_MAC:
-		rc = -EEXIST;
+		rc = -EADDRINUSE;
 		break;
 	case IPA_RC_L2_MAC_NOT_AUTH_BY_HYP:
 	case IPA_RC_L2_MAC_NOT_AUTH_BY_ADP:
-		rc = -EPERM;
+		rc = -EADDRNOTAVAIL;
 		break;
 	case IPA_RC_L2_MAC_NOT_FOUND:
 		rc = -ENOENT;
@@ -105,11 +105,11 @@ static int qeth_l2_send_setmac(struct qeth_card *card, __u8 *mac)
 			 "MAC address %pM successfully registered\n", mac);
 	} else {
 		switch (rc) {
-		case -EEXIST:
+		case -EADDRINUSE:
 			dev_warn(&card->gdev->dev,
 				"MAC address %pM already exists\n", mac);
 			break;
-		case -EPERM:
+		case -EADDRNOTAVAIL:
 			dev_warn(&card->gdev->dev,
 				"MAC address %pM is not authorized\n", mac);
 			break;
@@ -126,7 +126,7 @@ static int qeth_l2_write_mac(struct qeth_card *card, u8 *mac)
 
 	QETH_CARD_TEXT(card, 2, "L2Wmac");
 	rc = qeth_l2_send_setdelmac(card, mac, cmd);
-	if (rc == -EEXIST)
+	if (rc == -EADDRINUSE)
 		QETH_DBF_MESSAGE(2, "MAC already registered on device %x\n",
 				 CARD_DEVID(card));
 	else if (rc)
-- 
2.17.1

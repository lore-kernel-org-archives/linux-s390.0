Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729894AbgB0RIb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 12:08:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RH6LUN122392
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydh92jmma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:30 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Feb 2020 17:08:27 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/8] s390/qeth: validate device-provided MAC address
Date: Thu, 27 Feb 2020 18:08:11 +0100
In-Reply-To: <20200227170816.101286-1-jwi@linux.ibm.com>
References: <20200227170816.101286-1-jwi@linux.ibm.com>
Message-Id: <20200227170816.101286-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

It's good practice to not blindly trust what the HW offers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 667a10d6495d..1000e18c1090 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -920,6 +920,8 @@ static int qeth_l3_iqd_read_initial_mac_cb(struct qeth_card *card,
 
 	if (cmd->hdr.return_code)
 		return -EIO;
+	if (!is_valid_ether_addr(cmd->data.create_destroy_addr.mac_addr))
+		return -EADDRNOTAVAIL;
 
 	ether_addr_copy(card->dev->dev_addr,
 			cmd->data.create_destroy_addr.mac_addr);
-- 
2.17.1

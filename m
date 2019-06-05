Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727330AbfFELtJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Jun 2019 07:49:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55BlBXF022155
        for <linux-s390@vger.kernel.org>; Wed, 5 Jun 2019 07:49:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sx9nf8m4g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 05 Jun 2019 07:49:08 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 5 Jun 2019 12:49:06 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v3 net 3/4] s390/qeth: fix VLAN attribute in bridge_hostnotify udev event
Date: Wed,  5 Jun 2019 13:48:50 +0200
In-Reply-To: <20190605114851.56641-1-jwi@linux.ibm.com>
References: <20190605114851.56641-1-jwi@linux.ibm.com>
Message-Id: <20190605114851.56641-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

From: Alexandra Winter <wintera@linux.ibm.com>

Enabling sysfs attribute bridge_hostnotify triggers a series of udev events
for the MAC addresses of all currently connected peers. In case no VLAN is
set for a peer, the device reports the corresponding MAC addresses with
VLAN ID 4096. This currently results in attribute VLAN=4096 for all
non-VLAN interfaces in the initial series of events after host-notify is
enabled.

Instead, no VLAN attribute should be reported in the udev event for
non-VLAN interfaces.

Only the initial events face this issue. For dynamic changes that are
reported later, the device uses a validity flag.

This also changes the code so that it now sets the VLAN attribute for
MAC addresses with VID 0. On Linux, no qeth interface will ever be
registered with VID 0: Linux kernel registers VID 0 on all network
interfaces initially, but qeth will drop .ndo_vlan_rx_add_vid for VID 0.
Peers with other OSs could register MACs with VID 0.

Fixes: 9f48b9db9a22 ("qeth: bridgeport support - address notifications")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 218801232ca2..ff8a6cd790b1 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1680,7 +1680,7 @@ static void qeth_bridgeport_an_set_cb(void *priv,
 
 	l2entry = (struct qdio_brinfo_entry_l2 *)entry;
 	code = IPA_ADDR_CHANGE_CODE_MACADDR;
-	if (l2entry->addr_lnid.lnid)
+	if (l2entry->addr_lnid.lnid < VLAN_N_VID)
 		code |= IPA_ADDR_CHANGE_CODE_VLANID;
 	qeth_bridge_emit_host_event(card, anev_reg_unreg, code,
 		(struct net_if_token *)&l2entry->nit,
-- 
2.17.1

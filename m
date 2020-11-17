Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbgKQQPf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:35 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/9] s390/qeth: clean up default cases for ethtool link mode
Date: Tue, 17 Nov 2020 17:15:18 +0100
Message-Id: <20201117161520.1089-8-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Remove the default case for PORT_* and SPEED_* in our ethtool code.

The only time these could be hit is if qeth_init_link_info() was unable
to determine the port type from an OSA adapter's link_type.
We already throw a message in this case, so reduce the noise and don't
report bad data (ie. it's much more likely that any future link_type
will represent a PORT_FIBRE link ...).

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_ethtool.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index b8e74018b44f..50b0c1810850 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -343,9 +343,7 @@ static void qeth_set_ethtool_link_modes(struct ethtool_link_ksettings *cmd)
 		ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
 		break;
 	default:
-		ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
-		WARN_ON_ONCE(1);
+		break;
 	}
 
 	/* partially does fall through, to also select lower speeds */
@@ -393,15 +391,7 @@ static void qeth_set_ethtool_link_modes(struct ethtool_link_ksettings *cmd)
 						     10baseT_Half);
 		break;
 	default:
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10baseT_Full);
-		ethtool_link_ksettings_add_link_mode(cmd, supported,
-						     10baseT_Half);
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     10baseT_Half);
-		WARN_ON_ONCE(1);
+		break;
 	}
 }
 
-- 
2.17.1

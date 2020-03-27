Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbgC0KTu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 06:19:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RA1xA2087960
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:19:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbv04and-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 06:19:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 27 Mar 2020 10:19:41 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/3] s390/qeth: phase out OSN support
Date: Fri, 27 Mar 2020 11:19:34 +0100
In-Reply-To: <20200327101934.31040-1-jwi@linux.ibm.com>
References: <20200327101934.31040-1-jwi@linux.ibm.com>
Message-Id: <20200327101934.31040-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

OSN devices currently spend an awful long time in qeth_l2_set_online()
until various unsupported HW cmds time out. This has been broken for
over two years, ever since
commit d22ffb5a712f ("s390/qeth: fix IPA command submission race")
triggered a FW bug in cmd processing.
Prior to commit 782e4a792147 ("s390/qeth: don't poll for cmd IO completion"),
this wait for timeout would have even been spent busy-polling.

The offending patch was picked up by stable and all relevant distros,
and yet noone noticed.
OSN setups only ever worked in combination with an out-of-tree blob, and
the last machine that even offered HW with OSN support was released back
in 2015.

Rather than attempting to work-around this FW issue for no actual gain,
add a deprecation warning so anyone who still wants to maintain this
part of the code can speak up. Else rip it all out in 2021.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/Kconfig        | 1 +
 drivers/s390/net/qeth_l2_main.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 36633387b952..3850a0f5f0bc 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -97,6 +97,7 @@ config QETH_OSN
 	depends on QETH
 	help
 	  This enables the qeth driver to support devices in OSN mode.
+	  This feature will be removed in 2021.
 	  If unsure, choose N.
 
 config QETH_OSX
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 974b4596b78d..0bd5b09e7a22 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -587,6 +587,9 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc;
 
+	if (IS_OSN(card))
+		dev_notice(&gdev->dev, "OSN support will be dropped in 2021\n");
+
 	qeth_l2_vnicc_set_defaults(card);
 	mutex_init(&card->sbp_lock);
 
-- 
2.17.1

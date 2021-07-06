Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C4C07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD3C61945
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 16:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGFQKS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:10:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60905 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhGFQKP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 12:10:15 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0nL8-0007mP-BH; Tue, 06 Jul 2021 17:50:26 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0nL6-0005Sp-Bm; Tue, 06 Jul 2021 17:50:24 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] s390/ccwgroup: Drop if with an always false condition
Date:   Tue,  6 Jul 2021 17:48:01 +0200
Message-Id: <20210706154803.1631813-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver core only calls a bus remove callback when there is a driver.
So dev->driver is never NULL and the check can safely be removed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/s390/cio/ccwgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 9748165e08e9..a6aeab1ea0ae 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -444,8 +444,6 @@ static int ccwgroup_remove(struct device *dev)
 	struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
 	struct ccwgroup_driver *gdrv = to_ccwgroupdrv(dev->driver);
 
-	if (!dev->driver)
-		return 0;
 	if (gdrv->remove)
 		gdrv->remove(gdev);
 
-- 
2.30.2


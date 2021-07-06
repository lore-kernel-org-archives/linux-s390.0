Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A9C07E9C
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEADB61945
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhGFQKV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:10:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39245 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhGFQKV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 12:10:21 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0nL8-0007mS-BC; Tue, 06 Jul 2021 17:50:26 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0nL6-0005Ss-Hp; Tue, 06 Jul 2021 17:50:24 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] s390/scm: Make struct scm_driver::remove return void
Date:   Tue,  6 Jul 2021 17:48:02 +0200
Message-Id: <20210706154803.1631813-4-u.kleine-koenig@pengutronix.de>
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

The driver core ignores the return value of scmdev_remove()
(because there is only little it can do when a device disappears).

So make it impossible for future drivers to return an unused error code
by changing the remove prototype to return void.

The real motivation for this change is the quest to make struct
bus_type::remove return void, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/s390/include/asm/eadm.h | 2 +-
 drivers/s390/block/scm_drv.c | 4 +---
 drivers/s390/cio/scm.c       | 5 ++++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/eadm.h b/arch/s390/include/asm/eadm.h
index bb63b2afdf6f..445fe4c8184a 100644
--- a/arch/s390/include/asm/eadm.h
+++ b/arch/s390/include/asm/eadm.h
@@ -105,7 +105,7 @@ enum scm_event {SCM_CHANGE, SCM_AVAIL};
 struct scm_driver {
 	struct device_driver drv;
 	int (*probe) (struct scm_device *scmdev);
-	int (*remove) (struct scm_device *scmdev);
+	void (*remove) (struct scm_device *scmdev);
 	void (*notify) (struct scm_device *scmdev, enum scm_event event);
 	void (*handler) (struct scm_device *scmdev, void *data,
 			blk_status_t error);
diff --git a/drivers/s390/block/scm_drv.c b/drivers/s390/block/scm_drv.c
index 3134fd6e058e..69a845eb8b1f 100644
--- a/drivers/s390/block/scm_drv.c
+++ b/drivers/s390/block/scm_drv.c
@@ -60,15 +60,13 @@ static int scm_probe(struct scm_device *scmdev)
 	return ret;
 }
 
-static int scm_remove(struct scm_device *scmdev)
+static void scm_remove(struct scm_device *scmdev)
 {
 	struct scm_blk_dev *bdev = dev_get_drvdata(&scmdev->dev);
 
 	scm_blk_dev_cleanup(bdev);
 	dev_set_drvdata(&scmdev->dev, NULL);
 	kfree(bdev);
-
-	return 0;
 }
 
 static struct scm_driver scm_drv = {
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index 9f26d4310bb3..b31711307e5a 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -33,7 +33,10 @@ static int scmdev_remove(struct device *dev)
 	struct scm_device *scmdev = to_scm_dev(dev);
 	struct scm_driver *scmdrv = to_scm_drv(dev->driver);
 
-	return scmdrv->remove ? scmdrv->remove(scmdev) : -ENODEV;
+	if (scmdrv->remove)
+		scmdrv->remove(scmdev);
+
+	return 0;
 }
 
 static int scmdev_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.30.2


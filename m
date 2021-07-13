Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA2C11F66
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEF861353
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhGMTie (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhGMTie (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jul 2021 15:38:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C9EC0613DD
        for <linux-s390@vger.kernel.org>; Tue, 13 Jul 2021 12:35:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBm-0001M7-FH; Tue, 13 Jul 2021 21:35:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBl-0006q0-UC; Tue, 13 Jul 2021 21:35:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBi-0002f2-SV; Tue, 13 Jul 2021 21:35:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 4/5] s390/scm: Make struct scm_driver::remove return void
Date:   Tue, 13 Jul 2021 21:35:21 +0200
Message-Id: <20210713193522.1770306-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ktkMzQSAAyHCymxHaeuezQhJvasMyN9hNxYTQRFBFeQ=; m=P1AAUGZpbPCPO5X70OZJM21oQma4swJvSOO9wO7GJmw=; p=gttOw7RSWj+rG5XX1mcdi+yFxjr52UsL+JH53OMp2Wg=; g=f86d4654b18b6749acbbaeaf2b9c03f3c75eb3d2
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDt6tsACgkQwfwUeK3K7AlcAggAlBt yyOaj1gYpWUvnoMvXNXhM1uAIXaPQNTmshEtWErwa8+gqRvh4Sg363hNbcMmAhx95IqCjy1jNfzrG wiZsjXhqw6gHRnzlRlXHN0YKtOLEFyGp+uYILZ07fjpjGn0b/2Yf50JJwQ5bSqa7gOqGyu7B6Bu0K PjcOQSAgZ+7MQ4mVkvVbIPc/F23OV5/0wYucckqbdqrL03JFv05wI35iFPqKVH8h02ILpDphevo/D x0vjoKpXvlUSnSf5ZKOxy0XFk0vcgpj2Wmi7v+75YRGRZ0bjBibX0oY0f+jiTL4oRiHQCsW2f9sxq NDuQ8KLtmgF5AJXoaVq3l+CNo6BzjiA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
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


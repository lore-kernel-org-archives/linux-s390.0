Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B0C07E95
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CA16128E
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 19:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhGMTic (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhGMTi0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jul 2021 15:38:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821E0C0613EF
        for <linux-s390@vger.kernel.org>; Tue, 13 Jul 2021 12:35:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBj-0001Gb-Cb; Tue, 13 Jul 2021 21:35:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBi-0006pI-MJ; Tue, 13 Jul 2021 21:35:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3OBi-0002eo-LD; Tue, 13 Jul 2021 21:35:26 +0200
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
Subject: [PATCH v4 3/5] s390/ccwgroup: Drop if with an always false condition
Date:   Tue, 13 Jul 2021 21:35:20 +0200
Message-Id: <20210713193522.1770306-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=72HAwW1ge0SaWF88KqTqoq0HiIxYHEA9VDa9pzFS5e8=; m=mnRcCYX4Soun6UkRo/vF3OKbvkroGEUnmAV+HlocHj8=; p=l/VUm/c+DmIdVO+6MJuUdAI6l1YC3XF2DMW0Cfqol+o=; g=f55f0fa1ad1e2a674f85b460588b66f70eaabd61
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDt6tIACgkQwfwUeK3K7AlNAAf/Qze qs4OF09D63uZICdOzaFZhDKJPyv3xcTRmAgS22l3lnPhcvqnOkxDuoriAmtxv1PIAi8pvCKJAoLVn D4PLsjLPN9eDlRq8nLrizYaYJFaX0ReQsjd87Syzi9cAw9DzZ7pd1gdWzKoQ8X7guKBr9S4+GM5fl N3tGaE7EwSs0nA46ZCen6PYZL/kGM7OCmNmxlw/bgEqy2drCn3M9I8upTiUJS9mWC0S/04AxgcmZG VRXST57r+y8UnUXCDCmScyhUI9D/Diur6nKjU6cNZA0pGQo/Of1KEhGV5fuyuBdcZ9FrgeJ8bik5Y M1KrN9QulB37+0UQrIKBKqqyPOtRY+A==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver core only calls a bus remove callback when there is a driver.
So dev->driver is never NULL and the check can safely be removed.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
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


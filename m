Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39BEB64D7
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jun 2023 10:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbjFPKZc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbjFPKZa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Jun 2023 06:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934E137;
        Fri, 16 Jun 2023 03:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7601B6297C;
        Fri, 16 Jun 2023 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30E5C433CB;
        Fri, 16 Jun 2023 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911128;
        bh=4Q31ARF6WY9m1GKYTFzYIxybota+3TQG4uNvSZlGdJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGSXqFgtGKcTntFgFv75SQ0kslI6Fuv2WxKPtjOQz9ulbIv+k7wU2CAJ62wnDwPfU
         zjCAX2lVscAm7PKqzFTGuw3kwLEvCK1OLcnHc6w0sZCbai3qswLjg1R3Y9QoxZK+N3
         MMoCEEKbIhFpU6Zc7jkVjuh5nZ5nB/1B3JTrSkrf8iBFXNSB2iMCl3kZULlRYJ9fy7
         jNpt9v7pqqQap8yONEkwlAh+Ww5ujveo4zEZ1uqZuo7aOfQQBcrEH7DWcaUSbJ7oVQ
         590/+uG3/QLidwHh0NfHVtQLY2GPx8PA8qVsHbnLvHg4S2msAc/vgBne5qD8hvS+Sc
         hwm8CaN7KF1wQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 04/30] s390/cio: unregister device when the only path is gone
Date:   Fri, 16 Jun 2023 06:24:52 -0400
Message-Id: <20230616102521.673087-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102521.673087-1-sashal@kernel.org>
References: <20230616102521.673087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit 89c0c62e947a01e7a36b54582fd9c9e346170255 ]

Currently, if the device is offline and all the channel paths are
either configured or varied offline, the associated subchannel gets
unregistered. Don't unregister the subchannel, instead unregister
offline device.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index d5c43e9b51289..c0d620ffea618 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1376,6 +1376,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1408,7 +1409,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1470,6 +1471,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1503,6 +1505,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		sch_set_cdev(sch, NULL);
-- 
2.39.2


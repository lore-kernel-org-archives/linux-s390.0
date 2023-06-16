Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36815EB64D8
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jun 2023 10:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjFPK3L (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjFPK2C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Jun 2023 06:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4E46A9;
        Fri, 16 Jun 2023 03:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400AE6349F;
        Fri, 16 Jun 2023 10:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B194AC433CA;
        Fri, 16 Jun 2023 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911192;
        bh=quksZrer3WJ4nWC8iVnKMQ97wUUrh6goNPLkHy2Rkig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7VUKzYZunv07GrMh1X/dtRsKwLZX1uKny0W90YYTdbyBDXTiQKxDNiR6YvW5PnMv
         S4P5Jhl+ppyR2wJs6VSTkrN7D8hMvpqXPhmB6dSKz0iRN/5YhAflIvzykRvdjuUji8
         Bqb3BIcQpo7wQAshwnapCyDvOYL1SxXsWxDlPCN60+zWlFa1/n5bxJ6VYlwHRWvjU1
         +vdwJio/Z5Uclyo8n4tnp869ShxN/5tYJdMCpU1ux+FJiMXG3QSgK4vjAjHVcdknwj
         W5UqhiCLuxR/Z/UhXhF2Nn70FPlsx3y4szoUBxclDGtYxxYmukhL7HBGXFptIPfpLq
         hGszsKwRO+BGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/26] s390/cio: unregister device when the only path is gone
Date:   Fri, 16 Jun 2023 06:26:01 -0400
Message-Id: <20230616102625.673454-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
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
index ba4c69226c337..02813b63f90fd 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1367,6 +1367,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1399,7 +1400,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1461,6 +1462,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1494,6 +1496,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		sch_set_cdev(sch, NULL);
-- 
2.39.2


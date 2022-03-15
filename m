Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF2C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 15 Mar 2022 02:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCOC1L (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Mar 2022 22:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCOC1L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Mar 2022 22:27:11 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 19:25:59 PDT
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D361E3A1B1
        for <linux-s390@vger.kernel.org>; Mon, 14 Mar 2022 19:25:59 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 15 Mar
 2022 10:24:48 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 15 Mar
 2022 10:24:45 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] s390/tape: Use bitwise instead of arithmetic operator for flags
Date:   Tue, 15 Mar 2022 10:24:43 +0800
Message-ID: <1647311083-25388-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This silences the following coccinelle warning:
drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/s390/char/tape_34xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 7ada994..487ad2d 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -354,10 +354,10 @@ tape_34xx_unit_check(struct tape_device *device, struct tape_request *request,
 	if ((
 		sense[0] == SENSE_DATA_CHECK      ||
 		sense[0] == SENSE_EQUIPMENT_CHECK ||
-		sense[0] == SENSE_EQUIPMENT_CHECK + SENSE_DEFERRED_UNIT_CHECK
+		sense[0] == SENSE_EQUIPMENT_CHECK | SENSE_DEFERRED_UNIT_CHECK
 	) && (
 		sense[1] == SENSE_DRIVE_ONLINE ||
-		sense[1] == SENSE_BEGINNING_OF_TAPE + SENSE_WRITE_MODE
+		sense[1] == SENSE_BEGINNING_OF_TAPE | SENSE_WRITE_MODE
 	)) {
 		switch (request->op) {
 		/*
-- 
2.7.4


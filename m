Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBEC433DB
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4294161983
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhC3K5f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:57:35 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:20040 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhC3K5X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Mar 2021 06:57:23 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id C5E9D9804A1;
        Tue, 30 Mar 2021 18:57:19 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] arch: s390: Remove duplicate struct ccw1 declaration
Date:   Tue, 30 Mar 2021 18:56:25 +0800
Message-Id: <20210330105638.2742356-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTBhIQ0wfHk0eH01MVkpNSkxKS0pDT0tKQ05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46PSo4Cz8KMDc6TR8cOR48
        LkgKCxJVSlVKTUpMSktKQ09LT01IVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSE5CNwY+
X-HM-Tid: 0a7882c7def3d992kuwsc5e9d9804a1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

struct ccw1 is declared twice. One has been declared
at 21st line. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/s390/include/asm/ccwdev.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 778247bb1d61..d4e90f2ba77e 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -152,9 +152,6 @@ extern struct ccw_device *get_ccwdev_by_busid(struct ccw_driver *cdrv,
  * when new devices for its type pop up */
 extern int  ccw_driver_register   (struct ccw_driver *driver);
 extern void ccw_driver_unregister (struct ccw_driver *driver);
-
-struct ccw1;
-
 extern int ccw_device_set_options_mask(struct ccw_device *, unsigned long);
 extern int ccw_device_set_options(struct ccw_device *, unsigned long);
 extern void ccw_device_clear_options(struct ccw_device *, unsigned long);
-- 
2.25.1


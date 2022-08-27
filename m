Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B52C0502A
	for <linux-s390@archiver.kernel.org>; Sat, 27 Aug 2022 16:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiH0QWu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 27 Aug 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0QWt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 27 Aug 2022 12:22:49 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E9CC6
        for <linux-s390@vger.kernel.org>; Sat, 27 Aug 2022 09:22:47 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661617358tesgupk2
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 Aug 2022 00:22:31 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: FJKd/Vn4sJfaXwx803MlSU+CDn6ZY7YOv2dTkD/T4q0Xz76aWAMpWupyTo7WG
        EWH8+2N61KOyOnzGdpSgvpwpnmXVVTvaFfz+VqCDwV83+9GmLTYDlRNz1NTPNLbxCo9Jbd4
        UPX1keOSHX6o3Pj2VXKG0wwrXplm8PF3WGEB9HTbCJwt0HJuAWj2JAPuIoKFZgyvirWoh2T
        6n/sN2Jh1qpHAf49/YcxwD2AI3M4E3z8llOiT3KTuGqnUL0aWUE/B1gPvbBFpM0Iafezrop
        Q2pAnnXmLTBjR5K2stsAd4xg6H3QttMlsVZJ1PM9c2KfzxqwS+WhxX5pJdMMtWN9wK97iKZ
        FI4OBW7xE3f9u3uEM68WxCLcjKaja8bS5kIM2LkmO9WxfTDk4o=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] s390/appldata: Do not initialise statics to 0
Date:   Sat, 27 Aug 2022 12:22:30 -0400
Message-Id: <20220827162230.19611-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

No need to do the initialization of statics to 0 or NULL.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/s390/appldata/appldata_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index d74a4c7d5df6..e1721e2dd89e 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -88,7 +88,7 @@ static struct vtimer_list appldata_timer;
 static DEFINE_SPINLOCK(appldata_timer_lock);
 static int appldata_interval = APPLDATA_CPU_INTERVAL;
 static int appldata_timer_active;
-static int appldata_timer_suspended = 0;
+static int appldata_timer_suspended;
 
 /*
  * Work queue
-- 
2.35.1


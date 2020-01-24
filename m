Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403846AbgAXOTB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:01 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 037/107] s390/setup: Fix secure ipl message
Date: Fri, 24 Jan 2020 09:17:07 -0500
Message-Id: <20200124141817.28793-37-sashal@kernel.org>
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

[ Upstream commit 40260b01d029ba374637838213af500e03305326 ]

The new machine loader on z15 always creates an IPL Report block and
thus sets the IPL_PL_FLAG_IPLSR even when secure boot is disabled. This
causes the wrong message being printed at boot. Fix this by checking for
IPL_PL_FLAG_SIPL instead.

Fixes: 9641b8cc733f ("s390/ipl: read IPL report at early boot")
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 3ff291bc63b7e..b95e6fa34cc8e 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1059,7 +1059,7 @@ static void __init log_component_list(void)
 
 	if (!early_ipl_comp_list_addr)
 		return;
-	if (ipl_block.hdr.flags & IPL_PL_FLAG_IPLSR)
+	if (ipl_block.hdr.flags & IPL_PL_FLAG_SIPL)
 		pr_info("Linux is running with Secure-IPL enabled\n");
 	else
 		pr_info("Linux is running with Secure-IPL disabled\n");
-- 
2.20.1

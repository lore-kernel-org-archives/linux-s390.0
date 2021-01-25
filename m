Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:2875 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbhAYKSi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 05:18:38 -0500
From: Chengyang Fan <cy.fan@huawei.com>
Subject: [PATCH] s390/ap: remove unneeded semicolon
Date: Mon, 25 Jan 2021 17:58:39 +0800
Message-ID: <20210125095839.1720265-1-cy.fan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com
Cc: linux-s390@vger.kernel.org, joe@perches.com

Remove a superfluous semicolon after function definition.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 arch/s390/include/asm/ap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index aea32dda3d14..837d1699b109 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -368,7 +368,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 #if IS_ENABLED(CONFIG_ZCRYPT)
 void ap_bus_cfg_chg(void);
 #else
-static inline void ap_bus_cfg_chg(void){};
+static inline void ap_bus_cfg_chg(void){}
 #endif
 
 #endif /* _ASM_S390_AP_H_ */
-- 
2.25.1

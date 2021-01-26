Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] s390: Simplify the calculation of variables
Date: Tue, 26 Jan 2021 17:09:12 +0800
Message-Id: <1611652152-58139-1-git-send-email-abaci-bugfix@linux.alibaba.com>
List-ID: <linux-s390.vger.kernel.org>
To: hca@linux.ibm.com
Cc: gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Fix the following coccicheck warnings:

./arch/s390/include/asm/scsw.h:528:48-50: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 arch/s390/include/asm/scsw.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index c00f7b0..a7c3ccf 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -525,8 +525,7 @@ static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
 	return (scsw->cmd.fctl != 0) &&
 	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
 	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)));
+		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
 }
 
 /**
-- 
1.8.3.1

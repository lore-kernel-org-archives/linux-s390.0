Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755062AbgJWSso (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Oct 2020 14:48:44 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/3] net/smc: fix suppressed return code
Date: Fri, 23 Oct 2020 20:48:29 +0200
Message-Id: <20201023184830.59548-3-kgraul@linux.ibm.com>
In-Reply-To: <20201023184830.59548-1-kgraul@linux.ibm.com>
References: <20201023184830.59548-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The patch that repaired the invalid return code in smcd_new_buf_create()
missed to take care of errno ENOSPC which has a special meaning that no
more DMBEs can be registered on the device. Fix that by keeping this
errno value during the translation of the return code.

Fixes: 6b1bbf94ab36 ("net/smc: fix invalid return code in smcd_new_buf_create()")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d790c43c473f..2b19863f7171 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1615,8 +1615,11 @@ static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
 		rc = smc_ism_register_dmb(lgr, bufsize, buf_desc);
 		if (rc) {
 			kfree(buf_desc);
-			return (rc == -ENOMEM) ? ERR_PTR(-EAGAIN) :
-						 ERR_PTR(-EIO);
+			if (rc == -ENOMEM)
+				return ERR_PTR(-EAGAIN);
+			if (rc == -ENOSPC)
+				return ERR_PTR(-ENOSPC);
+			return ERR_PTR(-EIO);
 		}
 		buf_desc->pages = virt_to_page(buf_desc->cpu_addr);
 		/* CDC header stored in buf. So, pretend it was smaller */
-- 
2.17.1

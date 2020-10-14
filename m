Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726903AbgJNRny (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Oct 2020 13:43:54 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 3/3] net/smc: fix invalid return code in smcd_new_buf_create()
Date: Wed, 14 Oct 2020 19:43:29 +0200
Message-Id: <20201014174329.35791-4-kgraul@linux.ibm.com>
In-Reply-To: <20201014174329.35791-1-kgraul@linux.ibm.com>
References: <20201014174329.35791-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

smc_ism_register_dmb() returns error codes set by the ISM driver which
are not guaranteed to be negative or in the errno range. Such values
would not be handled by ERR_PTR() and finally the return code will be
used as a memory address.
Fix that by using a valid negative errno value with ERR_PTR().

Fixes: 72b7f6c48708 ("net/smc: unique reason code for exceeded max dmb count")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 5de637472a11..d790c43c473f 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1615,7 +1615,8 @@ static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
 		rc = smc_ism_register_dmb(lgr, bufsize, buf_desc);
 		if (rc) {
 			kfree(buf_desc);
-			return (rc == -ENOMEM) ? ERR_PTR(-EAGAIN) : ERR_PTR(rc);
+			return (rc == -ENOMEM) ? ERR_PTR(-EAGAIN) :
+						 ERR_PTR(-EIO);
 		}
 		buf_desc->pages = virt_to_page(buf_desc->cpu_addr);
 		/* CDC header stored in buf. So, pretend it was smaller */
-- 
2.17.1

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHMTt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 08:19:49 -0400
From: Pujin Shi <shipujin.t@gmail.com>
Subject: [PATCH 1/2] net: smc: fix missing brace warning for old compilers
Date: Thu,  8 Oct 2020 20:19:28 +0800
Message-Id: <20201008121929.1270-1-shipujin.t@gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hankinsea@gmail.com, Pujin Shi <shipujin.t@gmail.com>

For older versions of gcc, the array = {0}; will cause warnings:

net/smc/smc_llc.c: In function 'smc_llc_send_link_delete_all':
net/smc/smc_llc.c:1317:9: warning: missing braces around initializer [-Wmissing-braces]
  struct smc_llc_msg_del_link delllc = {0};
         ^
net/smc/smc_llc.c:1317:9: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]

1 warnings generated

Fixes: f3811fd7bc97 ("net/smc: send DELETE_LINK, ALL message and wait for send to complete")
Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 net/smc/smc_llc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 2db967f2fb50..d09d9d2d0bfd 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1314,7 +1314,7 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
  */
 void smc_llc_send_link_delete_all(struct smc_link_group *lgr, bool ord, u32 rsn)
 {
-	struct smc_llc_msg_del_link delllc = {0};
+	struct smc_llc_msg_del_link delllc = {};
 	int i;
 
 	delllc.hd.common.type = SMC_LLC_DELETE_LINK;
-- 
2.18.1

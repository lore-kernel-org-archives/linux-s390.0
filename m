Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgJHMT4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 08:19:56 -0400
From: Pujin Shi <shipujin.t@gmail.com>
Subject: [PATCH 2/2] net: smc: fix missing brace warning for old compilers
Date: Thu,  8 Oct 2020 20:19:29 +0800
Message-Id: <20201008121929.1270-2-shipujin.t@gmail.com>
In-Reply-To: <20201008121929.1270-1-shipujin.t@gmail.com>
References: <20201008121929.1270-1-shipujin.t@gmail.com>
List-ID: <linux-s390.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hankinsea@gmail.com, Pujin Shi <shipujin.t@gmail.com>

For older versions of gcc, the array = {0}; will cause warnings:

net/smc/smc_llc.c: In function 'smc_llc_add_link_local':
net/smc/smc_llc.c:1212:9: warning: missing braces around initializer [-Wmissing-braces]
  struct smc_llc_msg_add_link add_llc = {0};
         ^
net/smc/smc_llc.c:1212:9: warning: (near initialization for 'add_llc.hd') [-Wmissing-braces]
net/smc/smc_llc.c: In function 'smc_llc_srv_delete_link_local':
net/smc/smc_llc.c:1245:9: warning: missing braces around initializer [-Wmissing-braces]
  struct smc_llc_msg_del_link del_llc = {0};
         ^
net/smc/smc_llc.c:1245:9: warning: (near initialization for 'del_llc.hd') [-Wmissing-braces]

2 warnings generated

Fixes: 4dadd151b265 ("net/smc: enqueue local LLC messages")
Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 net/smc/smc_llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index d09d9d2d0bfd..85df0ef60500 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1209,7 +1209,7 @@ static void smc_llc_process_srv_add_link(struct smc_link_group *lgr)
 /* enqueue a local add_link req to trigger a new add_link flow */
 void smc_llc_add_link_local(struct smc_link *link)
 {
-	struct smc_llc_msg_add_link add_llc = {0};
+	struct smc_llc_msg_add_link add_llc = {};
 
 	add_llc.hd.length = sizeof(add_llc);
 	add_llc.hd.common.type = SMC_LLC_ADD_LINK;
@@ -1242,7 +1242,7 @@ static void smc_llc_add_link_work(struct work_struct *work)
  */
 void smc_llc_srv_delete_link_local(struct smc_link *link, u8 del_link_id)
 {
-	struct smc_llc_msg_del_link del_llc = {0};
+	struct smc_llc_msg_del_link del_llc = {};
 
 	del_llc.hd.length = sizeof(del_llc);
 	del_llc.hd.common.type = SMC_LLC_DELETE_LINK;
-- 
2.18.1

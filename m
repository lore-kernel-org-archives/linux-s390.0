Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFJBpR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 21:45:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524DC03E96B
        for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2020 18:45:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so640557qke.2
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2020 18:45:16 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] s390: set NODES_SHIFT=0 when NUMA=n
Date: Tue,  9 Jun 2020 21:45:01 -0400
Message-Id: <20200610014501.4268-1-cai@lca.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>

When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,

for_each_node(node) {
	if (wq_calc_node_cpumask(...

where it will trigger a booting warning,

WARNING: workqueue cpumask: online intersect > possible intersect

because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
cpumask. NUMA=y has no such problem because node_possible_map will be
initialized properly containing only node 0. Fix it by setting
NODES_SHIFT=0 when NUMA=n.

Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/s390/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f854faff38c3..59625356d18a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -462,7 +462,8 @@ config NUMA
 
 config NODES_SHIFT
 	int
-	default "1"
+	default "1" if NUMA
+	default "0"
 
 config SCHED_SMT
 	def_bool n
-- 
2.21.0 (Apple Git-122.2)

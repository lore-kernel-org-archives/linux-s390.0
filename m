Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93FC7EE2C
	for <linux-s390@archiver.kernel.org>; Thu, 25 May 2023 18:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbjEYSnH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 May 2023 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbjEYSmp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 May 2023 14:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33430E1;
        Thu, 25 May 2023 11:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE416491E;
        Thu, 25 May 2023 18:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF622C4339B;
        Thu, 25 May 2023 18:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039874;
        bh=FLZX+UK/82eRVORB7fraCDojcz+FqC8P5JdFgT7Lx34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+g+jU3xJ4Sr8zOC675gB7XpDUjm2di0zHGQsYZRB7giByuQvpf+rnhJnf30UI6ia
         F6FaBjDjf5m0hkSdpbCZBhvKnBqJDsuF1X65r3hv0WXtnDkl/ZF9wZg61KL9WmvwI0
         WrPTWMDMa67vQQUD7W0YSUHyjhWww9em4HfBu4iUEBld0As2x4GyaP8sHjGZR8n7pI
         rqSVnyF2QhYdVypkRA4vxmRZ/zYUy1nVep4egXKqFzRh8PDw5YNckUqc8Z5p2GQkhb
         wc9sq2J+RjDS8j8SkHU5ssVEAKSviBW+/+yeOEoutUxQT3EzA8pY2FOaWWhQJtq7vw
         HWV39IYO/lwvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        mcgrof@kernel.org, gregkh@linuxfoundation.org,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 32/57] s390/topology: honour nr_cpu_ids when adding CPUs
Date:   Thu, 25 May 2023 14:35:42 -0400
Message-Id: <20230525183607.1793983-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit a33239be2d38ff5a44427db1707c08787508d34a ]

When SMT thread CPUs are added to CPU masks the nr_cpu_ids
limit is not checked and could be exceeded. This leads to
a warning for example if CONFIG_DEBUG_PER_CPU_MAPS is set
and the command line parameter nr_cpus is set to 1.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/topology.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302d..10b20aeb27d3b 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -95,7 +95,7 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 static void cpu_thread_map(cpumask_t *dst, unsigned int cpu)
 {
 	static cpumask_t mask;
-	int i;
+	unsigned int max_cpu;
 
 	cpumask_clear(&mask);
 	if (!cpumask_test_cpu(cpu, &cpu_setup_mask))
@@ -104,9 +104,10 @@ static void cpu_thread_map(cpumask_t *dst, unsigned int cpu)
 	if (topology_mode != TOPOLOGY_MODE_HW)
 		goto out;
 	cpu -= cpu % (smp_cpu_mtid + 1);
-	for (i = 0; i <= smp_cpu_mtid; i++) {
-		if (cpumask_test_cpu(cpu + i, &cpu_setup_mask))
-			cpumask_set_cpu(cpu + i, &mask);
+	max_cpu = min(cpu + smp_cpu_mtid, nr_cpu_ids - 1);
+	for (; cpu <= max_cpu; cpu++) {
+		if (cpumask_test_cpu(cpu, &cpu_setup_mask))
+			cpumask_set_cpu(cpu, &mask);
 	}
 out:
 	cpumask_copy(dst, &mask);
@@ -123,25 +124,26 @@ static void add_cpus_to_mask(struct topology_core *tl_core,
 	unsigned int core;
 
 	for_each_set_bit(core, &tl_core->mask, TOPOLOGY_CORE_BITS) {
-		unsigned int rcore;
-		int lcpu, i;
+		unsigned int max_cpu, rcore;
+		int cpu;
 
 		rcore = TOPOLOGY_CORE_BITS - 1 - core + tl_core->origin;
-		lcpu = smp_find_processor_id(rcore << smp_cpu_mt_shift);
-		if (lcpu < 0)
+		cpu = smp_find_processor_id(rcore << smp_cpu_mt_shift);
+		if (cpu < 0)
 			continue;
-		for (i = 0; i <= smp_cpu_mtid; i++) {
-			topo = &cpu_topology[lcpu + i];
+		max_cpu = min(cpu + smp_cpu_mtid, nr_cpu_ids - 1);
+		for (; cpu <= max_cpu; cpu++) {
+			topo = &cpu_topology[cpu];
 			topo->drawer_id = drawer->id;
 			topo->book_id = book->id;
 			topo->socket_id = socket->id;
 			topo->core_id = rcore;
-			topo->thread_id = lcpu + i;
+			topo->thread_id = cpu;
 			topo->dedicated = tl_core->d;
-			cpumask_set_cpu(lcpu + i, &drawer->mask);
-			cpumask_set_cpu(lcpu + i, &book->mask);
-			cpumask_set_cpu(lcpu + i, &socket->mask);
-			smp_cpu_set_polarization(lcpu + i, tl_core->pp);
+			cpumask_set_cpu(cpu, &drawer->mask);
+			cpumask_set_cpu(cpu, &book->mask);
+			cpumask_set_cpu(cpu, &socket->mask);
+			smp_cpu_set_polarization(cpu, tl_core->pp);
 		}
 	}
 }
-- 
2.39.2


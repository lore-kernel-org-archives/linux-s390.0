Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgFJIqB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Jun 2020 04:46:01 -0400
Date: Wed, 10 Jun 2020 10:45:53 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: set NODES_SHIFT=0 when NUMA=n
Message-ID: <20200610084553.GB4894@osiris>
References: <20200610014501.4268-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610014501.4268-1-cai@lca.pw>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:45:01PM -0400, Qian Cai wrote:
> When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,
> 
> for_each_node(node) {
> 	if (wq_calc_node_cpumask(...
> 
> where it will trigger a booting warning,
> 
> WARNING: workqueue cpumask: online intersect > possible intersect
> 
> because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
> cpumask. NUMA=y has no such problem because node_possible_map will be
> initialized properly containing only node 0. Fix it by setting
> NODES_SHIFT=0 when NUMA=n.
> 
> Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/s390/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks! However I committed a different solution. Hope you don't mind:

From dd3f1f08f2317768b35b2df3ff8285185df7e195 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 10 Jun 2020 10:36:05 +0200
Subject: [PATCH] s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES

Qian Cai reported:
---
When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,

for_each_node(node) {
        if (wq_calc_node_cpumask(...

where it will trigger a booting warning,

WARNING: workqueue cpumask: online intersect > possible intersect

because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
cpumask.
---

Let NODES_SHIFT depend on NEED_MULTIPLE_NODES like it is done
on other architectures in order to fix this.

Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2167bce993ff..ae01be202204 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -462,6 +462,7 @@ config NUMA
 
 config NODES_SHIFT
 	int
+	depends on NEED_MULTIPLE_NODES
 	default "1"
 
 config SCHED_SMT
-- 
2.17.1

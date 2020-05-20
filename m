Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:58584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETS2J (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 May 2020 14:28:09 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2 2/7] padata: initialize earlier
Date: Wed, 20 May 2020 14:26:40 -0400
Message-Id: <20200520182645.1658949-3-daniel.m.jordan@oracle.com>
In-Reply-To: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Daniel Jordan <daniel.m.jordan@oracle.com>

padata will soon initialize the system's struct pages in parallel, so it
needs to be ready by page_alloc_init_late().

The error return from padata_driver_init() triggers an initcall warning,
so add a warning to padata_init() to avoid silent failure.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/padata.h |  6 ++++++
 init/main.c            |  2 ++
 kernel/padata.c        | 17 ++++++++---------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index a0d8b41850b25..476ecfa41f363 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -164,6 +164,12 @@ struct padata_instance {
 #define	PADATA_INVALID	4
 };
 
+#ifdef CONFIG_PADATA
+extern void __init padata_init(void);
+#else
+static inline void __init padata_init(void) {}
+#endif
+
 extern struct padata_instance *padata_alloc_possible(const char *name);
 extern void padata_free(struct padata_instance *pinst);
 extern struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
diff --git a/init/main.c b/init/main.c
index 03371976d3872..8ab521f7af5d2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -94,6 +94,7 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
+#include <linux/padata.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1482,6 +1483,7 @@ static noinline void __init kernel_init_freeable(void)
 	smp_init();
 	sched_init_smp();
 
+	padata_init();
 	page_alloc_init_late();
 	/* Initialize page ext after all struct pages are initialized. */
 	page_ext_init();
diff --git a/kernel/padata.c b/kernel/padata.c
index 835919c745266..6f709bc0fc413 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/rcupdate.h>
-#include <linux/module.h>
 
 #define MAX_OBJ_NUM 1000
 
@@ -1050,26 +1049,26 @@ void padata_free_shell(struct padata_shell *ps)
 }
 EXPORT_SYMBOL(padata_free_shell);
 
-#ifdef CONFIG_HOTPLUG_CPU
-
-static __init int padata_driver_init(void)
+void __init padata_init(void)
 {
+#ifdef CONFIG_HOTPLUG_CPU
 	int ret;
 
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "padata:online",
 				      padata_cpu_online, NULL);
 	if (ret < 0)
-		return ret;
+		goto err;
 	hp_online = ret;
 
 	ret = cpuhp_setup_state_multi(CPUHP_PADATA_DEAD, "padata:dead",
 				      NULL, padata_cpu_dead);
 	if (ret < 0) {
 		cpuhp_remove_multi_state(hp_online);
-		return ret;
+		goto err;
 	}
-	return 0;
-}
-module_init(padata_driver_init);
 
+	return;
+err:
+	pr_warn("padata: initialization failed\n");
 #endif
+}
-- 
2.26.2

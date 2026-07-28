Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054DA3B3895;
	Tue, 28 Jul 2026 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216546; cv=fail; b=bSYSEgDBeVemGuBuoXmX4wf6pp5BGsKxBKyY+UFSxaviI5cH//JulTurcCrPShCrg6oIbewmldKeBHvha2/SrG6kdM84SRr1inYOUgGovo52QMod0+I9Rp1+DKDWLvqbifXpxr8Fq5kEQ4fEzO9J4C2SCbBBVC8Xc+RJ0cA/cOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216546; c=relaxed/simple;
	bh=mr2FhfQvO/tp27wnGpsdHZ8MekZfhgfucdAgz4ddOEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHu6AxKWoF0WSgtHnYaxriiueBY6zIHYI8oUNAltTc2aMjicPBvC9XHH5V6fnpRmArteeeyuga7ALu/KvyqacRE3F1xo9TwNB2KtmuFueURdUJnQ37QM2iMkjNmYRaEhGEJqftn3dZy75ilvBYiVXs+lc9SqT7IHdxvCtbu/EiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zMWrhNKY; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zMWrhNKY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IamYZtttAI9ca5wRNSjf/lEN2t14Fmj4mDfCdrr6ksvt293XghudGKl81t27isUUyb/feHY//Fx+K1c3O5s4QYN2swbsnOiIPa5e+0c3APXBCwNnNrcJ1uxEg1nIeEFzbxgRJCB6tBpT/vjjH0nFXmu6hnKn7LFhD32VfG5dhrJ4ccPjqK2phoDKoL0+44nGaVt4Fd9/IyUIe27tdAgFyUec3qxd7o4HUwrjXMxm+KqEf6wSXSGSokM7qNgnSqNvLsts/Wcnn1/VHetGkpOjj49iX9wJVAP7XVo2fnHxbganL9ZmqlTkBkZcRx46Bbs1t0ltTQOpF6Flm1hOXloClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrIT0vYcKIvKO0OeiMfwL3vXQ2YiWeifA0VRx84bP7c=;
 b=Nnnfqi4HXZCFXtDAlPnZEbtUr6VjcWORZxWsB/3TgCV/svrcw02zGWKNqxgDdHnMU+vHAfYPNlEfn09PqFBUbPTh7Xr8ext/RUm6w90aUY3GX2SJFePLuAeI+cnvKvlj2Zhtbktx2TRgdZK2LJCZJOnVS3XBXz1A5O9D/GBtQ8to7SZbEtBhzd1VP7ywZXD8t62///YjXWRSWa3xGulNYPyclChZfyLR9ETcn9TY9nWb7ypJ9lZ5qamyLytWD34OweyoAWC6RTTlKHucX8Vx3ZxZgsw3u43N1uJosJiM0ijqHoCvplcpR7OceR7ks+KJsqy3WWD5JFHiLF6B8EyLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrIT0vYcKIvKO0OeiMfwL3vXQ2YiWeifA0VRx84bP7c=;
 b=zMWrhNKYvFsLYGD9CeZq2HpfrjvIEeiCoVcrl1+XZ++yO56Tcmw48wnjrxF9CYLde35rg/+gUsJUloF5LJgrmg/G5brdyP74P5q0qBMXIKbi2ZUm57QkD41ye/Jai03mXXJo8A4WBKkbEnVZXAyNCTbMN5lrfVSLuIn2YvnwKPA=
Received: from BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::7)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:29:01 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::23) by BL1P223CA0038.outlook.office365.com
 (2603:10b6:208:5b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:29:00 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:28:51 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Huth <thuth@redhat.com>, "Jisheng
 Zhang" <jszhang@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, "Samuel
 Holland" <samuel.holland@sifive.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, Guo Ren
	<guoren@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>
Subject: [PATCH v6 8/8] futex: Use runtime constants for __futex_hash() hot path
Date: Tue, 28 Jul 2026 05:25:40 +0000
Message-ID: <20260728052540.4728-9-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728052540.4728-1-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f58109-25de-4684-31b4-08deec692148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	dAi6w8BDRRi9wLppSf2/mmbKT3ORRdXZ5lNaISgQCA6/+CF9ab4Rl3TaqnxHNmtXYy2YrFk9g9iMmeVs8PWgGsIbJ0GlWzoa1QlGvf0c8aZHsTYHH9XODvQfFDgAZbSmOPvpAiOjXUDWNtHF6rQIHIJIiP9tONGjYQ14fJqhrVHzFg5iPNiD2yBaFrcSNlMvnQZ3VdbjoZqmyve4y8GHmLx6bGXPrYxmuTuAat+wN58MabLHnhScVaLkpaJkzKxgDpJv3Hxw/F2/RB9r6oDj1jOXdku/loVjEyjissKEJtxReOEXhUJOJh9ZM0TV/MFAf2wT9oTMCh4hyBF88qE6ghzM66nNSe44QP/1pmXvaURmhcw5EYgopAvvCwhqeksCQv9eQ1v8S1PE2RXzUcGjnIpYC82/PSFHisIkALit9qkMwerQuMtukQWRL1H8IZwCZjuBny29VKLNtl8gWCOvutpPvN49Bq9eyv6dCixbVINLUwzhvCsTxPA4z//UHkshGjLc1S+/pOULJO+GJjX1Vy7WOvQlp2PvtE49LZfGqk8CGhcEJq+Zq7s8lpPjMt0HAc26GNBpKelEo8FOqczxm306tHC+Zcz5eM23Uh/FPm6m/RqKl5kkmUOPLaMX7Hr0mV6YXBtNaEgv6aASUsKShNKgyywZ+XgRolqwlkIurjMEVVY+bTvsseQtPSxcoGDS4pr9N8iomXL1rUqswnOgew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FAW6YkaTuldoxmKZ3qcXztLm2Ymi3loxZZEXvcOSzkcSFdoq6QcPI452HpXWHTHS75Vu5/NdMjQ48qJSHBRNEi2sLW65m5KHjzHmu8m48FiEtZzZe/Ge9ouTpMejdXoUk3revEjYMMQma9mbCCGB1nKT3YVdTmjHFcWCFGXUjIYQwSxX34HruZSQeqcnEehHW9iB3ByKszWrdKW9h9BzPQI4fzJp0uCin7B0AM+iZn2k/qBWF78FpImlD9teDYH9z1bbsIbvfXSDV9K0ejpxVsVPlu/WqjsQwKR55czuVK//G8rWLCwwOMKbSjZz2otLoQzFkE5quSkj75xaeBj30d8mY7sMJirxo8pLZDUtA0dwZl8XhQH14X29eoX3KtB1pNUPMXhPgwUyJql7coVy4yiOeCksRqef4DZN3vCdU5OzDrzPKUtS0Ke+DGGg94zH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:29:00.6847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f58109-25de-4684-31b4-08deec692148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769

From: Peter Zijlstra <peterz@infradead.org>

Runtime constify the read-only after init data  __futex_shift(shift_32),
__futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
hot path to avoid referencing global variable.

This also allows __futex_queues to be allocated dynamically to
"nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
(1 << CONFIG_NODES_SHIFT) worth of slots upfront.

Runtime constants are initialized before their first access and
runtime_const_init() provides necessary barrier to ensure subsequent
accesses are not reordered against their initialization.

No functional changes intended.

  [ prateek: Dynamically allocate __futex_queues, mark the global data
    __ro_after_init since they are constified after futex_init(). ]

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMNODES bloat
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v5..v6:

o Picked up tags from Charlie. (Thanks a ton!)

o Picked up Peter's S-o-b from his tree.

o Added a barrier after runtime_const_init() after to prevent compilers
  from re-ordering a later runtime const usage in the init function with
  their initialization. (Sashiko; Reported by Intel test robot with a
  GCC14 build).
  (https://lore.kernel.org/lkml/alNgNvhIkBfkGo1Y@xsang-OptiPlex-9020/)
---
 include/asm-generic/vmlinux.lds.h |  5 +++-
 kernel/futex/core.c               | 44 ++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..53207901d4c1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -970,7 +970,10 @@
 		RUNTIME_CONST(ptr, __dentry_cache)			\
 		RUNTIME_CONST(ptr, __names_cache)			\
 		RUNTIME_CONST(ptr, __filp_cache)			\
-		RUNTIME_CONST(ptr, __bfilp_cache)
+		RUNTIME_CONST(ptr, __bfilp_cache)			\
+		RUNTIME_CONST(shift, __futex_shift)			\
+		RUNTIME_CONST(mask,  __futex_mask)			\
+		RUNTIME_CONST(ptr,   __futex_queues)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 233b926f5624..1eb83c9118a4 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -48,23 +48,19 @@
 
 #include <vdso/futex.h>
 
+#include <asm/runtime-const.h>
+
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
 
-/*
- * The base of the bucket array and its size are always used together
- * (after initialization only in futex_hash()), so ensure that they
- * reside in the same cacheline.
- */
-static struct {
-	unsigned long            hashmask;
-	unsigned int		 hashshift;
-	struct futex_hash_bucket *queues[MAX_NUMNODES];
-} __futex_data __read_mostly __aligned(2*sizeof(long));
+static u32 __futex_mask __ro_after_init;
+static u32 __futex_shift __ro_after_init;
+static struct futex_hash_bucket **__futex_queues __ro_after_init;
 
-#define futex_hashmask	(__futex_data.hashmask)
-#define futex_hashshift	(__futex_data.hashshift)
-#define futex_queues	(__futex_data.queues)
+static __always_inline struct futex_hash_bucket **futex_queues(void)
+{
+	return runtime_const_ptr(__futex_queues);
+}
 
 struct futex_private_hash {
 	int		state;
@@ -395,13 +391,13 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph, struct futex_
 		 * NOTE: this isn't perfectly uniform, but it is fast and
 		 * handles sparse node masks.
 		 */
-		node = (hash >> futex_hashshift) % nr_node_ids;
+		node = runtime_const_shift_right_32(hash, __futex_shift) % nr_node_ids;
 		if (!node_possible(node)) {
 			node = find_next_bit_wrap(node_possible_map.bits, nr_node_ids, node);
 		}
 	}
 
-	return &futex_queues[node][hash & futex_hashmask];
+	return &futex_queues()[node][runtime_const_mask_32(hash, __futex_mask)];
 }
 
 /**
@@ -1921,7 +1917,7 @@ int futex_hash_allocate_default(void)
 	 *   16 <= threads * 4 <= global hash size
 	 */
 	buckets = roundup_pow_of_two(4 * threads);
-	buckets = clamp(buckets, 16, futex_hashmask + 1);
+	buckets = clamp(buckets, 16, __futex_mask + 1);
 
 	if (current_buckets >= buckets)
 		return 0;
@@ -2019,10 +2015,21 @@ static int __init futex_init(void)
 	hashsize = max(4, hashsize);
 	hashsize = roundup_pow_of_two(hashsize);
 #endif
-	futex_hashshift = ilog2(hashsize);
+	__futex_mask = hashsize - 1;
+	__futex_shift = ilog2(hashsize);
 	size = sizeof(struct futex_hash_bucket) * hashsize;
 	order = get_order(size);
 
+	__futex_queues = kcalloc(nr_node_ids, sizeof(*__futex_queues), GFP_KERNEL);
+
+	runtime_const_init(shift, __futex_shift);
+	runtime_const_init(mask,  __futex_mask);
+	runtime_const_init(ptr,   __futex_queues);
+
+	barrier();
+
+	BUG_ON(!futex_queues());
+
 	for_each_node(n) {
 		struct futex_hash_bucket *table;
 
@@ -2036,10 +2043,9 @@ static int __init futex_init(void)
 		for (i = 0; i < hashsize; i++)
 			futex_hash_bucket_init(&table[i]);
 
-		futex_queues[n] = table;
+		futex_queues()[n] = table;
 	}
 
-	futex_hashmask = hashsize - 1;
 	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, total %lu KiB, %s).\n",
 		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 1024,
 		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");
-- 
2.34.1


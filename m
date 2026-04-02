Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F63C13FC;
	Thu,  2 Apr 2026 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129166; cv=fail; b=aMJE48Hn/eDJlc1U7wUFJeFf/LXNSzkBRRMHg6yreChqRsQFQPmEnp640jkPirMP9BFbJ0DkPVGijDKXg/BHQbU18sprYn91xzXWHecCm0K7W3PuLfKgL4huNhWKUj6ugzOPOxCrlSl9km+RM1YgCRcNeiW6H2V8NIeKXwiEDYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129166; c=relaxed/simple;
	bh=GrCOisxPcaMAvgbfr3+/whh2DeWnX4UZQQDgFRHBjLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8wDxlCyKLdX3EvMl8y3T2ZuaAxyEH8fpXnGxbekmutbhreRj/vjaf/M86aHLbnQRuENoEoFxDG3Nx5tEtqUVyZUXMF8AWv+QtYFfLojNkUWyo1As+lVGKNoBrFM0ds2J8kzXZl+okWQbXYW0tJVxd/Z07ApBVcsrh50h0/M6eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d/k1sR8g; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d/k1sR8g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz+V8SaDiVXk2YcQGZ8f4cNrDC35oFI0kuY3Cvti2rNXfkR3sSgg93Teu+1yafdQwXw0Vcaw7s2erRwPFGAT1YTqT8Du/Ma8sfRgh4+Pmh+vzrl5LXATYK3fxkJJHoEfgLDj+lA3ZptExq4ZO68sbbG7ArvMuPEa5CwPJwdGcQ9X1pdRH2LijmuuB8icgv+8o97Vdmd+YlW7hIT1RRXMZbOuhbxPQAPbUzATLUzORGsj/8f9BgH4Cd+2QtZaqpjoTkg4hDo1M+xb4oJHyQTlaRDQtWxunZw0jb4ZcQuWG0dkTSghIEe6JGif8TE46IPOUHID6c6AZFCMzizN/vvx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WMnMPmrxQrTbiw6MNrx6sOXgjqHWeuN90cGW0LyyWc=;
 b=r/ruXaxSA9ONUSRBtBucuqNw0Qx0/PgKvsttj06bfbslUDhqprzu8rW/RSvJ4sK2VvWCNAAEo9863gaRirHpKqEYIHlZUttrsUPRAfmH1a+XTQxnlRpref203i8IabHtpMEEYwyk3TjDk98RGTM8RmuMfuzIaLaTrmNO/OCOtA1IsjNwWtwu4DAp/8fM/6vDTpAWZdwHm9PpGmbp8wvb10YQvRcty5QGOeLAbpsLw1v3MNBxjGAVoAGDLj2U0DVrEVDCI7tscRsMg8xbPxOqiCvAB9d3fw3UfCqbs8DLA1Ct0kJIoLwHdSPHp5lEnEFOjhuGie3taE3Fstwt4e1I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WMnMPmrxQrTbiw6MNrx6sOXgjqHWeuN90cGW0LyyWc=;
 b=d/k1sR8gZH99Fl5O6kLBnK1upSqj/EoxsOnnzoIbLZp1QvXnYh5q9S5fAVDZJoPh7LLy1z0K+zh22uZU7sM45zXAGncLoHl6GJt680p8ebEwSNpwVuj2rNEjv2TzTXj41tIwnWMxYTRjeSusxC3RwfOFCzTvH+Nj4S0Nh9Gakk4=
Received: from SN7PR04CA0067.namprd04.prod.outlook.com (2603:10b6:806:121::12)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 11:25:46 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::62) by SN7PR04CA0067.outlook.office365.com
 (2603:10b6:806:121::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 11:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:25:46 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:25:38 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	"David Laight" <david.laight.linux@gmail.com>, Samuel Holland
	<samuel.holland@sifive.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v3 7/7] futex: Use runtime constants for __futex_hash() hot path
Date: Thu, 2 Apr 2026 11:22:50 +0000
Message-ID: <20260402112250.2138-8-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402112250.2138-1-kprateek.nayak@amd.com>
References: <20260402112250.2138-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a247bbf-bdcd-44d4-660f-08de90aa95b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|921020|18002099003|13003099007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gIy1AprgtkbovkxLKdDwgawWDjpvMw+poVNfUUtmZYoySg6ylbxZvzTMoySMAT71tZAoQg5Vjo1pHVOG0fMpKwLq1BFiXo/7FffliHkqDFTztPVM2HdpIBLdUhR7hhoZedZKSfMxUNc0r674pGuRk6CaMiZqUyLofzNUYSGr2x6xToSHc/P480fvj/CUv7JZuPaO8WGQNWJrm2LJfpxX2PQoNsS73oTR+tSL9dvSLa2A+kuKvm1q9MfQejKdVPWliEFDa0qvjYXw5OMtr6vzVIa0K5Oi0ofPQWPuTJsUeiag9dnRbrXRmCf0IWuJHFA94nIa4s3JytV0fJ7mVwuM1UP6Og6NbX6m284h/jwW4Z9gWk+mbA4SLT4Qg5c77oarEw4CnTqK6i5ysZxBEMxkL+C5j/ClWFpIrzyN3jgn/unt0UWwl7GnTzsS8AzOl+hFrww070+16IuA3BfLovRt1w4WtQkSFveNwe5606xClM/sC0Ckx/N5yCZPrhlwdNpWsgjh/xLHiVeQXYyvfFrGPT8CXYnAtFEWdP5YJUfFUaTb+VAQEXTt2XwEEiQXyx2RCnOH4lhWujawZW6yCF9pLoVxtmTWZyvSm7ERN+T1rdy+uCQm+mdRJ6SNx8zo34BqdTbFpTRRmUU3KNKoIEmDNuAN5y6/YLAM8bR2TSShiqaD9z1n2DV3drxUfdG/A2/vub6Bu75vc+n1ZbsjzPmlrYrlivgDGKd6WLh07nY0WWYM2r4iu7B8OhjK4Yt+51Zae3HXDgDlQDhzX6zKQvx47Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(921020)(18002099003)(13003099007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vrOwWK4Bod3z1tHDppGAJ71xRhJvwJuES1T3icT4wtxmfwRwXsfP/bHEcKwQKpwhgnWVcNvNsvgWSgEVA1vZLyID6DvnD3ADDNOfE9sPVJmaMA1m2GoYSnoaC9jGXQCwGZN8cPjX6YmfSTG1OGchV7ApozALRC1igLp/8qu8gRzv5146eBjS6m69C3E5orFPHoRTvOmpV+VoaHjN9WCTVdWJldmS7L4HoB/wfVJEnXae0ykSYo5RubchZTHnqP69nZ7o6W2Os45K8jIS0AaQhc+/BISMEdOkCJi+uQ48kxcelUSaHCzEdL5FgvjJtCR7dMSGimsqA2yC1Wu5cpLuT8z0e+HsWgYeQjMFnClKMkjWKYuN93OnwFfv6nNQ99ixal0YdabhBmO27NDfQfLGHg2mar4fcdvi6BP4yJNHwVvYd0VmMfteCFXjhdimDOUy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:25:46.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a247bbf-bdcd-44d4-660f-08de90aa95b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

From: Peter Zijlstra <peterz@infradead.org>

Runtime constify the read-only after init data  __futex_shift(shift_32),
__futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
hot path to avoid referencing global variable.

This also allows __futex_queues to be allocated dynamically to
"nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
(1 << CONFIG_NODES_SHIFT) worth of slots upfront.

No functional chages intended.

  [ prateek: Dynamically allocate __futex_queues, mark the global data
    __ro_after_init since they are constified after futex_init(). ]

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMNODES bloat
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v2..v3:

o No changes.
---
 include/asm-generic/vmlinux.lds.h |  5 +++-
 kernel/futex/core.c               | 42 +++++++++++++++++--------------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e1580febe4b..86f99fa6ae24 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -975,7 +975,10 @@
 		RUNTIME_CONST(shift, d_hash_shift)			\
 		RUNTIME_CONST(ptr, dentry_hashtable)			\
 		RUNTIME_CONST(ptr, __dentry_cache)			\
-		RUNTIME_CONST(ptr, __names_cache)
+		RUNTIME_CONST(ptr, __names_cache)			\
+		RUNTIME_CONST(shift, __futex_shift)			\
+		RUNTIME_CONST(mask,  __futex_mask)			\
+		RUNTIME_CONST(ptr,   __futex_queues)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ff2a4fb2993f..73eade7184dc 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -45,23 +45,19 @@
 #include <linux/mempolicy.h>
 #include <linux/mmap_lock.h>
 
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
@@ -439,14 +435,14 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 		 * NOTE: this isn't perfectly uniform, but it is fast and
 		 * handles sparse node masks.
 		 */
-		node = (hash >> futex_hashshift) % nr_node_ids;
+		node = runtime_const_shift_right_32(hash, __futex_shift) % nr_node_ids;
 		if (!node_possible(node)) {
 			node = find_next_bit_wrap(node_possible_map.bits,
 						  nr_node_ids, node);
 		}
 	}
 
-	return &futex_queues[node][hash & futex_hashmask];
+	return &futex_queues()[node][runtime_const_mask_32(hash, __futex_mask)];
 }
 
 /**
@@ -1916,7 +1912,7 @@ int futex_hash_allocate_default(void)
 	 *   16 <= threads * 4 <= global hash size
 	 */
 	buckets = roundup_pow_of_two(4 * threads);
-	buckets = clamp(buckets, 16, futex_hashmask + 1);
+	buckets = clamp(buckets, 16, __futex_mask + 1);
 
 	if (current_buckets >= buckets)
 		return 0;
@@ -1986,10 +1982,19 @@ static int __init futex_init(void)
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
+	BUG_ON(!futex_queues());
+
 	for_each_node(n) {
 		struct futex_hash_bucket *table;
 
@@ -2003,10 +2008,9 @@ static int __init futex_init(void)
 		for (i = 0; i < hashsize; i++)
 			futex_hash_bucket_init(&table[i], NULL);
 
-		futex_queues[n] = table;
+		futex_queues()[n] = table;
 	}
 
-	futex_hashmask = hashsize - 1;
 	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, total %lu KiB, %s).\n",
 		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 1024,
 		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");
-- 
2.34.1


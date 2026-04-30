Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8CA3A75A1;
	Thu, 30 Apr 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542640; cv=fail; b=RwO5vIXZUnUc/Q8bLTgm1EfzT+ixoyCg0dQYOYvLuePDzFQ4ov0hzPR/NfCpRUnPcR2mtpdHjxW7t9uvGWSvHQjedpeAIgYPnJp06VXE0aVFeL8TML5ZHpju5Pb3Fsup2yf2fwNfaOgl4heErW9Q89KiO8ORir5lPDNjX9GkzBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542640; c=relaxed/simple;
	bh=5291vks7AEh5TgSPkdwq2mdOx6xZN1WcV3EDTkGmSWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYmEUjH8CuA+cxLbS1GY6ZZO8XaB11ZyGPppVOh+3H5rQyvzuZtWmEYzabO0pYNHVn6av78jH3W1tIdo35qg9+Y6vQCD4e/bFjY89a1Qkbgd9gzU+3vrxSx5Ae/88RGCENY2sshW44olYoeSGEfaoSq4gxxbekRPb/i0ezClCUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wuUqrwhG; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wuUqrwhG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCspgdEML8AdyfJvDoxKr7LhzM90azIpDNDoq2615OKiiJuIHSXbBgqg5lLHqEYYaAc34sqpWzbgi5EDjmYYJ9ieilCnl+Tu6ZVs8Xpo7Pgvm26XoxzYLgLTMElo4mrghuN2uHDIZBwXkwApAJaZzEnZQn2p/iMqnZP0UAM5BkQV5eVP/+vRHqctpS6vBWU/VgAPKnFeDufZGOJZZvLcuKXJqlR+sGHsix5ZhMoMkGINKJw1VDlcyN29uvtz9u//c7qh/fP6w4Qbw3cnrOUq2qb3Gfs4WWbPa3PkfFDmpPn3MaV+UC9QZC7MO4A4VKcSqTB4qiKT7VvRRO7sQk4jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q16P5dNxG0Fm3IxC6pmziA/Z+m6goFrjWlFR7ztWRE=;
 b=loq6mSt1yd/31aJggQOk/0Mn9ImXhu7pH9sdLkKbWtc+gTU7T60h4dcmYm2CaCFsKNY+BvMF3PaEbQqrErTVjxoe075tqBvNf51RKwdnrglB81JVYBgjm46HSUIH7MlrwF9b79yBZHedPkbUdsOI+cjoCpqjJl4xsTJizR/fR0Q9W8bOTifaPLvevoIMNjWtMbsQ7kZ1/EZVOyBUeWUI++94W8PpENjVoDNYIJ9l5a1oyLYOVukXOP9vNYoIZeBH2rnIDYRw4nkIwqE1nq1VuoDjCz6JxyOstKk/x4ZnoLrBGH2Fu5iTU/9jqihcB7YnrYaCnPhGeq2ojpPBwzMMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q16P5dNxG0Fm3IxC6pmziA/Z+m6goFrjWlFR7ztWRE=;
 b=wuUqrwhGw2BsPkpNFKMEH3fZtzkPHqzXPqUrZTGq7uJamPdpPsh8epaDVQ0dquvmyDWre/BA8xOd2tNIGXoYwTYjz0YUyRPRCtqBwR4OP9vPJ0lNcBwMNBhQQtO/fN7pCFs5vORpWysSvxVALRJFAJqx+j3jY/k2Ys8FZzyFacw=
Received: from DSSP221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::19) by
 PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 09:50:31 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:3d5:cafe::3f) by DSSP221CA0002.outlook.office365.com
 (2603:10b6:8:3d5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:50:31 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:50:22 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Huth
	<thuth@redhat.com>, Sean Christopherson <seanjc@google.com>, Jisheng Zhang
	<jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins
	<charlie@rivosinc.com>, Charles Mirabile <cmirabil@redhat.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v4 8/8] futex: Use runtime constants for __futex_hash() hot path
Date: Thu, 30 Apr 2026 09:47:30 +0000
Message-ID: <20260430094730.31624-9-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430094730.31624-1-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 18efc1ad-5752-4777-09fc-08dea69deb1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|56012099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	vfCzn0of+eSGpF9ucSwW1ql4FmGh6H1EIkzxcP8bi0lluB62XBT8y1nDXrjLHgiv1ABq+6Y74/2a0NRe1LlbyWuJQonp7rbkzuzPTxtSeO5akcEVg2j4DTAgW6y4x6CreheXreyCzpQ+y8oFIel6KIoqNfCRK/VejPOTVwCWd0ilFq2MzhhB+6LF4WCm8kKemlMLz5i2zuo7WtWC2t2jsfREZ4lX9YWU28Z7tTXDMPq83XH3e3StzXeommEJmP3pCRXjwKa1NZpZEBpi7S7zvNo2fQj2Idv8IKMFZgx1S21mA0QLNA7fmqjEO+bbde9muxrgY2O+iHCqqfYIXcGUqXi7O6NsxSpI8XJAKiwR0dv6RkZO6zrGxHeeT/v3fEUwpWO0pXhQ/CsoefPufApeCaMT7F+cshGBsTFaCfCW2sviCGYum603xPcLNcOGDGwzc4aravw/xbwsQDr3Ki8dWv7NdRT3+Wk47C0WwT6JKmaMaRnMvoDIXfOw4iVfse7Qg224QgVac8zaL0+wFWQjLo6C3+aRIVOpoyh4IxCpCSmWSVQgfn36/NWKzwxpW3AcGWyY5PEF0S/zlvFZA+QEAQWIAFwgctHBI2GV0eWuyeDcfEZ4Uv126vN3qsFp5BmXMua0vaSUDvhNll50/tdptoR1YDsceHPgAHd6l1Nr/QRWd463EAN9C69BLngac00Re51wWocEuFBECWfiom0/8pPr9WeHHjIldZY0v1p5wb4pvOgeadDyLMy8awSK+PO3/SGAW4C6uAadMUAD4GWReg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ETTEpFS3Ha6S5K96x42sRzM1jMqYiBiRLLmbiw5PZGeyQ0E7uzdd5qf/lDRM8pJ75+5bttPM2i8/BK6sbUe0YHLrtZqO56SwWYoZro+AnT8vJEnTZQXK6slAl6++msoNDkI1ZfUCsg4iaFb1Ikb9JH7nTDuUoduBTvzq0C2voCnfVQCFRi3Dc+6edx8DuS+7obiTnvs6T5RvQH/tTYc2MRl/9dCdxc5/gXX0RXaS08aLOK/c5ZaqDlO0YrmaRUakG8rFFB+seb+bFfxBl5YIu19bWMGIxz0VEnCkbVjbXVl+fPcZB+FSE1SLpoGNB2EKEqCJwMDk2A/z+JPy1i1OKLGb7+3fw5z9+bDsyaWnMKUGHr2h+yua5L0tlCaxXVaNhZfmJMTDYyUSP/bnkrdCPPwbp/FTIB0Qm3lMnSWp9mW8SjTDKrWSqG59st8IXAr5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:50:31.6989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18efc1ad-5752-4777-09fc-08dea69deb1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

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
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o Added a small note on runtime_const_init() in the commit log based on
  the concerns highlighted by Sashiko. No changes to the diff.
---
 include/asm-generic/vmlinux.lds.h |  5 +++-
 kernel/futex/core.c               | 42 +++++++++++++++++--------------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e44..e80987d8016cc 100644
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
index ff2a4fb2993f0..73eade7184dc2 100644
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


Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DE3BFAED;
	Thu,  1 Oct 2026 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883225; cv=fail; b=HRNeTX4/Af4KCS2Kv1hHSC9zKZ1N5DBr6oeunNiHcBOXf67ZOlp4SoTDU4Vw76up9LreCe5Bd9K4+KLwE+NkJA7llAgWglQerXuKpKs1ABUinIuMuLXDS85cztkPddth4qQW0e4acq5M2kZriXE8BStGfSSI7ZbuDHy9H30y6AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883225; c=relaxed/simple;
	bh=9yxTdJBuJEHHjdcEjnOmq81Ceti8lYO99YQcxYv3rnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n58vpuQ8hNH2sMrY2HBopYyX8hz+z6/TLLzpqOTMlPO9JVYZBwIGOGRb0AW/hXRNLlT7z96wSW0qhROitfMDqbqz6n2kLHo7M7LXT/0gFwuul3wzaPAIcnCxhwxDl4wB9UycK0oH/nDe8h8qJaH/GVrNOKjyHCg9denn7dr/WK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ohbea8q+; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ohbea8q+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCmbvXZfzDfu7Ak64pLjFGf9u3/vOEX28ADwV+bIom7aII47CX1VGhJK+mHTZlfcteRI4uA8UnHQs4nZb2WJ+p6uwlyhKzzm181PSMxVxtzjBU6MIewprk6UGuH3BN4huJXouWQ14j39RmOi4Cva4T50rBtpHMEGfZWYrlzCSTXL36vvgpLKKtTpygl64wSPDaPrTNP07mgbkOLQSBpdcOXoDM4DV0UY1sz8IhSWGwC17TR54sPEFdDSa0eCwigUa+n30pX8Easz541KUNLtSU3Lyq+gVDmPI08zyHsb2IMPMpx6PFIoYFabrL+ORyZNEWZp71yI+1nvqQR1yhqpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22jSYU1IUab7uf+bX0pVgGok9mD6xb6tx35X7W1uqjU=;
 b=mXIj4Qi0IO3Mp8jNoEYlLsm1zFonqlUZcU+nJ8CA5FXNX3RRFGsOd/T48GGO07iuirfAo5GlUOxyrX7KYrfcK256Ieq+TRRJ5wU/ZvX9qfENjzWocZPEJWNDhTe1vvIF9k1A9x/LSj4WRSjLeoCt9lXMi+0xT7R38G1zqlRRWbSSVW5ksS4gg89j0p2xyMdHaG/ENmVXdbMTcg8J+1wRLbHotA4wfRCqi1RV1P+gjPyK9TkM/gQxyLoqdx1UAYlp8HyInWViInJBqTaf5ArfrOLzHJAuk4eT1rxz5+NsVxmtcL4CFOYJ/cGCFkcIH5FuxjNizvntThhizGm4fHYp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22jSYU1IUab7uf+bX0pVgGok9mD6xb6tx35X7W1uqjU=;
 b=Ohbea8q+BWY5lKd9T4xMKmv9nJP6egeg0CK9c1j6c/rWSOkt08Sco8/rE4ztDDluxPF0kKNu6g/LJ7HVvZNtdV87UjkBae9044+zvGip2PYbhYBm+pQBWkrlqceKo8+k+JzHtQEFbXeBytb7ax5JnF9yKQ+52Q1FNIXnzQauZbg=
Received: from CH2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:610:57::40)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 19:33:30 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::b) by CH2PR12CA0030.outlook.office365.com
 (2603:10b6:610:57::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:33:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:33:30 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:33:17 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sudeep Holla <sudeep.holla@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "WANG
 Xuerui" <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Christian Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v3 11/13] lib/sbm: Add helpers to allocate, set, clear, and traverse the bits on sbm
Date: Thu, 1 Oct 2026 19:28:47 +0000
Message-ID: <20261001192849.74788-12-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001192849.74788-1-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a3c0ce-739e-457c-35e5-08df1ff2df83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|7416014|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	bwVL3VtwqW6L7fFe/yQQ5KpRdC4VNMYU0BX4QyRm0YPShM84Zr4ZnhDmriv4dua0vhLmEudgKSV98gUdmW008FcRg5K+Y80Pqsbxac/jerhYbV4fslabBdycEhcziGHz4fKwWtK3p25ZbJOE/FCLX4A2WFVSJtgAO0rzRrHDgFNAkuBDBhDx2/8TJf+i27S5C0rC/cm4tY6mZzMOf3vjuP1P+Fzc0Dll3Xd2hRy2EUThUZLYJhNu29JZu8KlF5X9+UQPlo4/UXTb6eT1jVKffMKsChrCsoRAm7o79f3UycWiQDRUyKafCoijZRDB3k2c2bpNPzbQ0I7eTf9oi3T6gzhbErDBRfA/RAWrKL177S/6G1HVpJIeTWS1frOz1T+CppgzFe7BnywZLOAzry1UGVvh9D88gcoVscbyel9kK9UTJhQxN+PzujOXmXEfVwk3QJ+odib/LStnkcpbTOd4ZODRt+90iPei0xA031G9rC3ZS3lsHZvXkPF/xlhmCXdVnRvYWL/TX+jwy8TfxCNn2oLMe5e6cik81FZOMYp9axQS3zRZ2jfnThF12J9eUiFgOiE1Kkl1kKCsAQNn8phL1Rntc6WceL7uW9C/NvxIm9Fg6A5VgNOpo5E7WA0lrRsP7QirP+/Zm4rzFdAGkf68mJFsrS2qEJipLiF7Nr9MQKd1EfMdgT8U44Lw/gNdnF70kiqrUKJaVOVeIB4EacIah+upGPZnAM/waSQlDcya2hOGnXAP5igJO52GRD10mlEU
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(7416014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TrVDDkf5J9IbYvdZoxuO/DZCxGtZmN/Agr9xNORVb8rZXM5CvIug+0NPEYXZpRx4UzmVADDcK9w6Gp9PmuxIthiMvPXwoS/FXNZbJaMkkvZeq3ogXtySedcOtNtNsWIdZGpJnlG2s5wX08TocebEa3ZbuFy0om9THzpHBXraE6LK8wbYCRoDbiQR5Q4uxp3N3AfCN0IeLCWjCRC7v11rPgbs0TB8ZRG+M6RpS5n9nt0QtFlG3wsK9dkHvuYo0nIpJEwXgkzRfHsGvD7Afuv4KrKbRpvXpYQ7SiliVrFtjOqYouZqHFt7xVjeuL3FEWRsJj1WP1Z3kHQV2RpWrQ50BEODTYO5nV6CRCP8cqMxD9gSo6kXPo1y+iJum+n4M2t3yd950CffEoxbJYb6IfENA6ZoDHdDhbsra4MrFPnQHswcvArQ7Gmoon8YlD7kN4aD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:33:30.1983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3c0ce-739e-457c-35e5-08df1ff2df83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

From: Peter Zijlstra <peterz@infradead.org>

Introduce helpers to allocate a sparsebitmap (sbm) of arch configured
length, set a bit on the sbm, clear a bit from the sbm, and iterate all
the set indices on a sbm structure.

  [ yu.c.chen: Fixes for sbm implementation. ]
  [ kprateek: Adapting sbm implementation to a flat array implementation. ]

(Not-yet-)Signed-off-by: Peter Zijlstra <peterz@infradead.org>
(Not-yet-)Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sbm.h | 85 +++++++++++++++++++++++++++++++++++++++++++++
 lib/sbm.c           | 55 +++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/linux/sbm.h b/include/linux/sbm.h
index 232b0076bb3f..63b116e52e6c 100644
--- a/include/linux/sbm.h
+++ b/include/linux/sbm.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_SBM_H
 #define _LINUX_SBM_H
 
+#include <linux/bitmap.h>
+
 /*
  * Masks and shifts for sbm index to translate
  * a sbm leaf to CPU.
@@ -9,12 +11,95 @@
 extern int __sbm_shift;
 extern int __sbm_mask;
 
+struct sbm {
+	unsigned long   bitmap;
+} ____cacheline_aligned;
+
 int arch_sbm_cpu_instance_id(int cpu);
 void sbm_set_topology(int num_instances, int max_threads_per_instance);
 
 int sbm_cpu_to_idx(int cpu);
 int sbm_idx_to_cpu(int idx);
 
+struct sbm *sbm_alloc(void);
+bool sbm_empty(struct sbm *sbm);
+int sbm_find_next_bit(struct sbm *sbm, int start);
+
+#define __sbm_op(sbm, func)				\
+({							\
+	int idx = sbm_cpu_to_idx(cpu);			\
+	int nr = idx >> __sbm_shift;			\
+	int bit = idx & __sbm_mask;			\
+							\
+	func(bit, &sbm[nr].bitmap);			\
+})
+
+static inline void sbm_cpu_set(struct sbm *sbm, int cpu)
+{
+	__sbm_op(sbm, set_bit);
+}
+
+static inline void sbm_cpu_clear(struct sbm *sbm, int cpu)
+{
+	__sbm_op(sbm, clear_bit);
+}
+
+static inline void __sbm_cpu_set(struct sbm *sbm, int cpu)
+{
+	__sbm_op(sbm, __set_bit);
+}
+
+static inline void __sbm_cpu_clear(struct sbm *sbm, int cpu)
+{
+	__sbm_op(sbm, __clear_bit);
+}
+
+static inline bool sbm_cpu_test(struct sbm *sbm, int cpu)
+{
+	return __sbm_op(sbm, test_bit);
+}
+
+static __always_inline
+unsigned int sbm_find_next_bit_wrap(struct sbm *sbm, int start)
+{
+	int bit = sbm_find_next_bit(sbm, start);
+
+	if (bit >= 0 || start == 0)
+		return bit;
+
+	bit = sbm_find_next_bit(sbm, 0);
+	return bit < start ? bit : -1;
+}
+
+static __always_inline
+unsigned int __sbm_for_each_wrap(struct sbm *sbm, int start, int n)
+{
+	int bit;
+
+	/* If not wrapped around */
+	if (n > start) {
+		/* and have a bit, just return it. */
+		bit = sbm_find_next_bit(sbm, n);
+		if (bit >= 0)
+			return bit;
+
+		/* Otherwise, wrap around and ... */
+		n = 0;
+	}
+
+	/* Search the other part. */
+	bit = sbm_find_next_bit(sbm, n);
+	return bit < start ? bit : -1;
+}
+
+#define sbm_for_each_set_bit(sbm, idx) \
+	for (int idx = sbm_find_next_bit(sbm, 0); \
+	     idx >= 0; idx = sbm_find_next_bit(sbm, idx+1))
+
+#define sbm_for_each_set_bit_wrap(sbm, idx, start) \
+	for (int idx = sbm_find_next_bit_wrap(sbm, start); \
+	     idx >= 0; idx = __sbm_for_each_wrap(sbm, start, idx+1))
+
 int alloc_sbm_index(int cpu);
 void free_sbm_index(int cpu);
 int sbm_init(void);
diff --git a/lib/sbm.c b/lib/sbm.c
index e5b0508b6825..eeca5ce06d50 100644
--- a/lib/sbm.c
+++ b/lib/sbm.c
@@ -12,6 +12,7 @@
 
 static int sbm_max_threads_per_instance __ro_after_init = -1;
 static int sbm_num_instance __ro_after_init = -1;
+static int sbm_max_populated_index;
 
 int __sbm_shift __ro_after_init;
 int __sbm_mask __ro_after_init;
@@ -35,6 +36,11 @@ static __always_inline int *_sbm_idx_to_cpu(void)
 	return runtime_const_ptr(__sbm_idx_to_cpu);
 }
 
+static int sbm_max_index(void)
+{
+	return READ_ONCE(sbm_max_populated_index);
+}
+
 int sbm_cpu_to_idx(int cpu)
 {
 	return _sbm_cpu_to_idx()[cpu];
@@ -45,6 +51,44 @@ int sbm_idx_to_cpu(int idx)
 	return _sbm_idx_to_cpu()[idx];
 }
 
+struct sbm *sbm_alloc(void)
+{
+	return kzalloc_objs(struct sbm, sbm_max_threads_per_instance * sbm_num_instance);
+}
+
+bool sbm_empty(struct sbm *sbm)
+{
+	int i;
+
+	for (i = 0; i <= sbm_max_index(); ++i) {
+		if (sbm[i].bitmap)
+			return false;
+	}
+
+	return true;
+}
+
+int sbm_find_next_bit(struct sbm *sbm, int start)
+{
+	u32 nr = runtime_const_shift_right_32(start, __sbm_shift);
+	u32 bit = runtime_const_mask_32(start, __sbm_mask);
+	unsigned long tmp = 0, mask = (~0UL) << bit;
+
+	for (; nr <= sbm_max_index(); nr++) {
+		tmp = sbm[nr].bitmap & mask;
+		if (tmp)
+			break;
+		/*
+		 * Consider full bitmask from
+		 * second iteration.
+		 */
+		mask = ~0UL;
+	}
+	if (!tmp)
+		return -1;
+	return (nr << __sbm_shift) | __ffs(tmp);
+}
+
 /*
  * Certain architectures may skip initializing sbm propoerties
  * while having an arch_sbm_cpu_instance_id() definition.
@@ -105,6 +149,8 @@ int alloc_sbm_index(int cpu)
 	_sbm_idx_to_cpu()[idx] = cpu;
 	_sbm_cpu_to_idx()[cpu] = idx;
 
+	WRITE_ONCE(sbm_max_populated_index, max(sbm_max_populated_index, i));
+
 	return 0;
 }
 
@@ -127,6 +173,15 @@ void free_sbm_index(int cpu)
 	if (find_first_bit(&__sbm_idx_metadata[leaf].allocated_mask, BITS_PER_LONG) ==
 	    BITS_PER_LONG)
 		__sbm_idx_metadata[leaf].instance_id = -1;
+
+	if (leaf == sbm_max_populated_index) {
+		for (idx = leaf - 1; idx > -1; idx--) {
+			if (__sbm_idx_metadata[idx].instance_id != -1)
+				break;
+		}
+
+		WRITE_ONCE(sbm_max_populated_index, max(idx, 0));
+	}
 }
 
 void __init sbm_set_topology(int num_instances, int max_threads_per_instance)
-- 
2.34.1


Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1617D2;
	Mon, 16 Mar 2026 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638672; cv=fail; b=LEj3H7St6VUtWvBn6d7AWyfA4qV48QqVccuMddvTN5azUkFmsmGznDVpLlEbQBw8aYx0XPo13q4outWQQhGdi2L1A8W1lW1gFSAOP5TPy2c9+IlufDuRI65XXYb8X9RwsNatNNtwv16azTdPRZmWD0Q5GLzHAGZ0HOW1WvqMDI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638672; c=relaxed/simple;
	bh=4ytY8MSeJ7RlPpLYOZqO6gR9nZIi/uWxtdE/JTvb5v4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQtD+bS0esiLO6JE9JCDnLq3ub51gDvYsp8I7/XK/G46KRBFCiqbnwqS/oygVo+/GraAoqaW6+YWcWpkOvzYjardQqpy6GpI1zDRMbRVFBfvmClgDlfKuymddOyptyk78Ki76n0boAoiwFJ16t6BchhdDJGkXHbpm7KDpfsnnXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TOK4QKkP; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TOK4QKkP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6rlkmVszfA36vgWzwwGCkYaJckhyynU6mEirc7LvH3QF8UIW1mNT97b7qEA3/cJB2dn+yrXMMlno2Unbv9sTqqPbfOICNCW5bAjA+SUoqogZH2cEn+urUcrDnjvafAO8u/qJxko8QZ96UyTuXiXf8XZslRsQVYJJe1Ju1TjLavcdbNfOAwsMHXFRRRju4X/VFLm1VtoAaz2q1nvV+/CauQBwqPuXNOA8fN++H6l4VljcwEjbXslZ1frWFc+UWrC9lsHCz9gVcHFERRDXv7B8dObhe9RuGUPSRvfenPVGdP6Ey7UaLM9+OckJOKnekZUYZyKQQjJwYy2cYOhTN9Xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az15iROq3FYyfvRZsn4Zj27OGchGQSWSza7dvnNa+0Y=;
 b=wg/qiR2noZgYEw/3na6aCi7EOWUeCeqxQ6zHjcQsRSdv8qEKZvliAthRk9jxKuWqiedDKdd+CmZV3bWvRD4ul7mxg4s/R/y13QZVKfp89KWxD2yg2KByohMw9VEfc6dyE1+dY1tkIbDR8n+CFQ9rQ984wZDuIs1Biei6wAHWBRlYXGduSkeaQ6s3szfv/PlXITo0Gs4J5kyCBYR7ue3/dF5y7ifKpDAB8EAA1QvwXTOCoHDMO06AqQezRhVLVgUsmBeG5uJp/xGMdotOHOWOez68jQH/kgf0iphT9Wb+XfY2+9Why+J8Pa5fFguZ2Xv/Liph4XzW2sueCc0tvfZ7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az15iROq3FYyfvRZsn4Zj27OGchGQSWSza7dvnNa+0Y=;
 b=TOK4QKkPRZYUQdoT7goB02zN6K0kbkmN1yW+/oEk2VuszTpgx4qkZQlZUy73WQd3YsqMALb6Qtn3FTL32dRI424tGDeauUxc+MNxnHKi7qaeOVz8yrHvo5jCBftjYQB2ZTAzl9gAGSZou98Ey+LntWIa77P0DR8FS4iC/4+r06I=
Received: from DM6PR12CA0004.namprd12.prod.outlook.com (2603:10b6:5:1c0::17)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 05:24:27 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::d9) by DM6PR12CA0004.outlook.office365.com
 (2603:10b6:5:1c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 05:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 05:24:27 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 00:24:18 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Alexandre Ghiti <alex@ghiti.fr>, "H. Peter Anvin" <hpa@zytor.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, Sean Christopherson <seanjc@google.com>,
	"Charlie Jenkins" <charlie@rivosinc.com>, Charles Mirabile
	<cmirabil@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Jisheng
 Zhang <jszhang@kernel.org>
Subject: [RFC PATCH v2 0/7] futex: Use runtime constants for futex_hash computation
Date: Mon, 16 Mar 2026 05:23:54 +0000
Message-ID: <20260316052401.18910-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 882709fe-71f4-4e86-b055-08de831c4af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|30052699003|1800799024|921020|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7qHAgEwNp/DggjR4l+zhq+EJgh76EIdWZjNXdsN00M7LFHrDvmcA1izRxioDfXgvqF6keSZ5eLvYBxLqY14gpuh27anPU1dYKhwN6AO1tAgBjdFuvYST1+sX9gYeguiNNmIKDcDuD0d3jWSKc1IOqkUxd6t6BgEjf2W6LyZ8knS8ZfGHsFifuu7EthDvofJHvhIGt4QOY5rMjDiGSkb1lX19QV+fF/3+8BQDtLwq4mR1lRA4PyoKGbjbuf3TYk6VyOlLvfLCr3wcyZ4zPKWYDgxZ0BeFoqz4PHZMfnueAplmug+DiG1pbm9KoSGjl3cZxwTKnxXWTmKat4vzqiVHCIFpfT02hUsZ6d2TUtH3khXCvDGw7nqjWo8O3uEp5UYto/+BeaSbh/8wLPtiObbHSWboNpTm8umqqAnQyVG+BiW4QgvNdRAi+sxskH/MNR3AKEFfklhUlo6iZouTPWgjhepoL7S6vBk2kC1osELlvyOdAEtpN+IToPVFxSZbOIV6kuuHY0ug5lNpVao1bXmQeJoDe464lzI8yM8ppjIplG35k3sbrU+ghhnKcUy55YpW86b+3mXW084udLHCK+9Omf5yCM2SywsbOSu2RadNL4BltxRtxEKxWhnGUIPFb/0MrpY2AWyk/zqG4+70NT50cBbHQUr1r9LRD0OycxcgRWxUZfLzVnNSgIvcmFac+rmeLGB+vQkN6I3AVfioAqRANlN4BMLAk4ed8qJoYk3wbqa/pP0IVEa1gZOYNhBWnB5vEZm80AsPINMwBxfglFTQtTAn+2CsvXNXrnW5jUlj9kT0sJ/y/klyVA7DhK3GhID100wpxpuXWszrUN6FKiC+5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(30052699003)(1800799024)(921020)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fk8kVJ23oeVfvoWZr9rus6XcC7y6U52HrdghVVzo9fGMzq8m8/X2Y9acHytmmrzrXac66OceO6cFbc7VaSp+Y8bPEVYjZR2cbmwqMBSGPwqMa9oC5/BKc6T39R/col75wfAR48BjPfrwo+orzqNsyZLV3MpgYFG32hVATD/BcHADJ6mU9ic0VpdBOg6roDM3qT477/XCImP8wVYXFew1nQCTYJ9m5x3koz89QKGp21tpOv6GUhUkEvquAHjO+OBRxiGTQH2bANBVoDML4inwQi/axZPl5Rzl8VLHzaArt+gX6FxC5kbv7wlzKm1nEh/FwfOINNjCxQ//75/TmfLy87cFvaljs6wxiYB+ZhmXHLYEwBhBsTeowEToO6I5cs/zKyaij3ZAgSHW9OZKlmyuIlaYBaYTalDtbJuXeKT8syD4i41ySd90GLUbQlku+S6S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 05:24:27.2417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 882709fe-71f4-4e86-b055-08de831c4af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

Use runtime consts for futex_mask, futex_queues, and futex_shift, all of
which is used in the __futex_hash() hot path. With runtime-const, the
futex_queues can be allocated dynamically to only nr_node_ids slots
which saves a bit of space and was the main motivation for v1.

To support the mask operation, runtime_const_mask_32() has been added
and implemented for all the architectures supporting runtime const. x86
implementation was provided by Peter in [1] and rest is me looking at
gcc disassembly with a helping hand from Claude to plumb the rest -
these are likely the bits that needs more review.

Apart from x86, which was build and boot tested on baremetal, all the
other architectures have been build and boot tested with cross-compile +
QEMU with some light sanity testing on each.

Reviews and feedback are much appreciated.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

at commit 1def441ca008 ("Merge branch into tip/master: 'x86/tdx'") dated
15-03-2026.

Everyone has been Cc'd on the cover-letter and the futex bits for the
context. Respective arch maintainers, reviewers, and whoever got lucky
with get_maintainer.pl have been Cc'd on their respective arch specific
changes. Futex maintainers, reviewers, and the lists will be receiving
the whole series.

References:

[1] https://lore.kernel.org/all/20260227161841.GH606826@noisy.programming.kicks-ass.net/

---
changelog rfc v1..rfc v2:

o Use runtime constants to avoid the dereference overheads for
  dynamically allocated futex_queues.

o arch/ side plumbings for runtime_const_mask_32()

rfc v1: https://lore.kernel.org/all/20260128101358.20954-1-kprateek.nayak@amd.com/
---
K Prateek Nayak (4):
  arm64/runtime-const: Introduce runtime_const_mask_32()
  arm64/runtime-const: Use aarch64_insn_patch_text_nosync() for patching
  riscv/runtime-const: Introduce runtime_const_mask_32()
  s390/runtime-const: Introduce runtime_const_mask_32()

Peter Zijlstra (3):
  x86/runtime-const: Introduce runtime_const_mask_32()
  asm-generic/runtime-const: Add dummy runtime_const_mask_32()
  futex: Use runtime constants for __futex_hash() hot path

 arch/arm64/include/asm/runtime-const.h | 34 +++++++++++++++------
 arch/riscv/include/asm/runtime-const.h | 24 +++++++++++++++
 arch/s390/include/asm/runtime-const.h  | 19 ++++++++++++
 arch/x86/include/asm/runtime-const.h   | 14 +++++++++
 include/asm-generic/runtime-const.h    |  1 +
 include/asm-generic/vmlinux.lds.h      |  5 ++-
 kernel/futex/core.c                    | 42 ++++++++++++++------------
 7 files changed, 109 insertions(+), 30 deletions(-)


base-commit: 1def441ca0085042d41aa8614bee7269bd7e18ff
-- 
2.43.0


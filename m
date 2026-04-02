Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7183BFE20;
	Thu,  2 Apr 2026 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129017; cv=fail; b=p5VN05UUwMregjNjPp7ZB7UctuEkEzbyqkggJb2msUVH7YEfrk18NesABjjdxefaTD3PyWdhFXgs9CJNpfRBYfj+C+MP9rpgNY0QG8dxmzj7Zi5HW01xxuYRDapiY1ab2DoIjG+9w3E19DWSPcrZJX1hQjnG9AsQRC2+LiNEOQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129017; c=relaxed/simple;
	bh=zroB8N3jEcDqzTRhMLFPa5jISHOASGShEOzUWzNHCQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTKXPc9YyPAWogyU4jfNAGzStzyAfVPmuHsXRulRu5R9lH7PzNl8NC9hy/ZaKWsAHzXsBr95j0IKojs1HSHPLzFgWWI3rB+8GNhYAGSK+5pgSyG5ik9bZuxtl6EFd80csHF/kYTSqNKM6AL/ujugpyVd4PLMgYhBKV6IkfMrQQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k484HZbg; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k484HZbg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy0/BLKaeVGGVMa4pWYnjQgnk4WqUkaZTLSA4K5hkHHR/K3LXZeOtkun1yytiL0flJTxL1SuEW6r2S7Nzi1LAczjRX67ibKhF8Yq22xdXTcuvYth43ZaExGIq2O6cp7GZ067RDvOGhu+pcCnD1ZcDgMwLYdfH95vAnvH1XCno7m6EYagGjXHwCSgZ0ZZThvpTJbjARNhViEEN+3QhslyO2VxPUd+n3wa6fzcsR9rsQ6uRcnKFEwSaGLQKbGViTrIrcfIP4kMWjGToy6D5tqvZYO32hHsJ5UGFd6uImy7chRdpjWZKw4WxGbYlsN78/Kz8da+3cqiZprU6n067f+W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kGfQUAhEJRNe0ovYyjuYorzzpS/c3tAAv7pRCbngVQ=;
 b=mZJOPssPDfUUsbrfM0ZwN3E5yhxFKH0u9G+7xbnAGlc0S+VdwBQVfxkVlXitZ1inCnkt4wRUQ+DlIn/NCXvkzUGVCtoMjbvHgbYS1vlfwVnxcQdJHPzbCNB00GB7+/lrZXUMReG1tVe7EHmj1rM7vP5EKQEXboM0yzY90g4Sny9PKO1tJAb/kwjRX2n3dv9Jc+93ipQiXi7d+TZTRGxfPZmNkiYArSg0Ud/7/hyhGlp3FPZ7TF4DGaz9FD/MFlnhVzaHW6b7LkumbFRp5K5IPUC4RTkmbKaJCToAV6SVrbp7h/UT11k/KSv9qAmF9o7lauXfzk6hb57s+ohNgtWSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kGfQUAhEJRNe0ovYyjuYorzzpS/c3tAAv7pRCbngVQ=;
 b=k484HZbg89ugh89pJdMEgMvAKWD87seviZUTxQ2Lb0q2HRDGI8fWaMlZSzG/lTdCxWheLU0NV2/BiYleYEWx+W7N7y8mVOv55WLk0blXY31wnlPeZX2MOGxK1XAmuGOjzVEqGX3T5cMchcN0pu/avW6qoYoClRj0QZCenNPdd1k=
Received: from SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 11:23:20 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::38) by SN7P220CA0024.outlook.office365.com
 (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 11:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:23:20 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:23:12 -0500
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
Subject: [PATCH v3 0/7] futex: Use runtime constants for futex_hash computation
Date: Thu, 2 Apr 2026 11:22:43 +0000
Message-ID: <20260402112250.2138-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c55a4a-adc0-4fa6-c940-08de90aa3ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|30052699003|36860700016|18002099003|56012099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	jk03w2/gVFcpDJ8ehu51yI9eMM4IrQpOlJMrfOj008TCI99ayFwH3UuGEkqrZZzlhbFRhkjvaW3cjY2QwTKiMws/jtRSbXlqHGhwjDHmFpM0u4MGU7DuPN2132IXkGiWibgkPfAPSfVXJseUURMY3fy8SQwauDf2QFswbqdAoyVvlkIFfHu8qELkWiN/qe+WKDIQWrcZ6i6IaHrL5MVCiDpeYkr3fFWugNtX7RpiuHPufrHmtxqn06bnAju7zpqHp0sLqH6sJFCJhhict/uCteOEfUOqVO3aLRZ84zzNw5T9p6Ifd5Q5nDSmKcM2NmxkQ3Fv0D6Ed04tT1G7pmYngOS7FZCgkrtwri83DiXnAD+wG3WPyL/MN96AFz7I+7lPYut+qxNFu7iXaVoWluTV58jjiiF6y/6Moue0CPJEEXr4cNr+yepUcB2QDz6+i8ekrqkw/Gktcri0laSTG2zGZIA/eNB9wsSsXk6z+/Kldy/G3JMltAJzV1Aag5UUzvpWoiY2sL1ZjfKa3juEpKW6lY6Ltu/eTQTVy/8fXKD+YGNdCP/la3QWgkLAat4SHd7b2krmUnlHgRVWLPA7q62ydtLDwrzdkRJ9iA4zTk5O3pEZU17JJBTMH7T428SNI5MU8wElljLZ+nLfo+thMxq0GBMZfrQeNctUaCpi7atj7xSGbAWDcSgIF6b8ljbGw/6C20LpAm1uKgKrWoR/DRvv7RlJ1VISaeOoKbanUHfVuwa9j62W1ulyl/cSimL+zhRmZy5atAgv17BsU3FWSfoO7N6GRjOq0/H9uRXbAJdBVIDvwgV7vQ4wOp7uPMusU6Re9Pmcj598TTAtW1mVwUyz9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(30052699003)(36860700016)(18002099003)(56012099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BR+M2tLWmg2u77rwTTSx4mLWmZ0TOW2hIiuYCzNIL6kf+mBrhxulV3evVph+CozCouIonq93PtQ+QyOuaJSimG30znEQ9ScS+TYUdOGYli1vJc76QZJtPWnwN5cYvNsxmzQkFNayi7XvcRJSD6StH77YwHgw8VSKBF10BnB60LhymjXwLIJpmrxiO+ZMVNgmI3qOOLuQV29inm61QFq7bEf/gc3W85gX4IAKCK7vu1B5bOhxKUlzwM9oEMGpJEg8/J++ZoLh4ITZLoJKf7R/p/CL4/xXmi6Og2z94Sl+nQfRKTbyI566RhO3BanojKPyUtv7Y7qR5O3B7awi1DVJITcyx6nttrSHj/E4XVth/ngLxogs1ffo8IMdP0ujcVM49h6jlfsALt2YIESUFtaBg+zUENGx0x5bZq+h8zVKiYU69uRhSqxPGD3ofzByjHmi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:23:20.5376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c55a4a-adc0-4fa6-c940-08de90aa3ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

tl;dr

This series introduces runtime_const_mask_32() and uses runtime
constants for __ro_after_init data in futex_hash() hot path. More
information can be found on v2 [1].

Comments that have *not* been addressed in this version
=======================================================

Samuel had an observation on v2 that __futex_mask is always of the form

    ((1 << bits) - 1) /* Only lower bits set; bits > 1. */

and ARM64 and RISC-V can use a single ubfx (ARM64), or slli+srli pattern
(RISC-V) for the mask operation respectively but this had the main
limitation of runtime_const_mask_32() only working with masks of such
form and others would fail runtime_const_init() at boot.

RISC-V does generated a "addi + slli" pattern with CONFIG_BASE_SMALL=y
where the futex_hash_mask can be computed at compile time.

The old scheme is retained for now since it is equivalent to the
generated asm for !CONFIG_BASE_SMALL and can handle any arbitrary masks
allowing for all future use cases.

If there is enough interest, please let me know, and I can look into
further optimization to runtime_const_mask_32() based on the current use
case for __futex_hash.

Testing
=======

Apart from x86, which was build and boot tested on baremetal, all the
other architectures have been build and boot tested with cross-compile +
QEMU with some light sanity testing on each.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

at commit 1086b33a3f64 ("Merge branch into tip/master: 'x86/vdso'")
(2026-04-02)

Everyone has been Cc'd on the cover-letter and the futex bits for the
context. Respective arch maintainers, reviewers, and whoever got lucky
with get_maintainer.pl have been Cc'd on their respective arch specific
changes. Futex maintainers and the lists will be receiving the whole
series (sorry in advance!)

---
changelog rfc v2..v3:

o Collected Ack from Heiko for s390 bits after folding in their
  suggested changes (Thanks a ton!)

o Reordered Patch 2 and Patch 3 to allow for runtime_const_init() at
  late_initcall() first before introducing runtime_const_mask_32() on
  ARM64. (David)

o Moved the "&" operation outside the inline asm block on ARM64 and
  RISC-V which allows the compiler to optimize it further if possible.
  (David)

o Dropped the RFC tag.

v2: https://lore.kernel.org/lkml/20260316052401.18910-1-kprateek.nayak@amd.com/ [1]

changelog rfc v1..rfc v2:

o Use runtime constants to avoid the dereference overheads for
  dynamically allocated futex_queues.

o arch/ side plumbings for runtime_const_mask_32()

v1: https://lore.kernel.org/all/20260128101358.20954-1-kprateek.nayak@amd.com/
---
K Prateek Nayak (4):
  arm64/runtime-const: Use aarch64_insn_patch_text_nosync() for patching
  arm64/runtime-const: Introduce runtime_const_mask_32()
  riscv/runtime-const: Introduce runtime_const_mask_32()
  s390/runtime-const: Introduce runtime_const_mask_32()

Peter Zijlstra (3):
  x86/runtime-const: Introduce runtime_const_mask_32()
  asm-generic/runtime-const: Add dummy runtime_const_mask_32()
  futex: Use runtime constants for __futex_hash() hot path

 arch/arm64/include/asm/runtime-const.h | 32 ++++++++++++++------
 arch/riscv/include/asm/runtime-const.h | 22 ++++++++++++++
 arch/s390/include/asm/runtime-const.h  | 22 +++++++++++++-
 arch/x86/include/asm/runtime-const.h   | 14 +++++++++
 include/asm-generic/runtime-const.h    |  1 +
 include/asm-generic/vmlinux.lds.h      |  5 ++-
 kernel/futex/core.c                    | 42 ++++++++++++++------------
 7 files changed, 107 insertions(+), 31 deletions(-)


base-commit: 1086b33a3f644c3bc37abefd699defc45accced1
-- 
2.34.1


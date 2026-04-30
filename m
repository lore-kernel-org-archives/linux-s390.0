Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE993ACA5D;
	Thu, 30 Apr 2026 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542499; cv=fail; b=bjN2rwb+KaBW18QSekjwrUOxaeS+9YGyhNjsJbspGdJXf93IueMPT6pQynYevS+vowULBghR4To2k7WV5+8GYYp48RuT0TzcpoOPWUgS3VIQ6lAc23cE/aNP0DmMZIQEj7pgn4gGUs5R9fIuXcCbw+vt8pTZnwN4OeWvt3noOac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542499; c=relaxed/simple;
	bh=euwGIHwD7ajlVh2QwxxvsUshyMgDkjGfNADWjRJLutY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YTW4jnQaDJCCoC6JRydG0BpxdyMfM9x765BAnvVS64FFcuhXmrxFKolmKmrYwolkfa5htAh4lVkJ2y4jVuNuQ3hCVyohyj4vgQrUu9PU/K2BIDGUWiZkPPczD0Q+pUGgJiFWqavcVKcpmRLNPapIUfhK28LaWqrQdfmaG2pLCLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=doY/Ut5b; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="doY/Ut5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpMFnwwfRR+aZI84nF4ombB+zy3KbkwWug7tanVN1KTJe8QG7yntX/2zZS91GQaQsrNp3pCDtWIfYTmdR/lejgtzFWx0IXjRxvyoTLiFcwGwjGKC+5iZ7bLgHmSaZJE35fz+YJCXjpvA9C4OONxLoNZB1uFuyjJDfvLUcjDptz1uEYZnnNxkUXfWxs8bC4XixyGkN3QbMIZhiYvhXSbqUNcDDTiYlgu3gmadC+qvOvgcudrI+hYuTdCTF1NNysktludqq237z8WILUzuy8+SaYH4Msp0KCzY7Ixncev1Eavz88r55ZAiwtMKCrdhtFaiYY2+/vopnuY+mR8f/ovFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt9nTBuF8U9csGfbgU/qjpVF214T7dqzGpChYDZDnEw=;
 b=s6YEqRdFzHZAgPYwuwFJHcXvTO5hiPvH3j9p8Yedu11ZOV+RCs8SUQKjszbL2X86pUWubwj+WHGA/IIqOKXQhG1kS9FResjt27uxKC8+ot87lNU8K3D+nDHe/2dgSIebDYW0ii7nSGF1JS0S/WxQnrJkctrHBZqD+UBLXNcEqWZmVjjJDMgv9IyDyAyvwRHXJ8627HEmZElvgtoHsqCrq4F6cntBaAH9Hq56YIFM+lLMWQgkht4ICSLeAneXSUQFcFI8dJTdoPbDlQMFAjOw7WEnD6l8wCACGh7E5G+7Ea4wKeg8hjTF2Ysj/rdORSnFTWQ42gCcW28clHvjtYooXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt9nTBuF8U9csGfbgU/qjpVF214T7dqzGpChYDZDnEw=;
 b=doY/Ut5bgwVMrIN0mv9FAFgUN9r3dh3s14TyjrsjRx6JvK+TefC+BfKilfNxQ4haDa7KoZE09cKUjiS10iIHeR4Sp2UVlbqtzhZuVXGKiKS8MFIhYmfZr+uYMtIBZr/291HlA7evfn2rCKc6Rh19LcRazP2AzXI4KlK0pK1rTPQ=
Received: from SN7PR04CA0175.namprd04.prod.outlook.com (2603:10b6:806:125::30)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:48:03 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::23) by SN7PR04CA0175.outlook.office365.com
 (2603:10b6:806:125::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:48:03 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:47:53 -0500
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
Subject: [PATCH v4 0/8] futex: Use runtime constants for futex_hash computation
Date: Thu, 30 Apr 2026 09:47:22 +0000
Message-ID: <20260430094730.31624-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 308ef22c-a1c9-42ad-ffda-08dea69d92c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|30052699003|1800799024|56012099003|18002099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	jPLDl5WHMFolTyBzLb0asGRU26cK9pJe7mN+OYiwxXJAfJ2HZmo8iMD40XX8RVSxoA1IWZXPVwUl6YTPcyfZWand5HVuTKKapK1I54nlkF08fODhrkf1PXCJEzG6TJdQVwJf38wzOn9kcSfIz+XrhU9hof6L6wwnbI4a9JrByc9SSyrSNFhxOfcrW0RTDvKravxcAeyMzqN+ZzLGIUKva+udO0Hl1Yscq34PoGxJssxSIAcweFhk13dxLF5WxJPoSCDR+JqP5iMrZg52FM3+wd55MIwu1YTu20pfkHvPYFjp6+Zr80l+lQyxWFhmpvdLiBfHiQcWvnTKJkOtDMjxoWNQ+C9sTvsYfB5mUljIuQ/l7uKd9HMqqP8O7qPlfP8pxfvbQm7GttAntYwgIsIFF+dGDEs9lGycEOQpNH45Ebbj7+Zeao3Wemp6uzELTMoXLKHejgqzK8Wx/2bpMpgm2y1XfnHhhBD6njnfHsHfcRUz4N0PuTLeZMPQQRCdx8Of7KhjbCwd6XrnoKbcZ76H0eWp2k+juqjPiJuFsMoE3IJeeL/F5EUFYeBlkCEHw+RXDZZq59H5FE3Ubx+DlHnokEM+b02Vkr4fYn1mcnOS+46pTWnBsniin/Pru7SP/GoRTLnkW5zUO49GTSGWNm/Wdnbrq1N0StW5QfginkHBKPzKMA1+6UVEsmw24XHc/R0bOJj6FzKYnV6tJ9b2STlovY0aY+J9t3rUdRup+JVQvHaQbQIu8QWj9LP5GiNC82lrPax07ZcpdGXKVDd1WJhgeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(30052699003)(1800799024)(56012099003)(18002099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TGJoSBaJIKv1sMYEJDzwdgpd1BhRaI0au9W3KFiVEpuobqZOY+opf9/p/zcUP0kQ4kuwJ+5u83M1paiHQ+4fAGqWMLfAD2KDsUDshWsQqSfZMm0zUzeqWBeYmFjYqxddvOiTuUKh1az+yXIYFA3oUBpsBr4YIFw/oM8BFIXjo1twXHFhwlTgDFScmf0aWuzL4rpiFOHu6uZnKYalRrsXOb55ARU+t7Uavb/EzGA/M+Lwc8hAXoP1oKUFpij5trI/oHhas5R9k8onxfDwAXpfUfOul8b4N4LbGQWtuoeL3yxqV2ompDV1Dus5HQ+XtWJbrINRPzZkqe8SdxaHBvD4/X4yRKsVnSA56tcBKhDXTmKooeZxRuXmLSS0vg4dXs4OsvxGcNQ8GBFV3DmkBOlgpr41ENHeOp/b2dSYl0AYZInL8T+q+JfcQnnD1Vc3Z7fx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:48:03.5253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308ef22c-a1c9-42ad-ffda-08dea69d92c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

tl;dr

This series introduces runtime_const_mask_32() and uses runtime
constants for __ro_after_init data in futex_hash() hot path. More
information can be found on v2 [1].

Comments that have *not* been addressed
=======================================

Samuel had an observation on v2 that __futex_mask is always of the form

    GENMASK(N, 0) /* Only lower bits set; N > 0. */

and ARM64 and RISC-V can use a single ubfx (ARM64), or slli+srli pattern
(RISC-V) for the mask operation respectively but this had the main
limitation of runtime_const_mask_32() only working with masks of such
form and others should fail runtime_const_init() at boot.

RISC-V does generated a "addi + slli" pattern with CONFIG_BASE_SMALL=y
where the futex_hash_mask is known at compile time.

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

ARM64 build was tested with CONFIG_DEBUG_VIRTUAL enabled to catch any
potential fallouts from switching runtime constant patching to use
aarch64_insn_patch_text_nosync().

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

at commit 8f1aacb683ef4 ("Merge branch into tip/master: 'x86/tdx'")
(29-04-2026)

Few comments from checkpatch.pl have been ignored to adhere to the style
of the particular file. If something needs addressing, please let me
know and I'll address it in the next iteration.

Everyone has been Cc'd on the cover-letter and the futex bits for the
context. Respective arch maintainers, reviewers, and whoever got lucky
with get_maintainer.pl have been Cc'd on their respective arch specific
changes. Futex maintainers and the lists will be receiving the whole
series (sorry in advance!)

---
changelog v3..v4:

o Dropped the lm_alias() on the patching location and send the kernel
  text address directly to aarch64_insn_patch_text_nosync() since the
  function does not expect a lm_alias() address. (Sashiko, Catalin)

o Added Patch 4 to convert the RISC-V magic literal to a #define and use
  that in the inline assembly. (Guo)

o Reverted the naming of the macro variable to __ret to prevent any
  collision with the local variables at callsite. __ret seems to be the
  safe convention that is followed for all runtime constant macros.
  (Sashiko)

o Sashiko commented that weakly ordered architectures may see the
  placeholder value of runtime constant before their initialization
  which shouldn't be true.

  Since these variables are initialized at early boot, the BSP should
  commit all the local accesses in order which would prevent the
  placeholder value from ever leaking out for weakly ordered
  architectures that do not implement runtime constants.

  For the architectures that do support runtime constants,
  runtime_const_init() should provide adequate barrier after patching
  all the call-sites.

  As such, this concern is dismissed.

v3: https://lore.kernel.org/lkml/20260402112250.2138-1-kprateek.nayak@amd.com/

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
K Prateek Nayak (5):
  arm64/runtime-const: Use aarch64_insn_patch_text_nosync() for patching
  arm64/runtime-const: Introduce runtime_const_mask_32()
  riscv/runtime-const: Replace open-coded placeholder with RUNTIME_MAGIC
  riscv/runtime-const: Introduce runtime_const_mask_32()
  s390/runtime-const: Introduce runtime_const_mask_32()

Peter Zijlstra (3):
  x86/runtime-const: Introduce runtime_const_mask_32()
  asm-generic/runtime-const: Add dummy runtime_const_mask_32()
  futex: Use runtime constants for __futex_hash() hot path

 arch/arm64/include/asm/runtime-const.h | 36 ++++++++++-----
 arch/riscv/include/asm/runtime-const.h | 61 ++++++++++++++++++--------
 arch/s390/include/asm/runtime-const.h  | 22 +++++++++-
 arch/x86/include/asm/runtime-const.h   | 14 ++++++
 include/asm-generic/runtime-const.h    |  1 +
 include/asm-generic/vmlinux.lds.h      |  5 ++-
 kernel/futex/core.c                    | 42 ++++++++++--------
 7 files changed, 130 insertions(+), 51 deletions(-)


base-commit: 8f1aacb683ef4a49b83dcc40bfce022aaa4aa597
-- 
2.34.1


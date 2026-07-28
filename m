Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B43B2FCA;
	Tue, 28 Jul 2026 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216419; cv=fail; b=YD+1bK6sT+0R3FzqRV1COa6rOFFSsZhIKJiP6aTbZbmjKDxIcI9JG2HeR65KaNkU0bm/9I5W0XR1S9xwn+55aY3gUfwcbzCfRqz+/+5OjcWTMXTwyOc9UfpLTPgwjWEHawLIQGkXdDdCNsD/4u4n3UbhASn03GAf7lW8q3uQZ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216419; c=relaxed/simple;
	bh=EY6b3ujzfR4caEj/A4tJE5bbGqdM1aDhWHMaZ+FJaeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bi8dqDFN1f7yfdLHU4O9pONZkzld8O7sgJ+D543kLpkJk/cGkODMuGW1oybrelBxmQ7luzg6sMokP7/AkjT59cN4LBVxQtjuIZPFd+v4a14dTfhJVafVUn9I+GFo0J0f5CqOHBEcuThZtJxBnFkTHmjEhw4XrdaDW474UgwkaY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P7uJCwMb; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P7uJCwMb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvC2U9SajpB6SW0aQNpCS4lraBX417JkI2bKPaLKnjM2jk/7Ysg7NSda07et/kWeRLwp0UIKNRcAhHN1fD7IVEbItm+huYzLvlJQBQgSsGXa/Yjt8pjl3PNnq21VhlDZuIeLJaH4V7kgBPj4yVO7XXroqfkr1ZlpKDmNFUAoDhaeCc3hCkydYXW/dyOZDHkruYsicjU9fJSjPrXv2NOrhKCfA1rqHtW+F6HZ020FKCpVlcLcZU1lDRW895KU+/dmAAEP0ePpy9pOaqi8ZjgGINpLEVI2Z5fZM3eCdHO2u7GxJmpTNWTX0YIWW1m4mmRp1yjNcxSooWjxTpMvC1tB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cbZKs/vtIm2wOWW4KeBwiWZ3tHDef1SurLGGBaT6+I=;
 b=UPuH/Qwx+I+ZHyAzJn/9NRxZfP3vn38aauXFgOR9dfLJHpfWCzbzXwkDAzv5Sik/8UAgmLImymeV6d/WTqKMaoOkk1koPM/EDiX0c6BDhX/6CBeuqrXGTEL32teP8eOFM4uYncAItnckNlBZaPCed10brrYi62RB4kNp4mneczSBl2W8dkMkx6VcrV6RPVBiOeeM4PIgD7K4vQt2SkN5AIUi0IARCt5F45jV9vjRg1c9yzAjkjkxK0q6ujkgihh8FcP5Fo2/wgTBCmnjVf+1TQ8IhYHb6w2rhx79etz1JtUjAsBjyZXRj6LBDWKQgFRe5G/eAIImGQtNFN7lGKyWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cbZKs/vtIm2wOWW4KeBwiWZ3tHDef1SurLGGBaT6+I=;
 b=P7uJCwMb+iLU+Bx5XamEPnWUrZhS0vVAP+qSDX8m1IBuu9rF8tHKm7ZMCCYsfdRclidTc3TGQjRupMKCKi6+OvHV6Z83iN1fPxdEgmIAoSgN0SLRSnBKcD93gFpVClWON8asPxkwU6jGP9+tYeaxxBMh55s0g2O5fqIfWczOnII=
Received: from MN2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:208:234::27)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:26:53 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::23) by MN2PR16CA0058.outlook.office365.com
 (2603:10b6:208:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 05:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:26:52 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:25:58 -0500
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
Subject: [PATCH v6 0/8] futex: Use runtime constants for futex_hash computation
Date: Tue, 28 Jul 2026 05:25:32 +0000
Message-ID: <20260728052540.4728-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 69696a21-0a54-4ba0-ec93-08deec68d507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|30052699003|82310400026|7416014|11063799006|10067099003|56012099006|6133799003|921020|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	B4dUZnbBGpKyWd60rHMeH05nCh8CAo9vmlEpSmLqgWtfTVt7fyge5vaXFuXHgRKV+QQ1fQdP5v6RSwFqyeRIEcvfDnHvxjNwxqKIXZLk5M0nFo5FDHCZ7Y4gJtgHOmd7VTQrMSMIifQMqbmiod5F2EG3b9B+zUVoS1o0VeqHrufdBH/uffwox39UayzPf/4RvDh8I+zSD+fdgF48lJf57YdMRE7Aps+KfjtjQM5Ny/gj7gEHMqJeN8qRcSa801888UzPhL8/CfuHp6LuvLAA5xaU8bX7wSi9ejd9HtbfIChHFyvAmhk+4UqJXrRdPd40AVh7DWxpqidzLPBMvt7GhwnhMBRmkTB+RgxXCVRaF7FjMncjQEALmef0MC51cSizafIJkWbPbnYTSxWwpc9LOVNJ+AGuDhx/bxMb1n4U3HsF+/TqvoKhXTTfCHH6Iewjq07nTN63n5VVM2IkXWaEHGF2eriDs1fgpt8xL5JQ1nMFyTajNIgweXZidrjGBiYQTiNVDbxQswEtT6hJtWWP6FSMYl1LIyZgz0Rg1Yuy2uK3XOkgpehhJAunRsGWGPjN7PGRj0QilyCuh+LqMRLpp0B2OM2WyKfmhiMIEjT2sBytUXehG1O7xnE+mBiA/6E0udPe/dDLHr5CJyBgkKwPbpq/4eIzbIl/LqIuo+hFQECN/lJd06DOVM+e/5ZaZ8Py
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(30052699003)(82310400026)(7416014)(11063799006)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F1rkA++Z0AMNN6TYWqp6o8KodbbMN1rq+9NCwfDf0AskhFRf3FcTSVGKgEGExhRbutKi/ul/VzdpuvKNTCxzjn+nOmloDeGPitAWfVzZ2G3SlkwOc55dp4CggRiHOkcxeih8jdh5Qm8Cv+qq9PyX61rdbw2lRVLy+3v3G+laFOcce9y14zBycrGkt1zcq9YcziHMVaRDyOVn94UKhL99zheffQK9/U2/3dkoVFVSpy5uhj0Wz8ZJxVDN6DCVRD5+ja20N7wkMu0N5vfkIImRrl9M9C6XC2ts8kyxaTjO5mjtYVPr+uG3kkIxld/HmTyrlxqMyqJJ80L3k6vGLXNOTlvqK68HdfIuOeGiXq6DiSvbzvgSa+ksERo6uyzy/JIjaixFtyalQE8BcrcmNKKclamZzmvWKWCYlb9yy1svn/pPgK91SvaL+NTl39Ck7G9S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:26:52.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69696a21-0a54-4ba0-ec93-08deec68d507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464


tl;dr

This series introduces runtime_const_mask_32() and uses runtime
constants for __ro_after_init data in futex_hash() hot path. More
information can be found on v2 at
https://lore.kernel.org/lkml/20260316052401.18910-1-kprateek.nayak@amd.com/

Notable changes in v5
=====================

Intel test robot flagged a case of compilers re-ordering the
runtime_const usage before their initialization in futex_init() at
https://lore.kernel.org/lkml/202607091538.58e3f39-lkp@intel.com/.
This was fixed by adding a barrier() after the runtime_const_init() bits
in futex_init() to prevent this re-ordering.

Sashiko flagged that __fls(val), when val is 0, can be optimized by the
compiler to consider val as non-zero and silently optimize the
BUG_ON(!val && ...) to only consider the latter bits, skipping the !val
check. Fix this by explicitly checking val before __fls().

Testing
=======

Apart from x86, which was build and boot tested on baremetal, all the
other architectures have been build and boot tested with cross-compile +
QEMU with some light sanity testing on each.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

at commit 8d0b0ef04514 ("Merge branch into tip/master: 'x86/tdx'")
(27-07-2026)

Diffstat from v5 is essentially 5+++++-- with effectively 3 lines of
code change and 2 newlines; Resending for convenience since adding
parital diffs to v5 was getting too finnicky and this is easier for
pickup.

Charlie's optimization for RISC-V bits to patch slli + srli with
andi + nop if mask fits the immediate encoding is left to a later series
once this is merged.
(https://lore.kernel.org/lkml/178366995930.1208691.2993932866462893112.b4-review@b4/)

Few comments from checkpatch.pl have been ignored to adhere to the style
of the particular file. If something needs addressing, please let me
know and I'll address it with a v6.X fixups unless there is a larger
change that will require a re-spin

Everyone has been Cc'd on the cover-letter and the futex bits for the
context. Respective arch maintainers, reviewers, and whoever got lucky
with get_maintainer.pl have been Cc'd on their respective arch specific
changes. Futex maintainers and the lists will be receiving the whole
series (sorry in advance!)
---
changelog v5..v6:

o Added a barrier after runtime_const_init() to prevent compilers from
  re-ordering their access before the initialization in futex_init().
  (Sashiko, Intel test robot)

o Added a zero check before __fls() to prevent smart compiler
  optimizations of a later BUG_ON(). (Sashiko)

o Picked up Peter's S-o-b from his tree.

o Collected tags from Charlie. (Thanks a ton!)

o Rebased on latest tip.

v5: https://lore.kernel.org/lkml/20260630045531.3939-1-kprateek.nayak@amd.com/
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

 arch/arm64/include/asm/runtime-const.h | 63 ++++++++++++++++----
 arch/riscv/include/asm/asm.h           |  1 +
 arch/riscv/include/asm/runtime-const.h | 82 ++++++++++++++++++++------
 arch/s390/include/asm/runtime-const.h  | 22 ++++++-
 arch/x86/include/asm/runtime-const.h   | 14 +++++
 include/asm-generic/runtime-const.h    |  1 +
 include/asm-generic/vmlinux.lds.h      |  5 +-
 kernel/futex/core.c                    | 44 ++++++++------
 8 files changed, 181 insertions(+), 51 deletions(-)


base-commit: 8d0b0ef045143e7ebf2b4c3ad5347bc1e0e45a80
-- 
2.34.1


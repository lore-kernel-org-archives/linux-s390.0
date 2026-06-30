Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D3396587;
	Tue, 30 Jun 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795369; cv=fail; b=jNFokk7Rsl3FAzUf+wXmXb4A8tkRzUnDe0gbdvMElUU6rzmkJQXz10ZpSvxVf4fkCLnWZp9xi1vCV0xFaUGjJ/T9ldI8VnB8Mgs3HZsVSxqN4CebWTqrqFJGMG47feyIdiZA5xZX6805zbNaopM8p4EPrYUxZRFUVGghXzQtykk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795369; c=relaxed/simple;
	bh=YjGutiggoI0myffozFm6zcCI51ARZXtJDEOj/tjQ2KE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyP52TupDjiOhsQ1veeyBYEu78FCOdmOLKUNptKYvoLunTtwEzNb/GddqWN+maI6O0HxDx3WxtuP+RTfiqWgTAFUpuHx4BzgoSWQVgbJhUq3AZOKoq206+OQcY5ouiHaQyyRo9P96CWIKwrt//oK24oePBUJP5iY/uSMuFUS5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xsvnfZgW; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xsvnfZgW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm7vd2V7jWy1CifybqUONzls6WWG5zFEQxZU5uR/Hbzz831EXtoRYgcVNR75NF+n1BTR3UYwZx6I3LH6+Z+Eckn2wK/uyVHUcreZ+T8vL1qADAT3RwoAA+tH24hzQ2GOAV+fkIupnqiiFrZN1j+7eMikLhn2+dOx+B4u+0dG3WhQyix93x65/vKXsIPy7kQ+VtOZdDUMqpu+9cP/mInbrIMpFjODN1RF4kPxEYtMzwS9EmvEwSwJXG2nMKyLsd9h564MLY2KCZyZkxT8y1Z8TJcezorfNqOqyYKwkKr3n6aaqGQv/0P6015Fw5qMkY7hQZivcFAIZQYYQDOdN70SmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm4jPyqYfSy+wM0UcSzeSKbHFkhE0GsigqwVjldwYxM=;
 b=RmyGtwJc9XnA1cY5t374iwq52kFD1CBz1dJ8jL3g3ZXP85tSOaanJ7ISH27T1zY9oI7nGmcy9C6DJrqzbAt7thLRIFiRfZv9nhCzCy2QfXMOcLRk88D/hATcsXttOaTUI9IhepyTN1qgVl4rNGfFiWG4eTGxexFfsQ5EIyLw8rOogUJ/MnZFTcgQyXpNPzKZWyAlL8XLKlLEFsfjIavxbwLKbdJ6dwzD8bjbk5l9+viyRVwUPfYYKkNsNw9+x/7lUNAMjabYfv13OKJf0DZeSWe/lRcPZsMUT2lZP9vYAbdZHaEnrsI2PIX713z/3WoRmnDR46o5BAaC7FgHaDcP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm4jPyqYfSy+wM0UcSzeSKbHFkhE0GsigqwVjldwYxM=;
 b=xsvnfZgW90Eqhr2uYdPDhNxda3mik0xEtMKxLGdrmFXSIcng+POHFJYxcZYcbon9yjihbVHEQQqdULWIox4r9vlxQ3xwRd5+fMiNB2SKDVAKMtaikGW+Gq/hcKONmlaZ7pXvMvjxZGbtlTOelbimrEDBCTRL3CbmA+dOrOy9ry0=
Received: from SA1P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::19)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:56:04 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::64) by SA1P222CA0022.outlook.office365.com
 (2603:10b6:806:22c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:56:03 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:55:52 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Huth
	<thuth@redhat.com>, Sean Christopherson <seanjc@google.com>, Jisheng Zhang
	<jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v5 0/8] futex: Use runtime constants for futex_hash computation
Date: Tue, 30 Jun 2026 04:55:23 +0000
Message-ID: <20260630045531.3939-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 0004c3ed-31fd-44f5-39f9-08ded663e37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|7416014|376014|82310400026|1800799024|36860700016|23010399003|18002099003|3023799007|921020|13003099007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xahVD0nmsEavjUdAqZ8QUaXhtHHULGwiuxyItzJhO7v4knvvuvRqDXronI8Gvg0Ri4AIUWn+BnwoYP7On68N+ON2NACQ/JgDA9Z/DxM8Jw3W6jeGLcQS4EeufjwTHWShe1sjyBfUThKz3ta7qdkvdAhOQwaevc+KW4BDuGL+qvg+F+Mpu5C/PfytGWM6Ci+kIDD3vkeDxRoa3wcRLKBjai175yUnLUC8tbNrQzrGvyIs7Sujd0uD/rEzs7wKsX/qcMmJ855WP6yShqeLwqupwhimuRAaVYolDYsVOIk2MmH9zQl3tX1Bp6HZVIKfKi4KQE+V+Eo4fJN3Ksbbt3989WKwaQim+5VFo6jDVuQlSfyf9TYlV3wDyHIB3huLluLMMOaqqPJ3x1UgzufNwHhRcAF2yinoWESXILXEZqDSuNgjUdcgHOHTSdWtz866zLKtmvaTKUO4abw1tNZtCoVXkYfNa1m0t6SNtIh5IYjZh1Q1wah5t8mSuoRN67ApOI+YSQU0jcWbYlW0gN2P4uaYpwEK1o3XiyEg64ggGwh9166UK2PsP0jptqCqfiB+mepfacyS4Y1SvTb3zw/A88NM4ETTD/kVWcMEd1vdm2Iy1mDjfoIYprKP2ejtBlrjpi0pvuC492GLWNu046D8ghiJB76jVUIEeAyI3Myjcgz8D913O2Bq5MZANHu0xl6TI25AxkuZTVz6WuhMPbzfEtAaUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(3023799007)(921020)(13003099007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S7UVY++1DRmimcS3cLqawpSAFp3LkJzfYRzVww0S/Z6raEV9f+2V+c7XDs4ilcVgaqV1tvutq9DNQGmTZ9ykVnBCbZtyjR8CTPQQfHE1qMhmhbJaA2bl80U1TMl49nNcJaFMZ0eDDi1oSqNAoFgj99lwR9wjEJvv+c3KnPtuWz2gQSv/BY9ZYqgTFW1HgKYFp4hiLQMN+nvJ0uD4QTbvLBNuT9tf/h6Aru2s6b9fRGjxI2kqeiVtFpXPRQTZfGeAJzIBtqaR6mJAI+chm31HwHY6I8LOFYottAvYPWS0vV/PeKiGYeX3Kg2QCrVcp04ksAWu9Fq0m/mSfkyzoqka78x8LfceFsL0LY352EhiRdJ1uaAevbPjhS2BSZe0hjotHL4phiST+3b3WukAI0LsWkSMb1y4Vk122aFzOCO2+hYyG1qbBK6S7f9GxP/w/hY/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:56:03.8745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0004c3ed-31fd-44f5-39f9-08ded663e37a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

tl;dr

This series introduces runtime_const_mask_32() and uses runtime
constants for __ro_after_init data in futex_hash() hot path. More
information can be found on v2 at
https://lore.kernel.org/lkml/20260316052401.18910-1-kprateek.nayak@amd.com/

Major changes in v5
===================

There was enough interest to use better instruction sequence to cater to
the current use case on ARM and RISC-V so the two implementations have
pivoted to using UBFX and SRLI + SLLI instructions respectively.

This saves two instructions on ARM64 and one instruction on RISC-V per
mask operation.

Future use cases that requires a generic mask patching on these
architectures will trip a BUG_ON() in arch/ specific patching functions
and enough bread crumbs have been left in comments and commit log to
allow an easy switch to the more generic implementation from v4.

Addressing sashiko reviews
==========================

o The operator precedence issue noted on Patch 3 and Patch 5 no longer
  exist as the mask operations are done indirectly within the ASM block
  now.

o The issue regarding usage of runtime_const before their init is moot
  since they are setup before thier first usage. AS for the comments on
  weakly ordered architectures, the platform init is done on BSP before
  the userspace is active.

Testing
=======

Apart from x86, which was build and boot tested on baremetal, all the
other architectures have been build and boot tested with cross-compile +
QEMU with some light sanity testing on each.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

at commit ea9c52e91213d ("Merge branch into tip/master: 'irq/msi'")
(29-06-2026)

Few comments from checkpatch.pl have been ignored to adhere to the style
of the particular file. If something needs addressing, please let me
know and I'll address it with a v5.X fixups unless there is a larger
change that will require a re-spin

Everyone has been Cc'd on the cover-letter and the futex bits for the
context. Respective arch maintainers, reviewers, and whoever got lucky
with get_maintainer.pl have been Cc'd on their respective arch specific
changes. Futex maintainers and the lists will be receiving the whole
series (sorry in advance!)
---
changelog v4..v5:

o Collected tags from Catalin and Charlie on patches that remain
  unchanged in v5. (Thanks a ton!)

o Switched mask operations on ARM64 and RISC-V to use UBFX and SRLI +
  SLLI instructions respectively. (Charlie, Samuel on v2)

o Rebased changes on latest tip:master.

v4: https://lore.kernel.org/lkml/20260430094730.31624-1-kprateek.nayak@amd.com/
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
 kernel/futex/core.c                    | 42 +++++++------
 8 files changed, 179 insertions(+), 51 deletions(-)


base-commit: ea9c52e91213d5427c6a2e90cd41bf912fd1ea36
-- 
2.34.1


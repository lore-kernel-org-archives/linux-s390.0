Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625743E1729;
	Tue, 30 Jun 2026 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795402; cv=fail; b=esORAqVmsvaaXdtZcZvdnV0vyK2p3U2n7ts6U2caRMJVKmLReVKWkUgfcNvemho+M3iu8kVd0BK2ZS53TPYvzg5/wY5an9n4/0W1STcAuDYMVQxeXycjUgFiEzYkcNHAprLDyptsUCeWfwZ4C0ssdOffZocdj8V95EsmG8hqA1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795402; c=relaxed/simple;
	bh=YiOIJ6kWWeYoigvcVyhPUl5tR8u8c+d5eNl5BeBaFkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJjWUqN89sp7SUFcvrr2TufF19Hsx/gSkL9X1DUDQA4bTr/IhfXk6sPUG1g+ZVoP9RRDSefboq2UbV0CAQZp6DZQne68hYWf1qH3a0Ssvx48haPcgYMB0VmxAmewFF6Z3Hkzh02ry0ZuKuzYdboesB9hqU+yigCPhF7extUnqcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pGFE6BwU; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pGFE6BwU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7biroyrFImi5hAN8mo7A45YyeOk6wgHdF6VrIjEfsNDlxvV6nZCaU+KXWLCA21kK9lxm/P7yEB5/JpOjbKX6okaRHY9DhuUDIxEeCBpKfi+/57WJAMTbFHOP98EcKd7SOReNqp65AjOh9WIx59sI1Z+hL5rsy8V4TiSUKwbo0nCFURE+TqDGzTv0UWtgiT5o9QcPRf3W1RMr0fvfGl3K5meQkThwXqc95jAmV9kou4NhWdaOAlGxxHadSUSQPEh8ywrhNZjasLjpIs+J6OkIXEEgeavSIdBqvMnKOn9cK1hnp2MFdbJx4uCOQiEJWX/MUYSxjvV+DxSSlU7qieDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJfU+FiwNBHURWuWGDHCiMmvyyWAxnr1aNBsUO39fTY=;
 b=MA0DKzXzl/MDmPL4Vy3mWMjj9v4t5Zdhh6uDZoFSO63I0sY25M0dhGYYa0gS6H1//dSCz9hp4H9R3StSoxHRS0K246kPMbHbcRSDAwhR0qHGnpCJOi2UoLehV10mnf4xJSgfK5MOCJmXVLtZ1eInXRyJMPKbea9gQh1ZQi1lLsM6cf5Jl4GETrYGW5BPAmIwI3Wy0nqDd7J8BQ/T5YERBun3ir+EF6KSqX+m735dUVkq4RSh/PKXOtYZySCNIiTijJ3EeADHNnsgsX6YmnRV/HpBKwqJBaXxwWucpzGr86H8d3EoYmXfQT+SPoY98EI9cRWdGeiEo3wq1EebkGz/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJfU+FiwNBHURWuWGDHCiMmvyyWAxnr1aNBsUO39fTY=;
 b=pGFE6BwU0D070Fvl7m2udbHGYqENOlaQwtIptJKqgrHG1/c3mS/Fb0LUyFnodl6dPjY/8JceMGdUzqwSP6nGYjaC8grW/7QSuAV4RdpOPgE8SfV6w8Wau1rFGFHxvHzz22kqK90SmqsJB5nJk1DgY0mt1rx2vBRY5n2t/JamPc8=
Received: from SA0PR11CA0114.namprd11.prod.outlook.com (2603:10b6:806:d1::29)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 04:56:37 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::43) by SA0PR11CA0114.outlook.office365.com
 (2603:10b6:806:d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:56:37 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:56:32 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v5 2/8] arm64/runtime-const: Use aarch64_insn_patch_text_nosync() for patching
Date: Tue, 30 Jun 2026 04:55:25 +0000
Message-ID: <20260630045531.3939-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630045531.3939-1-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: d55e97b1-d442-45b2-a0d1-08ded663f78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gEn2bfOuh6EORysn/P4wKoYAJWr0KWTXGBH0nEYuu3kvx79h5zAibp3iTKYaYKcQId3HtTs2RLPLVxqYnbrPnoQQdEItVlBEp0pWPaTqaurYrpqqfQQLe9v4/ixKhm7oLuSRSNCh8ZOPS2s+EIwx5XEHBBbNqyYchaqQR9056bRXjX4LeyGSCPqXJU5IUHuSVvGP0LEvUcW0DKAxQ2B3hiqyEaHQ+xJMF7yJWgOjMVPC9spZaW1VB//Yah9jVPR7zz3UFkBEhJGpPuxLVenRksw5tMK2kkiyrOMnS86Msx+zPkzMXvFlVQ/Zga3+PlvJm9P017BCGwAOZ5U6v8yXS55TqcmuGymKqbOU9hcyoCZA3qpNvC2gZmuzW9LaFJKuZY/l5s0MCzm1iST2aO889s36apXxDWqiQ1L7o/Pfg1WQHvpVCHmk8lpPQjuewkd0IKFqNsjbH29/mqsy8kN/ZX/Hcr+NzKmD8HLk2kYdbTo0wQL1zd2PpS0LWh40XUjY8x3F/xpzjl8zO/qneOdkFI0RwXU4MKBGVqdLnKY2u2bb7e0BGLhqp7TXJbYnivrX/E2ZwqOUBfmIkUXSxf3hboBUC9Ts3snJTu9muwhhiNSSfK8ejTMH4NuTRLusMbQ9Q0RMMUQsJswRRZC3G/KTvZNCGng8BHna5zClIntuN2USerbA1323cnScl+Qli/6xr+sBHmuV0QvOpTlODwJnZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+2LmZOP1mXxqT6CKSq2/um++RcbIzNLlwM8ysfXXaEpdgHzIBQny5t0qWf7ds846tfCmg9rigOPxEp8rPg8ZKE+zKSvE+P4e4Nhm4O/gufSye10n1vKGy+tCd3hcPH0woJyeKBREBzMrE2KSgls+6nAL/Wwu+oWKfRZ62RYLYJy34FxcVuaTIacOXzXL2B0BGlvoQL/mjpdAHugTz3VJLN7entzXLTa0NeAUJKfl2uMfNs5O0CaMKTyzwq/f7KJWxPgoSoIMn/2rG5X6mf3z4OeDI3CbIPXCYioHwQ58VHrzLV3rNkeR0z7DybmUFsIuSsqH6J3ub7ynB+2R4BVPqVXI0la4/Sr6LdID2O7mr68I/WKXFoNsmqybXAEt5Aped365OYxLZN5fDsLq0j6yUkqvech52njrNIBCag4S+EYGLY0+qDA/h794izG88AqI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:56:37.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55e97b1-d442-45b2-a0d1-08ded663f78d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581

The current scheme to directly patch the kernel text for runtime
constants runs into the following issue with futex adapted to using
runtime constants on arm64:

  Unable to handle kernel write to read-only memory at virtual address ...

The pc points to the *p assignment in the following call chain:

  futex_init()
    runtime_const_init(shift, __futex_shift)
      __runtime_fixup_shift()
        *p = cpu_to_le32(insn);

which suggests that core_initcall() is too late to patch the kernel text
directly unlike the "d_hash_shift" which is initialized during
vfs_caches_init_early() before the protections are in place.

Use aarch64_insn_patch_text_nosync() to patch the runtime constants
instead of doing it directly to allow runtime_const_init() slightly
later into the boot.

Since aarch64_insn_patch_text_nosync() calls caches_clean_inval_pou()
internally, __runtime_fixup_caches() ends up being redundant.
runtime_const_init() are rare and the overheads of multiple calls to
caches_clean_inval_pou() instead of batching them together should be
negligible in practice.

The cpu_to_le32() conversion of instruction isn't necessary since it is
handled later in the aarch64_insn_patch_text_nosync() call-chain:

  aarch64_insn_patch_text_nosync(addr, insn)
    aarch64_insn_write(addr, insn)
      __aarch64_insn_write(addr, cpu_to_le32(insn))

Sashiko noted that aarch64_insn_patch_text_nosync() does not expect a
lm_alias() address and Catalin suggested it is safe to drop the
lm_alias() for runtime patching since the kernel text is readable. The
address passed to fixup function is interpreted as a __le32 and
dereferenced as is to read the opcode at the patch site.

No functional changes are intended.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v4..v5:

o Collected tag from Catalin (Thanks a ton!)
---
 arch/arm64/include/asm/runtime-const.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index c3dbd3ae68f69..838145bc289d2 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -7,6 +7,7 @@
 #endif
 
 #include <asm/cacheflush.h>
+#include <asm/text-patching.h>
 
 /* Sigh. You can still run arm64 in BE mode */
 #include <asm/byteorder.h>
@@ -50,34 +51,26 @@ static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
 	u32 insn = le32_to_cpu(*p);
 	insn &= 0xffe0001f;
 	insn |= (val & 0xffff) << 5;
-	*p = cpu_to_le32(insn);
-}
-
-static inline void __runtime_fixup_caches(void *where, unsigned int insns)
-{
-	unsigned long va = (unsigned long)where;
-	caches_clean_inval_pou(va, va + 4*insns);
+	aarch64_insn_patch_text_nosync(p, insn);
 }
 
 static inline void __runtime_fixup_ptr(void *where, unsigned long val)
 {
-	__le32 *p = lm_alias(where);
+	__le32 *p = where;
 	__runtime_fixup_16(p, val);
 	__runtime_fixup_16(p+1, val >> 16);
 	__runtime_fixup_16(p+2, val >> 32);
 	__runtime_fixup_16(p+3, val >> 48);
-	__runtime_fixup_caches(where, 4);
 }
 
 /* Immediate value is 6 bits starting at bit #16 */
 static inline void __runtime_fixup_shift(void *where, unsigned long val)
 {
-	__le32 *p = lm_alias(where);
+	__le32 *p = where;
 	u32 insn = le32_to_cpu(*p);
 	insn &= 0xffc0ffff;
 	insn |= (val & 63) << 16;
-	*p = cpu_to_le32(insn);
-	__runtime_fixup_caches(where, 1);
+	aarch64_insn_patch_text_nosync(p, insn);
 }
 
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
-- 
2.34.1


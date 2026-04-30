Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE393A7F69;
	Thu, 30 Apr 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542555; cv=fail; b=hNWIEgExe3bIf4B+nN9RYIQIjwgrOR6OH6ZAoBosgF4A4uDRqTSbCXsXQBi3Miua0ao+GSIaCtFd7Ea93MJ244dCDbZWLiTfRpRr8p51C3C7qNVA8sPZLMHFL0LOYm4C2a8E/dLNsMEujNyaT1PMWC/Z6XDm3OH8mpTQFs68B4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542555; c=relaxed/simple;
	bh=XuPQZmiGc0NPZsa21tR33Q2PZ7ql4MLZ8DXHTNKlzt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOvJPOyKjAdPVTvsEWDce0vOoCl25z2Vy546EWgPrQEE0zwt3hoVNAstpJtWJCZVHh7++8uoGgRuaJTVZnn5eqb44js6wQiZPPpbq9RVi1jVfMdfK9ZJQQ6equNRXfcTSLwlygrR6mNdtlyXKdCZ64waFdRPcT4+ewuRx0JpoMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4EkGHzQ; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4EkGHzQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBN00VniIMBc6O8BAq7DksOlk/tv0LJ7KpFtn7UkJ7H4Gm1Sw26BuqECIz68+Mn+Lyv341Qw+NAR5u01LjhfrUQjieh7IIetEL6jC1dtRQYirXj1xyeM/2LVSjLvvMMchdkXwGgZRPHSbLeY15Qg+g92iU6sxgFWCav1975t440IQewH60qzKCAKDkckiXTNHXvo9u+N3uxPhzGHVKkLbNBCZgTU0bJGuTV6lHjbiZifulV+33ERGx3DZvlMU/4PGNfjZAjThqsr+uuB35twgGzIwHsLSnmgZiCbbGNdtX/NYSKZ4liyelbrluZ8fIl7Ai+NZ1mfhh/JohF+frG1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj6ei4wKT4j87OaAUFpQiZTdFA1aaakEUuv9evu/U9M=;
 b=wpyAoNtdKCpkyv8hPq9VXwn1eM3p4NfU8ZUIjuzAjNWV+JEP0WWvf07H4lXtPN06MkWIvIcUHDNCaAJ28MrfB9JYTpDdI012W36JIBuqhjIFQoCrBzeooFKG3tPUg2lO6g3EhTAwkjiyWoChIEsLtz+dbcRxaVOarA1T2hprVdws6kLT6KL6YmiDV2K4t7Phv/8XdEcrRIm1jqYxcyVTkrt8sdiNkicP7DU8Avfkhk8ZvkxcYxv3Mn2OWKrEr6LMSfDaxHIjMck/CipTNvzFpl4WO0g9qZV6fKJQLkA9Ax/lhegNXs6Vz8Tv7R7avfzA7lJFD0Ho/BNE01u5eOOKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj6ei4wKT4j87OaAUFpQiZTdFA1aaakEUuv9evu/U9M=;
 b=q4EkGHzQ1UF8eNn4LRE2FzMP9jIPiIjVbWFRCFVES/3J89vku/kEHxuFeM2o9UgxzBMTUjzOCrSdfO6JsGXulPfY9pjGsjriA56GR5WuaPdFRAlqKYvu0HeTIwRGhozi+/09jFE7ZykPG/4EELPUvVTFWTuWA5VuP/tSntOiNGI=
Received: from SA9PR13CA0176.namprd13.prod.outlook.com (2603:10b6:806:28::31)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 30 Apr
 2026 09:48:57 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::c6) by SA9PR13CA0176.outlook.office365.com
 (2603:10b6:806:28::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 09:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:48:56 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:48:51 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v4 3/8] arm64/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 30 Apr 2026 09:47:25 +0000
Message-ID: <20260430094730.31624-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 101cdfd2-5961-4fc3-c2dc-08dea69db283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wHAdHYt7Ivhy9GdyKW9HKVvuixXpRduWuf54l0nAt7PqsGwl6d/Ku9wwtchHY8CuavFzafhod9BbxupJneKontTmJ+9qrpwedPSqC2eDXh3RuVDDVMuWstWP1VU6R5jcZ6nL5pPswu5RYbo+Pq/g0ogPvURdgRw6y4W6l6/XGlheasFihuSpa1J7Be/wf4WnivBtqUvx/HSEWrIprYaoTDfy61YgP+kQ5mOBVpZTCCeW/DUudEasYIA0850MN7PG/9fCvGuXo0yKeoSh/RclSZ0v5+b7vsF5nvZv7CUGSrtaK16C/pF4+3/sz5W9dsqb0Gz+vr3iVSqzPphrIw7fLVy259+N1U1Zo8q0eom5gcOk5i9IgK4Ot/1EZigeTfWsA38Tw25nnm+zLoHYR5B1IuuvNmdk8h4rcxstgrR+g8SE6K3nLXOf2Gu7FlNa7IIl1PemtEqAuMLrlwk0JQDwA/lKlQF7xrojq2cI7gpGMmHKbXd9en6rkWy13xmKtbaPqtGtjLqyhAiXjKRxoojwNXEjGRw0tzt1o5b5hTe1KVwg+i3NXQtSvCglPWNO+sQuWhQVALIcPsYan8UdwmVVfcg86k/ztpEfzWFNy1shLGvlTh6k2fpEzTQkSAxEdSouF21g7DF1CuXMb7yXmxWpX6EbfKMFB7UdAVgR9Cy7jk6g1v3zLnDI9zmWPtCldNCRh3Q1XPOfhUNpQN49Zl1fuoeDnl80iqQN88IbvTCLLf3kLLaUP5WkkQYRAg3L+H898doAoeSAm4XvcMWwrTS2oQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XBgyZuWsSqI58QXFfRWZ+hMoDTARFqFCTvOo6OMD736CMBSKJ25eFNnswKn7zqp7WQsLCodc0ATRsZiu80Uu/zt7QRd3UG9KJwVuegp0LMjfik9hOQ82tdizEfjhhlnoBKQ881uIShmArslZLwhZLwfrkSvPY5IhCzhW7S6UaahtPXsSp3I5zx4VWF8hP/zGQyennUNKXvboacL8F8HyQnmyjvMn6BaTep3Lpe1etoq23vMJQn3kD5ROaWxTBTrMQPmieZ9EPsRtC0DgvTe881F3cpK78QpS6MV+99Qutkxolh9v9xs6uFfXI6Mh4oYESsi8AqdHaLVQhvcrV0CLhPCKrYvqmrhMuKbL8Q/dW+ipFqMXtQJXJZ1OZT0aNcnMceE55jyRRUfCHN58sv2HJr+MOGZ+6QyUU/D+5q05wZPFfrtxG4Pld5AqQm0gIBUP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:48:56.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 101cdfd2-5961-4fc3-c2dc-08dea69db283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path. GCC generates a:

  movz  w1, #lo16, lsl #0     // w1 = bits [15:0]
  movk  w1, #hi16, lsl #16    // w1 = full 32-bit value
  and   w0, w0, w1	      // w0 = w0 & w1

pattern to tackle arbitrary 32-bit masks and the same was also suggested
by Claude which is implemented here. The final (__ret & mask) operation
is intentiaonally placed outside of asm block to allow compilers to
further optimize it if possible.

__runtime_fixup_ptr() already patches a "movz, + movk lsl #16" sequence
which has been reused to patch the same sequence for
__runtime_fixup_mask().

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o Reverted back to using __ret as the macro variable to prevent
  collision with local varaibles at callsite. (Sashiko)

o Separated out the & operation to prevent any confusion with operator
  precedence id "val" is an expression. (Sashiko)
---
 arch/arm64/include/asm/runtime-const.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index 838145bc289d2..1db4faac8c373 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -36,6 +36,18 @@
 		:"r" (0u+(val)));				\
 	__ret; })
 
+#define runtime_const_mask_32(val, sym) ({			\
+	unsigned long __ret;					\
+	asm_inline("1:\t"					\
+		"movz %w0, #0xcdef\n\t"				\
+		"movk %w0, #0x89ab, lsl #16\n\t"		\
+		".pushsection runtime_mask_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		:"=r" (__ret));					\
+	__ret &= val; /* Allow compiler to optimize & op. */	\
+	__ret; })
+
 #define runtime_const_init(type, sym) do {		\
 	extern s32 __start_runtime_##type##_##sym[];	\
 	extern s32 __stop_runtime_##type##_##sym[];	\
@@ -73,6 +85,13 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	aarch64_insn_patch_text_nosync(p, insn);
 }
 
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	__le32 *p = where;
+	__runtime_fixup_16(p, val);
+	__runtime_fixup_16(p+1, val >> 16);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1


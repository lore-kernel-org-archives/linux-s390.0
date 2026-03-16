Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93B33FE1F;
	Mon, 16 Mar 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638761; cv=fail; b=g5qWwmEpiJbsWlwJvg1ExczT/MiMWHX9dLMmV4aiwRmrGE3o6EtCKmBQ+NzxrLEAKeaByteGkNKnjtgLRcKqHA51rkB+ZHkb71GGLp82wYMiGAdFzaYnZialudBnm9K2hn8ACGJxmhTJmgpgVDEiKzux02IPUkyhVZbZghGzLuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638761; c=relaxed/simple;
	bh=tjFedfPW1NhNsno7/pjoaA4ziD82FtOKvzLsqXbhGx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO29pFb1NWN3e50ZJoScp82b/Ka708cwCZqp6AvPZkKwV5H3qTE+DKuhS784lnyr1jENBJjwPy0k4dtQwpWjPTedY7V7POPGwoftARcDWnd918DEwYnX564Bxo8wUapTKyWWnImtuKrmayG5Ji91w2eYRj8XGt72aGipIsZdQSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EQyFNkxA; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EQyFNkxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeJw8fcJYwgOUebNb17QNTS10D7f8UZeT8UyIGE9ZGjYZFLS3j36NNwSDnse8vY5DqbySdk5Qxngba5FSReUgEjN5lRrWzS6l7sYEik8HaQ3QqPfayvlYTPi1jIPpGne+/5gT1M3Jidqbk6x7NB6O9xCrKHMNoK3Cn2xglWWF9gxxtgopEmdEZmxj4lQtexiR45vXnw+/iYvmKB+572KdjEEEbUwLTdWlfz+apm8ygGibGEKPXuls1goiR5NEIyfRpDA6npXzmtyJJwiwEXMQL1eoAstDoy47JKiTygNMpwWfx+amMyqYUJl0l0MmRsh1R4doLbyE3al89vbnm9n6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv39+ZpovnJ8bVZpV0i6+K5nGNYT2LdikQjrOuO9hww=;
 b=nDS40d/XBoeMlKqmEYwDzE6zzmwMl1Lj6RaDR43ekuWmi/WrLm2jHLhPqF9EDh50Cjla0DZP+KVclcZB4zGOsMBCb1Pk3cABTO9YUT8Vi0kt/4rgNFT9As28FYtUExe1JBghOwKiWmmpeScJP2zNWZ4S5O6XTlqWWeJWC3dIRSNxeFv4FI27qLaEjcw9c9WaD2UJiXzCMioeLKjMrubVX/YVyih9hUNHQeTe5IvGBxDs7U4RRwGrMCquRuh5WIevx7N5Vg7Ofl60tmff5V5HTe11o4M86BBIRbjgLSovl/s5/nvM52raoGw1TmPGMiXMn1QmXYkHrv78vdOrmEE2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv39+ZpovnJ8bVZpV0i6+K5nGNYT2LdikQjrOuO9hww=;
 b=EQyFNkxAV7pxSWj46HekprCOmeNDhAiWoStxByRtIdjOsqTmqYoXWmJREHL8IhpnYw2AFgks80o/hJwWr0T0JsSNH44ZeF3uGdnx+UkoVl1lHtaiQZBiZxXsan9xzHDjVgXgR/i8FdZMwRcylC+369eSTZZ+Hwe6eE+WDL1wB/c=
Received: from DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::15) by
 DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.17; Mon, 16 Mar 2026 05:25:56 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::e5) by DS7P220CA0008.outlook.office365.com
 (2603:10b6:8:1ca::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 05:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 05:25:56 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 00:25:51 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>
Subject: [RFC PATCH v2 5/7] s390/runtime-const: Introduce runtime_const_mask_32()
Date: Mon, 16 Mar 2026 05:23:59 +0000
Message-ID: <20260316052401.18910-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316052401.18910-1-kprateek.nayak@amd.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 15213eb7-30ae-4cd2-a6d1-08de831c802b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gqEE48SwCJVGrbRfORKbiY7PJlZg2H0IF7fz5iOXmiBhNPGR+4g4lBABPY2QX48nvJYOYLempm9C2tmPQiWoE5A1DZUpqGLZIqV4RswVrgZNWGFnta8lR2Igir2Gi45hQKuBd9hXn0f+rSO1xPMZ0rGjTraUpdyCyTIgovOkRPxPh3l393fs0O1fKMpajm3rY9e15HdjgXEv4RO6ZZxeTX/qQijb2wpqOnkUGmc7PzP1T+aIsT5ftm5Vumm527WGEe1v4PiNQT61IuNk7bB0ZQlmMj5vRpyp9ekhrvDSuGiUCE6JlEXc7PLVzJTCv8D7O7tavDkpSo4qrHvC3Krw4JyPhWpLotPg6qCxAPu9ASJy1CWACMEMDCC4pqTaMoBL3K/GOv5NhFW9za71HBAdvAHqrwRBx7FuyMybVnVUzXoH226dacy+XrPpS8ykYKHGvgWbNnTcRsXyowZb9L6K3KDUqLAniUzaR64S4ZqNLQjb3wP1sSGFCDmz2fvcDkERj1Je3cVqdEgBywq9UC6irDoChC5/pfpy9yf7iklsABf2mERDxf14msgalhEoY5ftG5SERBig0Xz6JdvOYQ2yQitB/E/U2S3FlQD2LR/4aPOkZcosJgfAfIQnZInPMmYQTQ0L5ljXKZBHM8eH6l23/0ir/ZBD1BMjaR2I3V3DkBKoBoR6fwMTjO0iRaQO4FcYtlcSF0TFAgsLdRtLhY3cWzqHTohb9Ge3AFTKihrsgu2nABFRUl1F+w8RmAFwRMp95yKXM5hvowj4pcVCt0XENg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6SiSjQTWy2D43HkbI7JdWecSmhkPRthbMp3cUScmDFCRlOdrh8RbmNWb2xGCZv0r9YgQhsh4UrUr7HrxI3kL5cQM1xW4UZcQLC7k65gc41wM7ZAiDgvGX3S/HOpPqKDlvibp73IK1LEy1VU7gGaIOLuX/Xd7u8TrcmPYMBYGYWia6EgcnylZJWN7nwTpWKL9DW1Py8dFzuhWGKNrYvalblWU0ItahjjqvI63p35aKlrQledLI8u2sofALQ7/uqyBiB7OANhXwrwzQXS5Ku9aojQNRLMzqf1zafqjmIda97vzYDwAYs6TtB536ifgNmKXgQtBKhDqIrE9PndzH34thTXMiy4s5mBF6slVsRKthas/2lUtmjIcjKx+zUpfJp2EWXV5HOsTBEZHiYaxwj8NOPHOwlgMCWnPoicVB0R7vxSu8Oan51ffrtMXDT704/5M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 05:25:56.5067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15213eb7-30ae-4cd2-a6d1-08de831c802b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path.

GCC generates a:

  nilf %r1,<imm32>

to tackle arbitrary 32-bit masks and the same is implemented here.
Immediate patching pattern for __runtime_fixup_mask() has been adopted
from __runtime_fixup_ptr().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/s390/include/asm/runtime-const.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 17878b1d048c..c0f0d59066e2 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -33,6 +33,19 @@
 	__ret;							\
 })
 
+#define runtime_const_mask_32(val, sym)				\
+({								\
+	unsigned int __ret = (val);				\
+								\
+	asm_inline(						\
+		"0:	nilf	%[__ret],12\n"			\
+		".pushsection runtime_mask_" #sym ",\"a\"\n"	\
+		".long 0b - .\n"				\
+		".popsection"					\
+		: [__ret] "+d" (__ret));			\
+	__ret;							\
+})
+
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
 	extern s32 __stop_runtime_##type##_##sym[];		\
@@ -65,6 +78,12 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	s390_kernel_write(where, &insn, sizeof(insn));
 }
 
+/* 32-bit immediate for nilf in bits in I2 field */
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	__runtime_fixup_32(where + 2, val);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 				       unsigned long val, s32 *start, s32 *end)
 {
-- 
2.43.0


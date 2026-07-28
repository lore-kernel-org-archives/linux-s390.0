Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD33B3C11;
	Tue, 28 Jul 2026 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216507; cv=fail; b=ZgdE73KKhIwtXDAfcY58nRSN30NRHmUxmazGxLbiErQ5WZXyUWK7v1iDvpo2uhTVJ1tpOmz+1izQuaUoaMUem9WZ9YyU1T+JgV8NChlxhD+MINO0r+XeJp59Ljf5DbOqPa8LJvez3W7dzTYj0DyhUdgTaOLuxcFDdNz0rdU5MWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216507; c=relaxed/simple;
	bh=caRM17rtIk8IaURvyv/7ZmlC35iE36ydfwoelhXGx9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcumFQJnPbN8conhKEiWofw8TMO8SFprbfy8JOpzkszZoHOs4Vqw+WlFwqQpI3QsrmWL81KlRbZ4ucvhjZpxACfjg3nPoa1XIPyk0qKNirOtqvzIk9w0GDh27WlmFszg3A2tyP0GH7Ca7M72uTzQccgNRSpUuUrfnR4DshmNL1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fcvYkHry; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fcvYkHry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K76mZ4GaoZB+D3g3dLNR7mP/rWq0x0/65woJYenEvG6BzCFflRcbxB3mDSyhwYkvwqpny0hoEcJ8/6pR8c+RdAZ7QJUn2WI2SSXETt76KuYf8IsQ7UcZeXs8W3AMwxpJh31WGUb7uB5BRUl1BS9qyT7ESmxARbXpeSlg7o6+oU7/XEkPfFSRtBH9EDP4N2rVfEeBL1h2nEQvAwkQl2wl3KPm945NFM3TG3aIKnybTLdbGGk81VczwNemXTg+dj8iWkFi2jZRbU6j+yzy+sAFT2A3MFzbpy0axCP+SK15+cCzCwngSHrH9FGbOSqdUSyJdysNcVVostTDDG9ZpgTkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb1A//K+bXvCjGzVBOXX4pSYwzrrWDUBA3mpfhGG2aU=;
 b=G0ff54qW/abQYFab5xbXpeYAMS2O/kXYS96qka7QAXhSZNshQXWPMIKNlmw2DlpL828ryROoEyKKo0TvpSNcwcbUObH2m9OQGe5qVbpJKQga6KjG2s0Nxl4lzWdu6qFD3dtVTPQZt7SeNbQZgKtFz44VVFjfUe33VmepUQkrLMcmij3CWUeAmzUv2kyQO33qOB7gj3gWqGYR17F9Tril0F67J3nA/56d1CIzraqWxGv4OUVgJDtIhs+Qoksx+Ueo1fkN5jq4Ci5VPnfWZahZphx52MiyCiFEzhMgoFewYUVjrUMcgw6SGNPRabi3QS0yDnOUgQFPylk83mCeOzLy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb1A//K+bXvCjGzVBOXX4pSYwzrrWDUBA3mpfhGG2aU=;
 b=fcvYkHrymXbKMzq9yTKdpxDKl9EXIbwcZhMVk2WNoez6PdF71HjcXKVJ8nP5+0RU3nr+rdVudOSraxyLJXosVlZViYvHd3AmjFX7Qbo67N6AMsTsR//LTliviD6hhYAFic2NfFah1NZwicFRjRFKi8/BqKLr6b0+cn9MU+X1f5I=
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:28:21 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::64) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:28:20 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:28:15 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v6 6/8] s390/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 28 Jul 2026 05:25:38 +0000
Message-ID: <20260728052540.4728-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728052540.4728-1-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0606dd9a-dcc8-4386-c49c-08deec690994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|7416014|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QJjQXZMTnE8odsJ7nHuz3HVZw2DZzGYJiquCeD0MyFS0QCKLnTuPg9kBEamwuS0p79yKsWTpeKF2Ojbfz3+DQcaEQLfCD3+sjTW+FBhMSfKSsOoAXn1E/4xP2+W679GrmP0EPiIs8qOGNjiJ0BhgaEWOcvTTy0cvC4czaqVVK1QC7pL+vV8B3rw8wHcN8Q8FcIHEDeFf/Rx0yI228/2wW1FcNaPNCygBQ+G4L0+AbdDlwx39cQFK4RxjdwSEwSAArIEFN4bhEAMIpt9jhLkflJRCoCCdo7coWd/dTPvmnzslIWu8v3uwHUGzDvGrTkgN0fEhNx4Kytrfn+zFrbWk7sgaciu91CweKvd4ffAn210AJxtIsNtxf+ta44ma0W2+vscGaTJhh4rr6eIVxSHPMWJU28rncuI6TC4xYRPgMmLKF3frAiWJKSHDRPC6jSzcHty4ujpMpkk8ENKkiFdjJI36LHzcF40/D24FIpmwVWPrATAPYqjkFncL8fBOP0EydQGOVsV2R8dCEBibEUqaImMBLnm2jUSHF5HgMizK4xtdVdXkvwG3d7p4BpHmGhuCIPzv07SM9TA6AVt7YD+zp76akmMpORbuGRkduZDJidDNGg2ZQpFnx+oIhm2Xb3BUTz6Qqn7ojp06BfQA9V+TioZQW5CdDJpqB4YYoE2t1Ch9w6yMVta7rjyZniliaA2i2j8UeJmQTY8o6D3OSVShJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(7416014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZQ2qGKAWcxNuKAb9PAc0EEhpUUojNWDKGJGR5LuyBT0dnh4KwiPeTl2/gVl5kntPJisCAryZjvKut9TLu1rSiprtmbtP3OBpSOk7uuY5bcPZhpo1MC6igcVzt+37Tc8eNNNCaQU+uVvCL0DfH2gL4dFZE9EDcnosR3bzlFg5C+CnRN8G6jMGQXBTqczd+lsr8iEzNlHSu5obUAEtLYnsatcek9y6dT1mQRdxt6BDYOPEdkmK5HWXNGZFikH2d37e3OwyANZyw+RA0Wm5vha/No93omYOP4w6AgOx/UWVc7seA/polAwzjdMdq9W/6DCkWrlAEeypimhvFWK1rxrZKTz5E1ynnyXjQLZ4PTij0w12ezFGR5NlW5j99oROlVWjzbfEf1QWsu77LKqasARkFfLfen0Q5O3CRBpHQ/jgKZYeXVUvhl4jWI5BGyr26uFP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:28:20.9215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0606dd9a-dcc8-4386-c49c-08deec690994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

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

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v5..v6:

o No changes.
---
 arch/s390/include/asm/runtime-const.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 17878b1d048c..7b71156031ec 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -33,6 +33,20 @@
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
+		: [__ret] "+d" (__ret)				\
+		: : "cc");					\
+	__ret;							\
+})
+
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
 	extern s32 __stop_runtime_##type##_##sym[];		\
@@ -43,12 +57,12 @@
 			    __stop_runtime_##type##_##sym);	\
 } while (0)
 
-/* 32-bit immediate for iihf and iilf in bits in I2 field */
 static inline void __runtime_fixup_32(u32 *p, unsigned int val)
 {
 	s390_kernel_write(p, &val, sizeof(val));
 }
 
+/* 32-bit immediate for iihf and iilf in bits in I2 field */
 static inline void __runtime_fixup_ptr(void *where, unsigned long val)
 {
 	__runtime_fixup_32(where + 2, val >> 32);
@@ -65,6 +79,12 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
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
2.34.1


Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C973E1732;
	Tue, 30 Jun 2026 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795385; cv=fail; b=ZKUCr2A+b7xA8Bp9uMbjd81k614HE86R8QfAedRWEseea/+xlKxjfmlAJuEgvKP9R/xMZd6vcBGOHfJsc1Z3ZmDTZUUsvnhPFUne5LHh49llncWn6lxBGvsrXKxmdexh8zHH0kEV/F+3k4MpK31W1Zq4jE0lOlOn594OzUiHkVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795385; c=relaxed/simple;
	bh=ncSXm0XC4ro9EYh1aB92OA2xIfrtk97oWmBUkelOzfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7ELw1CM2RlhMiFCIav+rB41cgtXkiV2i5TamoClU3VqAcJzQOFX2v4PxDG8xA9ZbdH59zLEz5R4a4qPyH+2WZUijkhPkoohq/cyFDAC8mXIRxLTS1LqCddahTPuY+jF1iIkpavJt8lY+VoYh3+kdzY5fEMyko0sFqt2Z+C/tfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EwuvL/pI; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EwuvL/pI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5hbSk8psjmTp+FKzCmvoiUsZ7bVsNGGA4IRaUJrnQ8nl4DaVtXiCvpfNtWp/hr28rIMiovpRLY4qrbqlsErNiy4JdSv9q5xTL50ryE58E6lYxF3LyIRn/V1KAH4zoyPUkJY4xY0ObWF6nfVIGmCVp20MUgI0wYIvACrmGLiNrVVUyoeHPsTadRPXBw/t2No30jLujcaBQxeLsaiTVFITQVwn8ih8pMlXQc1km/RRj4mTFNugwD6YGuD68dX9V1oJzMSNn4lOrQey501L27EfdUFDKGSzGq0z7YniuZP6h8YF8hsMEVvSKFwG/yCMIGPC9Xm2zWxjRxSgszPibOY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdZWcO8ahzkMnCDJaoTIf1DjAICPQJ1uRxOKV8A9u8g=;
 b=is6a7wrJrTlWv+8ThhAcz0Xjid2GHgNi94lZ6ioHxizlxmC2jPVGiC3qzVXcwWrPdYvh+3f2XojhnlSQYcGhYXuC04obe14b1RqGHZY01pmWiB7PO3MXjeXxW37+szgC7LmgQ2i3GyX3ly9OgekOCb+EUJYIRgaimxyO9ljYO/dVmBvAwH3+Paoq68WLdv7Z+AzdhCtKxyax6+5vewSD21GcvRrfalegwKOAg+EsYuo0nWPQdMavi95s/PmE1lJm3O8656wj6IZj/yJFP9GGUa8qwVR72jdle5ebl2Xt0wbz8blBQ+eCvWkpEoSuhWqFsFvh3EDx4nWxtLj5ecAnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdZWcO8ahzkMnCDJaoTIf1DjAICPQJ1uRxOKV8A9u8g=;
 b=EwuvL/pIWT8kTtSkF3OYAk8Rw28EFNrjQM5jmzrNJTtg5O3/KV+3PtXqEnFo8/YULiCcpL7qG0/MZPIxsYkXtqDEfAZBrLmAzUZDpqvlDOT2mFGFva40Ax1C7ZsHWt8Si9jzf2rUq7Jwkj1tEUJ2lbOtB2jNqV+TGjCgo4BDGfc=
Received: from SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) by SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:56:20 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::51) by SN6PR2101CA0030.outlook.office365.com
 (2603:10b6:805:106::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.1 via Frontend Transport; Tue, 30
 Jun 2026 04:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:56:19 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:56:13 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Huth
	<thuth@redhat.com>, Sean Christopherson <seanjc@google.com>
Subject: [PATCH v5 1/8] x86/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 30 Jun 2026 04:55:24 +0000
Message-ID: <20260630045531.3939-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 27276124-c3c1-4b54-e45b-08ded663ece9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|13003099007|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pvG8X2ENvpIq3IbL5PJ4SUtwl6JLA1SVJQSLC/MsPt61g8Fbn1JIq1wqHMGIXp41FjBCVvKz5S0oFWaizvroxozNu4srLA5ca9Kp3hiPiDxuVUBBM9YDlpHOLppSsGTM3NL4tVE5ogdpqxcMkKwkkWgITtFK52XMWA6EyG0jN6zBnRzjUDALTovzZyKdDAZzgVzJSbwMJcizMsuuXJTpGroy/N9rQcWcnhlQipwZduQ3A3NDCBqMoXKFmD0WOV0+tmN6fzqAHOexap43M8mIuCHuUIIghxk1+QKhh21BsWTkZPoZPx+dA589qh0850il9kWDln2xreXgl32I3BkqRxD6xlFucmvlOdgmGAtT7LzBbKlnA9EQknPrSXCkUdJrOERe+kh5zKdHC2kabU/Hk8VzSh59JutvGGH38Ln5IpCar6Y+7G4lvgqr1yAu4kaS2nBrJ1LscN5a2VzY4QraQmjRwgEPvDkw7D8XimMA5GVTT3QEAAzSopTFyz/TRZ173GqIZSlFspTz/sWp7P2KFuHVIRcPAH0Nk/pz5UEUKd+mbPL2aFWc9+ubCOV1TjNT/PegsMc5aMwszs3xcnpXduHdwp+TmfFyPefBh9CDsJQt4QNxu/Ew4dfZ1TL35EJchP6Mt7BdCpeUY1Mcga3aOYlMB5KK7r/HlGdo71BXLOI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(13003099007)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+B6wd/xiuwO/sFz6vzlIphvssXLa1R16sxEpMCVgIQE0lNcI4ulF6NUKkuNKQ6epfFC2zr2TTbTPD8T69PcEgWOE8w2Cf7emwQ7n/r/zFhTpSDLJQKm5994gFDX72hPgzFNjSyN/nrw51utOp7bgquJ+P8H6qUPnau5dUaxDZIdSS5tGlEpeVD9fpP35dRRDNp8YWccA0xU/MoSZYyMO2Iz03J6FaD9JmczOUDXEcOI16rdFy0SE6esdUR70263QqybSkmDb516lq+VZHGhHquyp+ARwg5egCJxPEpPmlAAx40h0AYKrruGaHb14UVLa7vFCD0wRxSLBqphb+sqmwcBW8lvCKF+OLdk4CZycTrEDx/vBK1nYpjT+p4ofxI5hhHTkVob+IfN6910KICKUaDOg+jpAbM+MX0mv55KnCkZVqhwTErRRzgnqh800gApK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:56:19.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27276124-c3c1-4b54-e45b-08ded663ece9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

From: Peter Zijlstra <peterz@infradead.org>

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path.

  [ prateek: Broke off the x86 chunk, commit message. ]

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v4..v5:

o No changes.
---
 arch/x86/include/asm/runtime-const.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 4cd94fdcb45e2..b13f7036c1c9b 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -41,6 +41,15 @@
 		:"+r" (__ret));					\
 	__ret; })
 
+#define runtime_const_mask_32(val, sym) ({			\
+	typeof(0u+(val)) __ret = (val);				\
+	asm_inline("and $0x12345678, %k0\n1:\n"				\
+		   ".pushsection runtime_mask_" #sym ",\"a\"\n\t"\
+		   ".long 1b - 4 - .\n"				\
+		   ".popsection"				\
+		   : "+r" (__ret));				\
+	__ret; })
+
 #define runtime_const_init(type, sym) do {		\
 	extern s32 __start_runtime_##type##_##sym[];	\
 	extern s32 __stop_runtime_##type##_##sym[];	\
@@ -65,6 +74,11 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	*(unsigned char *)where = val;
 }
 
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	*(unsigned int *)where = val;
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1


Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EA3F7AA8;
	Thu,  1 Oct 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883000; cv=fail; b=uV2k4QqtUwRcFFI6GVxikX0FdlXRCLRrYo4rl3IUoLO1/HDTc0cNYqeYqy5LGGyL3LAQk5CFIMEF+jubi1tycCM55EToN4VXrRSw2TZuFcweylO9y/x0LLNcUe/1U1wq9LmIJ85WTVTlxLvi0ZIQ1iRguOs7jCKI4S1rM+WAN2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883000; c=relaxed/simple;
	bh=Fv8VbAP2bLZaqSVaDxHWSO1bbuSkg+WqKyB/FZPA8YQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdbb9IceuyTVMX3XpLFgbmHqjGfXuwUZE3MmTtJNRf/+TFhy/4wHVtvl2WFwoUf7weJYXqk2DV6RAG1COlGTFiIZdhCELfjCNqjAFlyx2NKyBLKUQKcjMdwd4frsnqd87Et3lXBwYfPKoNzHr0A0ZslXHo9Zf2ERA7dcTDxxb4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=myeieB/s; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="myeieB/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBSzW1jUp+8/mzQ1o4sFzjDmWnv559Om5jk9nNEeydSildLerUx0WSqraOdMNBUj56gYcRadRz46wnLDqmTsXPYpdNEDGetvtcfzQtcgNP7xWQ8R4lHLDBmL4JMFcRRdliDvH99F62O8pz++r0rlWTSB94d5lpNRNNoe0hMyDV6D4JvjOElUXW77CL/FBlLIFp6YEQfE+gcJxFy1NBA9U2d8Mxbz58Zc+HFQ+BIU1dqkZEB0vpwjt95m3uMDADHKfNOFiIlctfcI68GOZ3EOrTDTSSC6EDb5FxgzrCsH2PhhS+fMs4TMKrB0Xkt1ykgPNyrrBYF94Zr6YFlfRueiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkDM4+WSqprefXtbclNJJA88e2KjIbNa7FJJ0fNgcm4=;
 b=i1nXabZK/P2Vd9wxpeVZ8EjZfsbw6+oL73rOgpw+G69a/Z2rCYcDK0m+oot/9eUA3woaarg3JBlYy817fI3DQJKbcnOzjRuJBt4iRB53G4aUpn119woSXr7/o7360icpZ5OouzPj49P5lqW0rhMRQkhNHY0elgUHpb7ebLtqy+bdmyXw/+QNCAgJml2RQS/vFxDQsWKn1PVjCqXuj1SHhQhX4J54f2neaWk9MR9HvaO+WaWUqw6gNCkZj3vz0QBJV6PlSG7gsra3BByNthrAphq2GGreeka1lPmketngpX0VWrZ+0gndcFULqfYE0sSTG2OvkMavYbh7v0s+bhWvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkDM4+WSqprefXtbclNJJA88e2KjIbNa7FJJ0fNgcm4=;
 b=myeieB/sQibDrTeZ8TQeIO5gRNq6uH81sbBQ6oh4JhrnASH6125TrUSdHTUihImxTRDQsSqH57yRbYugADkbpl0qUjKSk5RLI9AxfEI/Lzgsf8jX8fpYi6Fa0b2LrbcSVdZxQdYMjD8rMRIBnnREalgXsQWmXamps+D8gRmhLwQ=
Received: from MN2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:208:1a0::27)
 by DSAPR12MB520039.namprd12.prod.outlook.com (2603:10b6:8:518::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:29:55 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::36) by MN2PR07CA0017.outlook.office365.com
 (2603:10b6:208:1a0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Thu, 1
 Oct 2026 19:29:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:29:54 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:29:40 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sudeep Holla <sudeep.holla@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "WANG
 Xuerui" <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Christian Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v3 01/13] lib/sbm: Introduce helpers for architectures to configure LLC properties
Date: Thu, 1 Oct 2026 19:28:37 +0000
Message-ID: <20261001192849.74788-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001192849.74788-1-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DSAPR12MB520039:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae57e6-60ff-4e1c-9735-08df1ff25ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|18002099003|22082099003|56012099006|6133799003|10067099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	4uqvhEIWVws5eomYZ5FrFH5DNAN+7cc7Ajjytptu0PtL2+kzCeU8QfF8Jvz/sPLWf7RuNoOZ5dvMPsj1TBdS104NmYEgUF+bvB6Wq5o74RGXKX7fRo4HewZ4ESmcWWJLvJPxDk5w1NjMsF5WBL4SxL233ogy7b0uzjhyuMYpG6j1p4B6jlj7u4loMhzPbtr3KPnaOaR+u1pzr9NoChNHLf5YwsJHEJRzIpaODXP/JAtJD3Sdqiue7xcye68l3M3ItmtuiRpi9zTsUIr4us0d2ybTHdIUbRgG3bLL54GnIKsLsLzDi4P/92DZ0ofu0QmBC0NCX9/40AhV7qdbEY+jZBgb2LVdza1VZxLge92A318Ar32neoBD+7rcJsh8AcOpV1Fo2YpN86ETjl8EUP55Pfdjzv0lggIk1u1hGUGGNr4e9camgZ68aUOoALG+gweo1u3kUgC4WxBRi9dQxmU8MSkwEQ6fbM6b1mpMPRUXgNDmqjS2G0kvTqH8vR8DzzPA8R6ofPxsZ0aZKDdPs4cQDaakdQOwPHfWOaW5nl9h2+S6PVrhDDlyETmrPGToDJ+zjCIOQ13cs32kmswujGy2ASO9pPH+s7Hv6G8S0Oh6viKWa66NwgJFrwDyMcYexGs1jMORIyPOfpuR7HZM9moMnGrikJyM9uaNy5Ok5BRSgZOTxdCpUtG5jG2lEenqAwdWUNeQTOLeop/tSdgXPLaqZBC7j1lJwqXNj/3/XFq/G1FyraUOOusAyH+qBsnhQoNF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6+aPjeg5tsJq2fE8EE3r+9d7rTkIvfD2CgCC1+SLCLiAiL3ELz/v0elyK/kMeoNzgH2W9eXQrT+qFcV+ZbeSHGEWETwR0ZUZCQVOB97W+kNRga0WJQes/KoK8g+/+c6ODg66wPk3tL6Zeokmdg1oYzgqtmDKXuRNZQk2CdBhSnZrcg1WterlQgsD/kxBIJD77KK7EBbqPNt/crTF8y+cy1XFK5XVXLHOZI9H43np8cdSuNTDuZuuuq/ZyJBezwCpSan8AuNvhPeoSBnk30qqFyJ0lVYqGiCJH/VtyNM3EC0Rfsz2bRDfnpIeTX+vZLeASDHiITdcz9LNH+I6OkmSDLUuXesWQnxsKU4yMvWAY4GnRammKZf8Rxl069B2cA+p3NMDQuP9D3b8o8h0yU2gUYD+BOGHplN3uLjTEwibAYr63RBBeiKoRhgrdnmeIjyv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:29:54.2739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae57e6-60ff-4e1c-9735-08df1ff25ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB520039

Subsequent commits will add arch/ hooks to configure the sparsebitmask
(sbm) topology - number of sbm instance and the maximum CPUs that a
single instance can represent.

Introduce sbm_set_topology() that helps architectures configure the sbm
topology. Also add arch_sbm_cpu_instance_id() which will be used to map
CPUs to the sbm instances during init to keep CPUs on the same instance
on the same sbm leaf.

Individual arch/ users will be added one at a time in the subsequent
commits.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sbm.h |  8 ++++++++
 lib/Makefile        |  2 +-
 lib/sbm.c           | 27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sbm.h
 create mode 100644 lib/sbm.c

diff --git a/include/linux/sbm.h b/include/linux/sbm.h
new file mode 100644
index 000000000000..adac12ed233a
--- /dev/null
+++ b/include/linux/sbm.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SBM_H
+#define _LINUX_SBM_H
+
+int arch_sbm_cpu_instance_id(int cpu);
+void sbm_set_topology(int num_instances, int max_threads_per_instance);
+
+#endif /* _LINUX_SBM_H */
diff --git a/lib/Makefile b/lib/Makefile
index dfab958327c5..7776330f5b25 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -40,7 +40,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o iomem_copy.o sys_info.o
+	 buildid.o objpool.o iomem_copy.o sys_info.o sbm.o
 
 lib-$(CONFIG_UNION_FIND) += union_find.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
diff --git a/lib/sbm.c b/lib/sbm.c
new file mode 100644
index 000000000000..82280e3306de
--- /dev/null
+++ b/lib/sbm.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/sbm.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+
+static int sbm_max_threads_per_instance = -1;
+static int sbm_num_instance = -1;
+
+/*
+ * In absence of an arch definition, consider all CPUs to
+ * belong to the same sbm instance.
+ */
+int __weak arch_sbm_cpu_instance_id(int cpu)
+{
+	return 0;
+}
+
+void __init sbm_set_topology(int num_instances, int max_threads_per_instance)
+{
+	sbm_max_threads_per_instance = max_threads_per_instance;
+	sbm_num_instance = num_instances;
+
+	pr_info("sbm topology set to %d instance(s) with a maximum of %d thread(s) per instance\n",
+		sbm_num_instance,
+		sbm_max_threads_per_instance);
+}
+
-- 
2.34.1


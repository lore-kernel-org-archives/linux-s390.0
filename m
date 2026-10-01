Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829D277C81;
	Thu,  1 Oct 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883237; cv=fail; b=an8CrgdrTnJM9m79DTJfLcBInThlVtpxPVPHYtF3pBCMBZFBEwnpluniMFLxcVCJpmjYzICrMMUCKSeKAwVC0+WlaBD2BnoY56HIiTm68GoFk6MdlRnd/T4SlYJi0Fa+cHkn5/nvaOxYYq9/K9u4O8rKlz8fJVgSaHm84BNsrj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883237; c=relaxed/simple;
	bh=BbgGOp5/HvVjARZvCvzuT9/S3yQOLj0hjugIJNI2mRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjOdQboBgJoq0vcGxlW9cuVFQHFsJZEbWZLB6kB9PUgrjq7jhyJlmlw76yzBXQvtqVWeMjo217bA17IkOACd+gbDU7DsS2ExMGsUknEBN8NyDWdk/zr6/49wRrK1Fp+DWShdlJn76nQ9zXRANH3+nFXXoMyd5cJCyUSeCIPiFwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rMoWOgr4; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rMoWOgr4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+1WFhoelMVNM2nYqZezIodINOhMBMMYOU3gzZDGeOSP5ZNU/1eXaIuosCqGFBc1wMa8A+ZRSa6m77vUHB+xggaUm1/4xynrM/eRE8Ak6qML4fZK1ThlIVpysKlYJMyczzii3Felg8JUiYe6/12GMIEQ9ka0JRbk3FoPg1VgnTdmEyGflSHMt608ZbjhBtvtHPZzUxYFMqEL9Hjc9+WRPTUPD4dOuBJ3hqSSwzI5VJGEpPKYqDtHKayBHlyWEUWgLeFd5ARmdC6IN0C+bDju8z2j8kj1bk0TFxVya9BQXlEO/uLSbKUrPTIc5VUQkUqS5ziOOBHR8vbJrrxwPdVspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rS8FNQ2p1R5eHnHNBeX46SxuD1oeZ3U6N9apdbQOUw=;
 b=qVxX9G58NO2yPvKLNIz3O7bmR0Lut6sSx/8hSAJgfc2PhwIHCHVSU8N3RR20fPAnFNZ5aIrfSUXAz61T14xETMIgT4SirNurXkNuM/nqXvkrXWCU46/lB7ueRMilcoiThPaNbVa6RZSls60/ALGldSGVEwJTPVLail/ETJhhJqyn41ufqWkSKGIDs9tRWcZseBoGIVNfsJQBoaB8PZK5/Zz4Tj5AQmOEU2PDeJWZEMQK27qO8FndRzVgVy4FWhDGj5XbCywPKLEwfsitAcdsve7xVjYKAxJproEhpXF5yV9v1AEoRZz5MVrk32504D+RCylHGi00ybS0nq9WP8yg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rS8FNQ2p1R5eHnHNBeX46SxuD1oeZ3U6N9apdbQOUw=;
 b=rMoWOgr4RtixaQKm3v04U7SXdN1SMhqVcvn326AhK72gKejvYSDrAhKZIodyTrEqwgwRoB+FL7Ed7WNi4o0w5An2fOt8jAUxAI9Ic63Ly9I0tk2fqHu2SyeHb1R944AdMWQw3A3ajz7elklEsZCz5Fe9RZ27tFlU9VJQ2wd8mpA=
Received: from MN0P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::33)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:33:50 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::2e) by MN0P222CA0025.outlook.office365.com
 (2603:10b6:208:531::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Thu, 1
 Oct 2026 19:33:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:33:50 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:33:42 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH v3 12/13] sched/fair: Allocate nohz.idle_cpus_mask during sched_init_smp()
Date: Thu, 1 Oct 2026 19:28:48 +0000
Message-ID: <20261001192849.74788-13-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 8589f937-980e-4b95-4b12-08df1ff2eb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|82310400026|36860700016|1800799024|921020|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HI67WcudSl1ixVN5dIuEHXST9r3FofvmEWtX2Xxwi2qs6xFcTq3c7N+PYFp6AqT9QHSt5IFk11Xe8mv0D97XcwtvOZ9lvyr1WpxO9QATI1iKHrcTjasUckQrCnJiP9r9Dnqw4beeS4Nrh87QlXAymTr90gpvaIDu/lPt9DeaberNwMV10wIFRxSVlOB5h0Rhyyb1kliiDMmIDDONxWLJ1z6m/6Jr8H6Y3g5XnPWQJrv/oVvsrxZNGE4UEpCdQE27nFRYI74rvkAuE7ktcnXXl/BQsgPgD2l1rGCpjc86ij3PVWJOfNX9cGcxr/gT2ukrd0YUxHR929b0orlONcHunS5Z5iDfe26B7+e8qJwDWBEc7WEFS2IngpD0ym2itYifzJE+uxejPY7Qynw1/KNLL13DGNFtIRT/JrN4nvUNKvouPi8bO6jGjNjWbkw4Z0L8F3UKXFdXnPC8lCQGJ7+2a3btCLJyEmp1LP6WYTpKy1lEdgmB5CnLaOxhc077VPd2zI98oFC1lbZMZTHPz8Q2+f749H0rjyNl3G4Q+dLKh5GswaDCcuA2YH0uKCqQvmGKlEvRkYhF/mY1mzE5h/+lnpznqqOESKNRD9bGT1zHvWZKsOFbppGlQuHMd3sm8gsWfT+2+aAyrsWCAGc5hOWOhnWiUhTreXZd/ZTv2h2Oiul0m4jhH9ECxbH6/lTXbiB/zehCpu77j5etNEUxpVQ9CNrMfcWKP8jvLBJ6hjNQOp94ZB6smqXYfclIwyQoj8Je
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(82310400026)(36860700016)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x/U7m3hZ+Ybv/VT5cWof8MeqztyT/sBoiy55dKgQ/wv4u4uNNXR/bZ4+1yklcsyaAeKCEhz2TQIyiQ0QTdrnrKu2M4zfFkrvSpyLDMThe3sJGPlNlakfteBpSN853nFh4QFf7J2ecciLnCisvbS8UCSAvIEBFZ3mVsQxo5MxBHaIih3pKE46cMMx54uzFMmHGIf0IbtYrtyTFFWd/0EPkskSYQuzHkaIgrkxa+pA7jh4d0IrIEI6URXg36+KQ5L9H0h+A7paPWs9nMNofJ7zKHY5becCEpCL4tFv4+MHdFJICx3+EnQfFZTfmRLSAtLjOZqotoavXQ9S3ToJh85+psIiKFf28Tq3QVUHlUnaylTUYas+cYVNHmq1L7JcI2NRe3768P73eEGlKBojarQhBlHj8LZK+tlri8yV/GxBxtTlJccfIEJwUcF0umDQ6bXe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:33:50.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8589f937-980e-4b95-4b12-08df1ff2eb95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914

nohz.idle_cpus_mask is not required soon after early initialization
since the boot CPU cannot go tickless idle before CPU is activated and
tick is started.

Defer allocation of nohz.idle_cpus_mask to sched_init_smp() via
init_sched_fair_class_smp(). This is preparation to convert
nohz.idle_cpus_mask to sparsebitmap (sbm) which requires architectures
to finish smp_prepare before initializing the core bits.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c  | 2 ++
 kernel/sched/fair.c  | 8 +++++++-
 kernel/sched/sched.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 977f579da410..127aed81d316 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8849,6 +8849,8 @@ int sched_cpu_dying(unsigned int cpu)
 
 void __init sched_init_smp(void)
 {
+	init_sched_fair_class_smp();
+
 	sched_init_numa(NUMA_NO_NODE);
 
 	prandom_init_once(&sched_rnd_state);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c687c3c70f1..a0a659f4c3be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15645,6 +15645,13 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+__init void init_sched_fair_class_smp(void)
+{
+#ifdef CONFIG_NO_HZ_COMMON
+	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
+#endif
+}
+
 __init void init_sched_fair_class(void)
 {
 	int i;
@@ -15666,6 +15673,5 @@ __init void init_sched_fair_class(void)
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance = jiffies;
 	nohz.next_blocked = jiffies;
-	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d2ec527b8a2..0726e8fb5967 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3024,6 +3024,7 @@ extern void update_max_interval(void);
 extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
+extern void init_sched_fair_class_smp(void);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_curr_lazy(struct rq *rq);
-- 
2.34.1


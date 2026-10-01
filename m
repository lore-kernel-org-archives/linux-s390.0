Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45C4F93DC;
	Thu,  1 Oct 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883027; cv=fail; b=KOJiNpa8iGbO6qoVHCROyyX2LbCbkxiRxos2R4Kf32QGdwWn3IfkV7PRMxj0kQ26UdQCGYbvxgCSvUoGT7LaQ+PLh0UNTrcz6pZ/aIFdiQJdgbiHIRPOThp5BbA2WKET5KSxIxHMEU5AujMaWcTV0VonwOD+nCJwW3hYvvyZ6gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883027; c=relaxed/simple;
	bh=UTYHUHD+cPJrQC70trHbTorseqls30HDRKu+2xceadA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQ8A62ceZ0CAI6zofBsO08alL2M4WzXnBveJrmH0mEmbgaZK4D3ZohocnnAU69wK7NgCnGtLacKhx7o975f6xTrfE4LakaH48BUDTtcD5cKqvhYi7xO6nhN7Kj5V35TNS1o2TO3p8LBxF5COsCryTW3ms80dPFS6dYI9G5qC6HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WJ7LNJjn; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WJ7LNJjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC/7X3TdW3UlWENnL6sCUgHWqb1cM9HhSpoi4BBAD4iBeiTeTwJHvBIQfo/eD3ko/fv9i3uXsUVnFlg/TJdMynX6wEDV+9Wk2+nPjKp5XiY4oeCeoCleYL186o5ABLtI84j8Ru6A0FvC9jlsBpCsXk8BBVditDE9ORUfIVm8kaUu21m5dKFEImUszg4g89XB59yPmvq75qQ9/vk4q4SIinHGkkpbdp8j+i+NZbD8Ljge8ISWtEBheddtfx/rbe0DLxY8CT+tW9TSZFE8H/zNwZc1c1S4pYqHM9MTBfCHoMNg8K4nnh7AjLPfD5FUNcYOJ8O38WuPXOhrRtxj+11KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTN8FjuBE90mTJzBWCQu6guR9X3/xil1+DmwNNY7+Tc=;
 b=JXUMGnKtqRlvMqGiQgzz5P1VQixUWlu8WGdlEhCrhpJKWI6/mYkoLITZL73zV6cCvv+EVcxesk65ZWlsBsokgGYuQhDA+QaPAeqc1oH4YeK8ySqndOT0hp995cgKoZINrKQfPFHU3B+BHCwMpxIESW7rRBnQ3lFexz0r5VOp/NCxvYm2EUnfsFw8jVdClWvToX/RutNpXwdhq0GKAACzHNfJcCYbmayVtEGqF0xOcjdQ22kV5vENa3/g4aoew1sXj70z5BKjdQl6jEHn9MSCZ4+90zeESaOZUxQWP2gZtuXpkVwmBJptBL3uAJLZhfuTFmBegMhylnpraQbas5EazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTN8FjuBE90mTJzBWCQu6guR9X3/xil1+DmwNNY7+Tc=;
 b=WJ7LNJjnlxxg+SNZrCBa0BQF4OQnxn1u4n0XAPiJzoARu9iJoAOdztYL/jFIMEUmbnpOqYW/uh9GkeiTa0shbU3OKOa80DjuPL8JEKYe7JhmvoS7szpzSomZpCRUQmq3PiF/WCnXVFjyth+RvT1ooW7rGx/VCv00YNTmm6JeJak=
Received: from CH2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:610:58::32)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 19:30:15 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::95) by CH2PR20CA0022.outlook.office365.com
 (2603:10b6:610:58::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:30:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:30:14 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:30:06 -0500
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
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH v3 02/13] drivers/base/arch_topology: Add support for initializing sbm topology
Date: Thu, 1 Oct 2026 19:28:38 +0000
Message-ID: <20261001192849.74788-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d9d123-06fc-42fc-84bb-08df1ff26b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	qy2w8wNFTPUT8SuETy/0e4zyS5bkdBnaPx4i+J5BqDB1VqBmr7XE+h6tvJtdaJlPjwMOd6NBHiq/8+2GmjbpT4mkkhuylK1QI09Uw0CjHx1DjUkb7vkTVOR+E0kKGJXM6ALhMe6egMHTDzhDJ3a5CgDOGWIZqW9n9YS6+XNq92OBfs/QigUApDm4/8hHSpFOjx0DpWZr9DmXV3nNy21cYvZOdgia8ekWEJb+H2PXDI5w0gVd7Q0A+GYBmoedqonMdgUq48pPZTLTEevKDul3myS2dIxq+DXCL8+HQcuXrKRh/9NIhYAR4F0mC8tCAoOM3IhZBV+D/WZkgQnkjh2xGuKciry4Fc7EnxxlZqeT2CjGz3ubREVfNxzQ8p1AE8poHCFNlOEmc88FPJ/RekxNSax8Ekq25sXBHMU6Q8fKhH2qA6ZYN/45cYAz8kUtnVuYD68/z4/CTcTAqo4/NYKsbrR+wOWmxdSIRjJcIoHw/VNl5VCSfhuA8JE/mqRrWy3lNdNnnXNzFlkz2zqT7evdYtDgejrZeWy4XaKV9RndywNKK9eHo/Bov90Fj+yCTMZx1P1Xjclq7uJUW/HQTNevP8qXql2wK6O66yLQqFQ6ccxurPyCwKHVgMsji4/Cmejlp6LP8hv6KyheCUIdvTA5pbZgkfreZjATxrxlzkLImrbg6ud8d0RH9cU7Zd/8XSf+3ouaWd/uv9E+Y6mz2dxTBRs0b6QhMKFYQU0ATS3Eledg7X/0bktt9KXbOLeD+YHB
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jydyKLOE4tgLm0qMRHpVQS1thsEI793beFhZlolF+mDBXxIQzuDmmVjjjCSp4gCqytk1Wm/YxLL3z6B6DJG9q4oF+6vAL5xjFo1yQEdQ9vQOxp0mahi4uN9NIhcDfmqGY1mHs8YxwJ8BMEAnE+QPrgZc6UhUOPU9xgb90KKWyazHqnN+pFyNzYi41uKcX9IfkRmPel771hScIYPkZosF1LRzYe5AMlgUqPs1+M8jxpqKBqGc0CohoYqVnrkgJsQocPnm8flXLEyiifAYyBNPmAITmyqRNBGpiFElpDIK1N49B0/CrKVI785/4blLQ10cQTdmGIbdYynrsAfZ0APaLX5R93xqWsAqnqgIu48PytbTht6JDmmyL/in3tTMhWM6gSH0gisLsQBBY6gpmFJ6aCdDEyss6FY+R5igCUOBj/6sEjbxInIQzyGakD0TnTT6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:30:14.8428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d9d123-06fc-42fc-84bb-08df1ff26b13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

Add (fragile) support for initializing sparsebitmap topology for
architectures that support GENERIC_ARCH_TOPOLOGY.

Similar to setting cpu_smt_set_num_threads(), count the number of unique
LLCs (if last_level_cache_is_valid() true, otherwise) / packages, and
the maximum threads that exist in those instance and set
sbm_set_proc_config().

Any failure on the path will default to considering the entire processor
as a single sbm domain and the default logic will divide the system into
BITS_PER_LONG chunks. In case of a failure, sbm core will skip using
arch_sbm_cpu_instance_id() and assume all CPUs belong to the same
instance with the same instance id.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/base/arch_topology.c | 122 ++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..f55745a93298 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
+#include <linux/sbm.h>
 #include <linux/sched.h>
 #include <linux/units.h>
 
@@ -930,6 +931,114 @@ __weak int __init parse_acpi_topology(void)
 	return 0;
 }
 
+/*
+ * Note: arch_sbm_cpu_instance_id() is only used if init_sbm_topology()
+ * below succeeds at setting the sbm topology. Either the LLC
+ * information is valid or package_id is dependable.
+ */
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	if (last_level_cache_is_valid(cpu)) {
+		struct cacheinfo *llc_info = get_cpu_cacheinfo_llc(cpu);
+
+		if (!llc_info)
+			goto out;
+
+		if (llc_info->attributes & CACHE_ID)
+			return llc_info->id;
+
+		/*
+		 * XXX: fw_token be truncated from cast
+		 * when the value is returned as an int.
+		 */
+		return (int)((long)llc_info->fw_token);
+	}
+out:
+	return cpu_topology[cpu].package_id;
+}
+
+static void __init init_sbm_topology(void)
+{
+	int num_sbm_instances = 0, max_threads_per_instance = -1;
+	bool has_cache = false, has_package = false;
+	cpumask_var_t unique_cpus;
+	struct xarray instances;
+	unsigned long cpu, *count;
+
+	/*
+	 * If the allocation fails, the sbm core will use
+	 * the default logic of splitting CPUs evenly in
+	 * BITS_PER_LONG chunk.
+	 */
+	if (!zalloc_cpumask_var(&unique_cpus, GFP_KERNEL))
+		return;
+
+	xa_init(&instances);
+
+	for_each_possible_cpu(cpu) {
+		bool found = false;
+		int unique_cpu;
+
+		for_each_cpu(unique_cpu, unique_cpus) {
+			/*
+			 * XXX: Assumes last_level_cache_is_valid() is uniformly true
+			 * across the entire system if it is true for one CPU.
+			 */
+			if (last_level_cache_is_valid(cpu)) {
+				has_cache = true;
+				if (last_level_cache_is_shared(cpu, unique_cpu)) {
+					found = true;
+					break;
+				}
+			} else {
+				/* Go by package_id if no LLC information is found. */
+				has_package = true;
+				if (cpu_topology[unique_cpu].package_id ==
+				    cpu_topology[cpu].package_id) {
+					found = true;
+					break;
+				}
+			}
+		}
+
+		/* XXX: CPUs should not suddenly switch IDs mid way. */
+		if (has_cache && has_package)
+			goto out;
+
+		if (!found) {
+			count = kzalloc_obj(*count);
+			if (!count)
+				goto out;
+
+			cpumask_set_cpu(cpu, unique_cpus);
+			*count += 1;
+
+			xa_store(&instances, cpu, count, GFP_KERNEL);
+			continue;
+		}
+
+		count = xa_load(&instances, unique_cpu);
+		if (!count)
+			goto out;
+
+		*count += 1;
+	}
+
+	xa_for_each(&instances, cpu, count) {
+		max_threads_per_instance = max_t(int, max_threads_per_instance, *count);
+		num_sbm_instances++;
+	}
+
+	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
+out:
+	xa_for_each(&instances, cpu, count) {
+		xa_erase(&instances, cpu);
+		kfree(count);
+	}
+	xa_destroy(&instances);
+	free_cpumask_var(unique_cpus);
+}
+
 void __init init_cpu_topology(void)
 {
 	int cpu, ret;
@@ -954,8 +1063,19 @@ void __init init_cpu_topology(void)
 			continue;
 		else if (ret != -ENOENT)
 			pr_err("Early cacheinfo failed, ret = %d\n", ret);
-		return;
+		break;
 	}
+
+	/*
+	 * If fetch_cache_info() fails for first CPU,
+	 * init_cpu_sbm_topology() will use pacakge_id instead.
+	 *
+	 * Uniform cache topology is a necessary since implementation
+	 * assumes last_level_cache_is_valid() gives same result for
+	 * all possible CPUs
+	 */
+	if (!ret || (cpu == 0 && ret == -ENOENT))
+		init_sbm_topology();
 }
 
 void store_cpu_topology(unsigned int cpuid)
-- 
2.34.1


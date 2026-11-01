Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560948;
	b=G6pZq0XNtwLnR8J41gjX4+u2LAzpwGh5amMHPJupby/pbM6KV9zwBned9+3mMHZQ/weg
	 UayUNaICBFgxaoDdIrllXB9/o50eEXIqBxFRuwxTi39GL1E7m2coP8rQiczsnvLVu9w06
	 84ywDjAxKA62WR2fC1XDCf3elNd4MQuJIg+Slx7horu5i3h+Poi+mHFaPZCYJmvyQpMSW
	 xDc6qPvJGxKpy5mVZlLyZexFGG8JOaosF7xFvn78BGZAj0rnCGwB2bFJAe9u6peqrjhmS
	 IPxF+PCB7TDh7PGFmXeBQUdvXwT+k3GeKxYZlVdB95Z332fidb1seXP3aXkhTiSA16w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560948;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WMZSQUZvefsucBorzHp3BfkFLYUAB0R9E9LLUjgR+Ns=;
	b=t3KUJiRofAhiRMA5Z3O/6Y1Bfyi6EWEuZ9M/HVa14Wn8Y7Z4hniyPJR08vGgDHXQ8Y0V
	 UHCptijI4zfA6g/RKlxTao8fjvlRTFpApPA+/ckEvqV7llX4PubebED5kORsDKydmbRtz
	 b8FAcNQKkoSm3AVNonmBXibZaf+BaAGemFnhqMim3tG/NMOogH9ENDMvk38zJ9Lkp/Ngk
	 jxvsrUgPKs/tSJFT2+NVVgyzSRZ9uwHWbvWpPZvYbkfly+6Ob61W0nrxOTzaIQWV9RlFL
	 b3cYT8qXPs4HXPs1ElP3JEvmhj8xlZsOlpfEX3iQZwEsV3/aABP/eP5WHVlxDqc2JPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="jk98C5/5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC060A2624;
	Sun,  1 Nov 2026 19:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BBC060A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jk98C5/5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAkLQ0rRBYdH3DJMcgIDoVc6FbtVDuHmgjXojuPHao9z2XRRDSEGU+V7oO2M0ORhLEnx7KCs02jlI9JNHfMZxCfI6+ti6OWnsKcDdPp+jtuXdSyP+yhF50oJueP7BUTuVg8cif9exBx/1Jur+a7qgSN4GouhEu7YQd13uud4Nl3Nq+LiVhF9Kc9XwoJabucWNV5BHh14BN2CAzxNgAuXzdU6S8G6/oogE4pKCZtBB7PIH4f+TPNdb7bloaHLceS/bcQp/joCWKwnRmnHrwC/Tcxz/IHUTJSA8rE7MUxWdop2PHavCvbafELF2XTdy17qtnjFIOz94Bb6CrVmRcV3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMZSQUZvefsucBorzHp3BfkFLYUAB0R9E9LLUjgR+Ns=;
 b=E63coq11vnAXbqUcD8dhzfxEICrCu5i6iJ0csiMxToZQ5UhnyoTQLGS0rzpUKONucOBh/ishNN/8gz7CHLhaqxEt49V+kwSc91RsoA6FOmJfilXxYds+dVJ+y1+Jjuf5PbG6OW62rKT7RwVqSSuV4/Y5ncJiozBJeAnE0cj870AhyHVD+hdPmwZ+fK/nE1gN6+lz522p5Pw0h30AGz1+W+Dj94X+yPea5FyY5UrXq14AgBWcTvsZ/zwLVTWR85EANaBFLTVkv2AdNPxv55DQNV8/5ZZPldRahqftTLnBBZ6SAIqN/Rlk+LPuJeeZyy6JxQnfx9XPZ3VlI+a6PU2Atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMZSQUZvefsucBorzHp3BfkFLYUAB0R9E9LLUjgR+Ns=;
 b=jk98C5/5R6LNjqYAvEwMv2+wczBy7zL9DTSOAvrgLTQKeoSypuLm9p3LX2Mp5HSwIk48z9J/IQrORqnO9mHzEevA1Hos8Ay0RLSa8qQO/CoqJ2rAYtRkaoNKTV5O7/SqfgoBXPZKPm+lH2sb+qBq8BEiBCh0lSlx4gi43reAmBqdQd/ymWqSfpCokepwdOCsxCRpW7Z2u5J4zlJQ9roPqK8yIUMmpwrw8pM1zH4U8q2+a8TosY+BhliJfvzMsuK6vhseP6xPVtXpwghEBnuSN9o2wjpb4+CL/VZIXuvsZ8+z9IHviNo5MzokYYqZPGRZcOApdZFnMAsal0GoV3x5sQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:13 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:13 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>,
	Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>,
	Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: [PATCH 5/6] virt: steal_governor: Warn on unexpected preferred mask states
Date: Sun,  1 Nov 2026 14:22:01 -0500
Message-ID: <20261101192203.6979-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0764.namprd03.prod.outlook.com
 (2603:10b6:408:13a::19) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 683c8e63-0059-4bd5-cd0c-08df384d6eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pBSr5q2RdG3giDdqjvGYXRTObcIRE2w7mo9uiBl7h4mavJJWJQcwv3+JMAmRKloWohw8DbUBuixuNzy9axh4dAJ8tuXCtGfd5BLLr2J05eDXuSq3b8lQtJbGBbOZGjchemT8Jys8KC0YVvWlRE2n+7DP50Lh8t8tFdE9Mmxz0tQYBCCClt0Bxzf3k7UmVl4DC+7fh/HXrING/B8KepcN1olxwQLehdBP3YPXShfIpLj8sH+IImT4CBYHJftC/vCmbYzSIIOQZVS9tDMQ4wzjN5mqeV+y9QGVMoTbyapurfwnZ9ET4Gn/T5704TQueqiqgHzK4t/+H1C9OWORwWKn//E+DMwLs23RHMjraXeXLMzl9vvDTdiebA9iOVDSc7aALpL+bY8oUp2lCbY9zI33g+pDlMlhgjxW0Zj6I9V7nB9s3c4wRQaGLBPsCZJhrCmbEPI2lzadj06YtAWEUyXivpvXiapZCOAqM/etw1XQz0ubLxxYJakm3jbN9BZQNa7+4sxAVvlq77C5SIWVxmM57I4MrNIMdF7W7uDAwTqSF3BaphmkndiGRiybKAv/B9JUbqYuyutuD4AQc7QRvHZvKkMLXl1X6V1v7F0Op9OMRlvXECm3yPeghTDwjvKbS70IzzjwwihUtflUdDIsR7vsL4mRdfkzlAwbXl12zDswgdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJmo+plw5HHnVIGd52K6YBhoBEdFQ8Lu16cqEpa48B4JrBg6CFBbzghUZ+Lg?=
 =?us-ascii?Q?haqtNLsrbNfh2C+v6v7xJJmC07ZMmhIpEmRhDdIyAwC9VS4yAIECBaysUWx8?=
 =?us-ascii?Q?6udQ1QvV0D5Jn+z0akCf3EkfAtda6LAouWj/QJpfn7DnSnSbwdw6Jjp+/HGc?=
 =?us-ascii?Q?gRBxK3ZuMoeR4Bh4dj3ow7mXpn6OiCQRDhP6513ayui+0ogsAcOOc1YMHUzh?=
 =?us-ascii?Q?dCivCwmI5mi7hGxCJ3rVyUiLoyOumtX22ZIjIpnNCz5C2IDEX/GJS+/9bshc?=
 =?us-ascii?Q?N2IKhUbDcG9m8xQZHrTX9hdnXS0xJ7onsdrfEVuDNeZmUIgX5Q+meStYchhB?=
 =?us-ascii?Q?FBIoxwXHNLKsokaRslEzIkBifsjqUcqG2uPM9GaFc1R833COgcMnINkKmkOe?=
 =?us-ascii?Q?c1SUCEPiBjvWEH1cWbq2y4KPBDmwOGmBvwM/Ls5qK4Lv8s6LAVpynTgrOpi2?=
 =?us-ascii?Q?v4flaRQmyzvyEuiS5L+RO2NOBf9eY43oyg7zyfOixSGqlBuyFXc2dAa2GsHS?=
 =?us-ascii?Q?4PPEPSvyiWRDYkaQsDunCR1Xt0hAwvzOULB7ZCpvFR8oCD+Dd7dgXqd/zOGi?=
 =?us-ascii?Q?pXxMAL55JBOGc2tCTtGwU0Ui5MzyAVFspHnekfZd067ucA7BEdYBCy8UIxq5?=
 =?us-ascii?Q?1usG0QFKFk7sIpuypLHXUt02jaBAtJOnz4eg4fJ5pBujYbcfE5Vb5I8q0LT2?=
 =?us-ascii?Q?V2pVwh9ES+WkiibnwKYV01x63gWROOH+3dvdV0LDn+1W8sjJXlDCTSmpt1Pl?=
 =?us-ascii?Q?IbBd7clwde9FyDpXXk4mATAlLcDbkrKBSWD2fJECHUaajHUL8bF1wu6pTy3v?=
 =?us-ascii?Q?goI7CN58yRrP//Vfsf2kvWR8Eoo34DbhEsXSvsKMePPunpNCOWf7/qcMHM4s?=
 =?us-ascii?Q?tCarQXZpqNkQUZV/mVBaB9XCqpG98bBYlMLBPJg00iR3BLZ/cFhe0CobqsSk?=
 =?us-ascii?Q?hkFzQEKOoVpAfmr39Y0v6uvPk/wPelKOKl0B4kZh3YeB8PkmApLu1gnnvD3w?=
 =?us-ascii?Q?jFsYRZ6vnKx3ojXvZZg5IbNSHPtzdQCQftGuNEV2Afldeq2aIq+LR3vswCuA?=
 =?us-ascii?Q?+bc03d9erg99RyjRBG0oqAyP0Du2v2NlUZ0jqAz8y2ZS0+BlBrJu6yrycxqU?=
 =?us-ascii?Q?1YhgDSdGLOaw2fKBSJPOSpNee/FbS+loI/Vy9JmmHU+TPedwESDyELToO5Nn?=
 =?us-ascii?Q?uNbfaGSuVvLoWiDtj45hUTxwk/zlpefEajYkC168ta/ZPQJIZ/39s9JIkgIA?=
 =?us-ascii?Q?hm49cFP8EJPNpCuhX7x1M2dV/pfIkKLnzjAyUZgsbPpppViZcKHGgggm7SSU?=
 =?us-ascii?Q?IIxTjJpZvxxX+MoTaoAnuPdR7BUwgJeSN3D1DayhYZQTqHdWx1nKGxpmxwnl?=
 =?us-ascii?Q?Z+2ztWItlR6VeIAmaoGlI9zVHMsAawdkg88xqPrHrMV8h4qe56xhv0owhKve?=
 =?us-ascii?Q?9D3k32pfSWWrYUfIjb82zLSYjPTU6VgF3Vx6XJHhxn1dn7RVAqgfSguwX9ru?=
 =?us-ascii?Q?50m351tw3dq5xTy7rF8+ca3lEK7k2iRzks/AeN3aRuylcvTqZIlm80teLIms?=
 =?us-ascii?Q?KcAE9DpGbdEEXbbxGQqdUu9D39fSj04v/HtHURqkkr9Fa1V17peeRWi+jnLD?=
 =?us-ascii?Q?8+0v3Xlm14s3E/Gc64LhEo3SoS19dlQlB4LpBk7CdvqxTa18fVaLoBc6n8SW?=
 =?us-ascii?Q?rTXTK4/8le8JTBEgQbF5JMO8vy8Y8sek8q8OPlptukrJyJE+fqnhE5XEcKT5?=
 =?us-ascii?Q?f3qFcnEM6iMm/AiUAHp2oUaydx7bmq/7SgleMh23bo2/BcBST34b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683c8e63-0059-4bd5-cd0c-08df384d6eab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:13.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+NXz18ztpV42ZljqS87Diqc2vrm9reAOB1TNFzyqAFpoaGNyflGECdfuRJjGdzsGxs/9peL5PU0fwABs40ong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

Now that preferred cpumask access is properly serialized, and CPU
hotplug restores all remaining active CPUs as preferred when the
last preferred CPU gets offlined, the corresponding logic in the
driver is redundant.

Instead of removing it completely, add WARN_ON()s in the corresponding
conditionals to harden the preferred CPUs mask management and highlight
that this condition is not expected during normal operation.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index bc3936e69eed..5679b7ddc078 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -145,7 +145,9 @@ static void decrease_preferred_cpus(void)
 	/* Always leave first housekeeping core as preferred. */
 	first_hk_core = topology_sibling_cpumask(cpu);
 	cpu = cpumask_last(cpu_preferred_mask);
-	if (cpu >= nr_cpu_ids)
+
+	/* We can't end up with no preferred CPUs under normal conditions. */
+	if (WARN_ON(cpu >= nr_cpu_ids))
 		return;
 
 	/* Find the last CPU which doesn't belong to that first hk_core. */
@@ -246,7 +248,7 @@ static void steal_governor_loop(struct work_struct *work)
 	 * else: steal ratio is within bounds. Still do design checks so that
 	 * module restores to active if CPU hotplug breaks those assumptions.
 	 */
-	if (!preferred_cpus_valid()) {
+	if (WARN_ON(!preferred_cpus_valid())) {
 		reset_preferred_cpumask();
 		return;
 	}
-- 
2.53.0


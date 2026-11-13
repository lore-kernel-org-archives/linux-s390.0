Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599285;
	b=Tf7sd3bW+GaMM7sDJKY4yFuFXgjoorIEziUiDAc6ikno2AsxRCzn9tOiKNqAHgh7m/tV
	 DM24dTemcyYzwcBTPfZe5mwjrWzlA1oE18HMY/8kF99yOaRqFnW90pbG93rD6yswvGeQs
	 399zhql/trVASRn0HUe/fMV/tteMMy2bcuDg/8qbeEAra1VJt8J5rvQKpe4q8U14EtvpL
	 8o1X/VWWrMQA9mOL9JLVZuYdZN7E5qObCInNhjVXo4V7FbHUj62tUrREJt9xXrvgC0wuK
	 7+pFp24BlNN5syjowWZOlfb3IiC+d19n/yFUeuNQG05WG5ZvhIgvejQQRoAyZtLwVeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599285;
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
	bh=F7K60yrGMowWr+R8XFHEJhOEA78qk9qL1+2THGEX2hM=;
	b=SBSFg1ZWL0HPT786LynI8SG9aGBbQ/1Kf2xHEZWIgCIANd7qLtRhzs4cE7hpZZT74Xbl
	 2X3SioX7ZPj5dn+MuQZCNqygYHBxRBSl+OLuEmbXoSYiqDr/5STgAsOC4OPQkP/j0Cqn9
	 eXhfwPv65ZvjO54u66NdxcAf7im8aUw2leWFMAuS3jMdVES9mIGGC3DDMkwc83nhoneVu
	 Jf62Keap0WDr0hABkuPOp70HoBQftd9dq1SqC2paTGZNyTrHOnbtel5yeuQUxI8LDk0gI
	 isZS5joawRbLlWAelP0KUdWUo2Vov0qhXhKOM+TaNAtKyMcMH2x7K35E0QvtAk/6eeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P78Vb8qQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F8606A8A2;
	Fri, 13 Nov 2026 19:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 652F8606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P78Vb8qQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHT6hhRKwvX3ZMutCVF6B6imWpHWMMHnPjfgOsx2tiXBeWLP5UJ+vL6b66dGPLchLSjaZX19FkiftweuZDGsHqrV1TkaaZgLzB6aPcqgmxymetEPIZ808keDULvMIMNi6QUQreo+a7tsr5S1uQHZgAz2HWV4kQ/G1ssQ9OuQ3Rl8dm26IuDe+5w0SkznQqluRyrgRz0JwcE6s6yxivTIkglj2McCI2YPeVcKnhu/ARPZ5VJeKN2JaBV/OgMtdE6KN2DsjqzYUqNTXNlwJCe9jA/F/aTbuJ4meYruxmk9xncKHvfd8W5og+sj0XiikesiPkFE7gs05LN8/ZAmB3uHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7K60yrGMowWr+R8XFHEJhOEA78qk9qL1+2THGEX2hM=;
 b=NUb/CZpsFYhM+FA+EdUTvoOv9R/HKfYzgOF+R2cMpPjjdiKiSSj6KDJiO3qLrbCPSQ7RO6yBNrtFrky7/krKdXDcFcFH1x3pvcwRRnVqj4GMqU86Obo0JN92cQRNiFp6ypth2J9+0F0us9DTfERs4du5SWIvBK3X1aGEk2XFUe29rz1h/yTqkk0ARljHaxt7Q7mE41BqqJUAoBDiSRkFOTlqkC4KyWXJg/kiaNg+m+rH7CV7S4DrBHpkUc2wKU1psWvTVnOoAiWrPSQ+4cYJao505+/qamApGFVBJPtdsjE0TAoLGzfLnHB/j58CBHoE68fri65aFuIxCS/xXfU2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7K60yrGMowWr+R8XFHEJhOEA78qk9qL1+2THGEX2hM=;
 b=P78Vb8qQz8W8/veCBo1iLDvRkS5B5RdsWu2JwbhuWuIb5YbN1XkmgBja0aDQQJvU8FNyH80n2hWleidpSwSw5ew4UbHmDM1aoXuoq85bFoeGcViiNi5hLycnUgSjuAbVLsRQ8kjvaSJ7wGOLZTD6tHzI0E9KR+RVl5H2fubYMztwPwZ7BvcKFee+thBXPB4wM9BoN36VSP8o4z7sP1h3FAiajm3C+DzbT9zeAnPDZub4RmUIEdnXdJyib0F8X0NfFXCpynlZBI4j4wwmQqJ1vvJ/3hRtv+S3yoaM3DmITXIchz29hau7R7U578PEx1GzHJFi+GD7tYpiongrkU/6ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:43:02 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:43:02 +0000
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
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
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
Subject: [PATCH 2/7] sched: restore preferred CPUs when hotplug removes the last one
Date: Fri, 13 Nov 2026 13:42:51 -0500
Message-ID: <20261113184257.621707-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:208:23d::17) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eef396d-3685-4266-ad37-08df41b5f2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261022105027099003|56012099006|261026140227099003|261028144727099003|261102123227099003|11063799006|261021121427099003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t8MXsupPt+aD26nuC8IhC4yqSBCFonpppVGi8FyCJj7T3+vjXP+rnopm1Vc6aWs/nBBVeI930H/u4OBEj0jYTbWXedv6dgGIQLjkA2hjoiz/NnFk7Qu3yjKbyk/vv0TTCExfD3UCq5sTw74TWrPZlye8E6w6v9r+hNz4nOXDUumwe/Okk68hYCbX+T2W8q25lraB6ZLK8skvhuoDvc8UCxllagt9cripe0+7ZdnDv1eB7SVL7IkKOo6ObylFzr2Dwe0pztyYhfDaWW17DwvZHBvtFLZKC25Xi0Axh+3Fj8K/N5vpmL5Az4KtIZ5T5lPvhKEO8xMUvCWNR68+SlVoyKVUK5eSI+HpAqmx+yXUxqWS5gDMcLSktWK4fWrXr1CXZYf02chhTVe+HvVsP7Z6idT7foPMsfvltC6pksuPr8C2U7mqefey4ov8r31TCdX/PIqh7U2gAdhSMUw02x3a7EfHNcoRqpH2Z83vKZm+cPP//Mm/abK0EjjoRz6b8/GVn+6ZoHRCz5B1ObB7rYRx620v4cyDr8pFVijdqH5G8SqZSMp8W+f3M6lTXuHBH/ASlR+QIMRRCN/H3uv09W7sF7otzJr91aUAh6wt1wtv32VVdAJBUK805PQ2bhvWxDs5rAGA8ZJv0l1F71pPikFxK6cP11W83ATVsFR9FmdVtJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261022105027099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(11063799006)(261021121427099003)(261022075727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AsDgfRFbywVI4qAKAIIIO50gjJwG8h8FLF4OTdy/Apasaha110a45D/rMvy?=
 =?us-ascii?Q?W+cGB+l2WEz2E9f5hut/iIqzis8c1I7xuZOqv0oqPi00vx4K+aPGurf0vMNe?=
 =?us-ascii?Q?aT1+slxXXR7o7aG1vbOkGjHuZMMdY4HITn9Fn4uMlFkxCkEbBgXLOtjk4iq/?=
 =?us-ascii?Q?7n9ry57Mr6W0iO9JcqSsl1sxBiR6VW+4IViweqLfdUxOdnrQaMzkPPGdkavN?=
 =?us-ascii?Q?wYHMCDCojKKEHEpevptgq72DepiHgMxfQh9N/1tkhSnbTrwCilRk3LkRmG1J?=
 =?us-ascii?Q?QSS+A/o8HfqVcMLvTWpwpLLISXr4x0SsVMr11Pvu2S2aSI4zUiOmZXBk6TO4?=
 =?us-ascii?Q?yKEe2T8KPZ3IXdyJzRiq1PbDFU7X9Lox7kdvDoRhmfnAUifFEMy+FLLGafhK?=
 =?us-ascii?Q?kYTf7bVwbL1y/vxuZ2p5XPXh6wZNS8h4enrwtUL5uY2sSh9Q3pTdu2hxOB6B?=
 =?us-ascii?Q?dNg9ZzdrGDR0HWf11fPUC7YhybjwMfDc5RZ3SdvEh5rmoZ4VaEFQiCW8DXR0?=
 =?us-ascii?Q?BLONmUFqCmi83cR4Bba1Ur7b0MSzmitk+U5swZ/jU1jYKMIT4H7xZyY53E/I?=
 =?us-ascii?Q?xlSfBM0Eb9jFrmFawdWMrYnp7FBlRNs2y/ihzwE7s62DaKfOC4GEoC/O2e+6?=
 =?us-ascii?Q?MZqIdBEZjWsPvnDKXEcG4NhkUGAvd1+pOqkkIETpU4gZjQXt/aGdmKBTVsvz?=
 =?us-ascii?Q?D8wLrBsZol0UcOPycp/PKEhLnkOdJ+Bi8M7vTQ3KDOClfUKnCRfngBq3jmvo?=
 =?us-ascii?Q?CcmCAUmS+GGhWLgdSHsifffIuSeNHp5wK9vc0nZ2Mq/frYKypivNADZ2ooIY?=
 =?us-ascii?Q?iN0LZ6YL8eyaErzoliUnibAQSgMTUtBrQE/q4qm+DkupqK+a8YyyfbtXkfBg?=
 =?us-ascii?Q?hAJcfA7dmxjo/qR4yoi7eFpfZJfcT+fwEnXHF15bYZREcQCrCMn4rcZAg8/8?=
 =?us-ascii?Q?Wx6kRq9k2KD66Jd+3joQwhf4jcyPcN5L7atw6SLkDN+Ll/1ZCMXtqij9aPS7?=
 =?us-ascii?Q?YF8xvMbK9IEsVnMmZypTGJ2l0uWxaL1QiJvI0k98NtdWU5Yu63+mEG4kN4qv?=
 =?us-ascii?Q?c9d4Ch8fZBUbBcJlDIwNjFtVvqFJA/oE15viMCrftNBw9yTBvUb3vrrAQ5lb?=
 =?us-ascii?Q?tnGetiSkC2nyjrUiLiWPZuHeVBi27dEQ856qijvqVwKEYXEFEHW2TFQzkKUG?=
 =?us-ascii?Q?A2vRcmzYWzf/f2bAJQVfeBiHoZQwlYA5hFph0e2u+Eyn3tW0wOLG2etk7yda?=
 =?us-ascii?Q?ROsaSnN4Qo48i+rHp4di71X+SBUBZb7Luv9FJZiy6luIKUZIUGRat8BwwXzo?=
 =?us-ascii?Q?iJVA/iiNhX0g4X+XzUUSG/goolDoC4Mi9KqfJ3JJWiD+ic2Attc8uKKPGAq9?=
 =?us-ascii?Q?iFNvCVfoZ/BEdSFsDKkma9hOUHUmjI6pCJu7chGn3H1OjmuImWhTsc4n0L44?=
 =?us-ascii?Q?yFP/tKSWTKkVBJLh3jni0C6YHbGCXUIkUJVKBjvaH7qQLH50cATRcWFtko2b?=
 =?us-ascii?Q?b/Er2S2BrGdn4TC62Kks1cFTjFtFUHimWL6GmyuVMABW5HmxBHYsGGvBKxtT?=
 =?us-ascii?Q?9AT3zKU1SkYftzZacEqq5aHBBDoIqgPT053ZeqVA+e6+mZEnfFhFIEHzieUd?=
 =?us-ascii?Q?Yg8D2Oknm2SGy41QRvwxANppYVaXiK6ddTQ1RHp3YmBjAOadPHZCxaZBSCHs?=
 =?us-ascii?Q?avlqWCKWLGpR/BkQ0ekmyU/oXOabK/x91JzcJenrhpgRmGx5jWdDkElZwjgm?=
 =?us-ascii?Q?WQQLn9FCLL/UmpaWc0g+7m32GSvn/qcuNQYfPvQgsIqlVzBB0iP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef396d-3685-4266-ad37-08df41b5f2b3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:02.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlU5+A+rPS2GxR57TXsusZTB8aTK3Nw3T/CQ/mkE2bCYEAaaMMms4LTW61pjMfkRSzOdD8/YshNC0j8dzAKZ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Offlining the last preferred CPU leaves cpu_preferred_mask empty. Normal
fair load balancing stops, potentially leaving CPUs idle while having
queued tasks.

Currently, steal governor is the only module that may modify the mask,
so it takes care of it by resetting the mask to mirror the active cpumask.

The design allows alternative preferred cpumask managers; relying on
loadable modules to maintain consistency of the core data structure
is not worthwhile in general.

Restore all remaining active CPUs as preferred in sched_cpu_deactivate()
path, without relying on the steal governor to recover.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 175b52a7ea79..b5c158c4efad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8723,6 +8723,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	set_cpu_active(cpu, false);
 
+#ifdef CONFIG_PREFERRED_CPU
+	if (cpumask_empty(cpu_preferred_mask)) {
+		pr_notice("sched: last preferred CPU%u offlined; make all active CPUs preferred\n",
+			  cpu);
+		reset_preferred_cpumask();
+	}
+#endif
+
 	/*
 	 * From this point forward, this CPU will refuse to run any task that
 	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
-- 
2.53.0


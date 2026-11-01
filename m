Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560934;
	b=twyFUNJ8KQcg0FPpjHGbiIW/NN0p5TRdCl1Dd5HFYjU85GncmS4Fw6jjUvTwxowNPSaE
	 KyM2uFB986lnynEYBtYbXf2HZUkB9fVNcT7Y5n9kuxjx+cDwoevXfNxkzRcoUWHxAmdI3
	 t+I8Nkeg4eUIjHTopMOtPoZGysXogBcKpJSpteyj2PtC9L2QsGxOGbwvVgil6BZqtQwKc
	 ynxweoR0FSDC0oEn/xNqgx1LYsoLIjjy3SuKtfObXqKxcXW8shvdJMtcuoF7KaeGAHfl8
	 CEDcxgAN5jNtCcHJv+Dv4TlYh0RY6KlNlop7nGWyMucSaIaxYkrAMOVLw+y0Y4Z+ZJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560934;
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
	bh=V7FMoZ7htv8VTgR/QP/XVQAnhbcR4Mx7ycM6RFQcfVY=;
	b=bFQigA4jW76P1b4KjTI32UlZ2ICL+jzOz+jhPlarVbbN+hG58zP/NCGmYUgGbWpRo9yV
	 Y5jXarJMivKM7QkZV/0gMv2k/XaKCqg2yUOpfDcAujPay9FKRJolbCAb/AKmtKgZ7O76N
	 dgcl6lpCmI0bcV3oqp1VX29b/svPixLzb15l/QT9e9pF0c/6sBj8euJpDhylMW2iMy+pA
	 fjpqUq9Vnz1oKqprE53MGtw4W8BVEWlU6ralNIqgn5FpWzixV4SAT7tFa4pIUdMkNFhXn
	 YnyrcMUoK0v+lAEGiWehIuWBhe/J02jTN2vUvDeKp+Kz+1PHxG6yhHS1bkLg5o/XDCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uROkSiU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED162606A324;
	Sun,  1 Nov 2026 19:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED162606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uROkSiU7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0aG17xIU1oZ4NSTXDmV4EqVbvtQtieZPqgpl95BBBbrQHWZYC49EZ2rS3NcGQk7kOmdzwy4p/w3AHVUVD7ckq/jtqwcG3S/DPLA0XiHePTloaPvtsDMtsG0K/RVqVGX6uM6ac3kWfEhOlvpENIJfDwY43W2DMAv00QXalqEDMVtvmpY5NthsZylA7fyz0kEieJdOQqMTh+/iiXiPsWS/qWeqmyopGvaBqT5XpRXBnKicnG3osuc63TdsAUXRvL6pfhGskuzXx0/UGTK8ghk2GTJHVDZ+FTz6F/CzFfKnFdCnlAB/8gYFsnAQqLtegzBiSAKF85ANR+y02dAxGa+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7FMoZ7htv8VTgR/QP/XVQAnhbcR4Mx7ycM6RFQcfVY=;
 b=Dhgw2ePk1A3RzVDKYrjpsWa2PsspXO8ah7rjjQdv6Yq24TINLexymlYUwMD+g+Dp8dvPfX2V6l07mpiObm1m9oDAj7X7rEvVrWd1FFoHv65ZkCcarc87oMQzFPuD/GGqUzML2bSfa50FHGmOZ+nwPkieIv/F7PzZXRuHaVCAX82FNvppXLwTiZIlqE3xoMVxI7t9kXCe2X0oUV26z3lC3wBX9PStxN91NlkZvvP7naIL20xpWoA597zq0qgP6pFa2SSh3/g3rxFmEZOPex4c8PKUN2r1ym5JB+8BHd1sS1MZEWsGMDmJVtOF1x5BWnOOaXrSpSvM5JylRv32G6lxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7FMoZ7htv8VTgR/QP/XVQAnhbcR4Mx7ycM6RFQcfVY=;
 b=uROkSiU7zDm2lNsGdsVZPCxzZrhFlmfnej+Yz8uDCvZyh2ZkuOSq+Ig2uuWRLDZNkQNXyVV1omzazQrhJmgqLmXax7yT47Zd1kt1fuyUwZv7Afyhsf0S0JuhnHMM+St/TC4cDFgiSjmCo48o3dQIe3HdYVF5hrize9uWC+T7CSDAsmKmFVpsqk1I9ustq1u7j1JN/8WrQU0ZB5T61QpS/i3Z8WfFxlKbKCd5aKR1LpIx6pnxM6vL9qlOVEscJKHtGkPMPYm7wQtJEQytQu/DDm2pZ+rB/EPM9XILw/RdmXeOcRTkWcnl9gJNdmvl4CeVopkT8sPQnLoHyD3tn1mfCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:10 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:10 +0000
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
Subject: [PATCH 3/6] sched: Restore preferred CPUs when hotplug removes the last one
Date: Sun,  1 Nov 2026 14:21:59 -0500
Message-ID: <20261101192203.6979-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0762.namprd03.prod.outlook.com
 (2603:10b6:408:13a::17) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c8d544dd-a091-4728-fd6a-08df384d6cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	57hVIQVPC7p3f+h/uRTNuaR7UGxcHQGVIAbT+F6fY6YDrwefdEd5nUZwjKL43wYv3JKcwZqS4OY2d7ufHxdCfvchKILq6ZzuGOQv55E7x4LX8JA7z4S9rpWy9tN88DhUbSWnsajDUjVYsZCB4aWsZyVwzfUdhFhbjSWWG6CjwyQ9qy3jJVdnWl0UpCE35pZDO/GQ+T2d+oWncg5hTSm3GRorfR9OuSBwPcqr2DPhhmHxMSEc0sJxT0zuTmh/Q7kzvvp3DaI4bvqPR6QCssAie25YJJugom7P9YrGlSmRjpgErK6VPjKm4bX0FCoJX2GNr1/IXsTq8EwMefYyAgDgPeL8Bsff2/npPfpDhc1DOXr1bSvPs+/oePdeobLU2F1fja2ZULCiSNgbsHHHpx8oie1KWlDhPxq3fbqk7188TFfzgp6TjFckcJVDdaQfe+xF/mOpAZCMR3SgRMvy8baVqbcBk4M9KPiDCWpHvrLjCXGNziRTGPxnoYk7ZA+dLmsNSeuz33VxulBeMsIVSr08khHL1EUkTtsozyxC5s4u5F5SIuxK6ZPFvVMlgMadBgz4L6T5bo50nas4TiQnp5dIWm7YBgMeXneyF2X1MmWpLmLqH+kphyJFiaHzqZBN32cirl64eQVy1yADgIjAxuXgtGKL7UzXzwCbZYaU558pS4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92hYwLZ/kZp3I0rccl2CKP8rZRhx/4RwTOvqZC3ixFm0t2urdwuSV/YWymkJ?=
 =?us-ascii?Q?ml4mzY6nk00IomN5pioa45wn172zpO6jxB1oo1DIoFdS9x6bWfsSJ8h2snB1?=
 =?us-ascii?Q?134Ueugz8rttbkElDgcvlHkQIMsJbTHsuQmCycbE7zTx7r958mooH8ubFQ31?=
 =?us-ascii?Q?TVwQqX0g8NCLVZju4nnl2OUGQIf3jwmAKJnVyLcaMkg/Nyq6fs8W6GLYewde?=
 =?us-ascii?Q?HMttpn6oB+9vlYDvIBW60u9+aQpfWRx4MGHO8XMK0XcOzMVwAjSj/JlnWt3z?=
 =?us-ascii?Q?abgkvCCamNQtBHWlgrAUwNJumHYHszlv4LKEGxuoAWqmeC83qvFAvbSE33FZ?=
 =?us-ascii?Q?3eioLoMAOXw/VxlsTdsL42phsgi+BQKa5OeLNNX/gm1S+yID2W4ZvK2hcX78?=
 =?us-ascii?Q?+kPDamJ99tmrvpI4Edi2kMvOYv05i0Rg9IA7ERCwUY4ndbf95MmyqtGMnjBP?=
 =?us-ascii?Q?et8JY6z+bTnv8oGBqlOq5I+NTMlq4jd1cjfCzNzhtmOvDDUmo+ivfFM3uWph?=
 =?us-ascii?Q?zoFU9OsCUebKKxMqmSlEzunw/MUnKa6r65/a43HWeGZW+9CbhUBqQX7K12i4?=
 =?us-ascii?Q?mAMdqkOBE4B1ScLFUxFnCsHaCoOb3UKKSrFMuN67dTYdV15eCXgndxhz9w9A?=
 =?us-ascii?Q?4nM6kDNbYUrYo4A9LcUO2no7WMheQtwLFCq8gZj1niVSN/arBHLuLOJLH6j0?=
 =?us-ascii?Q?PM9mtTs7lKRBLUZj2yX/kymg8tt+T+iEvTvNFFSHvzbT88q//9pYoedfNmza?=
 =?us-ascii?Q?5fGrW2Onc2G7G9S6WVrck2ljiMcCHx20+lihB86LruW0SR37iPRPWqUBfD3Q?=
 =?us-ascii?Q?IFhlI4DPAd5yNCdT3B+njORl0D4pMDpyNHDF/bK80dqi/rmRlzEPszruY9f4?=
 =?us-ascii?Q?GmgCgQAWoofHDxc8xT/hJhS0cLYYdauL+njPgE3rmteu3J38r9e35YzbxypS?=
 =?us-ascii?Q?4VOglcrA4aiacmxUEu5W+POeusSH0X1Gf89bquRKfJ/2abH/Hbyu4KI4rDMW?=
 =?us-ascii?Q?zVL82V4MxYf2yOw3tXK3F5Ah5q5yLfdendTJW3vlsPgvfwMhUYz8H/wkMhaZ?=
 =?us-ascii?Q?1vrqc8UNilPJcWjPu//LK5ha2DjkVvB/DvP+CnZeH/+ZMOD/xIjqvmDwMW13?=
 =?us-ascii?Q?12LwuNJiqFPUhzGA1TSnTTWXlrqL66XG6+jXyCOhkNkhQo9L9PnLy6+uZjN5?=
 =?us-ascii?Q?9hJSOp1jH4YIxIPIUkm8JoA+xPk08sbGH/hXhD/lN5zd9J6IK76Ph8mvYDFk?=
 =?us-ascii?Q?O7CfiNGjvWdjl5bnNQk7ExUHY94tlQUf6LuQAXEOg0z0eVJEWIDEk/j8Ow0M?=
 =?us-ascii?Q?4Mul6aMtVFjWE9Dm+cW4gmWavwqO9v9HQiUSe/yGYsJOboAqWDfa6IPEJnEp?=
 =?us-ascii?Q?0GMe61b/ylJ/St7h/hrcGFmgyTGwP8UV3Lpfs1Qc1ewWr9t548Dt6erwN6GW?=
 =?us-ascii?Q?x30OvQfFjIwK4TeVXqM0qp/cCUVlCDHsrNxGssho4n5NEMd8iY0xEGm5l8LL?=
 =?us-ascii?Q?RDZu1OoJtCZv5dNVqxGxbM5y5c/XvD55ktQCNbuSm1qm3YGIekgez2yijRC5?=
 =?us-ascii?Q?wxWSfaH9rafgecm6zl3AwAF71BBo7KHPAb/XCUK049pZeMGF0W+6jZTyYB3U?=
 =?us-ascii?Q?Co0D+UP7biUfLdJRAY/hAv0g7y198vNLnbwpREnolnY63hnFsHZ5ap9Y2TRC?=
 =?us-ascii?Q?Zemib5GX5UOU0cUGG5IZXSHxRt/OSeRpgYlZVMZTaVUD5uzI34N5RWy1hC0l?=
 =?us-ascii?Q?7oT7cFvb8CCJVS05v3kQQlGCY99y/qAHB4GEXXVzcm8YM5mxesIj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d544dd-a091-4728-fd6a-08df384d6cd5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:10.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxzzEJeqvw9NL4Z80JgkxJD6CgdV2/ZYzEJipytzJUSNr9t8odeCuyn41sXOnmGYLNz4ooYdpI8f/nR5ym5Y2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

Offlining the last preferred CPU leaves cpu_preferred_mask empty. Normal
fair load balancing stops, potentially leaving CPUs idle while tasks
remain queued.

Currently, the steal governor is the only module that may modify the mask,
so it takes care of this by resetting the mask to mirror the active
cpumask, but stops sampling after that.

This series adds more ways to control the preferred cpumask, so steal
governor may not be active.

Restore all remaining active CPUs as preferred in sched_cpu_deactivate()
path, without relying on the steal governor to recover.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..98f4f9434965 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8712,6 +8712,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 
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


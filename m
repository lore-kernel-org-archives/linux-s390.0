Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599283;
	b=aMS67Y66aOr1mFagyEzvtEzK1LwhJm0KRt+W1CGo9t6w+WgObYqf2jiclv+InU5+9QFP
	 3e6vY4493f0Zo5H9857fSwTfIq/TEi8oyzMGivN8xqb8VYVChjqtLfP4+2EmprwUnRwMK
	 JFc+W4VBa9OqfGuZ9tjByXvuDkkNINTNbWpgqGsVoQ4plxLdWNDK4JUlaouvHCTkEvn+/
	 HzdMIGhxDcVW8K5b1s2ceJnpmxlJgcG/MMGak4mD7jjM4RXkqFNDmyZG1VHJM1Z9p8PqL
	 xmfp8ipMeqxUTnyVZkdYbZJDqYwWJA50lcUxaFLGm/ZlcsWptsPcsdm3E+P/e0j7Wqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599283;
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
	bh=THD6DnefiGFU8v6pUFhOT9im2fEt/oaUGZQDjgbDNig=;
	b=rGkPUW5rzzMnGXPtmrKor3NNhxqY7KXpN8d+aAEeq4ahOMCXVdDgoMVLjHDkUnm6eyZZ
	 ADzrazfSO6kmlPR2vGngUR3ZYJIYeHKuk900amfGHRKIkt3EKYWvBC0DdpUnedTwCY9sb
	 7h9I5H7AjxvWwZhCmn/R6x/oxYUtB9hZycP91pNl8XJjYIGQhQAXwJet+UBOIOUxf7tVn
	 75NirF7UqFyLSn1R/XnHIcwOQCESdJzZBTSvIJs4cr4vEPBx/oeV1bYNghJEr0AFTdgl/
	 LRbnYkqIzFKVGz/7Gvsf8Dl0Kf/NwFh45Xr429xZte4GwUjFSx91cMIeUjB/KlmXFMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J3jGyrkC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DAF606A32E;
	Fri, 13 Nov 2026 19:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DAF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J3jGyrkC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCc/TyuYedfgv4hyrq4sd7IrL+H2JjmXO4bXR5pdTvMYUijfjc5JT4iKiG/dNfvKo3p0t/0XdT4agKtITjI7B1hiYBGAgTnHaCcoKOKMWTt4Cm/rvoWceBNUIJg4NZ5uPE2tPFH24oNA57GiBzRSrQmBSRHztQN0phtaXzpveCTSVrEKK27VQs835ITs3oy7a7vKyF/2pN/2OyObJHIN7lUrPUmc8RPky9qyzYg/FNWhIMblp6T4KjzCZsKm4UKXpCxJdiNqkM1dFIQ1Uu/inCuRFTLfJ4FoIFRkQWAxc/IYt3JjOkwo+3DQXC5E8DSsdxNYLmyB08bzp57uaOLYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THD6DnefiGFU8v6pUFhOT9im2fEt/oaUGZQDjgbDNig=;
 b=dsQlldFjclie5O0qch9fIl63huUCGrbMHhFY0wXTej0AZm02KNjHVoObinpif3zB7lFbGvGUhUFP1TpH7l+yMkoKxZ2lqgKdUHhNWlJ9ipmdwlYq31QoGXe2/oJ6A0HCxQwj7mX0oE7IfwVf66x6aG9b5kwZSGuNpgBtQHFz/9QmMgvqxy/0acMVHdZhh77LEVqzhVj4ZUL20FIacTMC/eXmUEHotzPNRxPF9lbw3hBvZ+hFZWJmXg4QjnWaMQmaATf3/M2fv3XcifEM3ZZpq0JMeY2R6kH0nR5dgC1F5p+gzyKWkS67zxpUKssyIr7dUXaYJcQLLbbnfbLfimA3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THD6DnefiGFU8v6pUFhOT9im2fEt/oaUGZQDjgbDNig=;
 b=J3jGyrkCw4MPueGRVGSf74oIhQkwQlS7kSso1OIfMDW1VTnPIh2lljVhewDov5zTy1lFicwi1F8Ir2iC36FPEax9/xjwMTDnBWpaEwIqfoW/yFGZ6aWx4O6LIJlNBIJNqNmLCxzkz7X0GOyqytiWwxrHWd/kezX485HFjjRYV8hCU4HvbVvurP6H57THXuTaotApQYGsO2Mv2fIX/VWvuothprBnbwHrjphwnAoKkEcKUCvYaDCCmUa0ycan9mc7tZ5D6OFEAWvC4n/9M3+6EDYNSuGyycqMmXp0berF4/2w9A8vJDA4/LvlcBThSt1frUSKnmIYJ3VzicXBBv6mvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:43:05 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:43:05 +0000
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
Subject: [PATCH 4/7] virt: steal_governor: serialize sampling against CPU hotplug
Date: Fri, 13 Nov 2026 13:42:53 -0500
Message-ID: <20261113184257.621707-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 43b41910-a4b3-4e1f-b67a-08df41b5f463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|5023799004|261022105027099003|261021123027099003|56012099006|261026140227099003|261028144727099003|261102130727099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	h2rehSS2Vqhfyo6bSQMmgSM3XcycX9zBwyXtbtzgyq+YKas7g8JBbE5beaYsdnqDKMWQQw5SiLHCWykoCajJN40mfEbA3fL5JjbMzKDIUR/MUXkQuOCimzI3zDJsGa/gQsnfdl3al8t0GhYDUmrs6j5yY0vSU06EU8a+z1yVwyYftTpTiGPi6kvMGur9IaQYZTw9G0vvMige0ujnfANOplavajLjZ92+pu65ID2O1PipJJGlhQEIL0FO1mcI02dZF/p8j3wJI4rNILHZjskjLNiE/lo3DOOLHkBtcOBPfTdc60cnVeWtAQAkQ0KK04APl+nay4bPTQ6+4vzprhHzFxcUxM3OnOS8oz0jLOBOA91OaHSktgZrXluhSzXzwwr8q3ty9YFaW++zA0gYT0si0XCNgr6DkBFBKWWaRiHpa39AqkrYaFG3+AQEyoZ/Z/Qxr9wfAwWrL6JEZwX0f744Aw1bxZrhgWr5Uf2g26A+TMs6TYiFubsmen28Qhj52SLoYy3ZEKsGQPWQ5q787hD0Hq8nyJsem+2Sli/8AqMLQac/H/aJLAYGSccffJza0fspNkX1QAP1Ya8fXEeXp9zRtVnPOrdWr28Mjkqm76sJdsrCTbaLV3GXIqX/bqIEcg4Qh2XZGcV9QVs4SbkY7LpWY0VzJL+Kq4rcMLyKdwOqHJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(5023799004)(261022105027099003)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261102130727099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLuRE42pUdEy4EsUYqy2L8lwIp+s3pg+USddUbBObrpifRvoK+0qwbuqJQqW?=
 =?us-ascii?Q?9kAMpdWH1GvruZD6F5ZkQCxx/RiudIl2Mn6yU7LiRMylf2muMlKufQ1/Zk3k?=
 =?us-ascii?Q?RIH2JftXoJwUJF1ZQQ8Qi1AkTB+kzT1WYnzSJ9qeiju6fP/IZXDq5Fj9BxXh?=
 =?us-ascii?Q?CdGly48dnDepBBPav8zl2Wd6nuunEwefsDZQlj7K6peNBJpwsjjB2vKxA/h6?=
 =?us-ascii?Q?dubq8BN25gHjNRR5LcX3f7o59M0Jn7N1XuTV5inBcn3hcmtq/yL7GU3mgyW9?=
 =?us-ascii?Q?tgXkJlBUP2kmQ51PmKPBjK/vVj7Yz3jwdg4NjMZ0tP6lysNxfohyVE238R6u?=
 =?us-ascii?Q?R5E2MCWjbCwmG1UtRkmnBxbIOniXUcVXAUPkh0xJblp92xYolXKSOqV8fpgA?=
 =?us-ascii?Q?UPGXdeG8gitWDLHJwElb+wDtvUhxwxCbH0dXmf5FGyd0uHyN9ZTdJ8zkAGab?=
 =?us-ascii?Q?VUjV4w/8CdD37nJQXnKhxHPeQsBj59yDAoCUyt7jtDrCfF6f8BAm/BEp2eVS?=
 =?us-ascii?Q?JN3PA6ChAYU3AucBICtnekZVtGiOnitHP7HKHmAXY6NEoryRLxsBN1j0XrC7?=
 =?us-ascii?Q?IA3mk8fCOy3CUiXeSIu/dOKqqlhicdcRw8/DrpYrxBJHmlwAqguOkJpggVAh?=
 =?us-ascii?Q?cdG6MuyRpqcjWe/fyXdPLDp4tGzOwRGnJJo0zEIXemk1T6lPhn/bs+YbOpx6?=
 =?us-ascii?Q?kVrYA7uNZK54bGozjUWRE+pEIzw9KVk3Fxo9fo5gjbngkkCMmW23nBj57s0r?=
 =?us-ascii?Q?PNn0IQRtxV80YGimCnwzciscr43r9OvtcpwLkp7uad9V4jhOu7lOdtfNWuVK?=
 =?us-ascii?Q?qbiZlZ/Pusah6he0n4JNoSc+IESCBW+KSr5pV5emSL9MXq2tIjBkDwTRNsL5?=
 =?us-ascii?Q?i8LG3mhxV5lWkiR7yMA3r3LfsPE+j79Vdtd1m8AZ+IH8n2b/mxyNA0UxV7Kz?=
 =?us-ascii?Q?X5+eJLVNM7SOO8OSG8YchOw8Q9xmq90xGw+ADhM1+qgtWky2vKuU6puAMChM?=
 =?us-ascii?Q?Wt5WJH6KWGAQUumA6ZL9kS3YTCbBxt/3gA5Y6EGTAZrZ88f6BFT+UsDbmvX2?=
 =?us-ascii?Q?RM/Blz6Qg3u43mEg0iywivgRi8haJc9oRrbGZbruzV2+pg/Y3fNAweJrVhCV?=
 =?us-ascii?Q?sDHTLmZs/DsbqLyYW1Q7c37FCbcOMXMujK4ERRMRrgjIckuQefsHif42JEno?=
 =?us-ascii?Q?UyNkgdQeVObtlJWeoWi6Vl6Dvklvf3xrmEw89BhMFK6tTWWR/Hw6hvfUsKnL?=
 =?us-ascii?Q?aFQXtDCam+BHuM6VjLDKfzs0msB7Z09SghXNkFSI2jspvFHnVxidw6V4Zj5p?=
 =?us-ascii?Q?emrl5i7pNbgpJyOvUNXJ3viCvAUDByIuHeGBL1hJ8bpI2cJHtOH6CXG/J0t0?=
 =?us-ascii?Q?Va/esGUbV52qMgUtPvrs5nPmuDhJ3DMYXFHB9kSTqbceGanlZTTZ1+OVnNPh?=
 =?us-ascii?Q?GPS6GYS+E4GYwNel15Jsg9R7OGZ5frcsgZ3x2s2z//nIbCVzMsyMn4xGOkTt?=
 =?us-ascii?Q?c131OzcBdDb7k7TCNwDb6hAUpSCaATfv1/PNnMQatwFrJCK/f0PTP3inQXFr?=
 =?us-ascii?Q?XoKJyWfQnqb0DbSVo2aK82WBcH5LuOssQCQAVq72Gj1VL5WJuIH8yqBS99aR?=
 =?us-ascii?Q?1oDU/OXJuVF0vFfqujiEOH1OUbXJVJD9H+kKpeVahbZTn1mCOvjWkcsXUeFk?=
 =?us-ascii?Q?xHeUfWgR5wC34io3vDBB5GoTcdcsDOYFu7E6BZcjBKFfDGBD2S5llEAz/uKI?=
 =?us-ascii?Q?s49BA9E86bjuqcuP1NK3NqMM5kyqcztnLcHvqFLyL1PhiRT/BUZL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b41910-a4b3-4e1f-b67a-08df41b5f463
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:05.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKJvhZx63OLxEppF5xqj7V5OIm5iBKK3L/HlEgbWYpjEg/vZRuGhjeYFuoZoBW5wGOCVSYc5NKl5BK9IOlAeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Steal governor is not safe against a concurrent CPU hotplug operation
because it can change active and preferred cpumasks during the governor
sampling.

To address the race, the governor would take the cpus_write_lock(). But
that may be impractical for the loadable module.

Instead, implement the following locking policy:

 - if the code takes cpus_write_lock(), it's enough to write-access
   the preferred cpumask;
 - if the code takes cpus_read_lock(), it must also take
   cpu_preferred_mutex in order to modify the preferred mask.

The core scheduler and hotplug paths already modify the preferred cpumask
under the cpus_write_lock(), so no change in core logic is required.

This provides a common update protocol for multiple policy drivers
without requiring writers to take the broader CPU hotplug write lock.

Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 17 +++++++++++++----
 include/linux/cpumask.h       | 11 ++++++++++-
 lib/cpumask.c                 |  5 +++++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 26b6bcca27ed..8cd5c0f3e3ef 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -23,6 +23,7 @@
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/sched/isolation.h>
 #include <linux/topology.h>
 #include <linux/types.h>
@@ -139,7 +140,8 @@ static void decrease_preferred_cpus(void)
 	int target_cpu = nr_cpu_ids;
 	int cpu;
 
-	guard(cpus_read_lock)();
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&cpu_preferred_mutex);
 	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
 				cpu_preferred_mask);
 	if (cpu >= nr_cpu_ids)
@@ -179,7 +181,8 @@ static void increase_preferred_cpus(void)
 {
 	int first_cpu, cpu;
 
-	guard(cpus_read_lock)();
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&cpu_preferred_mutex);
 	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
 
 	/* All CPUs are preferred. Nothing to increase further */
@@ -193,6 +196,9 @@ static void increase_preferred_cpus(void)
 
 static bool preferred_cpus_valid(void)
 {
+	lockdep_assert_cpus_held();
+	lockdep_assert_held(&cpu_preferred_mutex);
+
 	if (cpumask_empty(cpu_preferred_mask)) {
 		pr_err("empty preferred mask. stopping\n");
 		return false;
@@ -213,6 +219,9 @@ static void steal_governor_loop(struct work_struct *work)
 	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
 	ktime_t now;
 
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
 	now = ktime_get();
 	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
 
@@ -238,8 +247,6 @@ static void steal_governor_loop(struct work_struct *work)
 	 * module restores to active if CPU hotplug breaks those assumptions.
 	 */
 	if (!preferred_cpus_valid()) {
-		guard(cpus_read_lock)();
-
 		reset_preferred_cpumask();
 		return;
 	}
@@ -276,6 +283,8 @@ static void __exit steal_governor_exit(void)
 {
 	disable_delayed_work_sync(&sg_ctx.work);
 	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
 	reset_preferred_cpumask();
 	pr_info("disabled\n");
 }
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b13d099474bc..3716213d0730 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -124,6 +124,14 @@ extern struct cpumask __cpu_dying_mask;
 
 #ifdef CONFIG_PREFERRED_CPU
 extern struct cpumask __cpu_preferred_mask;
+
+/*
+ * Drivers must take cpus_read_lock(), then cpu_preferred_mutex and
+ * hold both across mask validation and updates. If cpus_write_lock()
+ * is held, it guarantees the exclusive access to the mask, thus
+ * holding cpu_preferred_mutex isn't necessary.
+ */
+extern struct mutex cpu_preferred_mutex;
 #else
 #define __cpu_preferred_mask __cpu_active_mask
 #endif
@@ -1199,7 +1207,8 @@ void init_cpu_possible(const struct cpumask *src);
  * reset_preferred_cpumask - reset preferred CPUs to the active mask.
  *
  * Callers must serialize against CPU hotplug and other preferred cpumask
- * writers.
+ * writers. Requires cpus_read_lock() and cpu_preferred_mutex; or
+ * cpus_write_lock().
  */
 static inline void reset_preferred_cpumask(void)
 {
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 5adb9874fbd0..2e16e19a2bdb 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -166,3 +166,8 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any_distribute);
+
+#ifdef CONFIG_PREFERRED_CPU
+DEFINE_MUTEX(cpu_preferred_mutex);
+EXPORT_SYMBOL_GPL(cpu_preferred_mutex);
+#endif
-- 
2.53.0


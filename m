Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599286;
	b=C5V4WeAG5Dtkyi7haFY4VbofMmcn4EaNbpy0P3ehcN/N+eH3EYLASdPgQGji7Gh6wumk
	 qgvlOsqqWluDv5w1gkkjbBT33GVcNstJ4bYLjxgxPZvbF/AQH770+XH04nZSSBSC60U75
	 rillOsnHnhYMe8EcIo1NiTowOLiRvxB0+1lm9SQavgSOHVPDXmKbn6bPYF+agQVIppqur
	 1boXKM6fvCnCMJkMGIK3D2HWWLZkqmBCLmfM29AZKL38QfAZb28VrEFLe2AhyRso2qWsZ
	 1Wy6U8MsyNqi/kNkR1IOljMPlKNO3N/XpkVRaK6pNuaJmC1WCTOFFeVSGho5bovGPbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599286;
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
	bh=1thHQg2WDQPDZ7T7ErqjPZCoCST2YOVD+u4zXbUFrb0=;
	b=1tcbdvdy2nAyYpmWy2MQBxSvGkkUu09jQeCHi2F5tn4NMgVVq4xR1J1qYiOUEh13lUFI
	 KhZB+2n+Io0x23kCh7xRT0Cn80DSSH93l5EVsxiulxX30KSURwS9t7IBFf+NoE85P5H8O
	 HbTW7SkhYmOtm6cXxOyZ49ixb1PbZ0iX9wA0bLRIBOe4xCciOkJNq5Ic/jcmU6kRlBH3f
	 QStksEhL+Ke+7CPNydZky49eADYS1Et63u+7wYGJUaIjieeg32V7vOVMt9R+qmCQ0jZDh
	 90u5/WO38oxOCqbBcikVedcKafD8cJXhvM3r1ass9Jv/jk7KjuxFEsEcJRgEsrrXP7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hZVocxVm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA8D606A8A9;
	Fri, 13 Nov 2026 19:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA8D606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hZVocxVm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcdzOrGI8PNcCgHzqLi2NJcwpgDHGv0jnHI+0TvGD8JPqy34bw9WSIhylb0FZsRgPXIk37VxGpOsYFE8q5AJVAaBqgumRuTAGQ5f5CU1vYwDaZVV5GjaQlXucfBorCq6iEmvOTSjKrYiSC5GdyDoK/Yu6ujpHwZiXLD6iKGzl0PY7X4Hs91QWvEIABqz79Bw2jyjNxO03hLd5dhb4C3WxtTWEzG7iGiUKTlc7nA/NRld37RWAxv2GvedYq1gdaJKzErD6EteBuaVLwwbggDsZVNFwXFVB9hPX1TxSTPZ+HzeVmLNN4XQNWrWjU2pD95/3YtiPINnSJFjjc4xQnVG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1thHQg2WDQPDZ7T7ErqjPZCoCST2YOVD+u4zXbUFrb0=;
 b=e2SPAIytMQ4PCaJMb/R5+5MG9NQYubfoEP3mM/w6gyPcjQ+WGsDdNbCnxUG89w2N/fCNm2Y34RazM7BI3JLDPg8wQVZtW9hLGNDAQxosjZt9YoW1VHCZ3fL2/IsSHjMbE4Kg2FfWPKne85BvxE2Bkt2MXq44TET9Vz+Ot51PYlg8XnmeHOO/lyYwLaExGc+JqI3uDUBLeXJgWpM2/UyO0X/rXj3jsUthqnv9U2PE44k9RCxLcQP26o++/tFdf1VuUeyTLMTXU4Epm0ZNC66mllp1LHn3iN4zZZ3OrYb8rWPu0mdX3hDE2HqpBkEYMlIPvNQgdclWuH9u5+AsrNS7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1thHQg2WDQPDZ7T7ErqjPZCoCST2YOVD+u4zXbUFrb0=;
 b=hZVocxVm9x30u7+lyDDuZG1qeyNRkO+XbFnMaGu4USH7RJPxMhRASwZVneFJEmUjzAxjxWtCnBa8MT49skeYvSNQc8Ol6ZFH8pbf/avjrF3rNKxTe5n1QfG4d0PGOORurPbZEcFAXFRq6upeTOLe4BUcXfG56e0TeOIOGV7mn9EayJ8NA8D03PLW3GMS1m7iXWbeMfpQpCebG3l86NMZUQ/HA8D/4lr4wLfnnwrjLpEBePvSubuDE9aDso2W9M4f1kdnRUE818Ub4dnnaIeV40P5GwvoOPX96/q+IzdnC/EkVttdsgtzRHJCDGTNTz1aVv8XpSEaZzEdm82ozHPlWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:43:11 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:43:08 +0000
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
Subject: [PATCH 6/7] virt: steal_governor: restart sampling immediately after CPU hotplug
Date: Fri, 13 Nov 2026 13:42:55 -0500
Message-ID: <20261113184257.621707-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: fa121c51-0f9d-4294-0e0b-08df41b5f64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261022105027099003|261021123027099003|56012099006|261026140227099003|261028144727099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0AOZvBvGn/AQ+dDzmJe1a496pmGYdkRABhgWYMVLnDWVp6VbAWyapQsV2KK0xS2gA9FTFE6kKQ1bqqEDwiaookrQ7Mr0qWgVWBaHXA4pSKc540SZx5Hp7a1brR5KC9CkfK5GTk2EOnFJNPdL81oplWKSxYOaguIXZY7f8J3FWBuVu6yXOZs1uZXTGnZ25qTKJdDpjduG3haD0CDhXhqdyb2qMNHoQ1nHbzoE8SGaCo7AE5/5P+V2ZljPsWHJoPE+oV7R4NUXw9WmV2sluw6PkYFxFj/6CPhpDkyZV3cXyDSTaUfU9ujby/L0Ln8wyeiaAAlT5rh9K9O5SSZ8PIS9jAaAC1AWOMZPhaej16LAwO3sDTwMK4nIfbFcpVr2qFrLUQHq8FKyeSbi1un1uN0/TdHmm5McSBGMkVE/vtOPd+W30jbqrZqbSgK1YF1AKyHdrs6MJ/dGCVrXK1XvFko6En7e26TmqBYgmqabQjf8ci1NdpVpDmQhz2kgUvcNNd+mXpo/7GjjKHW9ctv6RjKf5SDejHoB4+K0m85myX89BpfpfpJ744vAOpgeHBBqol5lWSl3aBCWnFkAEAxKU7BntAA95NNN+FN1gKcl5UxB8DscCJSh0gQeZMJyMXXqtxJb77pW12Wuu/0L5VKhKw4oRhFAglEdnmozhWG8kFawGSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261022105027099003)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?praNWuPqaBM8PZj/zwnkonc7fm6SOBEZzOsvaaSoVo3fuKY3UtvYrQLGNG5T?=
 =?us-ascii?Q?nuXWetGEd2p9xf0In39k8J3FYwYcKpNEJWPAamh66mK6dgWhLcaLwH3CP+yi?=
 =?us-ascii?Q?sE9aZTkw43YISUxD5KdJY5jEJ916YaQBzJhVPKtB/7YBiai3218joG3ZcK1y?=
 =?us-ascii?Q?ONxRg5JWzDi4QGSjr4yMFZc3dQv8l0tuOpY3qaEZQFUfpg24l1MKjbQvIiYR?=
 =?us-ascii?Q?5sYGcpq3yuoxKq6ZVBkfMxPng+716vAFVzkEOCuxk5ll84xcYp/CxbVfVH9x?=
 =?us-ascii?Q?9F0TH7/xzdPpc47kszG+TFI5FzCUg+k8G9qPQyLf8+rQgY/mVMba/d1Ouswa?=
 =?us-ascii?Q?jSWKMtfCBknzO0RbqZhiHij2dGsuSNaFb+wBFtlHhuI//H/eVlB6SZ+FKmu/?=
 =?us-ascii?Q?A8rF8rjRqELwCAam8t1zhaswtpliC0KCJKkQGeuVYrVOPKr0TvB9BJRIpO03?=
 =?us-ascii?Q?F8lZRay83DDLSpZzLj6GM/v35Bu0rrH5cOGCOFarOQEfsqhuN+9AR/rgn+GS?=
 =?us-ascii?Q?hRp47GYUVPq3myDwqqYZDeIP8ZhpgAZLgsQ2BUOI+VWgKml9e9j+wHXoC5fl?=
 =?us-ascii?Q?LZSJMmIOVasOAE2IormUGhsy2I2Hr0mkRw8tLIwjPQVDoyN4EdLpkiS5R/Cv?=
 =?us-ascii?Q?Co16EL+bFQRULSUvL71PbqSPH484PDHEEI0FuQVTAjQwgl9PtqsmiCe1cV6C?=
 =?us-ascii?Q?m3GHfE64SiaRufRYHBxKygwZP/oem1MjnGfNwK+MSzicq2oBIjtIDKCq9eji?=
 =?us-ascii?Q?yi1aOKKQfSoqaQLbP15DsplnJJha2IkJCS2BBZR15wurc0AvhrciotsA8kzy?=
 =?us-ascii?Q?aBLdKnFpZA5h9qwBWnCe8KoVY8u5g4cot/Vf9Wawfai9mjts0ispYKZKY3kj?=
 =?us-ascii?Q?PXFueLs2wS/WbGAI8/ervFisf9U/+p81PpZE0aMqqxT+MKoxG6mH8vwFZhha?=
 =?us-ascii?Q?W78XULsc4RU3Of5ebCfc+cFKKd7VOKkscFZvYTFrzka+IbGemTafxZkQTYcQ?=
 =?us-ascii?Q?EtVZR4E2XcTSP7QVmTtZ1QE7OP4Z8d9Pm8Btgt4RoCpZZcPEn88DTr2WoKVk?=
 =?us-ascii?Q?bws8a2HmsvQmZ0BJXhYixh7xW1bk/LOj5VJhNdIELz8rsqszt9CgkSSh6+BL?=
 =?us-ascii?Q?lFl0zPhPpnTbZYOTXMhabOhQ1NuHHfjvni77rrbyHJhfkWTTFhlC5/GMWDOA?=
 =?us-ascii?Q?VurybNcpQ7WDdfq3/1laUoPPfEM7GgsDNT5ItgEy+rcjLzfzpJD3Y+Uhwk3a?=
 =?us-ascii?Q?teJMUTqxnAuLYbhtSH2eujYbrz14+9/OyA9d4XfqAu3Dye8qureqypcXpYq6?=
 =?us-ascii?Q?sR27KWMoVNMEE62yoK2GGjRXa6pucXrEHFOV3rtn+C5ekqRfEuYZI4O45A7t?=
 =?us-ascii?Q?5Bpn4xg9GoBZu5XqCvz5iMs3gEqmXCzSUNMhIyvEbcXmFtp9bs/nYo8+7JFY?=
 =?us-ascii?Q?aDo6pL2OImsNJVODSsOumRpR2tGYcywhJpJgjiRQnMfMUpZV6U9e+1KeGrcw?=
 =?us-ascii?Q?Wpztby53HW3wr4eddsiR6lC92f/iVg44AJKOjc4r8l1VnUfyIVS5QLZCzktC?=
 =?us-ascii?Q?E9KmIswnc7vAAu4rannhjng3Lw92GGV8qI7c506nMo2ASatrYKlhfcT0zalp?=
 =?us-ascii?Q?D4aBisLvMyAgfPx945XWpu7E0kt72pezWxVp9POi/9CzMOB/rOeC35zDI8Dp?=
 =?us-ascii?Q?c6ZZTADL+PfmJ1xGgJzZePYb8sF26A811ckmqXgdFor2Z4ZH8HeW3ap2UEAu?=
 =?us-ascii?Q?EkWf9bFRv1/K+hc8TbZrzegFkInh3jbyliWq5Gt2ujNZSi7m6iI/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa121c51-0f9d-4294-0e0b-08df41b5f64e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:08.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhQIvwTd6+AWsslF0ugvv3rEIvzNSxitz2cHSmIT4kia3SMVYo5RNqdbySB0j0BnbSHkanhtzz6GU9sqvxY1EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

CPU hotplug between samples can distort the calculated steal ratio because
the governor divides accumulated steal time by the current active CPU
count, even when that count changed during the sampling interval.

For example, assume a constant 3% steal rate on each CPU, with four active
CPUs for 900ms followed by two active CPUs for 100ms. The accumulated
steal time is:

    4 * 900ms * 3% + 2 * 100ms * 3% = 108ms + 6ms = 114ms

The elapsed time is 1000ms. Using the final count of two active CPUs, the
governor calculates:

    114ms / (2 * 1000ms) = 5.7%

This exceeds the default 5% high threshold, even though the actual steal
rate stayed at 3%. Using the CPU counts over the whole interval gives:

    114ms / (4 * 900ms + 2 * 100ms) = 3%

Checking num_online_cpus() doesn't account for cases where CPUs go online
and offline such that the total number of online CPUs doesn't change. So,
implement the sampling restart on hotplug event.

Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 37 ++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index c34d91267ec1..f71dbf27e4a9 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cleanup.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpuhplock.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -42,6 +43,8 @@ struct steal_governor {
 	unsigned long		delay;
 	unsigned int		high_threshold;
 	unsigned int		low_threshold;
+	int			hp_state;
+	bool			sample_invalidated;
 	struct delayed_work	work;
 };
 
@@ -217,6 +220,13 @@ static bool preferred_cpus_valid(void)
 	return true;
 }
 
+static int hotplug_callback(unsigned int cpu)
+{
+	sg_ctx.sample_invalidated = true;
+	mod_delayed_work(system_wq, &sg_ctx.work, 0);
+	return 0;
+}
+
 static void steal_governor_loop(struct work_struct *work)
 {
 	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
@@ -233,6 +243,11 @@ static void steal_governor_loop(struct work_struct *work)
 	sg_ctx.steal = curr_steal;
 	sg_ctx.time = now;
 
+	if (sg_ctx.sample_invalidated) {
+		sg_ctx.sample_invalidated = false;
+		goto requeue_work;
+	}
+
 	/*
 	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
 	 * To avoid possible overflow, divide the denominator early.
@@ -254,11 +269,14 @@ static void steal_governor_loop(struct work_struct *work)
 		return;
 	}
 
-	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
+requeue_work:
+	mod_delayed_work(system_wq, &sg_ctx.work, sg_ctx.delay);
 }
 
 static int __init steal_governor_init(void)
 {
+	int ret;
+
 #ifdef CONFIG_XEN
 	if (xen_initial_domain()) {
 		pr_err("Cannot load in Xen Dom0 (Host OS). Driver is for guests only.\n");
@@ -273,8 +291,20 @@ static int __init steal_governor_init(void)
 	}
 
 	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
-	sg_ctx.steal = get_system_steal_time();
-	sg_ctx.time = ktime_get();
+	/* Lock to prevent unobserved hotplug event during setup. */
+	scoped_guard(cpus_read_lock) {
+		sg_ctx.steal = get_system_steal_time();
+		sg_ctx.time = ktime_get();
+		sg_ctx.sample_invalidated = false;
+		ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
+							 "virt/steal_governor:online",
+							 hotplug_callback,
+							 hotplug_callback);
+	}
+	if (ret < 0)
+		return ret;
+	sg_ctx.hp_state = ret;
+
 	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
 	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
 		jiffies_to_msecs(sg_ctx.delay), sg_ctx.high_threshold, sg_ctx.low_threshold);
@@ -285,6 +315,7 @@ static int __init steal_governor_init(void)
 static void __exit steal_governor_exit(void)
 {
 	disable_delayed_work_sync(&sg_ctx.work);
+	cpuhp_remove_state_nocalls(sg_ctx.hp_state);
 	guard(cpus_read_lock)();
 	guard(mutex)(&cpu_preferred_mutex);
 
-- 
2.53.0


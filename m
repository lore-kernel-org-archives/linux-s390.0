Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793885250;
	b=e0oiN0nc3cyoR9TceO+vNKlzB3Lg25ttso2D2vVoUSSuw6+fNLSsaeymW56NqVbeP0Yt
	 cc5syauUNTMel6JuavDKrhWr7jvxDpynVJAO9XylynOv6R+lC2Xr637eTx3GirAdd4XQr
	 dI5Wrp7SC10RFu0ftgZ5VUHzbGwIJWKaNTn7fOGTt9MPi/ZGnkA0h7ASNHyar4UAByrbT
	 nG3zFmoSvK42e6tudrnx/tbcgTg+Nis23Aw7Tj+SXnprsKjw9ZAImKX8/Ar4HStbzFaGu
	 RJd3nWtkhCWQE4rKbAMASIT1X5AD6yLeSLWH0xOdXLXgncz7nTFLpFFQaPJ4NqwjBwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885250;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=O7OWeHyRaSViQDC3e0rEmWeo0Cs0ZlfigiWNEGwEzsQ=;
	b=UwlJr6GKDJaIyEXPxTCGntSjLyy+Hp2gweLEaen1M+g5r2aXcPoNGFIlE66xnXRBPzCr
	 efx6//m+YgAlABAj+AZuqAkM1Zr7VcgL+FtuPBo210r2Tut6yxcz1HyMriC2X4yNHa7Fs
	 dmHxkM9QaM8m2FMM82JJthsd/agHvemRRZO3KjjwSe3FLtDU8jQ4pHN/9APPmKIaiOK4H
	 gsLAhl63wbAxvMVWdOokLCQyNcvb6Otl6Uw24bzYhTicI5mSS2chLb7JBh69RtXDc87tk
	 EpC6S0BA41g1zWbTHn1jffPKK8js3IqCxhiOk7VM1CoUvHFQrufw5L0vkeomg93elBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MsCX+YIf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.38
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575B606A31B;
	Thu,  5 Nov 2026 13:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7575B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MsCX+YIf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr+3vNQzHBRp5fdUPRi7ioD9pyPObI5DEici6q3ZvmLsCleYN8OCmToMOiwy1gkif/IBlF4AEc5ytCIMM28u4W1tg6yvgQS44B0Bs4rs7v8U8hUISRiSJnO4EmJqbGZuXj4OiDM4YHfssWAN4caF6oyGkPh3YQOFT+Zb9SwwGfTQ76JKp4jeawaMUjOix5EIONHVzfuWcmQHChweeKem0IbMsgExZCGnstZP+0rzuDk6zlsDTqnW635nxIP1v43LP0cf+zpUzxZK6XTLOvBAPZsNyugaZKSE4WgwlriYk87XtXQUOccBduohgl6gJOloYcSr/HFSx147n2KGMSKhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7OWeHyRaSViQDC3e0rEmWeo0Cs0ZlfigiWNEGwEzsQ=;
 b=coP7i2loJfDP8zk2APe743/RQWSBq2tw+5aCNS3qnIz6TdbUn3rvVVJsGYtBcpL65Hp5AqkkE5Fw01k57Fr0s4mALduLXT9Zigg7TusUJQAGIHPNnFfZWollfZccGdcviagezKSPqzcThJPFPKEnM6QW9202oKR2/8Vxq2xs4VxcbIWIMCdrpmoShJ2PlLKlXSYcc40mpGsFoZJOn9eUx6He520mknHcVImhk2tUVIu7aoVkXb/PVHyQu+WjH52iVBHg5JAm/pDLWOtEBihzXchJrOhNwjILx5Ha6MZyZVfbCN0uvDXNo0k8mb5AStlDavalNr44gG15CuS5jQ70JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7OWeHyRaSViQDC3e0rEmWeo0Cs0ZlfigiWNEGwEzsQ=;
 b=MsCX+YIfc4nSHvT8pr1CptUgUIGWLQjQsmcu1JKB2djRwNVRD/Ng2HyCHPqfJW7BXd2gR8qdIhzlr76F9wKWZkFAUlnzZ3T/nvPnGYCYtjlHqm+hwIktsCCo9F++jeZl4uzkA9W64SCPL/aXneqFt/IA92Mop+4WU5GlsPKXff055mIu/gVZ1zseCOuzeKjVBj1++4+ZXtyE6qkA/Mh9aCx0DViLuBspCNV40UVY6pYnrf460fMUvXeP1/spKIAEJxg+hRuTGPhUXofbdaPTlyl410rfHMMrrXSbd5M1FT2HlrwTwI/dz5BZbaPWfX+Nu8mjFPI00m0EWmP6PHT18g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 13:27:18 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 13:27:17 +0000
Date: Thu, 5 Nov 2026 08:27:16 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: agordeev@linux.ibm.com, arighi@nvidia.com, borntraeger@linux.ibm.com,
	bsegall@google.com, corbet@lwn.net, dakr@kernel.org,
	dietmar.eggemann@arm.com, driver-core@lists.linux.dev,
	gor@linux.ibm.com, gregkh@linuxfoundation.org, hca@linux.ibm.com,
	johan@kernel.org, juri.lelli@redhat.com, kprateek.nayak@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux@rasmusvillemoes.dk,
	meted@linux.ibm.com, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rafael@kernel.org, rdunlap@infradead.org,
	rostedt@goodmis.org, skhan@linuxfoundation.org,
	sshegde@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	yury.norov@gmail.com
Subject: Re: [PATCH 3/6] sched: Restore preferred CPUs when hotplug removes
 the last one
Message-ID: <auyENJOMktDe0uP9@yury>
References: <20261101192203.6979-4-ynorov@nvidia.com>
 <20261105090505.93940-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105090505.93940-1-fushuai.wang@linux.dev>
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7216887f-c94a-4255-4238-08df3b40834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|23010399003|366016|1800799024|18002099003|22082099003|10067099003|261022075727099003|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261022105027099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	LizE47CwwEH3Qm4crDOya9V4LTVuG9HRcjVWnTRKOU00uPFWmM9CO+D5pMXdVIG6y6nzVAIEuto2IN5/33RgCuE8LZIsjjYNEl2Sa8I+lsJHQOXxp9ERhlcpFQ7HJYaSxvZUE3hu/B7fmud1464bLDTrJAkUKhCnQqXxTmbvS+1TgTgfncZ3Y05AVTemNudW0q7LezkzglokV/hMsxOlvs42+vBWCGpuv61z+CPW2FQ6r0tb9oeMLrfB4U1pN7v1UstqWEjpgaVXKP0JadhwqQMTzQPOVtHrwdwqjC1uYEFZiHcJeJQ6SltUk2GpmBZ8+HTH8pR08smSXefoG1Ao87SGAXC+8FVLdTRWyNqzveBJSk5gGkeiyBN/p4oCpDcY0fEW9l1RmsWp71yXpVi9AD5oc4Rr9CiKYuyfsBtSPlgCpJGeoNX/SIWW/uJvqGhUn3JPzhPRckYddONwpGrfri3ldK1MpwUO3AJkTLuL562bsruFf9LubcQaXz2WoMS3zV0GZo3S2QmFlDXSSpzU6+BsS/Xd9nC1S5YoT5PH/qOMNmv+k4rh+uBpNBjfyhD2L0SAQBFzJ2mDAQlk9pnUjWNhsRk5dHvFESoodPuLcBfSq1YXrQQJEZ5iGMWDKZEfCdbUrK7BdgH+XdO+M0TqiTzSabu0vyjCC2V/fssxpNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(261022075727099003)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(56012099006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQTZr8r4vawaJek1xiZREPz97lU+08bMzDiovMnBiqkdNV33nwKvmwZ6NxX6?=
 =?us-ascii?Q?mQife5oFPkpROD9lQ6ql1DBC9jFcu5jwVdD9qG9oT2kUU2HPwe0Jtvm0G9+z?=
 =?us-ascii?Q?CiOicMvEuH81JSNcu6VjMG+PcEzrla2WHl7xfxEzMq76TRYfuX172JYQ0f7I?=
 =?us-ascii?Q?hzlJXCqwBGV7xjyQQAxE5GgR0U3okNPId8hYA3l4yFDY0kvpNphlFXGPBRMx?=
 =?us-ascii?Q?MwCIWlttLdmnmhvzktUt6+XuQkw6U6wAMcmWlPZgfuwbcmvNLwrQSge7kOoo?=
 =?us-ascii?Q?Z+oypdmfIHdC5yCclgfuNPr4DdNOMMTLTakR4LIepHvKkIiBtpS/zRINoLAJ?=
 =?us-ascii?Q?UNQOWx6j/j8Q8GwwUapn/rB/nP6C3YeVBZ79BBw12N3nOxdcagPdATH3b5b/?=
 =?us-ascii?Q?9GAWbyXbylXwzutcS1oR7ZbI4KGmpif0/5ns1rOZ2kyokxgStLwziyi2HPbU?=
 =?us-ascii?Q?MFgHCctlMeDDSV/u1XcyBcPgS3WWKZxK6EzHBC30NEtXcFtFSzaZdm/YAHwE?=
 =?us-ascii?Q?H/HgjtH4am3nSL7OK85qO427i/RFWbFrStwtx2PM8YT6vc4yd70HFzW6HnZP?=
 =?us-ascii?Q?wEyQEdTkXPOzpJVSwe+9frGvbjN4ew4H7z4K1heeE7Jv3yzUKCsvtTp8JfOn?=
 =?us-ascii?Q?mevyjiWvgWzxlchqkLNRXklJjH1sNq859mnjHmlvPsngqZA1ribjBZNOIYaT?=
 =?us-ascii?Q?w7sydhC/lnUtYc7qht8IE7tgwHvuB8QTOs5CIIZN5EceFO/oBykBRwZBMMaQ?=
 =?us-ascii?Q?YzwKZFibqQTdghaO0b+Y+6QoNWjKKkHgTC0NTOIHa3l7v0k8lrA1O5iH3sRK?=
 =?us-ascii?Q?e0Nzr2c6d20KdltO4naYfKXGBiO6Jah5Mw5qFOdslAhb0HWNwmxW5cB4rm/Q?=
 =?us-ascii?Q?mh+tQaKuQWVYpHz4M7QQq96KiZEnYKV8WvHNieSI0etzz9GNybsy3HRiNN+1?=
 =?us-ascii?Q?jjxMT01JBPVhxFmHhWY/NbKLtE/bn9ziSTiJoAfcznN+hMwzJ/gJ8FDCADAL?=
 =?us-ascii?Q?S63gdYTg5vPDUhbi9xlnOrr1i0ZOFia4E8ZJ5S5M5FtseKiD/EgYWr9mRRoM?=
 =?us-ascii?Q?uEN08y7iGxzw2jZn4fnnQY3WkFPqL270XwJAszko+sj8bwMPHXcgAiYa19de?=
 =?us-ascii?Q?bjXIMj4pbSIumqSOYEqSZUzpi/dDGswpw81ujLiKJw/n7ZR09+C/S49KNqCK?=
 =?us-ascii?Q?Y3hTu6CqFXtBnt00F4cwIxJGv78H6tPdqQSRH44r0OAxMpBrAQurJsGgeUHx?=
 =?us-ascii?Q?BMmgqZaw5+8zpyhPlR4AlmCh7v+yknlR7KbNRKwp9aPY+Z4zQv+fWl8be/jm?=
 =?us-ascii?Q?ZWkur1I6HnmbUPUibk6Pqhlk8Jm1QJEHg+sGW6nP/+bYlo5KTh03r3OWKHSS?=
 =?us-ascii?Q?jrvyf/xAhPTnHpyyeAK9RmEFPSZUjS0k6m7CR+xkytlrGwofc4SQgOZXay08?=
 =?us-ascii?Q?dis1qFbqw0Ki9dbJInpiL78M/1CuIJmLJbyPdwPAO0rzOFLAax5HIm0QwrpE?=
 =?us-ascii?Q?7JwgRy8fyhroVyA2kmLjGAK0UzHjVkpqSsFzrUyMwWm7KBo2pvGdQlPayy8N?=
 =?us-ascii?Q?lnHGeXOZhWYw+Pub/fQPL9aRT+2bh6ZydxfgXWikYbM98L/6/IAScq2DB8Xm?=
 =?us-ascii?Q?nlq3HwRCL8bnDtbjl7Ci2pjvQ7f39zNOTh+p0fSAzWiHmzn5bMHW5zXD4h46?=
 =?us-ascii?Q?PvY/Tp8tdoNrz85mXevmo/mY5zND/k/NHMMmyo4RXeNcIuNL1rqaX2KRuUBC?=
 =?us-ascii?Q?+9XZd/sQDBDD+pvHplqC/ytLPP/fim9f0a+SY+s7fEgG4bMxa/na?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7216887f-c94a-4255-4238-08df3b40834c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:27:17.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zoy2gAbznO5q25oSI+Bn4CbRbYxuvBIXrnYElnEGtlbac/2tvQ2hofIUGrc+/lGbZrtpKKeWhZd0DXvghCnKUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

On Thu, Nov 05, 2026 at 05:05:05PM +0800, Fushuai Wang wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 04b62c16fa8c..98f4f9434965 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8712,6 +8712,14 @@ int sched_cpu_deactivate(unsigned int cpu)
> >  
> >  	set_cpu_active(cpu, false);
> >  
> > +#ifdef CONFIG_PREFERRED_CPU
> > +	if (cpumask_empty(cpu_preferred_mask)) {
> > +		pr_notice("sched: last preferred CPU%u offlined; make all active CPUs preferred\n",
> > +			  cpu);
> > +		reset_preferred_cpumask();
> 
> Hi, Yury
> 
> If the CPU being offlined is the only preferred CPU, after
> reset_preferred_cpumask(), the steal governor may still need
> some time to tighten the mask again, and eventually only one
> preferred CPU may remain. Would this introduce additional
> task migration overhead?

This is the safest fallback from the scheduler POV. Current steal
governor implementation would require multiple iterations to get back
to the old equilibrium. If it will show up as a real problem, we can
teach steal governor to converge faster, and/or detect the preferred
mask reset.

Thanks,
Yury

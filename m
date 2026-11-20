Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189021;
	b=ArycLUNoT753ncIN2B6ljcI8rdQ2pmcQd7nlg6kAV1q1Bbu8kwfpi5im2mdt9XjLrEoI
	 5o73M0sRh/TGC0wmMKtutl1xILM6EyaXxMYHvtsgK6VaPgs4vQs1VH2xpIKLladbaCrs7
	 gikHl+SgnLVdlvtcmVPdOpiXt6s3/nB1d3v2qBxTYLUB4Er0ubBxDoJIMU75J97Uf5mIP
	 HfMk2oqQPNLfytVYO+UgEQX3moQD3NEzwjGu3zqGooa6LKqSPkdIchT3Smr+wAK/akQyn
	 NRJhueD5564WJb8EzuqD+oatzCku2tOQzscKueTFkZLH1OXqeResFWzM34PnVuqx2Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189021;
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
	bh=c600cCk0bymkjgSTJtdYCHHeCNrDL4EPXE5JNU4BW0U=;
	b=2wSoB+KGJRzPAK+9u4jf4/6IsNMBdF/1rbv99LxH6Bkil5xU1dDFNWMgSbwAN/jXKs1O
	 hhHK+KeoRpk02Y4PUn9XF89veMAu6KZ7r3xuovq+3k5PXSoXIyqdhYfgvZ/ZyQ+sQoH7F
	 Rh925eYXPHxx7GHqm9MHrYTjEG+cLZXhBmlSqU1bqyaiK7Id/SpZkcHusgArna+XYA4Bq
	 AwflCdRO3qElBrY8CARtkdILfYonGtun5embxVpPDxrsUeJDs7Ymd+v46xDKJdJhd/Xkv
	 pa7JW+lf143BdvK065tc8wCIvKKt7vWV2hoa1t0fZPrRjNvNy8aK8OsDBRVj3NejpEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=el2L0rws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.55
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40961606A325;
	Fri, 20 Nov 2026 15:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40961606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=el2L0rws
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+Q2kJOxZwAtbDJK7/OYiDOF26tV74ShC1fzSy/3pHHXgJayfQoExDldCV2FgFaMBbyoGu92pz7jjsJmb12Dh/4UjGDzhIaFOvuk9WydIr8R5AYel9pWr3fc/d4pdoFAIfyRSUpgpIkQq7+Sc88oQKpR/zKBOfjdzDREggy4yMu4MKyIipaU43wXJ+qJJVJUV+llSKHV1S+Mk8cq7wqLllWy+tq3WUViwHspkUtyfr2akNnPVjk6ryIPBcAEFbS9ko0fjuH/xf+/SQmocGnK1FPrl1STfxzalaVsaUZfpekXDtHuw0nXzQsyTM0/onsSATnAeCKgaHPan8DKd7bzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c600cCk0bymkjgSTJtdYCHHeCNrDL4EPXE5JNU4BW0U=;
 b=FLVcYWfhUNiOWBSMqLSWQtSeDyFAXsV2Rca5Q5Uj5UZADJJ3jxkmO6mbafEJgITFrcAwMz0BEpI8m3xlZ3BDPuqSPvtFpoNaleWcM1YYgA5T+iFbWsZ9SK/z4lkYlyvzcBxhC+xQm1UnBg4B9VcpCspMu1ic0nENoJHLYRT8879jFACGy+EkJajUm9kYSaE2OY0Yv0VhymeytNlpA/BftdxD/7LGFbuG6kpHNp7Fn/f0eY7iQqm7rku/GDeu1rBwNm8JWxbA8DHzNfhi8Nip8GK9UFM5+jSOrSCWV5A3DLmdU6uoF13Xwhbd8bHlQ52iwoVmbia4rjNlw0W58V9xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c600cCk0bymkjgSTJtdYCHHeCNrDL4EPXE5JNU4BW0U=;
 b=el2L0rwstOPlEV7MZxhHFDYirq21TCnfva9JxAdDiXw/6y/uAhSL8ofhQPnpJhOvpVFZIa6wL+ENFCxD9L73Rk6WuqarkmtLplO0k7iEVYtfW5ziS6lR/qOEi8j6Lxi0iX1tF5AU2PMUL14fn0cPAxWMu8x3g6kZzqwFY+ZdXy8N026Ma/bCLS7j5MB02aTc0nslxqJbtKSSN+zZ3owvmLSz/d07A4O8yHWnECmmTlpX5kEV8wuUZcTBh/Z2Mdn3jMPzBoMC/D22h4HT+DUl0KOHTiJzJvbvPRYNtLti2XKD1CAT85wy2LLKVjPXViabCJl1pkxZwa97Bcck6l3N6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:36:48 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 15:36:47 +0000
Date: Fri, 20 Nov 2026 10:36:46 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/7] virt: steal_governor: restart sampling immediately
 after CPU hotplug
Message-ID: <awBpDhQufKCyf6qs@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-7-ynorov@nvidia.com>
 <37a30a91-bd86-4dbb-ad12-8cbb509f7c4c@linux.ibm.com>
 <av80SflNuKlReSEO@yury>
 <0b449b4b-a336-426a-a72c-f6a560b5a8e5@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b449b4b-a336-426a-a72c-f6a560b5a8e5@linux.ibm.com>
X-ClientProxiedBy: CH2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:610:60::30) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2da3da-f908-4324-ec00-08df471c16cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261026121527099003|261021121427099003|261022105027099003|261028144727099003|261026140227099003|261022075727099003|261102123227099003|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hZ45/3TBzRjw7/VkGL6NiQM+8EThbbjSPJudGePu6zhnsxjJvrPrWHhjYud0gJwx0BTlCjL8SZxc2+RQwco9C+Ve6cV0GSQljY1kHzXlCp98nzLC+eo5OytP6V/I1cSqL8ZfDFbv5EtKea9gCdAkiUB/tAWajgYIz5DInAfSih4rcZIYqbb4FF2Ai0R8EJU6H2IarcRBJhH8ySGdTtC/cb8fyonp5vrHifLGJghVVmQAP4mrZg27WX26onuMxkUtRzsfLdIzG1z1dKur3V33Eo6XmjeYY420Jf0I6/cFgS14rZrmrv2bRmS13scSVMwJFZbf9PT+L8Gq4Aj3XtwVufuRZBobAQWg0iVoyaSDmkqKBqDoo9SQYbfSX3TJoYOCipIrbn+Z6j/B0w2uubdo9MHCGfHSdbEtkHo5xk54wTh1TDcfc27YGNzkHGVZowMdfXMlt+1BrsojlH8pGbSOkHpY5/sPtbVzMBslQquvLwQMVL+MVXq9Sw3UKaBtcTmAAu/PoRIZ9Mn3hfWfT/aUFaaniefWHetLtqmlXj8JkXxKMC/Xxei2ghQUKlnu0LZ+5sbLQ7I5tc4EIvhUIRWX6C7a3dw4SWEy/NE72qitXxXhfXuT7Lcbwus+FvvOXfzscNs0+YS0raiXYLhvCJH5oYM3dm0Lfflk8heUARhhBio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261102123227099003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zb40Q+eqW+cMHe4DNS+ZN6gxpJv31cALTK3MMUWRbVvkAsUBil3FGfZjBbmL?=
 =?us-ascii?Q?imPh7KuN+elpg3ePpaRTzQUolwrUrbwxDMaCtnTH7Ag72pyWaDEed41q4q4G?=
 =?us-ascii?Q?3K4u0TI5fgp1isTrw0fD1rwZIpJxcGnTiNrkHnQQs/2mUWBrraChnRuR5TLw?=
 =?us-ascii?Q?Qc8yvo5c1LPqrx0TxUG1CRNZjv6NlwwYA7hbqfCRdt9zruz+M0JiTojY9WjO?=
 =?us-ascii?Q?hc4MCkB80cvkWhIT3mj8P0BrFT72zADN6DKC/gAtz44Svh3/k/tNTEBEXPpT?=
 =?us-ascii?Q?iEeCjpQztA+sjq+pPUcsrNQpYNmgZeZHftuGHtSfPvbP20ABwU/e6GeuSpMg?=
 =?us-ascii?Q?lLwqzsUQ9S/m0rdmZOhs6ToUCSywC3yxAMRK74g2KCbA8Ksz2k9O4MslWdq2?=
 =?us-ascii?Q?WbsOEruac37yoGgWj7RdAVoh6VZkWSJT6tOZFCnSWkdhpSzmYMOUuyDCJMU8?=
 =?us-ascii?Q?6MreH+1szI/uy7TcEBjETxHShz3WZpgqUedeDmxK37iIkVWX1KRoyeRtvyC5?=
 =?us-ascii?Q?ekTB0SbQc09mV95AfhINhwcMcff2X8udY1b8XOQDqPcPtwyiFXKT/LEj0ZlQ?=
 =?us-ascii?Q?hD6r+ZlBXacPjRaiL40Hoe4ou5O1bJnsATCTJJLk9fUFRNRyAkwsHkoNhV00?=
 =?us-ascii?Q?KBxyMibSslPqjrmTYjMTp5WJiMgPB1/a7GEaPlB1BX67GcU4p+ZF7sUYNxD6?=
 =?us-ascii?Q?vFK7hBaudHDSXQ4qJ7Oj7raFvNq2H7ZBkIW0pODquOX7eDYDDTt2P1qF42qS?=
 =?us-ascii?Q?LyBjPN7zriA3XRII6uWiarp5U+sXzT5nX6tt29OUI7b3qtD8dpq9K5nEbhmf?=
 =?us-ascii?Q?A9TAftPXNs30zPVXtNvfjJu01f1nXkW6SQvs9EDHvv2r5SSo1RyOizo9Q/HN?=
 =?us-ascii?Q?nj4RSEdSOJfdQOT4ICFCajPEFFFanHthmme73L8kahBl/qdYAyTE/LGvHYmV?=
 =?us-ascii?Q?0tKn5YfnXcPfGyIXw9jxckymlZwd4dGZr6QpJ8cvgpe68TPO8KM9vjnI96UB?=
 =?us-ascii?Q?+yxSU4E9pn37CNYgB82xl9IzJMJQ8atExF3Wj9a5m67Z6QdvbJOFB8S4Vou2?=
 =?us-ascii?Q?OoCdunZkl+lkyYGAYLQBxjmXLANuwtK0bwdSNFxAMSYU28VFrvp6lLPoqhkG?=
 =?us-ascii?Q?kiI55pubLieOPjJvTgKmPFMMNuswP1O14Orce/a+dwdbweqbMC/Xv5VM++gN?=
 =?us-ascii?Q?7LmfYmPYU/LdKikSpeJBuoLRwNJ8OGvGiO/2AY49c6z75YozYOVJ2xXDhPPD?=
 =?us-ascii?Q?P3C3wS2bA7sfynAJAasrnfAR/ChqixRDjn76DB/WkgdqcYq2109q2Qf12zBo?=
 =?us-ascii?Q?zDB44tPV6DIg8W20i1WfNdM2SIONyuzx7JA5wX1VWJ6Pg0C7AqAQsIwTVzY8?=
 =?us-ascii?Q?jeKW8odWPxeCiS8LQAJHkeYy6e1JmAEHUD7g0SK2hUItFDycdUT59UlAAMMT?=
 =?us-ascii?Q?H5WWUPlBrXK0o8uvU/kXZwzEplc1z+hXS9AsppN93mvgdP2DjxlbkIFoUXFV?=
 =?us-ascii?Q?ZtSNFVDhmOsHnX7C4aLPou4ZMKzSsEP3D9d0XSjFbfyjmr6SGuXR8qo/qnIO?=
 =?us-ascii?Q?dcip2MSUYGY78xNLSKb2aoP3W9aSIZuJYXmio3riZ+bIt2AIE0jur9nM5R+m?=
 =?us-ascii?Q?Q5g433IWHHdPgZSson3Eo3sc+67ONcLw7hQK+2CLL3z/+4Xnwn0eB0FSLgVr?=
 =?us-ascii?Q?usAHATl5Uew+kc7I5GjeQc0BWHBqCLShHQC2kqr9UqG6SDSaWhxfLlINBNwq?=
 =?us-ascii?Q?M8uK6SPIG2go9M4gZ4K6aDkz66nkVQhi116R+PhHlX1e9Q6vdlzK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2da3da-f908-4324-ec00-08df471c16cb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:36:47.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNz+dnAIS53YlZZAR1tBjjqRHpCD0oFKcSXX7mvhv2g38aIqsMI9THoFPEtCGZjxDsa5nRndE0glvJaIT6usYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765

On Fri, Nov 20, 2026 at 02:20:21PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 11/19/26 11:09 PM, Yury Norov wrote:
> > On Thu, Nov 19, 2026 at 11:36:46AM +0530, Shrikanth Hegde wrote:
> > > Hi Yury.
> > > 
> > > On 11/14/26 12:12 AM, Yury Norov wrote:
> > > > CPU hotplug between samples can distort the calculated steal ratio because
> > > > the governor divides accumulated steal time by the current active CPU
> > > > count, even when that count changed during the sampling interval.
> > > > 
> > > > For example, assume a constant 3% steal rate on each CPU, with four active
> > > > CPUs for 900ms followed by two active CPUs for 100ms. The accumulated
> > > > steal time is:
> > > > 
> > > >       4 * 900ms * 3% + 2 * 100ms * 3% = 108ms + 6ms = 114ms
> > > 
> > > 
> > > This example is not realistic. If you had 3% steal with 4 CPUs, and if they become 2,
> > > your steal time will definitely increase. It will likely double. So
> > > governor likely calculates 6%.
> > 
> > You say it's not realistic, and then you confirm the math. So
> > realistic or not?
> 
> I do not expect the steal time to remain consistent across after hotplug
> completes.
> 
> Instead of speculating, we should to get the numbers from the actual systems.

You're very welcome to stop speculating and run your own experiments,
if you don't trust the above.

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109970;
	b=gFNiZKu0v6d4VEdizkHjiFtV47NuKDiazrCyPgMMS/v8SFjQdlJ8T6lqlp/BE+VSwPV1
	 3IHBGAutqEbyJqwG8f1dEOJpv9nC2Otx/6g5Lfbx/Ba1dgVMSAyt5oY6dAHBhrIxAoBEY
	 qkRRnKHbk8Z8DdMhTsdbvMqUneijI3GOLGTnC0UahY2ZlK63/ufYvZUQtbSuUn2oRzVmE
	 U87u0S/0RbeaeqCk3G8d0+zSO9W1ii95WsUBKFXGPUUtxTWekLgf3BfprdJ+6QzEL9BOY
	 6FtVeSn2Xw0nE20IoghNt6sUbAoSWiElxtdG3GyzDI6zzLcne6YaF/dlfr5CCHO9PAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109970;
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
	bh=MChaMpV0uPycHbMovYdnd18AIUFbI9qshKI8eEx7DoQ=;
	b=cmHFI7T/JyORyo/IVEaQKjJKWQGAbevd0O/bqVIPDQeN10UdbDOLeF0+PQi+X0V4CC1I
	 upYKsgzjhqQ5ROslYWJl1y9pjZ/BNQbXSq2LYEpOm5JMaOvv9AueiYrvvrpcVWm+py2ql
	 Z0KVLl6hIpGnIquCagXo9svHN/SHqGF0CxesBhuUWF03HrsILa0hhdYNCuyw+i1IDSuca
	 xAmt1s2V4+H26fFASF41/1v4+6/gy+6MJ8nbm86yoU08/+TDeOLYFfLfXm4OnE0ipS7qR
	 /BObF7JuNmSn/ZhpGe2LAMrf/jk2MKwxX8szufO7eEYM8pWMgdJLyHSWZONwxnPDcCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P7ZK0m+N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.51
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A52606A326;
	Thu, 19 Nov 2026 17:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A52606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P7ZK0m+N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWZm6R0jQqK8q5j/RQK/kS2lRG+CMlrDt11UCTOZPSrY8504oO6wq7DCBI0KF7+3/WShOyH86uV3Y6zbUklj6K/1+8d6xRQp6zIHh5RaE1yMiCo7OFuOan4wRP7DhLekOeJECu5GywIdZ3OgPAX/C+yghsi1HBEsGPkE9MGkjr8jFYYxG8TZrYeS2Bbq7GVZsH9Y2cngB2VQiLjPl3WBc4WpXdLg9F/IwuwoVG5iG8AIEuTFrPZPw7zIcjdcixnEuYix6IfRyuutJVNGX4MW/I3z6Zycp29WTkZpriKn9kVTzTJ5a35smiGmolAehe/noM9CqYjq2DjgzFE7IXTyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MChaMpV0uPycHbMovYdnd18AIUFbI9qshKI8eEx7DoQ=;
 b=muxQRpumFoQq7WfiUtMeTucbjxnkfX5VEp9oX+T5Z84IN3/iZsS8ruxhmqGDH5GUwCy31yhfmojI56raZcMTc3eG17Eaj0NAiZLZn+TUrS+L+KG04L5cjEkOqQ1oGtJrp2kLVkUcsh+ng0vjGO62Y4IXR0MBaMj+rsKQSLZQxHcMPn3q8eL9jUK9HYpuCmc5QwUGZl8cwZy4XiskUEWU8PkiV5Rvm/Eto2I2x/4cNUObcA/QzXiZTymyH4271508kSJW3Y1JfNINeecb8bqqT6RODt8Aan9VZVp/3slFRM9KAsWfNlZYfb1R/w5a9FT1abDBCy7/AHKUFkcf9bHf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MChaMpV0uPycHbMovYdnd18AIUFbI9qshKI8eEx7DoQ=;
 b=P7ZK0m+NgXgrrSFlwAOGaUxczNfDyRrm6Pz5ZoIPMBmCOxqfRcqvnQo3Cpn/SAbFhLo/h9pCVcRXiGgZB+ZPHW2iaVTupqtunVN5pUCgdyyEGNGVLINrj11fDE9oOAkBpX5Bn4pkpeEWF1xLjkYKMWnfcpiOIw9YdPUlYx0RH5I6hEf1IZEadgyXjKWvu65P5MGNxpzi1B1kdn3BlkKPW3CH6ZguWunoPi62+Bix5kzTGDQNq486YVBxL3g5ygjZvB8Q8TS9TS9IgDoPF7kpsSwiolIQizu3uOiKItFGckwxnP4e7LnrjlGl0Q0jnXnlWguOSAGSU0MX6YPFB+kfdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:39:25 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 17:39:25 +0000
Date: Thu, 19 Nov 2026 12:39:21 -0500
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
Message-ID: <av80SflNuKlReSEO@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-7-ynorov@nvidia.com>
 <37a30a91-bd86-4dbb-ad12-8cbb509f7c4c@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a30a91-bd86-4dbb-ad12-8cbb509f7c4c@linux.ibm.com>
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2006d3-a7d2-4311-3e6c-08df46640d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|261022113327099003|261022075727099003|261021123027099003|10067099003|56012099006|11063799006|4143699003|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6PqatlCsyM4piKhjjxzf/e5ni+soDs8kTlkblQjp+LDbqJnK900qEZ6YFzf2dt5et83zh4jrhi0ix5ZqeSspmgr5Eifgc8U1XXGQHE7+k8JXgvGZRiv7z91TSBiv6sSAQujciptnHTCxrWjx6Vnap/uU83l5HYw6n6ri+r7k22laR+Nb2hgkBhVAaq1IzX1uOnHCau+8NNeD9HfH7SBRG1FAYcPnk1e4wCdS+P60rGv2YphRaOAMFSx7OIgB0/vb9lOCAlEC+F5uTBGR4SwN3NJh50w1KhWvhsbkf6u5mkuHdjCZRg5qrNuK+P5YpJM5OZaS87Y3O+alHhKipUoBIVxPzLCGfuiAFksyeB8wqxtxa9wI+JHbxYoYAufSIzDxth/fCnBtX2rcB2L+B5Dfq3wHD6NfzCdYn6avhTik3NwPiJuu5h8wdGNw0jFtM91zlZXQZMfxZQQzgr5r8Wt9I+9XiNGUsmECbYGCENem4BA0YhRsOFtgZUYWTlpwZMmRfJp0pcPt9UKFaWFNdBxr59yRY0ul6F4V4z5g5nwgmxGHDH74LAoophQeNJbI0Tl8wyFfLnFd6qyTo2m9a5sKSjHEGwV27Ehb8sRiXBzPRtYlu6PNDtii4Jj//BNzfv8o2di3YqDHndRqZEYc/44AcNmtIdTwRmrZMEvDU9CXAUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(261022113327099003)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fkj6QnYQOXP44pkmqOO/wjTEbLdfuLntZrPesfmtfnDacCiQ49s70SiRlL80?=
 =?us-ascii?Q?SRR/gmlXm2UWcLGc31kGpGEeSic43R7fFi+Fhespx+Ve/krni8ATRWrUaDMy?=
 =?us-ascii?Q?8yzraK3jriQA7bBN7Y4Q9ZVy5LvVb0W76BBLqXx55cjk0L6lGkhL2qg6qiDk?=
 =?us-ascii?Q?+0qsXERNNXgDnomxeUJLlqcvlQTrnQlRn3IH5yFRIVhWUG8yF8TLQ91OXCaW?=
 =?us-ascii?Q?RKzydeciJ+ONkbMoyl1PCnlrcRbcfficDGOs7BCKEM/sOPDdDDirhHREsbpd?=
 =?us-ascii?Q?wQfRby6G7cmjeWRpHNIm3fJzVpCWAshIc6w+j6OPVwySsf0u7KKXbOqve5Rd?=
 =?us-ascii?Q?uL9gBLjr3G0v5FQGQGyYTaPBcDHs+gBt1sqVZykN10V6T3zo2yaHFL7ohYtL?=
 =?us-ascii?Q?hXpPAm1H8T0AL9YoEq9roZTgunyCBbos4gXznt6fyYMKnHRsnImNU15LSQh3?=
 =?us-ascii?Q?ozi9xL/M0j2J17guqLRhLXQJtcZqQwt5sBhp2Cf7w79Cc2KOvDTyTia0c6VM?=
 =?us-ascii?Q?ndjV2jcNZdTdMg9vRb/zd83KvsBIIOhv8ExlyH5KB0SMp8NGlfBv6qFAY6Om?=
 =?us-ascii?Q?9buDN7/1EgBCcUav5+DUUumUAQzvTo4OpCnzMqK9yjz/6K0bX6Nv4HmBZD7Z?=
 =?us-ascii?Q?JAsFr/dkxLUu/WRKEb3nqqCPjUBRdvU0GpvqFOB8qgItAhULr322CdSpmLSf?=
 =?us-ascii?Q?IAm0z5UNSdDZXt/6JaM7bfXRKvkPEMoTUJSIf49x8E7nPxKv9vW6imLgNyfP?=
 =?us-ascii?Q?Q6l5ahiN25KZbEnQbepr5e6J1cMfY54W68xAASj2QDc25jufs2dNccx8Zz4H?=
 =?us-ascii?Q?3HQeVK7FqOE6GUGcyi5S5p4fsGiYTIy7jRaimiw9BOyLEmnDXmgr25D5ua0D?=
 =?us-ascii?Q?JK15BZXd1++floLpdT65pT8lDLA18it9KXILsf2eQw7309m5Kuynbb2+EnRk?=
 =?us-ascii?Q?E49s37fuIgyv3mu1+6Kbc0PMdlI+n0ORPmWptTvDZcMsvbkuheFSVw8POCVc?=
 =?us-ascii?Q?AKMWat5l3pGJV14HEOyXJr4S7dFcrx0T2bcv3Iy4W9vfY5SxPkCYQupLIVg7?=
 =?us-ascii?Q?R9W/w7wyTBnTU+iRmMqwJx4mRtD20hqD3O1CxPjgM+Q/p+dtnbE4+pNdPSVl?=
 =?us-ascii?Q?j8JtjE0oP/Ri9BBj5th4MuBKqB2pG1P4MRaYVImCb3PfPQQzeN7kpSAol6qN?=
 =?us-ascii?Q?zFHZ7xsrB9pEMO6aGyjYhZ925UZfUVN7DpiFisrZz6cxcADwpAyb4hnRLHTx?=
 =?us-ascii?Q?+7D5oxRrcyX2hYWdBB2qIB+24IehhvzL+IPBDHRRfv0NXCTFKvHPi+x6VmiR?=
 =?us-ascii?Q?0vSrP6MSyQZB0/F3UaT6BGN64I1XCnBUlEct0Nv3OaDzxt8eSSFHd4uqKtGf?=
 =?us-ascii?Q?tF+HZvOa6dq/4FRB0nBculPVwX0HizJuM3vI3IgWhxUzrZYn1R/7DxWa9yn8?=
 =?us-ascii?Q?i7Cl1aRSPnY9ZbyZV+VCgtUZYxhsra+FVTuIUGVIDtsbc8MvZDH83CB31pe1?=
 =?us-ascii?Q?7GQC3ZZvckcq+IpSQLUbGQWnDgA4pBgRg0uJQ8Js6U4nIlo4hxdxgtAPv1+1?=
 =?us-ascii?Q?l0ld2YqG8N/QTGoIHkAIi/9W+Dfm3WUooabsGLVjwFYgdr/4br06Kn+nDW0G?=
 =?us-ascii?Q?QC2UE8hX3UPuxtFFmVLtfcFVf08Dn9ZIdEKeJf+zlr1UHMf8LPFwHdwlGPsY?=
 =?us-ascii?Q?K0Cn0v6S3AvxRUP2LaBIMeEfqR1b9TDpXVh21mVS3HF2R0P0qz73HSGnSdaa?=
 =?us-ascii?Q?CtDjKELkNc8bsmlJLn4TAVozgUaNNqnAmjYc0B1apkinJVCN1orw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2006d3-a7d2-4311-3e6c-08df46640d88
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:39:25.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJwlVCOl+7Si1nLPChOEzXyhHmTfN6qNYE9ANqQqDPETIBMnMhwSYAZktNK6s9/8bpYTy3yYHFAFZNue1t6FAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

On Thu, Nov 19, 2026 at 11:36:46AM +0530, Shrikanth Hegde wrote:
> Hi Yury.
> 
> On 11/14/26 12:12 AM, Yury Norov wrote:
> > CPU hotplug between samples can distort the calculated steal ratio because
> > the governor divides accumulated steal time by the current active CPU
> > count, even when that count changed during the sampling interval.
> > 
> > For example, assume a constant 3% steal rate on each CPU, with four active
> > CPUs for 900ms followed by two active CPUs for 100ms. The accumulated
> > steal time is:
> > 
> >      4 * 900ms * 3% + 2 * 100ms * 3% = 108ms + 6ms = 114ms
> 
> 
> This example is not realistic. If you had 3% steal with 4 CPUs, and if they become 2,
> your steal time will definitely increase. It will likely double. So
> governor likely calculates 6%.

You say it's not realistic, and then you confirm the math. So
realistic or not?

On my VM, there are 4 or 8 vCPUs, and the steal time hovers around 3%
normally. Offlining half of them triggers steal governor pretty
consistently.
 
> But yes, you can have realistic examples, where governor may calculate
> the values which goes slightly above or below. But IMHO those examples are very
> limited. Even in the above examples, the steal governor was supposed to trigger
> high threshold since the steal time with 2 CPUs is 6%. So if not now, in the next
> delta it would have triggered it anyways.

Sorry, I don't understand this. The governor is not supposed to
trigger decrease_preferred_cpus() on offline event. If some system
event skews steal ratio, the governor must adjust to that, or simply
skip the iteration. This patch implements the 2nd approach, which is
simpler IMO.

> Some examples are really corner cases. Maybe like
> 
> 60 CPUs 3% steal, and then 40 CPUs 5.1% steal = 4.55%
> (Below threshold, but should have been high). One interval missed. But if you see
> large duration was in low threshold, so it is agreeable to miss it.

Don't understand this either. Can you elaborate on your case and math
please?
 
> > The elapsed time is 1000ms. Using the final count of two active CPUs, the
> > governor calculates:
> > 
> >      114ms / (2 * 1000ms) = 5.7%
> > 
> > This exceeds the default 5% high threshold, even though the actual steal
> > rate stayed at 3%. Using the CPU counts over the whole interval gives:
> > 
> >      114ms / (4 * 900ms + 2 * 100ms) = 3%
> > 
> > Checking num_online_cpus() doesn't account for cases where CPUs go online
> > and offline such that the total number of online CPUs doesn't change. So,
> > implement the sampling restart on hotplug event.
> > 
> 
> I am not sure if we really need to stress about hotplug cases. IIUC, when a user
> does hotplug, systems are usually idle. (Atleast that is what we have observed in
> real life use cases). And hotplug is really user driven, so user knows system is going
> through some transitions and will be stable soon.

The follow-up series brings a real counter example: Android daemon
running on Qualcomm SoC offlines CPUs on thermal event. So, it's
automatic and the offlined CPU is likely not idling.

Thanks,
Yury

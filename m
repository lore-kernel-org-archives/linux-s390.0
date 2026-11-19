Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106808;
	b=O+J5hs7sAvmFa/rP9Js1sjENZAUR2gqA0zZxWkaYr37y+/BOv4iMchGXD8R1QognG3Ew
	 g/Cx7OlBq7Jf0ptO0AF4C6oud9XW2rURFi0M+lFYbGWS9Hx/YhI3BYJpI2A+UPodjVUB1
	 QqbT1ue53WDAx0MVJ5/hagnH63udiBFoDOrl5rTv8hnHavL50GX9IV+wyBy5NAKJEVQg5
	 G5pXRYvKOrHz8KWle1M+lRqjdvkGk8ZfJPKuXopuHXraQNZRZ/2WmikzvzYNjAgSqAUCM
	 RaSb/xNweG6eO9IAC9lksh1/k3a4E7ORRW84JsEWSazywHBNy0Sv0hnxplQHwbMrZtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106808;
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
	bh=ft1spQKXCgQJQ1xFtLoGbitlsXUxIm7g72sNOwl9Qow=;
	b=yLwNnCwE7koceFX2tzh+nOweUo48xaWsMK4hqq2ElnK3VMZwDTJPIw3yY/QEoR4FXchL
	 qH/8xyvNn+O1TSNgQwZH94dvvS0nvXGP1h66qpBA67ULVxytU0oT+xDiE5V4ybUDS5ke2
	 wZF/e8dsRzxM1n2SmdnAFcj92+3rh8LszAnrnUWvQr5AXzjq8Rz9jtdt8phyendwe4cPJ
	 KHjLB7oZgPQnubdmkOhktWnwtJKRYWB7kwaVBUMsq5C/F13LNd1ky37T6YdtitSBxhazk
	 VxMlOHFwdFncTYDK1iJ9qz1vtPRTyn/AHKo5kuMVGCX5W8QtC4ElGV3B3J8yUwrnV0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cBSqeNOb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.1
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC660A261E;
	Thu, 19 Nov 2026 16:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3CC660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cBSqeNOb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRRuBX9VAPyse3wpaXu9S6B3HK7Ie8+3WsdWc3ENii8yQ/IZgv869O/UlURxfOWP/7Hz2p5OGgLmMy86VJffpo00z+u8Qs3GyTf3e+RuZhHS/1X2frQsGTbZS/2S/GpB/elwRc/Y//2coecHOGqyAISmEmo4Y6WC2oaA6va54HJqbS6W55NNmMPVuuf3Nmx0Gvpw5hEUOqFbmkWMlHB03AU93q0qXm1h9bfBPlC6BFBp+zLUFioNnAXTvnDSXjocucpzsdT0gt6MEUdRG9mxYg6AV1T6UwQvXXLgCl+BrMd0blqNXpVYT6QesJn3tH4qwuUS+NRfPhKQ21Ge1qrpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft1spQKXCgQJQ1xFtLoGbitlsXUxIm7g72sNOwl9Qow=;
 b=NB1feN7qGD2bqf277xsMb+SLuKFJmGK6lThNXiU+WpnFkwRl+1i1LyVeKOgzywv+sbcoKt4+oSnaTC2JrvhPyx90olBqETEIVspcZ9A58MavoROM9goa3m+f3jrNPm7Xc4JTqHL4POxOwmRLp0KoC9nDWg7JCLL1CGXYzkyt/7paxOCmPce6GDjx1GWTqQPeKQii2FR+1GbaJdjHh1QOB7lX2atj3l75NoyZ3l5yhtZtBJoWdbL6hkPmSEdPthqqFBBSr70LQ7zP0fZUCic99Y2r2MohRzyDlKP9fCl47eGT8pdVRRbP+hrPCEMrk+hDwADr6rVP2dMcvM7NjQ/+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft1spQKXCgQJQ1xFtLoGbitlsXUxIm7g72sNOwl9Qow=;
 b=cBSqeNObBg9jpGUkZ+61pNQMCDe1JKThUstTYYl2aamTD3s+ZnRUjcvCdLkBGBORzn1VV9abKBHUrpsMr7sl7nnNjK1GlqbpQBIx8fvf/rZ3l811QMmY4gfZj2okY4+F/Qh9W77dmV6ovzSDKWICND1fEt5v2FGWMewF3lIOZpmKgwpXPlL4ZRoesXMb9WLsk7pbZUfF2lzxrPYgVf38P5haUy/swpNxJeMmA0ogcKkP2hfiRmHEPaWCxcZBz5wAt5iEdGFHuatGUwOfXI3fhbtNzpVtCJZdn/NVM2gJtVumsWz6XXqXL65bs7Wv5W8/R4ndpzgxFEo7cSMe7kGH1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:46:34 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 16:46:34 +0000
Date: Thu, 19 Nov 2026 11:46:31 -0500
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
Subject: Re: [PATCH 2/7] sched: restore preferred CPUs when hotplug removes
 the last one
Message-ID: <av8n5_x8WghrGbTb@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-3-ynorov@nvidia.com>
 <1da4ec68-6432-4e2d-b435-0761dffb19a1@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da4ec68-6432-4e2d-b435-0761dffb19a1@linux.ibm.com>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b5efa3-da1b-4ecf-57d6-08df465cab76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|23010399003|22082099003|18002099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261022075727099003|56012099006|10067099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	XeBhr1meS+ssfvQDW0rSYKnFRE7/onUX4FRjWxbKpubSPXe6yVABIDPN/48LMOW1DLaXZXGOT5nxbFI9+HNyXpXDFV6n3P+dHIa7wzwaDz4zbHrJ0p+ZMGSF+xwGEgvRJ762WYsHmurmgYkXzf3hvmnOyMJSCaMKqe8l5o5G3T9pO0CRTkZH2FXSkc2KD19jlZ83OGFhfmJzboiftgzyZoH+RbgTRTgZ1/PA2wGL5f+gh4tORz7xPgLs4YSem5ATYMOGrV0cgGdhfiNidt7k1YA9mdYF8SkF8BvWwFsr+DiQtTQXnaTIRjBw1I3pq0cz4lcSDrP4tIx460uefRkMHsELR100uERnsNkEoc3ehyeb+4ZqhZyyjkEEPmUPKHRaNtzvSkttg9ybq6M/FGJftParI3UMpbMCHKD0H37goiZQB35LwBbkg31vVA60V61X2Rwbrr9/Ub4Y0BH6TgTWtT7VPMussq676en3Bl0k8+up7kJR+ETBgJuaUPVpq/k3CDUdmkktNg3S2KxjPX71IA9M+Q3Kb3tzh2H3ct3IXkrWieWg36V7P0w+Uh9cqdE+/ABWVng3g/G3V+YasdQXg6j+X8NaZc4Ul9Eq9vIpt7jXeYm58vEC9qpZpRzkC0kiR4a9AKJVfgOk9GXVtAY7UJOSt4OBGenbs2o9vgcH74o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261022075727099003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iv1yh/u/FLzFAROn/tCwnflAtHsuz0K7TVuTyAxyNTqrJToXUNVjtRX7A5MC?=
 =?us-ascii?Q?P3Zif4LGaXy4IiWP7NZtib7FpVwfUdez1YyM03nFMFdOGadP9opvtQSJbk+B?=
 =?us-ascii?Q?bQg+om8vW7kHj6QAMLBFY1os2Sm0zrmltM3Mm/7A1aGum1NEAtHvJ9JZIvGG?=
 =?us-ascii?Q?pnEJVzzd7VxpheWxaNuLuVIKQjMEJe6z9V/CNUj7pgp++7jf4Ayd2g5Z7Ytq?=
 =?us-ascii?Q?D3AkBh51IkA9Ri7SNf/fNi9FwQFbolGJuva44aHfNoXWqMpp5mZHS3hWkaZU?=
 =?us-ascii?Q?mOhWFFryJEAA7Q2MJFfb5RRiXuIIU6bzLVTZl5mGQLvaXc1qxOwfbabjGMje?=
 =?us-ascii?Q?CLddwxEQi6NJVmMNHQTXBU47+fFH0YjNShp5PPdj6eizsgtPdRhnnsNYRpTm?=
 =?us-ascii?Q?cdsSMJaZy4O+Ibb1lbd9Cm5xvYVqhpDi9nzODf61oimKRDnyBTEFci+Z2xY8?=
 =?us-ascii?Q?2qFnVlj96FKOPq5dMH3qUnxzQQHSE2AhuoO4p4ZscaGLnBst/Gvp+7sXS1bA?=
 =?us-ascii?Q?vfCatDdAyyYD580h8gNf8xMNEwORcuUakmMgVgpbi3gri0qNIW0jh54bVGJA?=
 =?us-ascii?Q?Rp+dcwMjqnOOCEvWPI0FOPPxfitffFVAKw0BMuKmfKcw+j+v8xWGCR5UR5mY?=
 =?us-ascii?Q?Vx1qk+uF98VX/NszjOxnAbTKkfVCdSXOpWdv3ww9jSNR2gViGiK/CcFxuZGf?=
 =?us-ascii?Q?6GWbLNAnBlH4SNyQYv9dvCKJTK2SddWIPp727vgyDA7BUN8uI3eu5lrxjbt3?=
 =?us-ascii?Q?3fQCmROiha6eNr77+EVMTcuhuQLiNZVmZDPJDkeaTnf50qbIbhgp1JCf6eMP?=
 =?us-ascii?Q?VjYhXrXRhD6kgKwI38AMyG/23HdrpwrcGnXbLWcvA04S2+x+58eVtvrFmdFP?=
 =?us-ascii?Q?1C53G+sXrydYxzuFA7gU/iHdP1QFvuGPfV082mcnFGxSXET5To0864ihz3yj?=
 =?us-ascii?Q?F93boDNorwSzaKHgrO5RC5VhvZGb0ZdUcVtUlWMKtfUDPwkbW+DCiys+cHWD?=
 =?us-ascii?Q?1mCwlFVMOLeWb+naWwETboeFq5UadXiv4pko4g0IJkKh6d1c2vzp1kdDLjPW?=
 =?us-ascii?Q?hm42TGaXdFutHmShegoCWg9ghz/kaks+wzR2k5Nsz3fEF90zGO52m08UMjaD?=
 =?us-ascii?Q?5AO+77nYpZI1mQCPlziSAUHMzoBOjv1+gu4YpEqL3wcvNAsy0fB38e4KEVwh?=
 =?us-ascii?Q?1k4E/+NywaLvyDCP8ICoAT4V6gqE2KSJsYzYJ8xNaKhuKPYqbYbKxc1m7LC6?=
 =?us-ascii?Q?xuBg4/TcjmmKf9rAo22S7j6ojiLg/8ZmBNnuQwGm4V1renHip5Swo+y6L83u?=
 =?us-ascii?Q?kFRJHy86pBmcTaQ9i1MQtXVWcv+eph/+q/oL0HUbmoeGkUll3CcpKuArNE4n?=
 =?us-ascii?Q?QqIQe8alrqexJYjOb/fLRJhiB9w5Z0juZJKDRLGslFFMCW29UL0hYt9xOU6g?=
 =?us-ascii?Q?cofgiEJ9B/bV+vqD5hg1hjRHRBJwqKXo5SPb2yiO5T8CVa5Zp+rhf4O32gHP?=
 =?us-ascii?Q?ISxpRyI4ilxqLrr1QALtNMd0nDidT/k5qDVM6nh0hjLdpiKMd49LW/+tFCCk?=
 =?us-ascii?Q?txhJmCQFiHZFroP/uJOxiphribnaIe2G9Xr1uxJ1O24TyVXKi9CpzlFq5z8U?=
 =?us-ascii?Q?KtNGEUpiX3eV+0cITXOi41JjktNc7iiDmxQKR2tXzinodyrOUhBzUDWr9vfM?=
 =?us-ascii?Q?eOF5KSng5u6AOs1/u0HSKPxyDuiLYpf1q81ijHw9dVkmQ/FyhK5i+ghW6YCg?=
 =?us-ascii?Q?cRafkSVBCzBqr5RmV2GiHMth+LqaaaJcT3zxlF4lErMtDfewhFIi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b5efa3-da1b-4ecf-57d6-08df465cab76
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:46:34.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJYxJYAJuHh4s28NoprzPFkLTIqCKu+qrQHSNBkOdfb9gsN4LsjhZT1OkyGZrj3+qYAUUx45E9SsiKOFXsgenA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857

On Thu, Nov 19, 2026 at 11:43:40AM +0530, Shrikanth Hegde wrote:
> Hi Yury.
> 
> On 11/14/26 12:12 AM, Yury Norov wrote:
> > Offlining the last preferred CPU leaves cpu_preferred_mask empty. Normal
> > fair load balancing stops, potentially leaving CPUs idle while having
> > queued tasks.
> > 
> > Currently, steal governor is the only module that may modify the mask,
> > so it takes care of it by resetting the mask to mirror the active cpumask.
> > 
> > The design allows alternative preferred cpumask managers; relying on
> > loadable modules to maintain consistency of the core data structure
> > is not worthwhile in general.
> > 
> > Restore all remaining active CPUs as preferred in sched_cpu_deactivate()
> > path, without relying on the steal governor to recover.
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >   kernel/sched/core.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 175b52a7ea79..b5c158c4efad 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8723,6 +8723,14 @@ int sched_cpu_deactivate(unsigned int cpu)
> >   	set_cpu_active(cpu, false);
> > +#ifdef CONFIG_PREFERRED_CPU
> > +	if (cpumask_empty(cpu_preferred_mask)) {
> > +		pr_notice("sched: last preferred CPU%u offlined; make all active CPUs preferred\n",
> > +			  cpu);
> 
> pr_warn instead?

Warning implies something unexpected or undesirable that might need
user investigation. Notice is something noteworthy but otherwise
normal.

From the scheduler perspective, this is completely recoverable
situation, and the message is exactly about it. Nothing to warn about.

Thanks,
Yury
 
> > +		reset_preferred_cpumask();
> > +	}
> > +#endif
> > +
> >   	/*
> >   	 * From this point forward, this CPU will refuse to run any task that
> >   	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively

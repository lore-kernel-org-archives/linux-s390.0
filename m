Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107097;
	b=qy2lZyhlc9luhPPvhBdx+CnA6WPjW97x88dc6Edk+If0CxnJrmqWuZf4zoRP3pu3rWLI
	 8d83WkTV6XiojHkoAMEtx3fR8cO4dzi8Tp3KrLxWhKYCzSjc0qWRbCaUUS3/iux/HTCoE
	 o/gCj/Oc7C6WxlhGgCFctpqnsJ5ojG3A7Ppy6fdrG+xNYyzziuGmPd661IdJjZGX1Sx8H
	 HaSUUFuwPN3W/Oj7fRQPPPxAq5SmScardAGNZhUSLD8zJOOxwKo/EWNQOp68PQsI6+tPa
	 xx5AKNXfJI485vtCzoglj8GeQCWth1W40mE85gZfIoeba1brtNtkcugz/K/V+da0AHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107097;
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
	bh=AJk7k3vniF7F/iGu1Eg/aQQnaczaIWxQrKUdLixfHkM=;
	b=268hkG8N1BCJMV2gNM06C1NTZ7988PbwjOp3xFBNHxGuwntPTJA3Jk3bFVzSXFLWhR28
	 wQeCfspY3z7Pe8cQx+rFhARPF6j+RukYpswbNykOioLcs0D7Rl7l0Dk2P2ko+GJ3vL/iP
	 rjkuOKHyoG1Wsd6XqyFT3gdVJJlUeG1KrG8kh8Z1IDpu+FAGPLfX1akPkIHT+nf3N0OdR
	 4mZb9+Vm1GoM161p36bTC2UWOcd1w9FJxUuQONKxANe5IpmFtZUTKD+bTMJo1mZJoNo8H
	 ApO8Mop4E4WAK3KArw0xwBqAFezAWe6aOlBDHKjxE24LTEoviku5TMwQgOmdIlEkKdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mqKH2YGT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.61
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E50606A324;
	Thu, 19 Nov 2026 16:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E50606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mqKH2YGT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEfVL+uBmcPBhXBBV9EnSK3FZW+XBFD+8BnOkqv6XdDybh9xKUYJe4NPQoq4+bBIH54syj6qk8RljcfkhY0VPwxZKcLygj7BkaL+rxzXjSjF3igabYygc6Vw3SNz854zZ9TsUWClQfLmzu0dkPxzqn6E3euGDRhrC4ZRZCtGXYdAIQmWALmyn+Gote7bpE3+y9pjxBg4uP0yY3qhdOx/y/+QB9FZarNa2U/Q46Lpo6Xx6wGk5tqbl/IjJf9nH62bfBEmcdDez7rx+dEqquyTJ8+/6xvj/aGC+YIFfEx6NQF9Bbd+KEPIispfQEo6vRmussWTDdgpHlI7t563BLAabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJk7k3vniF7F/iGu1Eg/aQQnaczaIWxQrKUdLixfHkM=;
 b=Fp+jSp2+6U4ldJqVZ3ohlm9dFI5orNx300DTSS7HtJOanw17dQg5GD7U09qF5YWVF+KF7yOeRgKP/qUVN514IuI8KCpPrK6oGKrr1Ee2fL4uawuRvlbcLfWOsYw58zgf8HmBbZNVjkvURVTCtG04ZOtRj2dYD0UebxCKX3ka7Di4Krp6eRzJ2kkVJn266F/0Y7eSQOMtQaRcD9sljRXOwLZ10aum1eFSKSTR3qQY8Yu6aUH59pf/XhNzue3Og+9DBsitHegrIghrgpRlM+Vs1rbm/3MGYzhYdoqAn65FFN4WeEuuQnuKnXPhkwfn9fgm2E6znFHyaQTHFzG7PUsmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJk7k3vniF7F/iGu1Eg/aQQnaczaIWxQrKUdLixfHkM=;
 b=mqKH2YGTE1pKdCMn29p2FqpOTO8vSgrFCszmgmrIgbtkLo41A4z5/veVRn/jyVBv7SzhoubUOzbzWh/FAquzFaEQVN36TqzxqqgRADs5Up9ZjL9xcUAcN3JKyLIQHm4VrryACF/UhiZ80buCWiaZN0VqIzWAhMRkfZ0ASUpHMrYIpSnETV9y8kvkvgLmI7x8tkg7F+okwCIYl0/pP2ESf9vvjRm2UxGwnWO8l8s7U/t7cftS3eiNyk7BjEN+OYYTSGrrWNq/PGQHK5wxpCkeFSAYjT0lvQf2AmxQpAJgtd7kGD03Iah7p2CcUCt7Q/Y5y4egAj2/WSHnz8RFDS+GbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA1PR12MB363945.namprd12.prod.outlook.com (2603:10b6:208:5b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:50:23 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 16:50:22 +0000
Date: Thu, 19 Nov 2026 11:50:19 -0500
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
Subject: Re: [PATCH 4/7] virt: steal_governor: serialize sampling against CPU
 hotplug
Message-ID: <av8oy9v9eLTL0dw8@yury>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-5-ynorov@nvidia.com>
 <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com>
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA1PR12MB363945:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d8dc3e-67b7-4599-ff0c-08df465d33d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|56012099006|261022105027099003|4143699003|11063799006|261026140227099003|10067099003|261022075727099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Ybg7RO+b6x0AKWbUn+gXWYaNiVw7c4tlelV1VZCuvNkbL9sUKMKZIQTg5lfUWpoBTqG/K8qGnB7+91Vi5R9rDoLxgnGZj4Sa8v3PRiy7xsacd4lCOOIdbUNjvatAV9C9OhTyR6gj70JE+1it0uhQCr97EfqnNPMLYM7vQXYU0zxTDOfUUAemvvN3zcwvcNmYDCawfhHS2N3iCJVyfLALdYYSUMU7y6sv4CpDFctTg5mxSi9AKw7f0tCVlFyD4XTGX7wC9ihFq5l4LfT9lgu6zkBdmPZZy6+Qgv7GTcXkZq6s99S9lCd0+JGqFCQvt5Ji24WZBNcxyigx7vp806r6lRQHAbLGHbYUzglSExxCO0JyvvOgAX6Ru0KZN0p2AYxikhUiaH+UaXC4nujPB9zo0Y8YYyuZpPaIeCpWpoMtU+IMRHdMUNmXziTNg014zfwZJD+fX/Svpy7Cj4MEws+dhPDbqeFuX4lsDjI1Tr5IENnXtQ7fXizh/+El3mk13GoZv6lvRcuhmr9IYSQqmpb76yu3abW9wjMIdtVfrrMOUfBgT99Z1XXaD+TMFFDX12N8vF8OGidpXZ1KTMi4WJEitEHhIGt0mBS4gQRv0AHib0IN0hrV5O6NkkopH0Y9wN/CnbFB/nPEMGhOeKPqGVeq9eluCUKrQ/vL3qOKES2Ag8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(261022105027099003)(4143699003)(11063799006)(261026140227099003)(10067099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnNyWf8MYFZbDP3F9SJTc2MDkL/yD4Is6tGHGUS0CtcYzqeZZdOXjnvs5i06?=
 =?us-ascii?Q?lXS4W/MRXOJQsg8jKwaARqJo12o82zefyy8ZienKLz3eZ2BXytBV7+KVztZo?=
 =?us-ascii?Q?anFKQr5NUNKHbfgMfjdHe0JOIxY0Mt7ukpziy+VfKkXCCH3aKaSK7/0rcrE/?=
 =?us-ascii?Q?+iU6Pv1GtVIdVYW8TXdfE4mVOWO31e65E8ptH0jzff7jieABeLrRIjp926iZ?=
 =?us-ascii?Q?o+jEHNMJSTReIfeTTUPt6oaZOOKDIrYUPaSC0/MvV+JWPyxooaz6No3pcKei?=
 =?us-ascii?Q?VqXhfmCk2cmB+BDy8XDV6RRE8ai5W5ERI2lsC1s+b6G0SAEnEk5tDrhLujT8?=
 =?us-ascii?Q?IIz9caN7WjRqW07rGEUFuV1JDrhNWf3eyIDQ9pNZIKd4s7Xrq8k3wzuivSXG?=
 =?us-ascii?Q?tf63bf/PwZLn1KxvKRfyMH4MIOTyhEjk11wTGW9zfhVKIDf/p4Q8yFaovt/8?=
 =?us-ascii?Q?jUYeSr9aidyhsHBrFF+T0BfBWog+wMRdVmH+GYBCgAhAV2HG7KsHM4IJuf6d?=
 =?us-ascii?Q?Ypg1vObVtJBLv/lh6xRyH6y8iqYIpn+DT3K7rNPSsyODM29EVgPGCg0BPK2W?=
 =?us-ascii?Q?J1x/ib9mLqWjVTPiBP/OMGH1md9cmZA4sPndAeQrfZqPWEvOfnLvgDc8bSMu?=
 =?us-ascii?Q?49rW1OY9A4LshTfr7SbWf0mubwUcm+ed7g9osfPCoFycaJvnvJ3kCCIPCszl?=
 =?us-ascii?Q?h/0CQ6DPg/tH7xzNBQ6RUkoMlTFbePZocNrS2RypVUQuA7VEp/4QR8d0W9r1?=
 =?us-ascii?Q?FU7LLLYPVeDYg/znb+zq5A7t/7+4WMYKZlJ/ZqznuVB4Zieh75bN1AY0yMQc?=
 =?us-ascii?Q?RBqto+tZpvkQRC7dbblTB9x4DYIFPR6Gb5WUXUKWmNOOJY8c8cKiPlIPzNnR?=
 =?us-ascii?Q?+DKsI2yFDUv4whX4o0rX/A7m3AWQXmjg7mrUoFwpzh+/9sK9gUkwDenfigZN?=
 =?us-ascii?Q?cFdB9DBdCZFteeYFDLJGlcp/mLvFhdSYlhxBAZojQ2E91TE+Urz6eAnZSvLR?=
 =?us-ascii?Q?uU9nL4KogHRDzIx+oxDQeo3kTtaHqowPYHUmAz6JqypMK+27/cA22HKHlmq8?=
 =?us-ascii?Q?GFA5XFtnBeZeNJ7m00Cbh0fw6NfanaG+jB5tAM06qES5/Pk4vwiRKw6BJVkt?=
 =?us-ascii?Q?/pYSILCP0G4h+hfTuHDxUAef3L7RAqeMh7k/Ujg773mxyEzx/iQ8Fr+i6oPe?=
 =?us-ascii?Q?Rd+id8T3Pf2EXq36wk9SD93DDaLgZwKtsGf3II81fdUTfscEi8ynV5vgyqB2?=
 =?us-ascii?Q?/RJON9pBC1dzh0aOuoeFiG1OrPTOsbB4BlPUsgEONkQQOHhTzyK51hYN2efX?=
 =?us-ascii?Q?2o9PIvvcps8aN0i+0zZQ+Wk9NvAwbq9qeics7dcZYv/uBEVPduyYecx69hG3?=
 =?us-ascii?Q?ssM8lgQ764lQ9RYOWp/CH3njpp8sJ+sCZcLXlIrJwA/1tqu7R2B1EcVghALx?=
 =?us-ascii?Q?nCx3TQFLGfon5F0LG4glSWbyqFtK7J7EyFZPDHWcZgrXHTpUkUnJfepvJDEK?=
 =?us-ascii?Q?+8tDQuvpoDy3F6QTsl4Ymh96+JE8dxgefYBPWTo9B23ZaKhHdLh8NoVed7VN?=
 =?us-ascii?Q?VJmyX++GcMNaCYxDCh1ypRcb4rSzPzKNX+W415y+nLh3iTBXGd1fdPGvrEFT?=
 =?us-ascii?Q?J3PS8t7RABJ13TXF8s+f7lcS6LJI4BdJCr7ZJpFvX+Ea69mWEytJc3hO/tTn?=
 =?us-ascii?Q?ZI4ZqHLBP9LwL96zC0/NoNBYyoKlNmldMnwXMaWTB5jpy5cWhLkYPSO02dcG?=
 =?us-ascii?Q?PW7YdAe8pf98PPvpTqbFy+RUZI7VjetCh+r5RH9G+PQ0l0k3SRji?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d8dc3e-67b7-4599-ff0c-08df465d33d4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:50:22.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EZyuWCxf0VVIYLzij/06HW5n9lIH6fZZRNCqmcu5ip2TFMzSpZJLxvwWQ+NycPC0TUeGBwFwWG4aJFzbQgB9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB363945

On Thu, Nov 19, 2026 at 11:52:19AM +0530, Shrikanth Hegde wrote:
> 
> 
> On 11/14/26 12:12 AM, Yury Norov wrote:
> > Steal governor is not safe against a concurrent CPU hotplug operation
> > because it can change active and preferred cpumasks during the governor
> > sampling.
> > 
> > To address the race, the governor would take the cpus_write_lock(). But
> > that may be impractical for the loadable module.
> > 
> > Instead, implement the following locking policy:
> > 
> >   - if the code takes cpus_write_lock(), it's enough to write-access
> >     the preferred cpumask;
> >   - if the code takes cpus_read_lock(), it must also take
> >     cpu_preferred_mutex in order to modify the preferred mask.
> > 
> > The core scheduler and hotplug paths already modify the preferred cpumask
> > under the cpus_write_lock(), so no change in core logic is required.
> > 
> > This provides a common update protocol for multiple policy drivers
> > without requiring writers to take the broader CPU hotplug write lock.
> > 
> 
> This is also necessary if there are multiple writers outside of core hotplug No?
> So should it go with the write interface series?

The race is real, and it's already there, so this is the fix for an
existing functionality.
 
> > Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>

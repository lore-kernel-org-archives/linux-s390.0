Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418872;
	b=t120q2Kv/yN66CR9EL4mea+R68NQJPjyLpYESsaEu+bcnwOjDpAomzLflnbXlJeAhm6O
	 AIMg3BbIg8wQIK2jE598i5ePyuFhV1/wIj1zzvqqSxeojdnJNzy+7O11WDEQ2AQtKFdtt
	 76eCObdCe6ozEfWSB32RBt69/xJzCYTRKl3I6XG3+GJuqLvjhTGFEzvXVl27PARlxqBTR
	 R8vzwryNr/d04cNEM2Cs2AAB8afHFkGxwgtoUTdLXliKC75auiUG19f8xze6cd0DwqDsu
	 4eZh3ig/aGMqXjl2YDCd7++I+OvHqty+Jyg8tnJ6v2GiE7KaVABenIogVxKlDQPMXtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418872;
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
	bh=AoDAWUeKH5UYii991R+L39AFNbEQdlozCDVJjUr085M=;
	b=f1Jge9vq6nt0caNb2jOKtHiscYplsuIhqnCQplixim7LCmFEAxq3N2xg9j68zVsVfCP6
	 jfpfQE4b2saKAdbYBiJeOvGKEXHwsqMTQaLtaL6qBUFsSMYd84bYsGZiCG9akRHZVYVtE
	 QYy9O0nMa8K2P6Kruj3rAtmVomKR6mZIiEsl5r9CfcWiw9ncPqnindD/XA44mZv5f3+xv
	 AicFjQwyQVzIeUnYZZLgiwJ1STsG1K0HWObM09BxIMrsU2X28qx2FD52rMLkQCmhuZ0N8
	 /UQFbswbfKHozZMiBR7ZOOqyZ6lr8yJ5sTh1DTBzu9WpTk9OFsK69tDZpEzPJ3CcLIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kTSvkvcg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.43
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10115606A31C;
	Wed, 11 Nov 2026 17:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10115606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kTSvkvcg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFCsPhmIevLIBGGonCsQlUwCMBFymlwi9N7Vsgqj901KOqU/B6SfPypL7beOa17BphbuNTmgAx4IKt7ZEPuYwnYmAXhB+T21EXaxCX8K3aCRSZD2Vn9LeXsluzT8EyFL6FTzZHw6sd2RIUUoiaLjbIKG4jGsAhqNSu4D3bM8OgjyvHJERP+HG5fdtu0Pl2D4H4S/CX/KYGpGDs5y+QhKU+pvD7sBIgzS+CJ4gsFURg+s4rEfEB4eZuXYMtZqkojJ1G6sCtcWdzpFRhykfDGuD0+GFxjmhn3oSQUWQUCbukR5coB4m0tGl/L+U3vWz/soKv7gmB7FBEkDnXCphreeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoDAWUeKH5UYii991R+L39AFNbEQdlozCDVJjUr085M=;
 b=bckFtHyk7KwVqGNkcqF2lFCZaXhEX+6QqN58UsTKeryhKKOBB4QmGVYUY6LIp+RoNq8gxFmqw+BvgqXNY6ImhGce2iblpdrzycz61liDpwgNXeCFP6ywncxlernaDUO1dbBEEj1c3ZCBWhynuBULmhH8808Yr47gZRQnL+t2U8anCJqj/2H9LbKltMIP1lEeZqmFnoPmVWQ4SKvnNJxEVvl79w6M2xm0Ez9GyWxIYFqsxyQGpvlDGRbbsUWU+QNLq4eEgIAoyc0xIuWnC7da24EghzLRmjRK7IR5PW+2ApeCHvQKUXr0cGiFixIHDCI67A8rj1TIM4iq8gz0RPrlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoDAWUeKH5UYii991R+L39AFNbEQdlozCDVJjUr085M=;
 b=kTSvkvcgYK9Z79v/TY7ZRU8YibSSep1T0LFObvvmYCaAYHMLs3GjxXs4DIA7RwZAQwkNVy6rnQyE7uyr17Ul1h+tlGTZ6Fdd17iaT5gQMdrbnw+wOvAgRG8GfMuclWrdb1IgIcq7c+L+Nrb+uyBnAR7S56NYeqrYLJXEcTI+KclH8lR7dgADy9odteBAfTQIEdAmLkVX/wW9xsAsCjIW2OcRFy2ax6VWwdBuamMso/9g8gQOuNREvLzjybjCyA34DcX35eWwRNji2kYO8XUYo0KROtgDTVqguiQGdRkpX6SR+phMcDgim8Iodksspr0HahhXIwHlyJPA+lBASVpVpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 17:41:03 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:41:02 +0000
Date: Wed, 11 Nov 2026 12:41:01 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
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
	Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
Message-ID: <avSorfTkB3pZX2ic@yury>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
 <1d1b22ce-fdf1-47ad-99ec-8c9925ea7275@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1b22ce-fdf1-47ad-99ec-8c9925ea7275@linux.ibm.com>
X-ClientProxiedBy: MN0P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::6) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: d440eb62-3baf-41e8-2555-08df401af491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|261028144727099003|56012099006|261026121527099003|261026140227099003|261009223027099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	Vjw6rhXw7rnzUedf4k7L3+VCBrgmW2zVibcHrYH6jxbEkW5Yst6fEBDksan6iYlUa1lZ2V9QiRtgePyxXB5XwD5Mf1CGPb39h8MJbjWEea7Yt1zaUZG0UJdh3rAdrbx7JklES820bqlEo1bdWSfSEs8t/AyBXKXmjrm11zxJMkejy4+WMjlXFhrOWTUK8WoV8kabLfFguqpZ9s1vpmL9nFbJ3CSk/P7usSLWs7r2JBEAR2GEGLsoPaZSK3saUfhoXcHEUuVHJEAzjkFAT05qshWWH4mJxbTpL7RbEkZTXav5HWlM1BkHJFHQbH4Yc73jqbRWPfRzUGxczUdmCmlzImzhq1sUHfapfs0iBC2QScfnuCfdeyPK0jYLoXlTqDeFpzGISgfSVlcZu6C7xkju73rzb9GKaWtmry3SyCZDjmrjXOQd7fNdCAcagZiUOUBrhSPds5Y/5Xp6QBt8FFXhZLLV7o/Ddjl74SNIg9pjvuyw2GVSasefJiokisQ51JqMk8eaPWyAR7+ZrpjxwPiIA7c66XWmYmTjjC3BMgACblq1XL3g8NVnUayZZs4dqRDCAg+kTopVYvmgP1IdyJ3fKSKPLQ4TonI+9uSaYuPUAIuMUKgVT0f1ZJ7W26hi35avmyg9E3zAaBJVHVtZsj7e+iqbn+ncCzNOHEKk1CkNIBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261028144727099003)(56012099006)(261026121527099003)(261026140227099003)(261009223027099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2maS3Shs0MLZw6uNg7Lvk5InQQgY2WSUEfhCnQxXX1Q4O0A/ic2P9wbDuqf?=
 =?us-ascii?Q?p/fTBupyHbpNzlSOkmAoaqCPn9OJgnJ6THD0zRcot4e1Pi9JfMvllxvWAOoS?=
 =?us-ascii?Q?nQbHsOhZX6U7TRfs08hZV+CmTpvLHFMRjQeqO/PfHfidYlepOUraNBgYWs27?=
 =?us-ascii?Q?5OF+OKAKPh0gijtKkXq43Os6gyleQDDW7EP1E8+zjdzeulzYY42d1gV6jPP8?=
 =?us-ascii?Q?0M8LUUqIQyzD/YjcYQ4zADKzAJadENfl/F+kaLmLmZyiAhkQim70pCUsEQxb?=
 =?us-ascii?Q?h3k+DOUl+cyk6Ymv46n/88O6rE12pGomDmjzJX/r6gbkLTrH/s7PUk8hgo8y?=
 =?us-ascii?Q?htE2+Psh4LZTvRm90VOy8/qptmJX23HihAk/V8CdIBWj4F4B98iRN551imUk?=
 =?us-ascii?Q?ZEzmcpOe37rRNPhPbdB9ZDOaJCk0kHwUvSMQkJ3Q0L6Pq/E0BoYM8lFSo3C4?=
 =?us-ascii?Q?iDK9rOOEu9NM4SNTUBh+X/a1zY6WwnGpKhz6a1RKpO/qfdMLcNXNVQWPE+Tz?=
 =?us-ascii?Q?RprCrNDFVu+FsZGglUb7ekYw16xKICyYBHz1kf6wGiVwDA/lkSUwJFGrXX6F?=
 =?us-ascii?Q?UkRcxJ6oZl1QjF8+vIuVVI5GsfBtWK6MR5EsekzmhIMbhL20NDDxuZkbShnF?=
 =?us-ascii?Q?6uK21Pgk3/o9dg1KFfw6aI9Gu5xFuDlldCMHg976TWRu+CT+os1C9m3bfhhZ?=
 =?us-ascii?Q?GwDvQUIf1ct60+93QIJ59H87jLq9PcT5zcb4fp2D6N4MD3AlktGMqrZkimhx?=
 =?us-ascii?Q?LuHaWWm0kGVbbdV8ZtmRBfp3d/BgFTjBdKIjT9OVTuR7hCq3eHomPOhNu/wd?=
 =?us-ascii?Q?kFAWu0vQpfC+r/BDn5RX13D5QbN3rTWKPPxnBXE6ePDBM2V8kJtR8HTt7FtQ?=
 =?us-ascii?Q?/ZMtIuMI0TbFDk60iI5VZwrtNhf3y5DqQTlgX24MO5x/XBAYYhCRFs0hOvl8?=
 =?us-ascii?Q?uflCRn4hP+rYzqje03RhknabFxx6UBEyAAjBjM5198SbhmIxhRil5KlERvg1?=
 =?us-ascii?Q?4SgMpgJEB1k9c5UQF+oGDg09yTFiZJHDvJrwMwFexaBWYvYCCT6c6d8A1XU7?=
 =?us-ascii?Q?6xdfMLelInkhMsSN2M5BlwPwWAgiqtzZbpL7qvnIUEwuuEMKtE/rkwfJaydk?=
 =?us-ascii?Q?Axy7LF9QdngxZmC18C6OJkKagELLYF9dTyIjY2bZF4BVZQysVAvZc19FYM2p?=
 =?us-ascii?Q?KGua+dTLUzn92T7q5EAb2Nt1Us9KhTTm+i6PbiTx2J4+9rwFUgiPCu+AUelh?=
 =?us-ascii?Q?Ji6bJXP5PLAb4VZEIOpqqLmci/PfAv1HD9uwgjjsTCoZ4izEvo71ZE8I4JYB?=
 =?us-ascii?Q?KGrbDsboukE2/lc0bQEXmLG0OsiE2JdzpJhLTQ6n917zCE0vr4rI6v23+e8U?=
 =?us-ascii?Q?pt7+Unrba3udF5Kvmpq52h8QjDapaqrzkbCjBMZWyfbXdOwrPtvRTJ7hTrbs?=
 =?us-ascii?Q?pY38+39WKjes6uAx6za+ogiuMNmOwHfb8mpXVFmesMlemEhMNPXxPlTz8L45?=
 =?us-ascii?Q?aKIowludQyz08dGD9kcA++o+m0oHAcfCsHIG4OfsSmnN6B5nqx77WaOmJy6T?=
 =?us-ascii?Q?wabEU5nbELgh1g3FbO1uaaHWtxyFFenpQkAU/su1ZgDRW8foShgcuspXAOz4?=
 =?us-ascii?Q?NyLtutku6ibgVWFSMGG2XaZ7DFfU5UgZauILMxHe/GX2JRdQSJnthukn7qIS?=
 =?us-ascii?Q?mcjeLNRwH881q1TcVkXwyJX2febTK2xGZY5E7A6WTdw0bfqavLLBoafYU8RE?=
 =?us-ascii?Q?TOyV6Zs7kIkL+0chLwGZdK4W8IOziY5ZG3Vzv9IJtl3/LEH4Xsks?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d440eb62-3baf-41e8-2555-08df401af491
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:41:02.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wj4HFocGFDKEzZAhIOVfiJwPfEyzOA+Qlmj1R2Te7PRiZqdfTnv+yB4U42KUlX1SUdbVk9wwLeP2C+3w8BSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6

On Tue, Nov 10, 2026 at 02:45:58PM +0530, Shrikanth Hegde wrote:
> Hi,
> 
> On 11/10/26 8:45 AM, Maxim Kuvyrkov wrote:
> > > On Nov 2, 2026, at 08:21, Yury Norov <ynorov@nvidia.com> wrote:
> > > 
> > > The preferred CPU mask currently lets the steal governor reduce vCPU
> > > demand when physical CPUs are contended. This series adds manual control,
> > > opening more use cases.
> > > 
> > > For example, setting CPUs aside for selected fair tasks at runtime while
> > > steering other fair tasks toward the remaining CPUs.
> > 
> > Hi Yury,
> > 
> > I've been trying to do this with crutches in user-space for a long time.  Thanks for implementing this in the kernel, and with a convenient user interface.
> > 
> > > 
> > > A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
> > > whose affinity includes preferred CPUs are steered away, while tasks
> > > whose allowed CPUs contain no preferred CPU can still run there. The CPU
> > > stays online, task affinity is preserved, and the selection can be
> > > reversed without rebooting:
> > > 
> > >     # rmmod steal_governor
> > >     # echo 0 > /sys/devices/system/cpu/cpu3/preferred
> > >     # taskset -c 3 ./my_workload
> > >     # echo 1 > /sys/devices/system/cpu/cpu3/preferred
> > 
> > My use-case (being a compiler optimization engineer) is to pin benchmarks to specific cores, and stop the system from using those cores even when the cores are idle.  This prevents L1/L2 cache pollution and makes performance numbers more stable.
> > 
> 
> Do you change it when running workload based on any signal/event? or you set it before starting it?
> 
> If it is set before starting, you might as well offline the CPUs to achieve the same. I assume you are
> managing the preferred CPUs manually with write interface. You can do the same for online state.
> (Though it takes a longer)

How that? I tried, and offlining destroys the affinity, as it should:

  # taskset -c 3 sh -c 'while :; do :; done' &
  [1] 380
  # taskset -pc "$pid"
  pid 380's current affinity list: 3
  # echo 0 >/sys/devices/system/cpu/cpu3/online
  [  115.767634] process 380 (sh) no longer affine to cpu3
  [  115.772881] smpboot: CPU 3 is now offline
  taskset -pc 380
  pid 380's current affinity list: 0-2,4-7

Did you mean something else, maybe?

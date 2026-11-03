Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793724554;
	b=j4Bd2sJc3AQLv5gNBNyqTU9AjwEM2H7QlF2cC5zvBKvLbT3sGndSKqZO9s8+r2jXUunq
	 2/XErzNfcccB1VY6teoLzJ2NKoeevJ5oWbQ/tnHTuk09YCtvlQ2pvfsCJ75V91oXcXVXr
	 A8dvYaaJYvxaOjA7QSPwEnLgZN18S0dV56MTTEAwkVvsN3DjwebPCJTaBRFcXOz3W6bCN
	 UVzCyzDheIoqx0RfOyHIK/jEb1/e4dBwS8GzHUrwn4+5tM78jgMfQGLUbDNwI4pc4R1Nz
	 TljvsrBSZw4n7OaP1SIjb1ZoWqht9TsE9qExkiMExxQD49WKB8F9QgYKoFF7dT+5UiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724554;
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
	bh=2SjriM5Ft1OJ4vP4Azv/JbwDOxIimZIjo4YeuW1ymvQ=;
	b=fmBNAroL2e+KuD6c1smhk14CUpt58ywuz6u+kXwecBsNyxkPv3QQIohV3styZvv4zC6Y
	 pSS0SD7cHdDSLdQTyp41gYOGF3Her5ZoaFrJrdhqMeC/E4XqYUqXGn80wohG8WoOmk3be
	 8EooM29bowMjHUyF0vO1/JX76smuO9iX1QnlpIb6AnfNaw4JwA3tx4paf+Z0US8A/Bvbq
	 EnSTprKj0jFFcTO7jnJdEKKmDi8pcQ51p8DKWoWzvmgXGUJke2tL4ACcwfC6nenewf+jq
	 HM9HdHMAuLwY4EcKaa/1TrjM+LEA6HinuVr5PURF4v25gbW82O7aBJ3KCyH3/Me87Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Xu4oWslE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F2606A32C;
	Tue,  3 Nov 2026 16:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673F2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Xu4oWslE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQT5Gy72zRbqxFxMaN1LIKKUPuP91FxRkzJmO+65f5cmz3V/2xGNonGhcyTCtty5lB6+CmpV7GFbXCBnLG/eOSfKwse45D+CJkYXihuAIH6J2+l2JJIVftr+/P9Zdv0qRMsl0cPCM0vO+KvLbMjbdIt5b+IbdaCvk9xTXsc0cc1STmvstA8OECY31V0AMMiwSbJjxJ+un4rd9BGs7MuWl2NeQNkOE5Xw5sfrCxA1oKdcplQ5enJCiwOsgNoaxnXSaopbBLcKX5hQGdYEgpAKnpL0NGmIvW6ETtxdc6BInEy4BX4P8KCBZWcROYf4w20BdxLXt0G8yY5IE4CarVTMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SjriM5Ft1OJ4vP4Azv/JbwDOxIimZIjo4YeuW1ymvQ=;
 b=r60SgJgHB4PlRJkTx7MhnYlPk6hDb839B+R7xHumi2WxDj24GONoO8c+WpciDaxDNLQTGv4B8ZkBHFgXwRqV895/qwKpzufLWYo9tN80A26zZSIkP8d3AHovVQcxSdGgPvESdVHW0ST0vAdcMexkiDtukkiQ07sxVy5gRgZcOBjb1ahX/eNiVD11jGi5BsWGf4IDuUJW5KQNnMubPB1ymsRV/Qo87tjIJeRnkroihPE8NAc2XkYU08AvjTh4dy3zE8fKys8aOaLzrQ94GVAruB7o/8c5IdiFpbChzyTII3slL04DTZfNYsP13RZt9Dv4zluxx/QM1iIokm8xNW13hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SjriM5Ft1OJ4vP4Azv/JbwDOxIimZIjo4YeuW1ymvQ=;
 b=Xu4oWslE22EwbgxbfRPnafhEbJgaAv6Wqug9IGz6ewmM6Lg6QC4cQLfQccyOQplrFR//sBRHlHDyEszrAIRdISAn4siwSZM5piZXp7a021n6Cxpm18mTErkYamZa6MTvrCB9bG5VnxvspAHhJGvnsXf6GHR3pJsVGzRrfcprbwUjh12+eGZ7dZ4501Z5qFDD9+/eRjFoJQJXVHgMZhLbaLynIz31Z/J4ZJmxmV0cj62X+2BHg/n5mhTCj0Za8O+ay/PcMAWJh7hcqXj0YJwYtL//KgS5IvTN3213keDMfMZTvvLyBtzjTeO93JGam6j/D2PyKrAc8q9fdo82jCTDwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:49:04 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 16:49:04 +0000
Date: Tue, 3 Nov 2026 11:49:02 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
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
Message-ID: <auoQfjpg3CRvV5yG@yury>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261102084704.GQ1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102084704.GQ1779021@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BN9PR03CA0895.namprd03.prod.outlook.com
 (2603:10b6:408:13c::30) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a78dddd-a216-4cf3-fa4a-08df39ca5e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|23010399003|1800799024|366016|3023799007|10067099003|22082099003|18002099003|261102123227099003|56012099006|4143699003|5023799004|11063799006|261022075727099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	B4ebKSrdSCQ5vc5bibu4xdtv0YpjtTAIVfLsUBilyOh0Gnb+Lltkvmz4/AqyVzfrwQjkENjZPsFTr735x5Q4m6TCgR9TIOv9fAbRoQMBPE4iD1Nn8lkgXrXkSYVsWpoDha35tjmmMTAlp7dIddSJGjgX/G+0LN0sXdtb5nCHVK8z6OLhqBeQzdlW+waDP+JfA62hEEVKJZiP3R9YDr+/neJJh+87sutkgzzw1b+2x661S7srI1W7mAD+xoCPoYujrzeszsRTkYL8hO62jRn7exHCHOnlydvEGL/bcmsnJ/dXF0/SoZnTP4bxkY9Jc3B72j8TApSgjd2pdSa5JIkr80N9vs2QpX0XfOR46dOv0Jm8sTEEQUay++wowQkav+OQGZBYgvvYaF81Q4cwcsTNuQj5AAJucz8G303T5v6xgeQpVTWFRhnIoCIVnLtlcrE2fJtEigLBziiabCHG5iC+VHw7NFrfOFpiagMYR1zZVlNRlqSANCHfDCmp/61svKPKOHXScuErru079UbPd2pPUWbbOY424iiKfGuoCS73OcvP/QDXFAt8+BQ0QsTI4Z3JTEb9mRJ2rVpuMb6ECyxu3J49UdlOE/APJ/bHma+gl4q/fSb6EL6eJDYpxashiJ9XdAJZG8Iwi3CcdkZpzGtShZMCPPF+Ur9/2oAssg0RTNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(23010399003)(1800799024)(366016)(3023799007)(10067099003)(22082099003)(18002099003)(261102123227099003)(56012099006)(4143699003)(5023799004)(11063799006)(261022075727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01lR2o1x+E18aqfxn5y/rk4yDe8FYhsZFk/g7uY6zU8g42foz0w+eLPSj8Cw?=
 =?us-ascii?Q?VTkyMolbUUojalt+Z8ITySciknTuBh7hhijysQXaaiOY4vPt78n/bSVFjIh1?=
 =?us-ascii?Q?ATPz9nCpN/UI9n3ad09p29WI5hpAGGGzIYAZ6qS1WwvhDqKIAOP2y5h7q2Vq?=
 =?us-ascii?Q?qsxAjS1aBpWE632cRJ6OVZuNdEGHXL13kWjyKHOLOj3FipEk9pbP8EsIttjj?=
 =?us-ascii?Q?5FpIZWf402tkAbN/UEZLRZdqa/yFF0yIxaVbmPu2RpM5A8vFQwI6Cy0x/iXx?=
 =?us-ascii?Q?mvbuGaRhMOh1i6ZzGQKLHWAdDicfWU54ai+ouh2DmvGfSe9yp2Kh2M5Gxj+N?=
 =?us-ascii?Q?s4mLKVWB7C2vE3Eij21stz+78/cWHx1T0Us/KZgcFEwq3sziX5Mj40mJI+md?=
 =?us-ascii?Q?pjrU6ubW7OkFqtjcymP2/sYK44Etw0xYOJD4jrliS4xFDnivNgfKL8CpjDNV?=
 =?us-ascii?Q?iN5iIFfyWNy6NfDg8mEIgFmFwgx4qu4Ee5ZxGbKPai2c24SDBCJQ7HtzZNJn?=
 =?us-ascii?Q?uir2cXaRoq25WF1EC9zrCg4jqURfK7cBT3+eo4vD974gqLCJAlkqDuGAmWgO?=
 =?us-ascii?Q?8eS4KkuAu/AhDGZ0eQ5EgXxdGUCODV3l5Smp1rOeMH0ck47A427LfFO8sFm4?=
 =?us-ascii?Q?G9B1Xw469SoChmA3mOoPn8+0J58jjGwTuKKot+8S6AcJ0bmde3PRriA8DD0q?=
 =?us-ascii?Q?XKaqzVsEtgC60kmddZmJRLybBnnQY1GaM8pICUwzLvLwxXXkt9DABZQgy+nj?=
 =?us-ascii?Q?eqmkx6I6JdmhlWmbw3rxrIp3mfsXDJjcOZ5V7XtofkpbWxtQDmilsmej5eZw?=
 =?us-ascii?Q?caazOKmZJ90dTJ1w/6iTyTKFRoF9NeTqIMMVfF4Zrztgh9HK4bVyyDZ3i0IR?=
 =?us-ascii?Q?MUNtJFdHrhn7j/LqWh7VkdrEzjADgzQhwv5ZdqEmu7EGTGUyX8TmScOng4dv?=
 =?us-ascii?Q?CTDicj8Dd9qF254RWA1oVWP10vOOS4gIpHorYK8oLLwbjYojA9PCdqQw9Sg+?=
 =?us-ascii?Q?kXeB+rXOlIfEI7YW9rorW6UVp1sNUzKrEVtlKIcsi2K9yYApn1dpVzEeDQXD?=
 =?us-ascii?Q?6pYfyrC7nyOOtl16QKxAon60MeCcY+10WScuLuOrY2LlE9eSwt7SKdFBRYHu?=
 =?us-ascii?Q?F8PbIXGRcseJ2jPiJvKnTDon+D8IBaAtgSH7uyAwiUdoXolbNvXsxdPQBvB9?=
 =?us-ascii?Q?HiEt52HbVUBYNsq9WtBfjK8xN1zPjni/aKA+IS/qz7f8kUeC2QZ/3SeiJYsa?=
 =?us-ascii?Q?RUx/BD5NGpJKa15SLgjkXTp7V7SilIHxQwuCtjknkxj47P7kchKSSWidQ5+0?=
 =?us-ascii?Q?3FqA6iNwiizEOpPYBDsWhUA077w0TDst6PHmzImvrChHkyC6eVZeLFhtg7pw?=
 =?us-ascii?Q?3eJKtVA5pOZPDucXxRhcxdglKp6aQUCfQ/dSXSuvUQT8+YSllLdvXMNKeNv6?=
 =?us-ascii?Q?U0C1rNF2QI5S8VSgA/5dXF58J5yQChHNxM1L34DJR8h7ekI4NCLpGyxboie8?=
 =?us-ascii?Q?GP/9PEGNYS15vHyjUr+hMMYX31rdikPD7eFJFn6Q7hT0S0OIJfyaGILOeemE?=
 =?us-ascii?Q?Svd7kkcx3UjdcR5yPe+jngXji5lGpk2EmBKMvcAxGO9VNSKYjh60CnIa3DFn?=
 =?us-ascii?Q?RWbBbJvX9cth+mW/ErJTxZ8Sv63R8rkyjQB3Md+6Uj2+3EEeo7lqCL+PydQN?=
 =?us-ascii?Q?/G0PRMcHQTuOJdezfU9sBWQDRduqjQBKjRyjgW2JjN6unRPX0Tpfj7tRFd0D?=
 =?us-ascii?Q?UnCVHOwOPBRNYLSlCqFwxRYbIPPgFV8CqzRe6tHgFTMEMXEXfGvK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a78dddd-a216-4cf3-fa4a-08df39ca5e7f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:49:04.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DqTHAPT+U+vZwK2dwmV23nhvtap1R7aEwCPowSTEuFJqkjQYFwmBlyNHR27qA0ZXbz89nIP7BovGOMeHeLCHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

On Mon, Nov 02, 2026 at 09:47:04AM +0100, Peter Zijlstra wrote:
> On Sun, Nov 01, 2026 at 02:21:56PM -0500, Yury Norov wrote:
> > The preferred CPU mask currently lets the steal governor reduce vCPU
> > demand when physical CPUs are contended. This series adds manual control,
> > opening more use cases.
> 
> Sceptical, I am.
> 
> > For example, setting CPUs aside for selected fair tasks at runtime while
> > steering other fair tasks toward the remaining CPUs.
> 
> That's exactly the kind of nonsense we don't need and makes me want to
> stop reading right here.

OK, I started with the wrong argument. Please consider this as the argument
#3.

#1 is: conceptually, preferred cpumask improves performance because it
moves the scheduling decision from host to the guest level. The guest
can do it better because it knows more about the workload. But then we'd
consider moving steal governor logic to the guest userspace, because it
knows the nature of user workload even more.

#2: convenience and scope. Some systems don't allow loading modules -
either on config level, through selinux, or somehow else. They don't
even have compiler installed sometimes. The sysfs, on the other hand,
is typically available.

I want to be able to write a simple userspace daemon that implements
steal governing without loading any modules; and i want to be able to
tailor my daemon to my specific workload. That all requires write
interface.

> we already have cpusets that is more than capable of doing this.

Then why do we need the steal governor at all? We can steer all
processes away from a given vCPU without any driver, only by playing
with each individual process' affinity. For vCPU throttling, task
isolation, or whatever purpose.

Because of the overhead and convenience to use. Setting an explicit
affinity for each task would require preserving the original cpumask,
not mentioning that it's much more invasive.

The overhead grows linearly with the number of threads. On my working
station right now the number of processes is over 500, and number of
threads is over 1500, and it runs pretty much idle.

This is so impractical that people would rather use boot-time isolcpus,
not to mess with thousands of individual affinities on runtime.
 
> > a user can mark a cpu non-preferred and pin a workload to it. fair tasks
> > whose affinity includes preferred cpus are steered away, while tasks
> > whose allowed cpus contain no preferred cpu can still run there. the cpu
> > stays online, task affinity is preserved, and the selection can be
> > reversed without rebooting:
> > 
> >     # rmmod steal_governor
> >     # echo 0 > /sys/devices/system/cpu/cpu3/preferred
> >     # taskset -c 3 ./my_workload
> >     # echo 1 > /sys/devices/system/cpu/cpu3/preferred
> > 
> > the current preferred list is still readable from:
> > 
> >     /sys/devices/system/cpu/preferred
> > 
> > This provides task-placement isolation similar to a use of
> > isolcpus=domain, with a runtime interface. Scheduling domains remain
> > intact, tick suppression, RCU offloading, and managed-IRQ avoidance
> > can be configured separately when needed.
> > 
> > Different preferred cpumask governors may coexist; all update the
> > same mask under common locking. Manual settings are not privileged,
> > and later governor updates may override them.
> 
> That is a recipe for disaster.

OK, that's fair. I can make it mutually exclusive. 

Thanks,
Yury

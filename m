Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599310;
	b=tFQJfWawFGC5rxB+zbrQ2U9aJuH+De2mdfQ9UQa168cV+mNnDvSuUFxcOGzczK2/w5cO
	 cp+BPEfiXe+Wb647IFFWkJ+YPjZ48xUQdn/HFeutF7n1tF8KKZSxavwvfXYng0kYJaFHI
	 aTcxHCLZsovpoPB7y53QEgmiinR1dORq+t7KLYUIG8shFnoIdaT8g2TyX3Tzskls8l8aX
	 CpbFBqCBoBxqt5sN6+fZk0eJMGag1BFCuHFa+evTd+Z1W6lX6EIf5TuFQERmFMj20VQKs
	 dwnwlikYwBPiZqXeFX+EeZxVeGmNRmL0cwuk1YBGs1FP3UshMEGzD+xwvzByKI786Lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599310;
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
	bh=0ljNFmecD8tIEjS7UBA3LjMgU27aEE4yNC2CJYwT3Zg=;
	b=TaEgnyF8qOyvj3qg5cUjDkL0mXmgqPTU3Df9O2RC8AzGoEjiyhJxwNrHmlXnU4HRXTtv
	 MIJHenyF1Ch8z2E9kF8YInBJS8YRXE+NkxCPFlqIgySIWmAakTC+yDRKA1d7qWQ8riK7y
	 +Om2z6c1PM/Z1wOy2rIjpkEiu3wMkTlDQDXivALNRcUSSmXKcYK9X6g3Kh5uh5MQFZZmw
	 /2ikpr4WuY+ILme+QgKmT37rp8rahjT8jPmGq4cb3o3/oOnwpA99xVM9o8sqtu91ygrdh
	 nOPSBMj3DKwGSRUchI2EShz7kd1i9yCLzNL+4A/DeEwEeWNa7yE40hBQXNBefvuwIRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VpeelGdj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.36
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45955606A890;
	Fri, 13 Nov 2026 19:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45955606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VpeelGdj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyAY5+tFXndmfifaRGAnNrEpdOoZ5upjXDZKO0OAi9BA8bKRVapzw9QMibUkn4m/UJ7bLJy7SaJVB4aitsmu/Jc0ffT7fx2a8w5vI6uRsPozWWqc9hyNeZS+j5BowkmE9CpRyM1EAtlU1FKePaKnTrto5gK/NpslTTqCDmoVfPCFhOKS5Aown5lUl73SYWiffdJY9eZ/qMpYfFCiUhh4QvGR1AzjHLAqdYCyMaelTgaRe4KvzvM3TST0iPjLZ8vfY45LVf4VABOjdthP51wfdd7zUIAfdUVqMW5O2QQOcX6pLv2b0wU8qoBswwde49iOSVdmQx8GVCDhptTVN7JsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ljNFmecD8tIEjS7UBA3LjMgU27aEE4yNC2CJYwT3Zg=;
 b=vvKBIwku9wQkERk3WWAvUTUrY06/9ZZ0nznMqJHXufSJ351LxmWm+tgK3ZgAJ267DBVqncRDdoBlV/PelHWhMkqQYCz+xiCdKSARiFDA8MAeIGpr2FhipwLNaEMNQb/8ss0VjiToKrrR7keztSSdPocrZnqhG2tryriHNUxJMdGzggWGQqDXtmFM0j2/Jp25HvUQvM8XFEOO0xIpm9FlEJruzzp1s+c0VF/2gMkuyTvYRN+z+M30BsRXMPBYL23M8AhyNeWzTxZZNXXBK6hZZFXHVsNnxGisVW/DFUtFfWoDdemKEbqPsRmd/wgX2BL8id18EvJzaSXlYFw7zIT2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ljNFmecD8tIEjS7UBA3LjMgU27aEE4yNC2CJYwT3Zg=;
 b=VpeelGdjHQnfqGfbgXJ+ea8DoSlqIZQL3k569jVW6PKnuOnRLUNyg0Up1nH3yu0sf+fmblafWZJ8Em7xA5184gXFXM7ZS7yzlK1GRJaWijtSOIDnNqKVjRwZfVy0a0IyqoD3DgIkVHr3gzhPIIvupmjXHVel7S2ypaNbtptpFLj/YiYcgZk+iEc9mYvGaGUWjMgTFXpmN3zlas4O6VbqVYsSEcj4MVvMXkyP9q+PTf27HTcw76UHpnuUphIRZti2Z9FcCwJ+ESdIXK0LcWA0tWi+M6ooQOUpGR52y8+tYAOhvfY/8JIA3dk479df+iJUZWP50UOkPVEQ5n30PfcBpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:43:01 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:43:01 +0000
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
Subject: [PATCH 1/7] cpumask: add reset_preferred_cpumask() helper
Date: Fri, 13 Nov 2026 13:42:50 -0500
Message-ID: <20261113184257.621707-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0293.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::28) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6a858855-bc80-4828-94a9-08df41b5f1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261022105027099003|261021123027099003|56012099006|261026140227099003|261028144727099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OUZ2WSjbvMkYGOgdn38JWzwGKI+VvbsOkvwrXmyL/VnfmvkIU8t9qYQhjL6s+787D2Um7ndCrKgBn9Lb1BsSgX0BhASqESVolvaAszdl4Xulq1V3rrXWDrKkIXTY3AKZQWR+KNefPDR/z4kZ2BI/BjBRl1qGUG+g4AQM1rkl7SUF8RXpI0w13h2HX6v4dwgMWZX2SLYOF3PEHMPmSJSXU5B/qW+yt5igduyRvRYSj8OIWVFx8LkBG/NRwYRWigHOVe4LTocMYQGvenjyobNwfojwg9a9BrGeOsAF0EYbknpjEBh/k02obXWSro3j4qxuBrEooWypZ0+eoSVtEPhi1SbrcHyzCxtAMMeJjEkFkrdQFoxbRymEiXdiRUdBImrh7JPbtuYk7t49nf32hMqLUYpjdBI1elqp15XlR9J7ima9wbu+bjpMjORxUq8Lm3ZfA4VFZUYlTiJnlABDQD7HdE8WqaBJIlJDAT1a1Q1TWiKbFGRwOGYZznvEeixt/CezNs+DMT73XxkQbkHLZ4bReCc/mvC6Yrn1oEIRSwiSlGNoZtAPKewsb7DYIrDm+ea2Ce5Zc0vvi4yBxE9qAsIth5JDVgW8tvkElnmLzZqYTyc2Zi/woV2fLwfnVxLuPt8B/mccaBta6rOP2L3qJNudekVNiykPjXNJdKO/629QejQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261022105027099003)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTDGzVUUt+20PfTFUNepYDiyE6BqzkJfWbJeGZMKfnM2yjyrkyvSFQ3VabtE?=
 =?us-ascii?Q?MwTbDvwIJy6CbGMxxzwCl8b3m1/lIJkzRls/SbWCTCiXmCqywKDMBQ572Zkk?=
 =?us-ascii?Q?VLg+NHzjGV53uNgmuBn40/HP4DVKfXopTeMvKyFv5yShknTUpuaRbO0RK5yn?=
 =?us-ascii?Q?bjrtSta2QDMdl+Jekb+4L3JPEzcI1YfG969Ge8kAOAdKPs2oumnoqTfbQ0lz?=
 =?us-ascii?Q?m6xmJmcbuaXN7dUJwxALpsgfmjfBn3FFq2hnRxusVZc0DId6yHFOK3IdCIQu?=
 =?us-ascii?Q?YkIKA3wLMmfGf/ioBti6Z+1U+cvQP3WjXpSdmcflJcQ2LkQBYwWHH/8a4mN1?=
 =?us-ascii?Q?uSLUoyF6ZExdWlbiA+l9xNVj4s4yy1TPkfKsUMklVxlvKeYTpumnPXTyIdLz?=
 =?us-ascii?Q?OTXUorJTZ9xOytxhhKgwTy3txg4EXaM1BoLqDKOyytp2LpapnyTf57+aQIw5?=
 =?us-ascii?Q?21daZnALV3+OTP1T6YXLtJ0SQR8DX5frbAUogUu5mTqsAeyWYEqJk6R4GBQN?=
 =?us-ascii?Q?KRMBXfKTh5z5A/sDINa88jPL4d9zzsojBHTk27hIiU8iosmTzhHP7QvHwmhL?=
 =?us-ascii?Q?W5/4AKFXvos9gxYr2KhxCB8woXi9IrK/F20OkpnFGRenf0r/99zS8GyszfO7?=
 =?us-ascii?Q?s/c+nU5LMdMHbbx675AelxvcgcCYjDrvzZmG7/x2Q8IyaIFp3QHWioAjxy25?=
 =?us-ascii?Q?fvXpBDZG98mVwZrpqWxvNPnK4+VMNIlEoalg7OTYZ/lxtN+TMVojdjuykBmK?=
 =?us-ascii?Q?AyMr7r9oCD75tWHLeAfz+iLi4kjFZpMoVWJtVE1+/1UydEFJ94QIssvJJ47a?=
 =?us-ascii?Q?Df4kjXSir/fzfDDLqbLXNHQl+uXouiTyctKcnpZgr3C/N4/HhWfVsBHlli6r?=
 =?us-ascii?Q?UTij1kyQU+n7i9/LZ4nUdEWflg6+9ECi3GHVNwWDGgrlNj2xVpS/pJ7NzPiC?=
 =?us-ascii?Q?0r4/Ut4IcDkiFlqO5dUXHqYUhd9nvCDKj9UwIjWtu1DgsK29wjSirPGTljZh?=
 =?us-ascii?Q?D1h8EIsWppYfssJ+ixRkxDGmOaVVcXylp2BAYFiQh3NTrloSr61wjNrMC39d?=
 =?us-ascii?Q?M84So3cKAft4MjMJlt/YYc0lYoGkoTTo+f4518MaittNAFAoI5SBqsNInhXW?=
 =?us-ascii?Q?RLbcKC2W00O3Ihyjjnm0kazDqvvkeIXaGLG67/Dpvo5PKA+qy9n1cs0ZJ/KZ?=
 =?us-ascii?Q?0URBfInInZ5DpI0EpceNundh7+acXqgrtn0Z4rrJ/pJ6nQUlJN7KUG7uge3T?=
 =?us-ascii?Q?GZJGWuHB7TQD+cBbagbanKrPv/hJda9hHg0qiNT4llhDZT83WuAyWGp/Ptbc?=
 =?us-ascii?Q?tbq5rav/5d4+fvBDtbGgQ2xzakdt85gS5N+T+xrmETO4AeVoy3Si5KD9nlqP?=
 =?us-ascii?Q?GO9MDWnVp+tKRihZa+0Q2hcnrnkhAdusberC4Qx1HK/Q0ueBTY1DDbkVTyJL?=
 =?us-ascii?Q?2Hm7WnqG+q+ONTtDKv9ZevPEkTXU1p9FxmDW7qbVNJ9hS80a613f0Wo6s1D0?=
 =?us-ascii?Q?V9R2AgCtAkFtD0Vsi2qyuCWWarh05uDwpGB+wQmmzOumNjQ+jkgMXkHNT2Yn?=
 =?us-ascii?Q?lkTI1sg26l5Zo3mXThdexc69uYRIBUnvD5kRMmhtKTSq+X2fAvQEX2nftm4Q?=
 =?us-ascii?Q?gPNqkihp+iAcHvAvSoS7iw6Ufndx2q0GjddEL9rbMwslOmMc/iSrIH6rSMxl?=
 =?us-ascii?Q?lj2cs+vQ//Jprl0x7xO6D+6KiVsIgLSTENIpOKLLXRj2aG4x3BjUqEs6Sh0B?=
 =?us-ascii?Q?CH5vUFMBgF1JmKFrXbFUl1u1vDvlgTgGlF64q5eWrlwKw30bSvNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a858855-bc80-4828-94a9-08df41b5f1c6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:01.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCXkiM/XvfzbUxBzdUaskdt56daNkal/UkLL1UtqgBBxYEAPtO5TRu7BTFguBHijkN1mQnM8cJRVd4uNUxtpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

This series adds more flexibility to control the 'preferred' status of
CPUs. As a preparation, move the steal governor's preferred mask reset
into cpumask.h to make it globally available.

While there, rename it to reset_preferred_cpumask().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 16 +++++-----------
 include/linux/cpumask.h       | 13 +++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 81e5089ba824..99bebd3dee8c 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -50,15 +50,6 @@ static struct steal_governor sg_ctx = {
 	.low_threshold	=	200,	/* 2% */
 };
 
-static void restore_preferred_to_active(void)
-{
-	int cpu;
-
-	guard(cpus_read_lock)();
-	for_each_cpu(cpu, cpu_active_mask)
-		set_cpu_preferred(cpu, true);
-}
-
 static int param_set_interval_ms(const char *val, const struct kernel_param *kp)
 {
 	unsigned int interval;
@@ -252,7 +243,9 @@ static void steal_governor_loop(struct work_struct *work)
 	 * module restores to active if CPU hotplug breaks those assumptions.
 	 */
 	if (!preferred_cpus_valid()) {
-		restore_preferred_to_active();
+		guard(cpus_read_lock)();
+
+		reset_preferred_cpumask();
 		return;
 	}
 
@@ -288,7 +281,8 @@ static int __init steal_governor_init(void)
 static void __exit steal_governor_exit(void)
 {
 	disable_delayed_work_sync(&sg_ctx.work);
-	restore_preferred_to_active();
+	guard(cpus_read_lock)();
+	reset_preferred_cpumask();
 	pr_info("disabled\n");
 }
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bf89bb3f30f6..b13d099474bc 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1195,6 +1195,19 @@ void init_cpu_possible(const struct cpumask *src);
 #define set_cpu_preferred(cpu, preferred) do { } while (0)
 #endif
 
+/**
+ * reset_preferred_cpumask - reset preferred CPUs to the active mask.
+ *
+ * Callers must serialize against CPU hotplug and other preferred cpumask
+ * writers.
+ */
+static inline void reset_preferred_cpumask(void)
+{
+#ifdef CONFIG_PREFERRED_CPU
+	cpumask_copy(&__cpu_preferred_mask, cpu_active_mask);
+#endif
+}
+
 void set_cpu_online(unsigned int cpu, bool online);
 void set_cpu_possible(unsigned int cpu, bool possible);
 
-- 
2.53.0


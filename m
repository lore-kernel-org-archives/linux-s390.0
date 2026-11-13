Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599287;
	b=XYFv0iOki9ZL0SxE6EcDmNPugPt6yaTaVUNM5xlr9Cq6+0Ro2WSoAR6tAo4D8b0t024g
	 l0YKby9xFyAaViC2w+QmGgsccd/8qnvCkFbm+CEy998800ZxnAPEPuK2duk10qbQl3tgn
	 cXz7JXw6a6tojeN9Mj0sVQT+eHzg0epDCAZZXEQyugWRUp6Viw1ADmiY0YTpDmd2m37UA
	 L8nnN28qc9/sfYMoVitsUZGxKd9WjEiPxc5UyVH3kDDEw2wM50SsqzQhyyfaWyIEOJUfe
	 viinMt9MvYisbdXpeK8NNFTerNVxeEWjLLn63bYsrre8poM0ktF+lXJLgFHmAjIBB7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599287;
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
	bh=CL+TqLFft42y4CjiR1EG2rBza/zuBnsasE64zaurmF8=;
	b=QGZrNKySPYCp57E80h6rtjQU+EPskhWWnkQdVTdNitXfn5YCLNgqQktDF+KxxPWdPOBT
	 d21mVjp3kRAZ7ppR0rLEIpnF/9ItIj5Q31MO57XZ+L3PEbeRwzAi96aFhkHLyvCgoObJ8
	 eZJAkxRauuKRDtVRkU0R+owxIy3uQ2dnxYQM9lsUBgnwh59DwYv01ZZmBpvVdHvwWYMch
	 zuR3wZXImPJTmNKygQLSHe2j4cG2/RbAkP7fN2YVwFA5JIxXoPwq6xzkIk2Dch0XBBDDu
	 f6+D9Vaac6kyLsJ9kPHtPvRslscIUOOqwV4PU0syh2DNn1in/eM/8EGshsDQYH20XKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mxif0UmP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080F606A8B5;
	Fri, 13 Nov 2026 19:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B080F606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mxif0UmP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZShojYPu/Ejcv2FqFHU8DHBxoNiw4nlKG5pMUm5V/awe/i7YOykEHu2WF9+DyEFX1YuVE+1XSqNVL4ioWbhQZsDn28bNdeWpBcelQkrhxikqDWMyQ6adI9L+cEsr0CoJQ6LOM3DdMee9kTyS8aFcaq5RRDSYNtbBs5xk6veFOUlzYyBIcSG3CtShiA5gqKNX0bmTk/oGzceHz8O6oS7Y3Pl/HIrp6d1B19YeI8k3zc7rp2iRCMc/W+PYHF02fVqnhGCYFa++0AfhkTvI4TMHHGebVsKHBhJwCIsNAZ1F1TfC9dYSvezOYieUbO9GN0o2GrgIldB+NHeLJgSnc3PwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL+TqLFft42y4CjiR1EG2rBza/zuBnsasE64zaurmF8=;
 b=n9FXM/O7b6zJVUFJHO7N5xgcMfLUgd/tm9jcBr8LyYoi+zseeqSizvbyFrYFMSSAo+vBOTh2fUJhWKkaykzO1Y0JQMxoiPrEWlsan1V8xi35sd4WkS3qmzphOB3dIpAVqQwYB+ms1yCDu16QGYBLRrTkUZ+9F+UzmiAqSmFzuM4WGYLNB54ApSBOCFuZG2fvaUR1szUMi5kTrQocqGdAWByXaUBkLqSHl1VHc1jvAIIFcsDoWekmA5+nHCmL5mGV6/Y5etoft23Lmbi3q6VZCzAhb6ej+jkBsMwQ/209diPDxP7XlcjmFmGq6uVKEF42Fr0Z/HvtLeCC9iKNLCkgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL+TqLFft42y4CjiR1EG2rBza/zuBnsasE64zaurmF8=;
 b=Mxif0UmPo0fu07Ej0JkCIZTM8Z7uvP7rg+201hsYB5hg1Umfkla0XUnN7rH/pYhavJb8NRnODkDp3VSY9/UTzfVymvkgL0MS4xKY+UpbNm/3AVXO3ryOPbW3RZzNcZEMFI4TS8PbRqWN7ErxmuT0phSh56HE2amJkfWcnQ9yWsvq7Y4gD7KAO6nA4D4lMtEdFYUy+toVokQkHs+4ifVskwGwLB7fzOs0JDj+5L6DXTN1ngjN5EIoG3RfQLehS/0CauChst5CGJNtLUOcjer8j7NTGyCM/ETDBJool6YyjV0mJsQ52/3OtMoXVyIThihugvcek9yKFFUKJ8ruW8tyrg==
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
 18:43:11 +0000
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
Subject: [PATCH 7/7] cpu: make preferred CPU policy writers mutually exclusive
Date: Fri, 13 Nov 2026 13:42:56 -0500
Message-ID: <20261113184257.621707-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::17) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3e4e80ff-d2f3-4af7-89dc-08df41b5f741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261022105027099003|261021123027099003|56012099006|261026140227099003|261028144727099003|261102130727099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4NXp+eTTjZlDJn0QZMdyLxl5EewnTwpMImin+I9waOgaF6LZRrJ7EYhU52h8Fe5KZE1hGq8yL44/d2lY4toI7kgB41el6D83K4/5Bz7tUlJin4tX0AimX2doc4G8blYIgIe1V7vjZ+DMDwJZ/yUhkCmfsCoKML2/ZW2dKABLPgq5wptzMZwQG83s04IQAudwPfRuYIE+0vh3FSJkw8eW+Mflo8zxR8plKBbvH9CX3ZvCNAyAT2Yvokck0atiQaLtQh8KgdENSEIqdFfV1aKwWkU/LUfXtylKpIpfY6aaEAM7jbXz2ydYtxThxPGBYLeMdEQAXsgRUTGh6Y6j2FMB/HX5xSa8AiRFT2rjKybfjCPXElUBCI4yNhOkLEcaLIx3/0w5OPR5VU+VEkfkD6e6DXYmZCLvVwizmIYtZyFlSisMKUWe4k58cLY1hbFOiJ9UCOp4RQ7rPrMcCjweueum6XsdQ9/54iwWHEi3q2FwX6ZNoK0CdYKYocswaerJ0HWpXyfef6MtSnaXgCQZZhpZnw2H5XMpgVAQGAItwJGsqu7ZU2Pqz4gtAo0SVCjo21Dqg2aB+82Blj8eevMPAu6BE2e7Mi+dcNL4sWm83lgg5zPiaJetSWPdSGwFYnGTVhqSGC3ig7nxRlokxI9jsXIe1HJw6ZQoSJQ9zUZS/mK4ehk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261022105027099003)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261102130727099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQtdR9z7nqsbF238zIHoxmOW04KQgTLN9tVNELtpDcxi0M1UUyg/OyBSim3y?=
 =?us-ascii?Q?30rgrY/PY32OxyRe49bpq7/CYrGyr+BQ4kBdwkLtEEqfnw/dUITZO+VlEX3/?=
 =?us-ascii?Q?q9OiONMxVUBmu6q4RVKm2OmAfmnuleNRQJRtjCuVov1xpPsg02eDEta+d4RN?=
 =?us-ascii?Q?WifBdg328kdIesOtzCvSxRbs970aspgt2iYSKSr/R3RCQukQcj5ksy/1Ftm8?=
 =?us-ascii?Q?g0RbSbZP/+eQsvTC5rsyEA7Fi5iwA4cv4nXiOIV53Hc3PH0T4AKBmp/CYdi4?=
 =?us-ascii?Q?Os4wtnsVXIguJ3UdyD8t7a6sYVRZYHSvo/WdPQHVuvaBawCE+IMiI92SPSel?=
 =?us-ascii?Q?6lzPBkTDv8/hDL9lqAdZTowAGR9ix8sE0LYS2sRT/sG3dua3oEYmjOlNT6Ms?=
 =?us-ascii?Q?rXimeYXmKV3+k6g2mKVfWr1sobFBKjYwuAePFSPdiHvZsu4fUS2OQ1yuQ1wh?=
 =?us-ascii?Q?mspvKFByirO/YL5+v5XDoTlmUfOmYO8m8tU3bQr6wu4ZE70hl3CpOXh7Cn4o?=
 =?us-ascii?Q?rTRXN+YmLHb/T3UIlZXJJ2X+EzEiFxZ/MKoFiFSSncCKnPh0REzMY7dVIl0h?=
 =?us-ascii?Q?jkgs0I5sAaSUjmuog8Md8OV0kZPHYgUo7enb5j4xmEcFE0VEuUl94rjLwm77?=
 =?us-ascii?Q?Up9lC4pQ3ipuPygQb6aMqPwUBXyNZUJC9LSqnb5DSS/MjE11NS/n9rLo0ikM?=
 =?us-ascii?Q?MyyUBMUORytxtjdKfshV5OW6hjdys8295chH3z5C3u6DG37jyC6iTWxA1DDm?=
 =?us-ascii?Q?yZ2KnGZvmsTd91cA1/wwclZjjT9no+AwmBZmXmtMvPROd/L59tc70D0gQnxe?=
 =?us-ascii?Q?CLhCyt+wl+y0EuLtmdRAp0lpdlzaY3ToAcfcW5W/7X3hQfe4DA9HOXjJ0++p?=
 =?us-ascii?Q?jzP7A4TICGrhmQgEbuLbWj23N6YX5NV/2tv6fTtF2MGbxlv2ARN6z8Jg1OgA?=
 =?us-ascii?Q?cvQRX9hwrIdqtfnsXizvzwj93KfhD8wFuoMezxEVbINiW3ayqkENuw2pxfrJ?=
 =?us-ascii?Q?xVhS0v1NK7CpxHrZFWxlXHST2a9LwnJZ8ie9DVAr/8In2ulf2eYNkuJ0q9SC?=
 =?us-ascii?Q?GKFbzQxVvV519R/uej75HS/rspBlbSOOHhX+nHju2joq5CcRLAEf/pbkrkX1?=
 =?us-ascii?Q?0jpWiZCa1oTbO33zvoFsc7GYaX7r0SV6oIev9WAzooMKjGFArI2KoWu9GVIL?=
 =?us-ascii?Q?IoDhWQoJo2sKIOnvEnKtlJNFePcmSx9O0ioa6PPesSv2rCu16xZsX0dbRKxL?=
 =?us-ascii?Q?0LBKDe+hDKYEef1mmGxlMSp1Sac/cQ6UCP8EW8xCwITJ0Jy46W23kuqbF6bg?=
 =?us-ascii?Q?f1gfqCx+stm07/2ffpd2fgE8lFoUbMUg0ljrky5SzB/7PeZzLFnlPFreq5Me?=
 =?us-ascii?Q?kw0OYq7BqGhG/RKwbkiIHOXkJ7ZRGQ1g9+kwU8RFgWH8pLD3GC82SyEJOwK0?=
 =?us-ascii?Q?7oz783M+cyAJzFrwXJVjJgFRdjp403Yto7xmXZlr7cNuNRRt0kv/4mT0sWHG?=
 =?us-ascii?Q?vUlx5d+d3N8DX8y3FJtqa1NYjXyGOkNtB3Hn4JNS71EphBT1oL4WMGyNhHgt?=
 =?us-ascii?Q?d9SdjV6Zq4+nRH3kg3U32OZ97tzcQpIjzu22jvqNq3KRIxjymkBmfkRzho6O?=
 =?us-ascii?Q?pEwLjNlMF6P4CiASh7YiXhz4bvrlGdLvFofLxWCCJn8rU8//ODBKwV23nbUI?=
 =?us-ascii?Q?7CAIerAA8YyoRsgrydt5AWE7aglIkvGEuwphs9vL0dt3kKi1g/BlTcMoz4k/?=
 =?us-ascii?Q?CIgO+/WFwvfrf4h7cYi/EeQz3iT5x5AQOmTUDg5D5q4zeAv9FHaZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4e80ff-d2f3-4af7-89dc-08df41b5f741
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:10.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjffUqdU1aQ4cvqbwSXOsoM2IlyjgadOH0vD1VVU3i/5+E1HfgniFUumE/BR5EMzMpSPcvDTnjFZkCiEdTCDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Serializing preferred mask updates still lets competing policy drivers
repeatedly override each other's selections.

Disallow multiple policy drivers running at the same time with the
exclusive ownership rule.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 Documentation/scheduler/sched-paravirt.rst |  2 +-
 drivers/virt/steal_governor.c              | 13 +++--
 include/linux/cpumask.h                    |  8 +++
 lib/cpumask.c                              | 62 ++++++++++++++++++++++
 4 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/Documentation/scheduler/sched-paravirt.rst b/Documentation/scheduler/sched-paravirt.rst
index 311cdbf2722b..d8f446c3ab6e 100644
--- a/Documentation/scheduler/sched-paravirt.rst
+++ b/Documentation/scheduler/sched-paravirt.rst
@@ -48,7 +48,7 @@ Notes:
    makes decisions should enable it. For example, steal_governor driver
    (``CONFIG_STEAL_GOVERNOR``). On enabling the driver, CPU preferred state
    can change based on steal time. Without the driver, preferred CPUs is
-   same as active CPUs.
+   same as active CPUs. Only one governor may be enabled at a time.
 
 2. This feature works for the FAIR class only.
 
diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index f71dbf27e4a9..b456b03714e4 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -291,6 +291,10 @@ static int __init steal_governor_init(void)
 	}
 
 	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
+	ret = claim_preferred_cpumask(&sg_ctx);
+	if (ret)
+		return ret;
+
 	/* Lock to prevent unobserved hotplug event during setup. */
 	scoped_guard(cpus_read_lock) {
 		sg_ctx.steal = get_system_steal_time();
@@ -301,8 +305,10 @@ static int __init steal_governor_init(void)
 							 hotplug_callback,
 							 hotplug_callback);
 	}
-	if (ret < 0)
+	if (ret < 0) {
+		release_preferred_cpumask(&sg_ctx);
 		return ret;
+	}
 	sg_ctx.hp_state = ret;
 
 	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
@@ -316,10 +322,7 @@ static void __exit steal_governor_exit(void)
 {
 	disable_delayed_work_sync(&sg_ctx.work);
 	cpuhp_remove_state_nocalls(sg_ctx.hp_state);
-	guard(cpus_read_lock)();
-	guard(mutex)(&cpu_preferred_mutex);
-
-	reset_preferred_cpumask();
+	release_preferred_cpumask(&sg_ctx);
 	pr_info("disabled\n");
 }
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 3716213d0730..1f4d93adb917 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -132,6 +132,14 @@ extern struct cpumask __cpu_preferred_mask;
  * holding cpu_preferred_mutex isn't necessary.
  */
 extern struct mutex cpu_preferred_mutex;
+
+/*
+ * Drivers must claim exclusive ownership of cpu_preferred_mask
+ * for the whole period of operation.
+ */
+int claim_preferred_cpumask(const void *owner);
+void release_preferred_cpumask(const void *owner);
+bool preferred_cpumask_owned_by(const void *owner);
 #else
 #define __cpu_preferred_mask __cpu_active_mask
 #endif
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 2e16e19a2bdb..ee710c3c8920 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -3,8 +3,10 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
+#include <linux/cpuhplock.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
+#include <linux/mutex.h>
 #include <linux/numa.h>
 
 /* These are not inline because of header tangles. */
@@ -170,4 +172,64 @@ EXPORT_SYMBOL(cpumask_any_distribute);
 #ifdef CONFIG_PREFERRED_CPU
 DEFINE_MUTEX(cpu_preferred_mutex);
 EXPORT_SYMBOL_GPL(cpu_preferred_mutex);
+
+static const void *preferred_cpumask_owner;
+
+/**
+ * preferred_cpumask_owned_by - test preferred CPU policy ownership
+ * @owner: policy identity
+ *
+ * Return: true if @owner holds the policy, false otherwise.
+ */
+bool preferred_cpumask_owned_by(const void *owner)
+{
+	lockdep_assert_held(&cpu_preferred_mutex);
+
+	return preferred_cpumask_owner == owner;
+}
+EXPORT_SYMBOL_GPL(preferred_cpumask_owned_by);
+
+/**
+ * claim_preferred_cpumask - acquire exclusive preferred CPU policy ownership
+ * @owner: non-NULL identity that remains valid until ownership is released
+ *
+ * Call before starting policy work, normally on module init.
+ *
+ * Return: 0 on success, -EBUSY if claimed, or -EINVAL for a NULL identity.
+ */
+int claim_preferred_cpumask(const void *owner)
+{
+	if (!owner)
+		return -EINVAL;
+
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
+	if (preferred_cpumask_owner)
+		return -EBUSY;
+
+	preferred_cpumask_owner = owner;
+	reset_preferred_cpumask();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(claim_preferred_cpumask);
+
+/**
+ * release_preferred_cpumask - release exclusive preferred CPU policy ownership
+ * @owner: identity used to claim ownership
+ *
+ * Call after stopping policy work, normally on module exit.
+ */
+void release_preferred_cpumask(const void *owner)
+{
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
+	if (WARN_ON_ONCE(!owner || !preferred_cpumask_owned_by(owner)))
+		return;
+
+	reset_preferred_cpumask();
+	preferred_cpumask_owner = NULL;
+}
+EXPORT_SYMBOL_GPL(release_preferred_cpumask);
 #endif
-- 
2.53.0


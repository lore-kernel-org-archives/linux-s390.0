Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598707;
	b=UWiUhY6LB3FCNuhios8ZFgwUy2NgTRyLTNnVdciksCt8P9PSYOc0fdDhdOI2rNWBzVQV
	 JGXQnnGBiaaeLeQhuF1b6uphFckVpSmQP8L5ektFVbipmzcBbJqxYSMFJbEVKs0HTu5JG
	 u7/gCetCudbT0CVsED4XHGire/is9fKUODAdbqOHwfMfFcBRmfP4QOVXOGEU0pg77kMNf
	 n78C98gXVTkkVJeCjeEf7NWLxvzq7sJ3dK7Bovn53Qnk1gB+MAOkUTerr5R2P3LoqdYPs
	 6TjeKbjrzNUk9JND22kZlJ0Y8Q6rNg4v1dooAiX7837422rQVFGRxEiVD5GXuodIApQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598707;
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
	bh=NXHICSD2RwmYRsasxRJbn/y/168SIDdf1Peouqqlpp0=;
	b=3BSp8FYn/4LlCQf1eaMLKwSYUCfPFc15EmlXD8lrEYnjrTaynC5giQWt4zGYU+MTspAg
	 rjP3KwBlbaUPqPjdtCnrWSivRvcN3kBFDqL1wN4u6BixU3215Jjl5eM+/R6TmhklNqKJ3
	 O63AtXDqwy0Usdb4ZCJur8y5z+iV8FWL4wClEtd/tQL0aOVHrJuXr//zAKP5qpfLY5o6x
	 ZIdMvKggzYY5Zz0BFIJvYA4FVdD1A+8+98GjuZu6M15OCmj9FlRE67Eu/Kv7lE2/iApAm
	 A9Hr4RiEINIn6NikL9kUikC1dEdVVnU3ACgyaameTY6kPg4yzqajcuU6/td+ydzlTyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nPYT9m6G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E428606A330;
	Fri, 13 Nov 2026 19:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E428606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nPYT9m6G
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrRqMyczTYjPoCFbdGm+GoVrySiqAzWkYOLwePG0P+iIrikTl2B1Vx3F2KjjyisjmC+PjVl8NhPkX6dRvdF58nlrFsFP0e5AFSb2NREicciGHPIvM5AGMWYXZTG+y0eVqR+SlZ+8SwatSQA3DnD63LyAmmAtKNOFtlVv7ryJQ3dosHCYZnVSPNz4DQG5lVxoHbOzWJK4wUdSADXMlC/Ljm62q8GPO5KA9I1az95/dS+DJ2hGnm/n2N85JZoH5j2G7IrcYLIMcsYWhjACOssVg8G/+x/KOlXpep4gvZCcs3RyE+PhXsDXrlkGX/+VeoEjkUzep57Gi3XtHXJAnDJHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXHICSD2RwmYRsasxRJbn/y/168SIDdf1Peouqqlpp0=;
 b=UeKoo5Ac2c0Wx7i4NUygnv56aK7QTQLUm0v65icvmrk2IIVLrzp6qRa/+bn9Ft1BjSriCyIA4YUySpKSC1X8kfkL36NhTmTBRf87+v0WjRTYSVn2zW3dKvHqAGxFEteduCUtgcgi11++t6KgXkxQep6i2SN6NHPQwbqAtHZW6nAUObuCFzsKtc7urSb8lmo2W24bSrBR+60JwppWCPqmtIVIuHFaYroO+MvA3hOFUr6cNpaTajakdoruTObSa63JNBtHyx4VeffSAkPbgCPN07L0GoCvzBn0kFqVJ684kU80/kKxZzn5GhZS9IR7BFPG9V8IQ87LkvrcXjKb0EkdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXHICSD2RwmYRsasxRJbn/y/168SIDdf1Peouqqlpp0=;
 b=nPYT9m6GV888+3esoB03iZr7sdBb0CLghkywZWbvkLzJ3lzCLEKLkJjhODKKhhGWbnFa1jhl/xsm4aIeHF2ebYPDNF1efFHsuEiIGwyKt79qTB97jd0DpB/c9nX9FXGi3tfisZy1xMak2gOqmAbXLXqEbnEiuNWKOf/BsiZE02HBRGsMe+4hFKvI0FWtRbumbLQUkFJqBvomNhxLm6dPTFYLufcZc+RnfSsVYnO5W5K2CYPjcRj8wANtjPERBgVBdyCjkPy4xVmk+eJA4aUJSWmQiMiqBFxY3GtoDRrL2MS4JEXALF6I77unGfls+MEV9SvIL4KUP7als7azVVtsYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 18:43:07 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:43:07 +0000
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
Subject: [PATCH 5/7] virt: steal_governor: warn on unexpected preferred mask states
Date: Fri, 13 Nov 2026 13:42:54 -0500
Message-ID: <20261113184257.621707-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113184257.621707-1-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:36e::6) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d449fcc1-932a-4942-69dc-08df41b5f56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|10067099003|261022105027099003|261021123027099003|56012099006|261026140227099003|261028144727099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hBzOv6XeCt3htDqBouxSGv5Dl8sWz1Lp6wJCodE2TJIJZDj2IxIYSNmCw94eIwdQu3Nq27i63hCfR5VDmLUiAl/EAyiyVfkFAmuTZdogD2/sEzCJAyy4aAcjSEoEBRkkl1e2B1UlzJv83fg8bb318iJgTwNcU+us0Ms5CVTu9iDXTrOTUBUg3qMcOzKhwBXAqmTCsKmPpjMB+lT0iInciUk5baTDOdwxchfIdYuAHyDNTKpZAsMfL8K5oee8lD+9iDltd7fdRfxs3vUQs66pGqFLRjOvDtdIdHb6v7mZ75MLSM9p63vTvdISWcZUS626jm/eRB7e/fNuR0X23vKUhU2NnabTFykvX4RcB7Zf+AP7S8PpNEcHCeBAjjSBj8Wqo5bztmGWb0ihZV6zbyJJVn6USWkDc9r3TDWiHdQJ5mnJg5uNZFgR7wLwyQQXFXXTJzyS8KDyhyRYD8oV3bXUnqZOwoUGLzB2herl+gZdRBd6BfzIyqqSzBGuf7O6wYoGZDS8MzZdxtTfux4rWhslPpGYw2B7ndQab/hVjoxAkam+QRVMGHdFUJLTvP1oM0nm+bQiXRZe6oCs4hu648I7Gj4TJul3rWeB/6ThRyziGfn1gKwagUxnsz88nszKfQgQ8jTslk/OySD5E6hrhCkkhP3fAC4he9Rng3kRdUZ8SUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(10067099003)(261022105027099003)(261021123027099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?45LDat8m5ei1f0V0Z/nvJ82i/cgoTH5xQqXOwOPBJMQfl7nqgeB+3VmCJKed?=
 =?us-ascii?Q?3khZsZmzK7Hk4S79zMCXMRVp0JinfolCc2Q7qTzU4W7zhteP1r+/iBlC9xA2?=
 =?us-ascii?Q?OS6zTrSQJgBnDk44JrskdvRtvh3hS26fZjopF6v3bM2TVJ8mhDMKHN0h0LY8?=
 =?us-ascii?Q?oebP0YX+MD1Y2a3QnH0Dj1tajwPIAT2vAyCz/t4P3Y9ikaFZHpapCv9KvoAJ?=
 =?us-ascii?Q?ext/umYvvCB0N+xdiCOH8dC2aCD1f3//83PfH8oJEvfn1iG/4mahGEsOhgkw?=
 =?us-ascii?Q?iBdHdHidHmN9S5MBw2ylAITfTFElptTFhQ93tl6gva88kT6QvcFHb8myade/?=
 =?us-ascii?Q?mPl1ovXQk6OLDbv9vuxpAlr5xFw7BZTR84plXoxfrfA6jGDe5bOSAQxVFqov?=
 =?us-ascii?Q?n/M2fQ2UygK/rc1P75CmgQzc3qY81dZvyIoq8xnKldNYB8aNrGGJQFRJbWhr?=
 =?us-ascii?Q?r8gKiS0YAk8YO85na2Wzb+w2Z2GWUh0A3o1Uwtepdxj8OVpZJ6ykPltO1mqx?=
 =?us-ascii?Q?ih3n/yqbu+t3MgcOR+sI7wVL3BNTUXtOnFbDUE8mvAHrS3sql/2o/HfKZ5RA?=
 =?us-ascii?Q?GLjKn8DxiCBBTC57KKCxGfMyAY2f2XUBjBP0UJZtOODHupHHomKlloaNYzeg?=
 =?us-ascii?Q?8Lmvl90x4ELB+AGFIWqOFbxj4MRfx8ohm4c+fD3fLk4u76zSLW58dXvyOIoS?=
 =?us-ascii?Q?QKrmY+8C+oarj2mqWEch+eyS2qq9rWELcorWYJO5UweaUOCPeLA1D0idJXdQ?=
 =?us-ascii?Q?3VzchMeRr6CZ268sqtDhwBkaurfIN+vbMU/k9coIGebaHtIElOaPk8KV8iYc?=
 =?us-ascii?Q?x6+0SkYHcQ6Kw+ObfOpCmV0s+PA6QyjGbf/nhQwir9ptRyDsBDHSL7K1XsKc?=
 =?us-ascii?Q?QTOFVL8GTZb3r3jlZgGKBYIp578staheLqIRUdYtXLsPAV74A65dZ5JukFEQ?=
 =?us-ascii?Q?VgafxbOYHO+Xy7d/jr8KYZH2IPQ+z8/Q8As7WFwFRIuYZRHc903J9plm1mf0?=
 =?us-ascii?Q?KA+W4u+jK9PK1Cz6YVpg5e3Au261LlSvIUIuAjlmT76Z8Dn+ZkKuxUYYlSJH?=
 =?us-ascii?Q?U130HuAbhJLIfEz3v85Ar/wcmFxMg4MoDkGNfIZDH1x4Pzhugx3pCfqSZwmF?=
 =?us-ascii?Q?wHduX2mzF1l4+KxCn8zFQFHhMTVT08UoLVq9En1Xk93e3qhnkyRs60dItiU6?=
 =?us-ascii?Q?Ua2ocI7UP5xWtNFIWVyFHemhcLvYqNGLw3WwKLcrbhaVE3R15y6V4D1j7PQr?=
 =?us-ascii?Q?JcbA05gSfiYVk5Uoq2uqQJ4SBC4jcm1nH9YWqdBQ2fIogEMMtmDnbgMTC1Re?=
 =?us-ascii?Q?n+LDZ+/7MV6XKsS4HfnVE93yTV1cIJX5NtQk5EVjC92t4Uf3tNtTZ8R8/71K?=
 =?us-ascii?Q?TVmCjAwGvc9RPMGa5ATisVBrjC2/XhXyeYcn+zE8WsoTpzTsA8xnxQF54J5j?=
 =?us-ascii?Q?mZ26HIAvKttoIuYN46pDgVUIp9QnGwvd7VujkDzviZJAER6LldKaos4aECYc?=
 =?us-ascii?Q?vCApHJOdqal8JeaW++gw1z6gjFuIZl1oqpkwKi/iF3euiiKmGtx7c2LIrpE8?=
 =?us-ascii?Q?NPFXq9a9ulZcnxhJnsoetVNXski6jYQgR4On3oFboDnmEcSada7kLm2ZAViz?=
 =?us-ascii?Q?YDq2vKJMxwsscOZKZHAH+bIVkbmExgfi6dfosNb0TnSMdF5Ozl2V2kTSnZ//?=
 =?us-ascii?Q?lODzxmsnaLbYUXB0DVxpfDHX0mLegMsjhJz/UWPBarFcfyeGx3ut85bWm7vG?=
 =?us-ascii?Q?JWNCB2viXxC9aNPptUfNeznFwe3Gwa3M/K93j9ZtctiE9dLXpy0w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d449fcc1-932a-4942-69dc-08df41b5f56f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:43:07.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCAe0CYYaP4zgBdcVc086elbTOepJhFIsUN/12CHwDubDEYfi4oKT8XAssJrfLYOPoobv5Ud8tl0hAduimcm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

Now that preferred cpumask access is properly serialized, and CPU
hotplug restores all remaining active CPUs as preferred when the
last preferred CPU gets offlined, the corresponding logic in the
driver is redundant.

Instead of removing it completely, add WARN_ON()s in the corresponding
paths to harden the preferred CPUs mask management and highlight that
this condition is not expected during normal operation.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/virt/steal_governor.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 8cd5c0f3e3ef..c34d91267ec1 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -142,6 +142,11 @@ static void decrease_preferred_cpus(void)
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&cpu_preferred_mutex);
+
+	/* We can't end up with no preferred CPUs under normal conditions. */
+	if (WARN_ON(cpumask_empty(cpu_preferred_mask)))
+		return;
+
 	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
 				cpu_preferred_mask);
 	if (cpu >= nr_cpu_ids)
@@ -150,8 +155,6 @@ static void decrease_preferred_cpus(void)
 	/* Always leave first housekeeping core as preferred. */
 	first_hk_core = topology_sibling_cpumask(cpu);
 	cpu = cpumask_last(cpu_preferred_mask);
-	if (cpu >= nr_cpu_ids)
-		return;
 
 	/* Find the last CPU which doesn't belong to that first hk_core. */
 	if (!cpumask_test_cpu(cpu, first_hk_core)) {
@@ -246,7 +249,7 @@ static void steal_governor_loop(struct work_struct *work)
 	 * else: steal ratio is within bounds. Still do design checks so that
 	 * module restores to active if CPU hotplug breaks those assumptions.
 	 */
-	if (!preferred_cpus_valid()) {
+	if (WARN_ON(!preferred_cpus_valid())) {
 		reset_preferred_cpumask();
 		return;
 	}
-- 
2.53.0


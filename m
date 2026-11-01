Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793560948;
	b=KAS+q8QubXBAuBc3tv8JfNrzdRnTCdkyKqTjBFD2VBD5UwMiTza6MidsMyNn/RcfoYwC
	 WIR9rERah6gOTIiR2q7RFl/7cOPtd9oUTfhLlrHg4Em4umLf8HMc04BDNulWeNkeELuFL
	 1iN9NNe+1WaYGucY4fvhVSlax25A/+shboOoWZdZyLWFMJR09ScQKUHgYF1nmjddiKPUB
	 gORh4DZNED7xFTiES20Mog8Qgk0TLoxF9OJeYdSZdcB+lBv+zkII0CqyKDtACHXqVyjTb
	 ID3ynHJGqBC4BJae8/Kg99KU5XAN8H9oYSDp+ykGkOATdEjLvyyarn4tbnEIwz9BDHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560948;
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
	bh=DFN6TFhZQgorw0AL8LQAgGFErGer3pkEfhLudyS4XIA=;
	b=kmxGpsf9ZUhhslrxFGaDdNelgBZeXXJg35I4Y+KDFye09DNKCqwjDzi8AIblm4GPMSlL
	 pNQkAopvopR/eU5mJr7LzmBcSY0ZSn/YIISsmlY8f21AJX9EF6YwDJBqbk4tvIqX0lz19
	 nC0Ys7kmA1VKw7GEXox6tRSJM0cooDMDaCCu6UA+qoScHvkMYSS13dsnSPSHRCUyQIblc
	 GgFC04GLzuFpabpwNPN4uUIxI8g0CTYbypWEAH1goD8QmCSNEYt5O8EMrS8AzXaZXEHbx
	 BOjMJkf9WYNhrDF2rz7UG71hrnKWJur/PMy2IX+1cMizyqfmhwWtXOzr5dYn2DT1KKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U36AzFQ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBD60A2625;
	Sun,  1 Nov 2026 19:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEBD60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U36AzFQ6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUangFRm4RwQdpkda3n1TSEdTePtEd8pa61gRHC0tS6qQV8hulXIcJtXFx/4r544eq0OuTiG4fDwyrtljmQDpdX904JivWR1nnk9UZR8OCUfe6nownGg/qSp8A5NKcyJ7HuJnlP84bJ6LufR+9jlSLTa4OCXxlryFde5Mao8yLUQ9/KCiyds1BFBVlrQw03MxVex1iQx2JJ3+FjfW1tBRaMeJuQa+vkHlzH6e6cemyuXTQijfQ6AQlOGsut89lL+jbb/y1JWbVRerIU/AEInqwHZa3IUCny508qIstwcXEhxs7pq7L2K/UnWT0Nfgqok3xQv+0rRu56pWUFp/xMdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFN6TFhZQgorw0AL8LQAgGFErGer3pkEfhLudyS4XIA=;
 b=NI/EvMBb/EBLpERKuOvm3v59zBed3LDnWEX+gr99jtamIsCMgHsiw/i3QSwFtr8hThYgsFdX2SW9Pj9mNHkQTZdLjjhSuWYypcXD6enQD6SxNzLxNjPxQK8wM1/m8zHY68ukqjnNOGSKq4eNzdQhVsMu/ystAxDuwXSccrnPhDOm0PUbKEXQxMXWPu3ujVfhkUwGvUltRJxklbVszsNhMQ0x9KdhM1BfBKvk63a5Q5WpaW+mCS3IThkH10mMzhKXzK2gG4JoZNMI9Ny/4KkHjKb6x2YZEOcpklXuQyZcKvk/PL5qU8nReIeo7vhyTdeq1B32qqUBV5AkTy3fW5+sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFN6TFhZQgorw0AL8LQAgGFErGer3pkEfhLudyS4XIA=;
 b=U36AzFQ6huIx2FOXyDP9JvPso3en+F3IxrYi+NrsDDbJj6W2x9Q424vZrdmJDPgbLcyfldQ/Y+whHVM98/pwQytU6ipL4b0j+iZ9hZNHYbUxnxF9NzWm0o/qMHU1RV2J/j3IWTKisLmrO9YYuIS1itrZZ7rGAegQkUDNT64dFwmsvjn9b5/wOOj3MLGF6a77xBItNnkosk4To/KwznsCa6ej0tl2KwFrUikI/Eils/QJWA/42A85EQMRgw9EoMUUtQ+yEfqqotDiTgNXVGPLm5xbHAUuOJgffS7HrJHoAwgec1UAvJmIXw+Nj8QvVOGuIO8KcXfvadoSLxiCRDn7vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:22:14 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:22:14 +0000
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
	Johan Hovold <johan@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Subject: [PATCH 6/6] cpu: Add per-CPU preferred sysfs control
Date: Sun,  1 Nov 2026 14:22:02 -0500
Message-ID: <20261101192203.6979-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0765.namprd03.prod.outlook.com
 (2603:10b6:408:13a::20) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: fd079b16-a8b2-46ae-9fe4-08df384d6f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SSW9XmkXGi0XHl4mBXIKQAlejmB3Hfy/Y4GwmcvzEsLRTPs+hkGLxHpqUja6ctRk+o53KPaxKMuV0Z3xvITtYXYyicGOcVCG/o6sE4K2+rJkk/QHmAS9WcGX2uANr0wcD5cVICeWz9bi4KvfRFdI+p2gYPAZJCkPGtwk9+vBYFFWWOlKop52FxT1GcbZ0kmOFa1r3ebQf37bXVjMXykP1wCh7f5O14n0qABuSnN8pbnf7QDnnyJAoSRQTuoAgNQt716ks6A8hY0qesw9K2us+//19rO9qRXz0LH+qZWy98F4GxJWIj+OMh/cV9n3JbyXgCOMc3Fm9vBH0M0LiA23K8ypbs1YsbldoKHaf2chE3c+NwMvV8yopdSdyiw7luqlu4jdC9RrW697N8ZlGkIkXj7yog23BU9NIWtTFnrnl2khiJhSZi8B9k9hbrElHwR9d5RvSmvY9fORCm93PVM3a1wH6GZMnONl4wg20vjJze6MMdsaEyGa1ggiG0iaOOyylNDVzRwl8fvJk4WgF3kU20yrRMnTVAzoKIy9acAiCzF+XC4rcwMR0l7IsVqtlOQy6kmCusrj6TDnht3FdNAVbopoj+efBMdUb2xkcT1fQvWgCzQz8jdLN6U1ESwYhdKlPyHtlPDLAMlEtkpeYkne8FpvXJ1vDRUfMDX2G6F6ZKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/94WhPhrwx02GyosoYxe6/uQJ9LnqrJYerytdfoIibMu5f9fQF23gRiRE2l?=
 =?us-ascii?Q?4lKfQGqFgApg0Z4bGvB/qxtHPXSrqsSMZ41sf2LshbHfXPnCSn/V3rj+TO7L?=
 =?us-ascii?Q?rcrNJJDM+Mt+b8zwGIYZODOvWl+NXKnTSRPSAGJp7DGUBumq+RRXzzcext7b?=
 =?us-ascii?Q?wEc6bIkVwrzi98MS3Xwa5XEGtc/Rbzb604Dly21CY2Mq8A9RRjmMLUXGSs9U?=
 =?us-ascii?Q?e/Wt/kDi/fkktYzKdgz8e7tzf89ezh9Dr9TOsnf0/kDKrTfjOgMWQfX8sfgx?=
 =?us-ascii?Q?nummimXDxH4iOZHJ005H6Ohe2W5ZmNf3Z88gK4tzwRw6NA/xQ5YVBK3uGeK6?=
 =?us-ascii?Q?e2ujgvytWU9wpfsxtW3Pc7sJiW0mXV1ULyQej6XGmqoUIa8Zz5RoY5vYbZY5?=
 =?us-ascii?Q?ceorzY1gum7grTIzLZEqHxig8hMu0fFJOj5tZ8CE7vsn/Mi7kyv1kCX+Hkv9?=
 =?us-ascii?Q?J5b/3k5f28K4WNHEYxLyH74//oicEIF0sbWKFgSAQymrqh0+62q/tgIeOaEj?=
 =?us-ascii?Q?gLqd0wg/JqA0MNbPUiySUfzqIASCprIsW8MheZXbk68JjXvkB5B9OjiTgpm9?=
 =?us-ascii?Q?tK2w2E31fhklLQbucuKDrlkNHLwRZhdWCrbyS0Bc9HQCy6Zz+LGp/3uXYo7K?=
 =?us-ascii?Q?IaqugTmuIxLC92txdjLnn3YidU7mPTIsPcxVjenwTPNwzlcRDzsKIKXeRwwQ?=
 =?us-ascii?Q?yocZtBrywyQYysyAq/pVrpG4FQkRTxN+NsG84RoJrsNhMhcB7edmfHGEAFXG?=
 =?us-ascii?Q?vYJBft3BQetMfSPLf03l9CBBVf2rPJTeNYDX682YesdrugLgy6JH2yye6WdY?=
 =?us-ascii?Q?GcqhLICZwNkRSs/aQyWWxyly59TjXAp0prZGYwpxFFIKXV5YQqTgjpF80fe2?=
 =?us-ascii?Q?9H07iCjtCpbOWSBnS76Fp2Uj1xTjNZ1FKJSyT0FqiV+3c6LbYpiYBLieNxXZ?=
 =?us-ascii?Q?yQLV915QWoUzDTixsC1fo7fSwFDiY3YAM6BHEEwedBvwjr03ckVEyMa+a0gF?=
 =?us-ascii?Q?GM5F3ZNMRWCTakODPAtZ+A/6lays5Fp9HfzNzO+lQQhZYeAJtUemgdnoyaRT?=
 =?us-ascii?Q?a3hJmLG1x6MYXDdY+oAStPaHyGrohnX3VQOmCfHZ6K02zWlxeEkpkTcBSkqE?=
 =?us-ascii?Q?WInL/oN9bPek+htprA2nlNEJ4Y4hih+QJC6/fecK1TOMvGZ3k+BPsVhTrth7?=
 =?us-ascii?Q?dAfCckmaquAHKEXeASjFGJTN18elxJalryzvEBUiGNw0e4zh0NgFdzOieQHK?=
 =?us-ascii?Q?ZmTDmiMNL9il8omErHBmBSeBHSy3wy9oHaIDdEn0/bOEwdE5gIyBxERxsOOe?=
 =?us-ascii?Q?XWk603KsdeVdCUhR1+p2XTLlF9Bmi4E1SDNKvGtKTD2sSg73ZPIX77GmsKPP?=
 =?us-ascii?Q?cSHqxZ3FOgWW3+qywJH9chWwdZx+uMrXwji+ApJJDXy0tdQMetEtBYqC6e8e?=
 =?us-ascii?Q?8X3Cl9RI+aiZZoKxI75NP8KH9M0esr2U3yo6W4YRXjhRd9XMiqOHSjQ+Pkux?=
 =?us-ascii?Q?lYxqfvjgQF4FsWCgPC2yYPtfsSbotvAwYR3kJiOcnPCPIP5rYj+7QUF0wYMV?=
 =?us-ascii?Q?933l6Za0XHrBAsEYDEEYDZSrFQ3WAm9EbE/RVbtTHwkWa0p7b2mlcM1GC5Vc?=
 =?us-ascii?Q?9VO5df250ONPGZJmqFMGwCsp1kvC/Im8frfgxA1/vAxGQah7iHjGK9rjvr9L?=
 =?us-ascii?Q?Tzvq5laf43TOG+LmzF2+L7IBoXUmRhgdfa/AuiBJwSCLRP8BNzKAJCRu4NPW?=
 =?us-ascii?Q?l7AOenEhsYUr1eMJoHi0QWtAVgp07Z5Hbvj8aExPW9NBcr3rdJj5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd079b16-a8b2-46ae-9fe4-08df384d6f99
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:22:14.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heYFxuHEVzPMUbiD8aCkseMncoQYyxrcrzk0GrbHHt7ky/TOVd82q1o/YD/MNM/WKaAqpkCY8QuS2S8PAjggAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

Expose a writable preferred attribute for each CPU so users can manually
select CPUs for scheduler placement. This allows users to select any
desired combination of preferred CPUs, except for selecting inactive
CPUs and deselecting the last preferred CPU.

The manual method doesn't imply any preference over automated governors.
If an automated module is loaded, it may override user preferences, and
vice versa.

Fair tasks whose allowed CPUs contain no preferred CPU can still run
on active non-preferred CPUs. Other scheduling classes are unaffected.
This creates an environment similar to isolcpus, except that the list of
isolated CPUs can't be changed at runtime. Tick suppression, RCU
offloading, and managed-IRQ avoidance are compatible with preferred CPUs,
but may require separate configuration.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 14 ++---
 .../sysfs-devices-system-cpu-preferred        | 37 +++++++++++++
 Documentation/scheduler/sched-paravirt.rst    | 26 +++++++--
 drivers/base/cpu.c                            | 55 +++++++++++++++++++
 kernel/Kconfig.preempt                        |  9 ++-
 5 files changed, 128 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-system-cpu-preferred

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 545687ebadcc..0af57b55ed30 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -821,12 +821,10 @@ What:		/sys/devices/system/cpu/preferred
 Date:		Sep 2026
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
-		(RO) the list of preferred CPUs applicable in
-		paravirtualized environments.
+		(RO) the list of CPUs preferred for fair-task placement.
+		Fair tasks whose allowed CPUs contain no preferred CPU can
+		still run on active non-preferred CPUs. Other scheduling
+		classes are unaffected.
 
-		The steal governor driver dynamically adjusts this mask
-		based on observed steal time. Scheduling tasks on
-		CPUs outside of this list may lead to performance
-		degradations due to underlying physical CPU contention.
-
-		See Documentation/scheduler/sched-paravirt.rst for more details.
+		See: Documentation/ABI/testing/sysfs-devices-system-cpu-preferred;
+		     Documentation/scheduler/sched-paravirt.rst for more details.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu-preferred b/Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
new file mode 100644
index 000000000000..39ebfbdef365
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
@@ -0,0 +1,37 @@
+What:		/sys/devices/system/cpu/cpu[0-9]*/preferred
+Date:		October 2026
+Contact:	Yury Norov <yury.norov@gmail.com>
+Description:
+		Control the availability of a given CPU for fair scheduler to
+		place tasks. Reads 1 if this CPU is preferred, 0 otherwise.
+		Fair tasks whose allowed CPUs contain no preferred CPU can
+		still run on active non-preferred CPUs. Other scheduling
+		classes are unaffected.
+
+		As for the online attribute, boolean spellings such as 1/0, y/n
+		or on/off are accepted to set the preferred status of the CPU.
+
+		Removing a CPU from the preferred list and pinning a certain
+		task(s) on it provides a runtime environment similar to
+		isolcpus. Tick suppression, RCU offloading, and managed-IRQ
+		avoidance are compatible with preferred CPUs as well.
+
+		Selecting an inactive CPU, deselecting the last preferred CPU,
+		or writing an invalid boolean fails with EINVAL without changing
+		the mask. Writing the current value is a no-op. Writes across
+		all CPUs are serialized. To replace a selection, select new CPUs
+		before deselecting the old ones.
+
+		The list of preferred CPUs can be found in:
+
+			/sys/devices/system/cpu/preferred.
+
+		CPU hotplug sets the status of new active CPU as preferred, and
+		deactivated CPUs become non-preferred. Offlining the last
+		preferred CPU resets the status such that all remaining active
+		CPUs become preferred; and emits a notice in the kernel log.
+
+		This interface can be used together with automated interfaces,
+		like steal governor. All interfaces have the same priority: if
+		running in parallel, they may override each other's policy in
+		any order.
diff --git a/Documentation/scheduler/sched-paravirt.rst b/Documentation/scheduler/sched-paravirt.rst
index 311cdbf2722b..2d8e83194c48 100644
--- a/Documentation/scheduler/sched-paravirt.rst
+++ b/Documentation/scheduler/sched-paravirt.rst
@@ -42,13 +42,31 @@ This is achieved by:
 ``/sys/devices/system/cpu/preferred`` prints the current ``cpu_preferred_mask``
 in cpulist format.
 
+Manual selection is available with ``CONFIG_PREFERRED_CPU`` (which can coexist
+with ``CONFIG_STEAL_GOVERNOR``). Write ``1`` or ``0`` to a CPU's ``preferred``
+attribute as root, for example::
+
+    echo 1 > /sys/devices/system/cpu/cpu1/preferred
+    echo 0 > /sys/devices/system/cpu/cpu0/preferred
+
+Only active CPUs can be selected, and the last preferred CPU cannot be
+deselected. The attribute is available even for CPUs without an ``online``
+attribute. The aggregate ``/sys/devices/system/cpu/preferred`` remains
+read-only.
+
+Manual writes and steal governor updates are serialized. Manual selections
+are not persistent constraints: subsequent governor samples may change them.
+
+See ``Documentation/ABI/testing/sysfs-devices-system-cpu-preferred`` for the
+interface and CPU hotplug semantics.
+
 Notes:
 
 1. This feature is available under ``CONFIG_PREFERRED_CPU``. Driver which
    makes decisions should enable it. For example, steal_governor driver
    (``CONFIG_STEAL_GOVERNOR``). On enabling the driver, CPU preferred state
-   can change based on steal time. Without the driver, preferred CPUs is
-   same as active CPUs.
+   can change based on steal time. Initially, all active CPUs are preferred.
+   Manual sysfs writes can change the mask without a policy driver.
 
 2. This feature works for the FAIR class only.
 
@@ -56,8 +74,8 @@ Notes:
    to run based on its affinity. But no load balancing happens if it is affined
    only on non-preferred CPUs.
 
-4. Decision to change the preferred CPU state is driven by the kernel.
-   Hence it shouldn't break user affinities. One of the main reasons why
+4. Preferred CPU state can be changed by a kernel policy driver or through
+   sysfs, while preserving task affinity. One of the main reasons why
    CPU hotplug or Isolated cpuset partitions was not a solution.
 
 5. This feature works best only when all the Guest VMs enable the feature as
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 747915ff974f..79896dae92f3 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/cpu.h>
@@ -145,6 +146,54 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_PREFERRED_CPU
+static ssize_t preferred_cpu_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
+	return sysfs_emit(buf, "%u\n", cpu_preferred(dev->id));
+}
+
+static ssize_t preferred_cpu_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned int cpu = dev->id;
+	bool preferred;
+	int ret;
+
+	ret = kstrtobool(buf, &preferred);
+	if (ret)
+		return ret;
+
+	guard(cpus_read_lock)();
+	guard(mutex)(&cpu_preferred_mutex);
+
+	if (preferred && !cpu_active(cpu))
+		return -EINVAL;
+	if (!preferred && cpu_preferred(cpu) &&
+	    cpumask_weight(cpu_preferred_mask) == 1)
+		return -EINVAL;
+
+	set_cpu_preferred(cpu, preferred);
+	return count;
+}
+
+static struct device_attribute dev_attr_cpu_preferred =
+	__DEVICE_ATTR(preferred, 0644, preferred_cpu_show, preferred_cpu_store);
+
+static struct attribute *preferred_cpu_attrs[] = {
+	&dev_attr_cpu_preferred.attr,
+	NULL
+};
+
+static const struct attribute_group preferred_cpu_attr_group = {
+	.attrs = preferred_cpu_attrs,
+};
+#endif /* CONFIG_PREFERRED_CPU */
+
 #ifdef CONFIG_CRASH_DUMP
 #include <linux/kexec.h>
 
@@ -190,6 +239,9 @@ static const struct attribute_group crash_note_cpu_attr_group = {
 #endif
 
 static const struct attribute_group *common_cpu_attr_groups[] = {
+#ifdef CONFIG_PREFERRED_CPU
+	&preferred_cpu_attr_group,
+#endif
 #ifdef CONFIG_CRASH_DUMP
 	&crash_note_cpu_attr_group,
 #endif
@@ -197,6 +249,9 @@ static const struct attribute_group *common_cpu_attr_groups[] = {
 };
 
 static const struct attribute_group *hotplugable_cpu_attr_groups[] = {
+#ifdef CONFIG_PREFERRED_CPU
+	&preferred_cpu_attr_group,
+#endif
 #ifdef CONFIG_CRASH_DUMP
 	&crash_note_cpu_attr_group,
 #endif
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index fa6d0eba5b23..606aba68590f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -203,6 +203,13 @@ config PREFERRED_CPU
 	  respecting task CPU affinity. Non-preferred CPUs remain online
 	  and can still run tasks whose affinity requires it.
 
-	  See Documentation/scheduler/sched-paravirt.rst for details.
+	  Preferred CPUs can be selected manually through the per-CPU
+	  preferred sysfs attribute or managed automatically, e.g. by the
+	  steal governor to reduce CPU contention in virtual machines. All
+	  active CPUs are preferred initially.
+
+	  See Documentation/scheduler/sched-paravirt.rst and
+	  Documentation/ABI/testing/sysfs-devices-system-cpu-preferred
+	  for details.
 
 	  If unsure, say N.
-- 
2.53.0


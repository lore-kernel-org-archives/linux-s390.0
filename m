Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020125.outbound.protection.outlook.com [52.101.191.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56043453489;
	Thu, 26 Feb 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134702; cv=fail; b=OOoaoIHH5Q9sYiKYrp53NqnE4VHRFHFyd3rIxEHC3CrbwloJqIDv0GuF/zov6nrVZVweoC/C83PUskoAFACwvDFRJ9pXhnAUVwUDivXLmq07LfqUtLzxV7nXRYL2ueKq3+Uv1U8vjkzbZ8I+vXxdzRcmtwqicyqArwROOPXSexI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134702; c=relaxed/simple;
	bh=ujXkoo0S6N8XxOg9MndyfU24hJRzlZjqLTjzFKY0y9o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EHmgRLfa5jwHaVyiSsXs8Ou7Qh9juTv1k2TqvE9B0DWLywwMw6hr+Ciwp/xhIwT2i1Ko2/o/K2VyVJVJ/6ud38PUguPDEdTJBuFBIfHRmInW5FGFhic8VmImEbt6rfyaid3PQvF8+6/lpLxaMB6ik9bLjTEQti8kvEfdMrD4RMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ljq4Zy2H; arc=fail smtp.client-ip=52.101.191.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ljq4Zy2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYFA5QT8/Z2uqyXF9bAJr2QDoaeyVYd9ISbS7hZmSHYyyt+Xlz4DTe4uJGmHrEAsMrZwB2laezCTG4cPQMGCC4g28TXf8Tk609Wl7Zfu0woBqlBnX9dwX+A7FQpVetZoVSO67AS6t77ovHhrCq6pmMte8QFKPWgkTEHZX65tyDWjA3Eoi+qj1B+Y6VgS5h4nqaCjXfCVlm4aU2FApXZzOkXXYyi3C8NAGgSYQ46cbnQpBMrqWI0W8HMGi1+4h7N4iss52C8bQSsafjOVMec+5rDaSK57TX+Wt+huRev1pVKFnM3uvexUIPC28zVP5Lykssa28hDTXqCiDKg+IHzZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0/ywz2YpQbgAvJxO8niF9tasupNphZbfoy+mMgWY6s=;
 b=iH5V86+3vcc9NGBZsAmw6TwI8RUxVUebAvPZwSZzZLGWJx6VEgev9IaOKnKCPkMkCkkSSA829MWsTDl1XuUZq2ICYWsTo7oa3aGlrUQrut+eOOepgLrZNkrE1l7i8u6CWIOSDQPhSO8frDHJwzqNwPr+HdpPFY8lyD8B2FpeBfjsP5K2N/QWrwxbLne5/KDZgpUve84M7ji53NOdLrPD5civnR8PTMJaLhKq6nbnMl4TAkYzk+T0OIv16IApZT3F73ls1iiRj6ZVJfciphW74O/P6qympr/bVIHHyII8sw/2u9VI/8j96GSmlBov362TAdqoqCoblH+sgs3wr9h0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0/ywz2YpQbgAvJxO8niF9tasupNphZbfoy+mMgWY6s=;
 b=ljq4Zy2HKNKeau2C4x5bnQBNQlR7w+MsdYIQog6qQICI1OWh4cskJRFSGYCotPAGjjMwBaKllzd4Vez6E4Ky0p+ligIJFUO68VJO/2VcoK8Qa++LCJjoqeF+6rFbcRhjJOyASpgRR13jQjl3pOa/pOInUS5H5pBQ/K+bLVCUCRn6ns5c3RQL31Rul5kj1szWpcVLCUT/0WevXAw4rETY1XGHGp3AGHbKarSB1r8Ulwit6LdGR29CMrdsSxeO8NLdv1YrtoXge9KYod4GIfSrDxyWz4d+LeA9WpoKYXkgVptyS0zlmzuIWFWvyWifkqofvmQ8h3tn6Mdce+RGIUiefg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6364.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 19:38:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 19:38:09 +0000
Message-ID: <73e6fea9-caf2-4404-b511-11646013f8db@efficios.com>
Date: Thu, 26 Feb 2026 14:38:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/3] Improve proc RSS accuracy
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
 Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260217161006.1105611-1-mathieu.desnoyers@efficios.com>
 <20260226120422.8101Cc2-hca@linux.ibm.com>
 <59b28cb4-4fff-4888-b562-7b7236e29d27@efficios.com>
 <e0af317a-d6ad-4de4-8bb1-215d5dce7351@efficios.com>
Content-Language: en-US
In-Reply-To: <e0af317a-d6ad-4de4-8bb1-215d5dce7351@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a5d4a0-42a5-4523-1c57-08de756e9248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	01Cxd3v0Ce/1Wn8lvkPcQRfPtHnOH/O60tNHMvOVKGT3HSW++PIha6Cf90uPPStNkyUaGI/PKtADZHraaoJ/j4ecn7Ge3UEoAqa8wZLvOKCgesCh2AKUnVyudU+WvGz/r0apzEUZxnptsbtnjq0SiSyLvAHoBhB+UzGcR1Ld+pb3aEyUoiRlj73ZY24RScQYhAGQVFWJNgCdyxJLrrEyF9Tml3Q+/LMBo8XGLrv1SSwjERi+qiWfRPAGDgAecfIgKBEriUYz5e0CqhJaj7nyGwl6KBuqcaYYGTk28p8vg/CfdYrkt+1BuXEon2t4HzFGFU7ucYwxjRMEH2q3gwBVDQCKxNzA7Q4JMOvWhWPaIlVOTMw/ZYpklJLv6YxE9dDsy9Qq7sqT34N3MBhKYZUpI51sO8INurYNB+CZFUhmuk+gknfIFeXGMqxRYsYoIS3V5T8A6xyN8xFAAerZo588XOUSIA0S0oA2vlSQbrzn8xIjQMNwyjGQbvwVuHD/CZJ39osMblS+7A6+ghp4zZYfqDj9WqsZ/7ytHlH91V/ssJgKmSUX+AvaJIAUbxXocV4Tjb8puIaBBIgz2VunNwQifzHuoJgrdScw4TbWHUr0DfDk9xX7olsErb9hFJbhOtZcxwhXkPLuioVohHOwkFpwWVWZfJm0w2MmdW8J0yJ7m00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG5MTWs2dWFndDBtOVdpbEszdmlIWnFQUVJMTGRIZllYNktQWTljUlJzbS9Z?=
 =?utf-8?B?M0ZLSHpLMlA3NGhLa2RFWStWeWJHUGorbWJyV0JYMHczUkdrMEZFT2ZnZTZj?=
 =?utf-8?B?THhaZkI0bWtWRThTVWlTbjBlc2pmdFBzaU9scGZNcFdCK0hWQ3JlbW5sQk9L?=
 =?utf-8?B?ZVZXRjlsRlhlWENNa2kzL2xVWTU1blRmZVVDcWVUV1J2eHZseWpmZ3EvS2Y4?=
 =?utf-8?B?T2xsV2ZxbnE5S3c5bEx3SDNwbUowY0ZKbGZKYjhkQVZOZEJ5c3o4STVubklT?=
 =?utf-8?B?Y2JVL2lvS0lNOFlPSlJkcE1DamJSYU1aVEt5WDEydXB2VVhVNm1Db3hISk5V?=
 =?utf-8?B?cHJKUE1FUkN0Y1VQdm5WZDZsTFRwdXpDV2xmWnJKcWhGanNSb2w2cEZxQ2Q4?=
 =?utf-8?B?VEFhejZzOEpyZnF1clVOZG1wdzEyeFMzdFdvbnZFQU1QQXVkWjMwUHZGdlBz?=
 =?utf-8?B?cVU4Wnc3WjNERndxMEIydUFjbzlJd3pXYW1lZDBnQmpLQUZ6bmkzMmtISzh0?=
 =?utf-8?B?bUlBaGdWbU1sYXZHWUlTZWxyT0E1SnlETlNxd2VlaTZLTWI2WWM0eTA5TFdB?=
 =?utf-8?B?WnVEWklSWnVnZ3FEYm5VRmUxMGxUY0xydHF1L3dqeUxTcWV3QVB3SlQveU1w?=
 =?utf-8?B?cUJmM0lOUGhGU3lMaHVVN0t1cytrRGVlRVJPVXFSQnE2ZHZIN1NScTM1RDht?=
 =?utf-8?B?TTkwYWNJM1FodHN2RTZrTjZ6dmtKTWRtc3YxU3NsaDVrY2p4eXFQanZGTnVl?=
 =?utf-8?B?cHgyTDJZRjFocGZrMDU0NTV3YWJaTng4SjBWazZaK3orSmlHdzdFZjNJbGdB?=
 =?utf-8?B?aVRnVUFZdlpMdDRINkxrbk9WODNEWWZvQ2ZkSExDQnl4NEhIRjkzc2MzTDVK?=
 =?utf-8?B?WGM3OXNMT0JQVUY1WVJBSUF3U0lia1pUaEVFck1PK2QwVURkV0dYd0RUV0t4?=
 =?utf-8?B?MGN0WEZUQmE0NU5wcUlndjhicEhhK3J1dk1zK0g2Zmx6VFBNbXd3OVpsTjFY?=
 =?utf-8?B?MFU2Y2wrN05ETjBIM3NYN0dTOVAycEZLOGh1a1YvSUgyL1NGQlFZcDR6V1NB?=
 =?utf-8?B?UVBIMkpqZ1RRVitEcWFudXhiaG9FcWxIY2MzZDlEaW9TOEZ1TDVoTG1OT0p6?=
 =?utf-8?B?ekhISGRRdHE2dkNZL2hGU1lYc3FhTEM2MkowSk9aMmNVVlByZ2dXZ2c3KzdE?=
 =?utf-8?B?TitDQ0R0VE1qUm8xUGo4TlVEWU9tNnJHeFAzTE53Q3lOM3NhZEJ1RW11UW1Q?=
 =?utf-8?B?SlYxSm1wd21hS0wvSm1ZTHV2bTdXQjB0cWQ1QWxVRC9tbnBwSk40REo3OUZ5?=
 =?utf-8?B?L0hLTGVKQmFaWHo1K3VKV2xSMDN1bW5US3VSMTYzMU5XbTBBNTlaREdnaEdD?=
 =?utf-8?B?M2p4N1g5U2tEVjY3TWdsakdtVktwWVBUVlJHVDRpQ3RyVWlpMWpGS1l6MG4x?=
 =?utf-8?B?WkoyNHBPVmdTclJjMG1mcTQ0WTlkK1QwalVDUGw5UW9CZUwvaGlqdDFYVlVo?=
 =?utf-8?B?b2hDS1hXV1dYTE92a01DUVNHeXYyWmdPMWdaK2JWZmtscUxDaXhhREdqa2tu?=
 =?utf-8?B?eFNQUkJUT1FIKy8vY0RBVWZlQ0J6R0ZtdVB5NWczcVlXUUhiZnRPa0JHR2hl?=
 =?utf-8?B?dE9TYWU1RjFuZmV5bE0yT3JNMXEwVEV5cjJrM05scEZrL0pxTFRpaXhIWVl3?=
 =?utf-8?B?SE15NUpDNkRHcjlmUTRJd3RQYjBibzcwVDBvbkhmaTFmU0Z1R2NndE1kdWQr?=
 =?utf-8?B?UFJyaytkVXpTRmsxSXd3WHRPR0VEUFE0K0pVV1N6WStFRzFoZFJUbDlGZHYw?=
 =?utf-8?B?cGZTTERJdEJaUitDQlIwcFFJUTQvbGErL1lXQkFVdEk4cXZxTUxtTmJYU2sw?=
 =?utf-8?B?VExSeVlINVFvV0I3WW1NRzVXOE01UlBuWGg0TkYzTDVYRThrRzlTaUJoOG1E?=
 =?utf-8?B?c3BYQXI2Zy82WnlRMjFnSWVYdVpkNEFFSW1RK0ZtdlhnaCsvSk0zb2sxS2pI?=
 =?utf-8?B?YTA1WkVHTGV2cStUdTZtOGswYVNTeDN2RVdFMU05b3dET0ZTQ20zNk5ydUlY?=
 =?utf-8?B?RW05aVMyU1loQUExbnRHempKenRFeWhoVHd2NGZEWmx2MjdPdlAwd0gxWFVM?=
 =?utf-8?B?SzNyWnZCYkJqN0RlbVdjbDA3TUdqNHc1RE90VFlqWUxsc3FRS3Fnb2U5R3hq?=
 =?utf-8?B?RFJxTnIyTTc4T2RKVWgyenhMRlpMbGg4RXJkT1BQb0l4ckQ0ajBvZzJWTmRq?=
 =?utf-8?B?blZpOExpRUxSamNOaUM3UUhCZTBUYlNCUStKYkM3OUthaFFJeE9JcWEzSDhS?=
 =?utf-8?B?YmRzdG4vN3dHUHRFOUl3L0NGalVySGRhMC8yS2d5dFkrRmF3VXBYVGt2QVRG?=
 =?utf-8?Q?5s/3lD1ThQ54VER6Kd+yB8KAhrLJGxWfgf1ds?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a5d4a0-42a5-4523-1c57-08de756e9248
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 19:38:09.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og9qD8WfYexPNbOj5aCSPmA2KPLJCJRUIqGzpv4o+U5jXOa2Mw/In8NwUZEvPSkoCmkneiICuAoDbBZ6du0Py9KpgORsq70KCjMC692IQvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6364

On 2026-02-26 10:42, Mathieu Desnoyers wrote:
> On 2026-02-26 10:00, Mathieu Desnoyers wrote:
>> On 2026-02-26 07:04, Heiko Carstens wrote:
>>> On Tue, Feb 17, 2026 at 11:10:03AM -0500, Mathieu Desnoyers wrote:
>>>> This series introduces the hierarchical tree counter (hpcc) to increase
>>>> accuracy of approximated RSS counters exposed through proc interfaces.
>>>>
>>>> With a test program hopping across CPUs doing frequent mmap/munmap
>>>> operations, the upstream implementation approximation reaches a 1GB
>>>> delta from the precise value after a few minutes, compared to a 80MB
>>>> delta with the hierarchical counter. The hierarchical counter 
>>>> provides a
>>>> guaranteed maximum approximation inaccuracy of 192MB on that hardware
>>>> topology.
>>>>
>>>> This series is based on
>>>> commit 0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git:// 
>>>> git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
>>>>
>>>> The main changes since v16:
>>>> - Dropped OOM killer 2-pass task selection algorithm.
>>>> - Introduce Kunit tests.
>>>> - Only perform atomic increments of intermediate tree nodes when
>>>>    bits which are significant for carry propagation are being changed.
>>>
>>> This seems to cause crashes with linux-next on s390, at least I could 
>>> bisect
>>> it to the last patch of this series. Reverting the last one, makes 
>>> the crashes
>>> go away:
>>>
>>> 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 is the first bad commit
>>> commit 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 (HEAD)
>>> Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> AuthorDate: Tue Feb 17 11:10:06 2026 -0500
>>> Commit:     Andrew Morton <akpm@linux-foundation.org>
>>> CommitDate: Tue Feb 24 11:15:15 2026 -0800
>>>
>>>      mm: improve RSS counter approximation accuracy for proc interfaces
>>>
>>> Unable to handle kernel pointer dereference in virtual kernel address 
>>> space
>>> Failing address: 766d615f72615000 TEID: 766d615f72615803 ESOP-2 FSI
>>> Fault in home space mode while using kernel ASCE.
>>> AS:000000025dc04007 R3:0000000000000024
>>> Oops: 0038 ilc:2 [#1]SMP
>>> Modules linked in:
>>> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
>>> 7.0.0-20260224.rc1.git266.3ef088b0c577.300.fc43.s390x+next #1 
>>> PREEMPTLAZY
>>> Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)
>>> Krnl PSW : 0704c00180000000 00000216ef164cde 
>>> (kernfs_name_hash+0x1e/0xb0)
>>>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>> Krnl GPRS: 0000000000000000 0000000000000000 766d615f72615f65 
>>> 0000000000000000
>>>             766d615f72615f65 0000000000000000 0000000000000000 
>>> 0000000000000000
>>>             766d615f72615f65 0000000081212440 0000000000000000 
>>> 0000000000000000
>>>             0000000080a00000 00000216efcb5390 00000216ef16530c 
>>> 00000196eeb07ae0
>>> Krnl Code: 00000216ef164cd2: a7190000            lghi    %r1,0
>>>             00000216ef164cd6: b9040042            lgr     %r4,%r2
>>>            *00000216ef164cda: a7090000            lghi    %r0,0
>>>            >00000216ef164cde: b25e0014            srst    %r1,%r4
>>>             00000216ef164ce2: a714fffe            brc 1,00000216ef164cde
>>>             00000216ef164ce6: b9e92051            sgrk    %r5,%r1,%r2
>>>             00000216ef164cea: ec1200208076        crj     %r1, 
>>> %r2,8,00000216ef164d2a
>>>             00000216ef164cf0: b9160005            llgfr   %r0,%r5
>>> Call Trace:
>>>   [<00000216ef164cde>] kernfs_name_hash+0x1e/0xb0
>>>   [<00000216ef167d32>] kernfs_remove_by_name_ns+0x72/0x120
>>>   [<00000216ef16bbfa>] remove_files+0x4a/0x90
>>>   [<00000216ef16bf96>] create_files+0x276/0x2b0
>>>   [<00000216ef16c15a>] internal_create_group+0x18a/0x320
>>>   [<00000216f09b61c6>] swap_init+0x5e/0xa0
>>>   [<00000216eec7fb00>] do_one_initcall+0x40/0x270
>>>   [<00000216f0990a40>] kernel_init_freeable+0x2b0/0x330
>>>   [<00000216efb5160e>] kernel_init+0x2e/0x180
>>>   [<00000216eec81ffc>] __ret_from_fork+0x3c/0x240
>>>   [<00000216efb5e052>] ret_from_fork+0xa/0x30
>>> Last Breaking-Event-Address:
>>>   [<00000216ef165306>] kernfs_find_ns+0x76/0x140
>>> Kernel panic - not syncing: Fatal exception: panic_on_oops
>>
>> It looks like either an issue with ordering of the bootup sequence, or
>> an issue with the size of struct mm_struct init_mm. I'll have a look.
> 
> I've successfully booted a linux-next 7.0.0-rc1-next-20260226 within a
> x86-64 vm, with a swap partition.
> 
> I wonder if s390x somehow alters the value of nr_cpus_ids late in
> bootup, after percpu_counter_tree_subsystem_init() ?
> 
> Can you share your .config and kernel command line arguments ?

I've successfully booted a defconfig s390x next-20260226 kernel in qemu
with 1 and 4 CPUs, and within a nested s390x VM on 2 cpus.

I guess I'll really need more info about your specific .config and
command line args to help further.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

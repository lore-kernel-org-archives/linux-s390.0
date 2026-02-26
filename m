Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020099.outbound.protection.outlook.com [52.101.189.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712D3DA7EC;
	Thu, 26 Feb 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120550; cv=fail; b=qJVylGuV4/nqX0vemT4KSIV9cfOkEnpj8XJHrcBp43PS8H5XmNePBhI56S4iqWbdcrnDEChUIOPd3+5ss768v4j6ukWVJuNobuKkycxmdi+S5qEK2UQvwq7VlGL/almBqa3RvsPQc9IM0E+nFucz+fPj0Ti8BwskDzp9rbH/Bsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120550; c=relaxed/simple;
	bh=h1pQ7CE4aCbk05Mr3hugfoRfXCpbuAxQlOYnYd4VCik=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iArdoNGDhNj5yGDcX/Wh9xT4cm/6VBACYP//ih0y/dwNevZsJLQQMbWIBhuzqICSIwatUwG2zS7vbnaGitrPEB9uRerKkPZSuxjRyKZHb7xtUSEHdCpkIl9kMHQ329kTkAwnhDXxvcEb3AUMcMLrkFbMNCfLqAMeKmEBax58GAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sOKpKmAc; arc=fail smtp.client-ip=52.101.189.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sOKpKmAc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrqOGgDyvhTt2Tzo3HyTId+Cr7xCCxksQkacMAfheGp2dtVoapYXu1/LtRIAPZxFB58RCC50P4ZPuVaOgEve8JyWLpDTvRabRMCBObizLKG0bPTgvJ0WvD/BD73bWlMGho+D1/tcTSlAFUtG2an6RA4+VxQaWMh6hYs+vh+LOmw7dmU6gxDvC1nYJFuYeA6pTABC1fAFGMXLoM1Mup12jIG8k0yiR20yLQs0j0qw8ujV4G6i4cx/i/MNVhGYwLgK7R4KBfySiSNhXqp1p0tc49hXNxzQNLEHFZG+/EEwBXsY1pxU48j2uGtQqfCd8cHsDVSpWF1WWDHv294GDD4T0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIKOOCpCu9R3FpMuh4CEGX8jFB7Rv0api6vkTQ+JqEk=;
 b=HPKGuuWrZcnCpLIMpfz38ECBUReF83hbYWl93LIlpjugMdAJfnampdBQsYcRZ5Uku4d9vYsTdiqodJwRttm9QaczGqjW/6b7tsaTQr9Fi5qBtoSdan5sE0UxKXkPb2YdmrHNILdf/z/VGs2y5Ugyj9es8MpYEomAo1bjde1NLGLpnaeIL+NvTTBip/7a4BTVREHQFzTEfc9JoAHKPsZkPJAZs3+aXL8zCw+6kAvJYTTppveLvJb00XDSK4bLg5H3jar5IP/A4NCRukXmzdll6lMPSkRcftTCZJH7/SUZfgdQ0FtMGJZF7J04AW+7m72dEdkSs2DfjMEaWkgpPQOw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIKOOCpCu9R3FpMuh4CEGX8jFB7Rv0api6vkTQ+JqEk=;
 b=sOKpKmAclUAAFM63Mq+MkC3ltMtB1gHzQEdNVo+414rrx9bSGRxpkK6ZhrrF26t1Kc4Y+Tg/UbWcR2hhFvMPzQr0j+RuAiVxSwxpjwssmHwR/T7/luS91gQyvsyy/WH4x6f78BVDuYKd05FpTrwrHqQeqqW7aaMkgGHDaFmSPhVs3qkHAM0WaD2x7sHSzV+SpBcLcOuYzTbAy8eSamHszpjYTTpt7WH8YU4qqU9MU8L7Y0oqEwkJIyQQ+BkH/CjICOq5KE1cLrKFJl9fXl496YHpMDt3gX4booWRZ1RfwbIQlVMM165sNvF9CyUPOqMEaVkRRZMAReMU6bprlVUNaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6183.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:42:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:42:24 +0000
Message-ID: <e0af317a-d6ad-4de4-8bb1-215d5dce7351@efficios.com>
Date: Thu, 26 Feb 2026 10:42:22 -0500
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
Content-Language: en-US
In-Reply-To: <59b28cb4-4fff-4888-b562-7b7236e29d27@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bf15bc-3995-4326-7ea3-08de754da2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	iMa9Np8Qci7crThVBo05W5hN2QyO4tEOVQKfyS88Wh9rAuxj2Hb0uqv7bpyFWqW7+CIjlzyiwc7ypkkvOu7Yu9Ykj/3j41xuZCS7y3hXtebl0HeSFNA/+V5t/isEuTneBJBBLNJIwjJaavjBvGCA9pl0F8uYv7MLSsnJ17V89xbwhmYioXXWwb53Z9edhuHOcB3eQUtiazi1GyeKq2W9IJ2WWp28tGssvipkoMOqr5Bp2ZtPT7AwqWcLYSDASHAmy5Ar/KRBrYD9R6N8LM4EYl6cVwUtwcaLvl77e209DA8ZFbQT2haDHBvb60mnpeLz8gnNSlFNZQw6uuVEeiQY7F3GFkAp7388er0jgZHyC5ON1gA+zvimgL8kn1WNHlEO9D3rkjiEW+SCv6Q1Luc/hjRSOn8sounQrObUv7Zs0lx9vIhnj2P8/XIAs17SOgCjMfflqhI7UUZIcMYXY84ufJOKcdQFcplrSj1aOtFb5FeNx4OV79+MEZRiW30qidSzHCbwn/EyX9Ji/22VkCKk1bGG21FJAkFRzTTsnKM2wRz9eXLbGLb+MF9HvUnqm6o/eHUjOzrd/CBfMQxs97L+MZ+XEr0MudmxGXAH8hP9hLSb4g2C5Rx2uKuHprlqzOtSTJMzOoqtAZXdGqWYz/oxNsX9p9uoYZXW9Y0EByGt2Kc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDQ4WkVHa0hRMHZlMEY2Q1prRU1xRXFoT3BkdUFNaVh3Z1NwalUzVHdIVExD?=
 =?utf-8?B?OTlXRHJmSmdIU2k4MnRSUmRTL2lxcUpXMmZlbFp6NlVmelNqM1FqTnJ0bVB2?=
 =?utf-8?B?TEMwSEdsZld5UEU2UHRYMHNrWnM4UitrTGtQM0pWR1QxaER2ZUxhZ3c1TjN0?=
 =?utf-8?B?RGF5WFkxT1FlTXE4UVkrTE56UHNlLytKWDZxU21oQ3RhNGtUZ0QwZzdnQThP?=
 =?utf-8?B?Z3hkSFYyZmZJT2NZT1Z0YzYvUGhheXRHbWVURlZ3UER3YWFPZWdGNElrNnU0?=
 =?utf-8?B?WHFTM2Z1ZW9QSWlPN3RTTW5zTXVRMUFyR0JEdEVUTERiK05ZVE5XaUlyQXho?=
 =?utf-8?B?cCtFUnZPNm9CTXZydExmSzR6VWpEd1BqdExtckhJVkhsdDY1R1BlWnpLUko4?=
 =?utf-8?B?dHJ4NG9iRkJlNzRCVWZYZGNuUWpaMThlVGs3a1pGVTl5SVdhWUd2L1JMNmpv?=
 =?utf-8?B?Y0VIOUwrbVNlQTNRQmRFUmdwK2NlY1d5VFlSWlZEd1lOTzN6Vm1GMHNXVUZN?=
 =?utf-8?B?MG9BRUt0S2YzV0RCSE9GdGk2cHpINEFqK3FnOUk3Nk5pc21EUUs5ZDhvbGRq?=
 =?utf-8?B?WUlDaG1xUTcvNkJtRlRhR2s1enVVeFlYSkFpWVlJdUk0ajVVSlV4VDdCRWp0?=
 =?utf-8?B?QVhZOWs4d1pnVTZxMXYwRDU0aGNxRlN4UHlyazQzSS9YNFNXSDUwakpJcmxX?=
 =?utf-8?B?V1c5OEFPdTVyczhaYXNDQm9FM3UxTzF0N3kzSGdBN21NMCsrT1RYZ1Zpbnpp?=
 =?utf-8?B?MmtyaVpIOTBRNGtjUzh3OU05Z2g2S3pqOWF5eTFpc3hlSFB5dkUwRzVXaVVM?=
 =?utf-8?B?SDhseDdyaytQaDlobjZmbWhOak9jbTI0VUppZUY3dWViRHZIci9FU2FOVjhN?=
 =?utf-8?B?R1IrWGRMRUFoaGVuUXNQeUtaVEFVMjlldWlFRDVoVzE1OGFxUGxyWUZralQ3?=
 =?utf-8?B?dmc5UHhqZlNYZmI5V1Y5VmEvYVpDS0llQ2NlcGhJWFN1RVpSZ0hVT1g4aFlY?=
 =?utf-8?B?TkFlQU5JWmtaY3lvVkliZmR0dWJJL2hNazFDVGpkenRVTXo5d0JwSSsvTEpF?=
 =?utf-8?B?MlhiTHA2WS9vNVJZRUJNMFNaemFTWm1jQ0JHL0JmcUx0eHcyai92cUZRcVc3?=
 =?utf-8?B?M1VwQkRJNFVsVWhRTGxlRWErTkxlOG0rV1pkbGhRTWFFeGJwbVc5SExHWTJm?=
 =?utf-8?B?eGRKaGlzbytaQlF2bmR4WWdJSGppTFMwVC9PNlNrcXdFcnRURndNNDk3dVVt?=
 =?utf-8?B?WWMyWG4zNTh1MXE0R1ZHa3ExQ1BDT0U1aUZKUDhWMEpqV1piVXJlbEJodzFx?=
 =?utf-8?B?TVBTR3dJSUx5Zjc1RUxKWG1VS0ppRG1PUGZpYXdIWllNNUNGMXV4RVcwZlRO?=
 =?utf-8?B?ZmwvQnpjWGpNVDQvbHFCeE41eUpNL2hDVy9NdXQ0UkVNZ1BrTW10cXkyMjNq?=
 =?utf-8?B?a3NWOTk0VEFUK014NWc1TUtZTVZpcStsNHE2MXVzK2cxWGF4anppNjBGcVBj?=
 =?utf-8?B?QWcxSUIzMDc2WnhidWlPb1lvWDhLYkxEUmxzaGNLSHZHQVUySGZ4d1UyV2d2?=
 =?utf-8?B?QTlOVTkzbmxzc01JWmxHYS9aYW1Jc3pXenRJdjhDNm5PZlk5NHVZemwvUE9s?=
 =?utf-8?B?UDF5SlNYQU1neUs3QytERkFzRGl4Sk5DNmVOMHYraVFza2JkaHlMRklpQTNQ?=
 =?utf-8?B?cDhvZDBmR2Uzd056YnR5MzNBMTZKU3NKWWlFanFtT0N3NmdtTm5KUDA0WnNm?=
 =?utf-8?B?S2M0ZFc3bUErT25EdHd1dXZMU09DVXgrbFNlcGFNU3BTcGJzaXZnL3lBdnRk?=
 =?utf-8?B?bG43dXFubEhQV0xyL2ozZXNFWkpvTUdBZ1JFR0dSeXV3ZHJ0c0dKcFRTUnlM?=
 =?utf-8?B?TlhOZXJmZzhrWWE4YzBKRHdjZFlFMVl0K01tVXdseXhsanBXbEVIYmx2Rk9I?=
 =?utf-8?B?VzJyQUMvdFVmbmp6TTZTZU9idHdvWXlZMGJESXVVb3g3ZDBNOEFHVGZUZ0RQ?=
 =?utf-8?B?c1BrMk5sSHRPdWVlZVVFUGc1ajhaNUpKNkV3dWJqOEQvNy9IMnNLclZaNTBj?=
 =?utf-8?B?amxZbnoyUTFYR3NmWVlJN0VZMi8vQktNUy9CK2laVlVOMzBiZVZIbUIwRVZl?=
 =?utf-8?B?Rm9CZzRHSGtCMnlaWWlhMmg4L0R1NjVKTkNPVHNFNXk2eVZnY2hkMVdkclNn?=
 =?utf-8?B?eHhtSm9YSjdBajVKdHFKbzNQcHNpMGo2WVBieElMbm9ObXVZdWIyVTMvYy9N?=
 =?utf-8?B?VzAxbXh5V3FROEtFNnJmRWpyOHFNME10OWJnVFlvYXlLLy9zcFVObThHUGhh?=
 =?utf-8?B?TmU0QU4vZTR5WHRVblBCL1RlN2FwbVpqUnQ2NjFIZnp3SlBwWjJRMDFDczE3?=
 =?utf-8?Q?hZ3Uh3yxvwKW7a5OqStIGTAFF8jdDCVVj0Sx8?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bf15bc-3995-4326-7ea3-08de754da2f4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:42:24.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMXWYhzS0R/2lsJvXXhRezvh2vv99GBiVCdXFR1ifaPH1JXg8vrPVZZfuObllh6agelXzxQVA0O81ZDnVW0V66dkKRXh386VD3D6jOYdmFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6183

On 2026-02-26 10:00, Mathieu Desnoyers wrote:
> On 2026-02-26 07:04, Heiko Carstens wrote:
>> On Tue, Feb 17, 2026 at 11:10:03AM -0500, Mathieu Desnoyers wrote:
>>> This series introduces the hierarchical tree counter (hpcc) to increase
>>> accuracy of approximated RSS counters exposed through proc interfaces.
>>>
>>> With a test program hopping across CPUs doing frequent mmap/munmap
>>> operations, the upstream implementation approximation reaches a 1GB
>>> delta from the precise value after a few minutes, compared to a 80MB
>>> delta with the hierarchical counter. The hierarchical counter provides a
>>> guaranteed maximum approximation inaccuracy of 192MB on that hardware
>>> topology.
>>>
>>> This series is based on
>>> commit 0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git:// 
>>> git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
>>>
>>> The main changes since v16:
>>> - Dropped OOM killer 2-pass task selection algorithm.
>>> - Introduce Kunit tests.
>>> - Only perform atomic increments of intermediate tree nodes when
>>>    bits which are significant for carry propagation are being changed.
>>
>> This seems to cause crashes with linux-next on s390, at least I could 
>> bisect
>> it to the last patch of this series. Reverting the last one, makes the 
>> crashes
>> go away:
>>
>> 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 is the first bad commit
>> commit 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 (HEAD)
>> Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> AuthorDate: Tue Feb 17 11:10:06 2026 -0500
>> Commit:     Andrew Morton <akpm@linux-foundation.org>
>> CommitDate: Tue Feb 24 11:15:15 2026 -0800
>>
>>      mm: improve RSS counter approximation accuracy for proc interfaces
>>
>> Unable to handle kernel pointer dereference in virtual kernel address 
>> space
>> Failing address: 766d615f72615000 TEID: 766d615f72615803 ESOP-2 FSI
>> Fault in home space mode while using kernel ASCE.
>> AS:000000025dc04007 R3:0000000000000024
>> Oops: 0038 ilc:2 [#1]SMP
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
>> 7.0.0-20260224.rc1.git266.3ef088b0c577.300.fc43.s390x+next #1 PREEMPTLAZY
>> Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)
>> Krnl PSW : 0704c00180000000 00000216ef164cde (kernfs_name_hash+0x1e/0xb0)
>>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>> Krnl GPRS: 0000000000000000 0000000000000000 766d615f72615f65 
>> 0000000000000000
>>             766d615f72615f65 0000000000000000 0000000000000000 
>> 0000000000000000
>>             766d615f72615f65 0000000081212440 0000000000000000 
>> 0000000000000000
>>             0000000080a00000 00000216efcb5390 00000216ef16530c 
>> 00000196eeb07ae0
>> Krnl Code: 00000216ef164cd2: a7190000            lghi    %r1,0
>>             00000216ef164cd6: b9040042            lgr     %r4,%r2
>>            *00000216ef164cda: a7090000            lghi    %r0,0
>>            >00000216ef164cde: b25e0014            srst    %r1,%r4
>>             00000216ef164ce2: a714fffe            brc     
>> 1,00000216ef164cde
>>             00000216ef164ce6: b9e92051            sgrk    %r5,%r1,%r2
>>             00000216ef164cea: ec1200208076        crj     %r1, 
>> %r2,8,00000216ef164d2a
>>             00000216ef164cf0: b9160005            llgfr   %r0,%r5
>> Call Trace:
>>   [<00000216ef164cde>] kernfs_name_hash+0x1e/0xb0
>>   [<00000216ef167d32>] kernfs_remove_by_name_ns+0x72/0x120
>>   [<00000216ef16bbfa>] remove_files+0x4a/0x90
>>   [<00000216ef16bf96>] create_files+0x276/0x2b0
>>   [<00000216ef16c15a>] internal_create_group+0x18a/0x320
>>   [<00000216f09b61c6>] swap_init+0x5e/0xa0
>>   [<00000216eec7fb00>] do_one_initcall+0x40/0x270
>>   [<00000216f0990a40>] kernel_init_freeable+0x2b0/0x330
>>   [<00000216efb5160e>] kernel_init+0x2e/0x180
>>   [<00000216eec81ffc>] __ret_from_fork+0x3c/0x240
>>   [<00000216efb5e052>] ret_from_fork+0xa/0x30
>> Last Breaking-Event-Address:
>>   [<00000216ef165306>] kernfs_find_ns+0x76/0x140
>> Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> It looks like either an issue with ordering of the bootup sequence, or
> an issue with the size of struct mm_struct init_mm. I'll have a look.

I've successfully booted a linux-next 7.0.0-rc1-next-20260226 within a
x86-64 vm, with a swap partition.

I wonder if s390x somehow alters the value of nr_cpus_ids late in
bootup, after percpu_counter_tree_subsystem_init() ?

Can you share your .config and kernel command line arguments ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

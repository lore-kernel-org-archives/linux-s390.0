Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020074.outbound.protection.outlook.com [52.101.191.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20A3E9F73;
	Thu, 26 Feb 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118067; cv=fail; b=pCI2NBZatPO9QJr6uy9q/dNlJXil/M4WZHDdFbsiZWyE2MpdjXHZf1VPGs6z0sc6igq1tVwjOLydMtA5ckFmM9Ziuxey4mBbjpJyGBSbhOQkB1xfC+d5dkCP4TafGwFwsCYdrSdwvQhGyvZTvB3iLGeQov3VeyB+PV5n0t4qz5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118067; c=relaxed/simple;
	bh=ljCEeuq2/mNS3TU7ASDvzxDOI2cSXec+jKETxqY0Vjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWBZKsa5hmSedGxscv3Z2sXhblMruFN3RZH1Fp3d+NxZGl0uwqnM5kHCEcbXY3oTnQKw5poa0qGQO7ywx0xzJwqQEkBK1pHw4AycSC7i8aUB5tR+TK7yN5RwuuL5TEhKsoAayOmOhc9n6h/8uj/vYGVt/+aqMgBrDiFgu1PGKME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Yq2N/QU5; arc=fail smtp.client-ip=52.101.191.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Yq2N/QU5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=somKg2W/B/dItZOdavUSj5UYXwNq/ZFXB+TUcdnDDC/VcY2Zq50Dp9+vAH6O6y9cauQyiQTWQe3sxCn6kIwmOvqA2DiqcEDjlVOji7u6NDVRr4nleSMzB32Hp9Gqszj+BtPO2U9zuccyM8P5uyBJ6B21oI2zJOxBb5SiXQrya/YTERcLR4S1XYJoUfKI0qeC4Kmmkktc5MYud/agwBUZaMTGkcmbCsKTHPo6BBwLfoui87m/17PbArKBM7zoRtaOeGWGJjmkAGCgdoKF6PUmd3uLgF6kwz/qk8rqjmt2LZMlmV8CYnbch3Ol1TjKBumfsr2LErF7d3Rc6kJzXxeJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrzCSv5MPRKb/EZsql588Z/m6Nk0L3Y6C1zwLDXRoQw=;
 b=k/xY6PCm0xM+3kxHKuAQ96NF6VXWxKbCi6jX3wYgJcNAYvL0qG19krEFoKr7N+ZIZB830MUkJiEZKMWL1HN3qU1W0wqwS42ErvKVK8leWswarY9h7vVLmi7um9gn4k+yLDHFmVvhv+h0MFJifBFmnkHMiLlQSnLP7Q5fN8PjotADzWuyPXWZEDX4KaWHWM1b/Aq3CAutCNlCIvNQL3zBL0WBa58Y4SSXtqj362EsDO6sTBOLlQxlICeGgYZBBMUJqHyAl9EFReTDsYBH1rPc6JHgut6X83hAzlJggAqCKmpseTvA7r3X0jPskAdJyYMW6VpzY80YG5X/fIrdMmchoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrzCSv5MPRKb/EZsql588Z/m6Nk0L3Y6C1zwLDXRoQw=;
 b=Yq2N/QU5qSgd3Rd1J9UCCZdrp2KLaJqczD6KX1xEkcjJpTJhTdAJeCeR+frpBu0gJizxA+Fqk7rV4Hq7t9IWIkVRGhB6PK1VyMfEXcJz/BHIvOnzRg7oj353HvpIAirwz8aYxDRqxuSJcq4147GmvMOH1OdHKEq1rT8zHrP6u3YL4ZOZVxTxEMX2ahmcqFTzrcasQtIlqzChPu2WsW7K/6HfvExT9hulkEQzNDFhpauyYMh2/TZuD6w5U2cvm4P3exCtxydzXnCu4IFvIt2UUgIX6OWUlgvGlYIj5Ne86z3GoV/mhFTJVcY2bIqWcvfyJghhKolf/FrnWatevVOuaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6686.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:00:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:00:54 +0000
Message-ID: <59b28cb4-4fff-4888-b562-7b7236e29d27@efficios.com>
Date: Thu, 26 Feb 2026 10:00:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/3] Improve proc RSS accuracy
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260226120422.8101Cc2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: d7be4e5f-826c-4eb6-8d44-08de7547d692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	ioifxo7lMMz6r+SSInI9ZEQCAvo7gcGY4FmubaH8Qc7wt4e2VzoDdevUfGug3f7KmuKm38kBjl/crcZ6hQEvWoPh3+YNN1wrxKEjh7jEocEW0aLo3iCl3rgpCBoEV2ON08Y5/Rtzk6uBJOkfzDiGVzychf7O79E8GJOJy7ybz/wh2q5GeDlPeye3//PQvPeAvQgkYtMkNkjYxuXeyX6nUM1VIEvrb4Da7RSedcnqZUIyJO2I6E5HeZ5Ivq9HW+ajkkZUj4JYUJhLQkVpb5c1xuWcbz+crM1eReNDpZwiZ1lIaQfWHZizG/WXS0jnSxDyTmfwH0wKE/W3b7a/jqVuM1iYFayr2KEN1iZVK3BcIahXeWa4Tbesi+wy/m2AnkiKpNZ87H3Fb1jQh1A7ZS/I5IhkNx5GYSuDe3xa6ponuA0jLLmx4Kcj+LPPUU44qkiWV5/rSEjRm2QWi6Aeha9k4PswU6EFXHe9E+hsaH/A515tnQ6wXZtLB9OXgkCRF96MbEefa/m97CBq/WDyQ7+C8Lx2oRcPHIbQrwTLJ8RytH3kuihHwzUVOgMKa8QWFOvS72FhI/LmAy1VDGGicEf47tfk6Y3puh8PJ73rvQt/gX02K4YaqoqVKb1FqZOL2ERpCvy8kOTP5eA2cKHTwsbNbUt82cnEjUYU7u8GPsH68kI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdhQWNqbXZLRE4wdEZtcEZuTW54cWZoQVkzb0ZyL3VVUDFyamwrbG1OUEF1?=
 =?utf-8?B?TEdlLzBxNFBtY0ZEUFVIVmRGQmM1L0pZWnJQcjBGNUpIUU5WeHFKakpNY2Ja?=
 =?utf-8?B?aVJTdjNoaytzY2dtbFBIUGcwVEI1M2RkdDlSZGdkeGRqMnFaWjk3dFNzRVdI?=
 =?utf-8?B?TW01QVh4blJXTmJBYXpLcWtZQ21acmM5VytoTFJzejYxK2lYQkZYUHNDeTJE?=
 =?utf-8?B?c1JWcXI1aGRBeW9hbHp2TGxJT1JBRENxbkpyZjlqNXRmQXdNcjh0KzVVaGww?=
 =?utf-8?B?NmhYUjJJcWZBdkpmazdZOUlMd09seG5pdnNBUks4RUtRVkNoY1FnNmowenk2?=
 =?utf-8?B?U0RnMEdjVlJJOE5XK3diYThOZDlDVlNnZUQ0NHFmalBWM1RoRUkzTHFzL0Fz?=
 =?utf-8?B?a3EwaDlSWnZITGlFN2dDNVpBRnRjUzBET0h6WWM2K1NZb2xMdGtVVTFnMnZ4?=
 =?utf-8?B?UHRqbE5BdkoyNUNQaFFTSk41UUpVOHJvZWlVeE1OR1A1VDhCMVJtUU9QaEhO?=
 =?utf-8?B?a0R1YUtLS0dLT3Bram9CRHh6VEVnSytyTkhYNjhPRkNJNGZnOTRSYXU2TVJJ?=
 =?utf-8?B?d21aVHVuWjJWRmw2eWJSZzJrNmtPUU1lUEs2c2dwMGRWMXY3MklzMnpvRnlt?=
 =?utf-8?B?V1kxK0dWaHQwRm0wamVCamEzcExtMGpxY1dYVUszWnpkUzJQdDRDUm9HYzZ6?=
 =?utf-8?B?b1NJUDN5OTJHYnlXWnJMK2VTMEEyS1Eyd0lpM2FtZ2N4WXluVklZTk1uNlRq?=
 =?utf-8?B?TWJjTkdGejdKRDNtN3dxSlVhTkQybXNoMFRNS1dzdDNkQ0pxWVpsWmFWRGRn?=
 =?utf-8?B?MEpaanU5OFVJRzI3bUY2bEduVzBYbFE4UHJPQlRyOFJSbDJVUGd1LzBJVkNL?=
 =?utf-8?B?RWxpTGNTeHIyMHYrQ2M0L3Q3cWMvRHBXakl2ZDNXd3h0OVBvdkZQdnJsYVpM?=
 =?utf-8?B?STJCT1Q2UGdNMVJFUzBYZXZlODZPK2pBT0tvTkJpZTV4QmpiamswcDBOZEJy?=
 =?utf-8?B?dHIzdXRCRWFhb0gyL3VXdHhxd3UyZSt6VXo1VnR2dGphL0Nld0duUDgzV1VH?=
 =?utf-8?B?YWNBSEZzSm5BNnNpRDUzQUpxajBHY2kvOGFpaUFmTzFPcVNGSVdrT0FiZ094?=
 =?utf-8?B?RDh1ZXNJNG5BME5wcXgzd1dOMUFQelN3T1pnWmt5ZDZvWDN5dmx0MFFmbm1E?=
 =?utf-8?B?Z3F2bUgvb2FFUVZvR0pXTUVXWkxXYXAwMlpyQXF5SHBzakFBSHNEb1hBN2Vw?=
 =?utf-8?B?VUJFN0VwZkpmZHl3aDFHb3hLUUtMNUQ5UjRPQXZJQThDRGd4azUwL0REUkZm?=
 =?utf-8?B?VFFEOVB1VGZFblVEZ3Q0bU9TUTRJa3hBY3MrRkhGTHpad3l6cHcwR1VWQ280?=
 =?utf-8?B?STZKOStrUlZsMUdqS0JyUXQ1NTBTdUtZUWo4bjFNVnR3Slp0RWhjaEdRN2or?=
 =?utf-8?B?QjdMRHpmZ2hOc3o2U08yNERQT1VUTnlsa2s0SkxFU05pVlNZYnlVcWRKaEtQ?=
 =?utf-8?B?amh0TVEyeTBYT1JhRmFsUnhoakljTkkrUE5Fc09MOUdLQ2VBZm03YXlnOCs5?=
 =?utf-8?B?ejZBdm5LOTlGVVBSc205Nkh6YTNRTFZhdkpLVkdqaWlVUmFVcUwrZ1d6SjZS?=
 =?utf-8?B?NHZtb2lGa3pweUdOaWFRZHYzbVZpNGU1Y1NST043R1lNaGhsTk00UzdsSk5w?=
 =?utf-8?B?REpKR3B0bkdpZjJlSkZHNmo1aVp1RVZTV2N0OWorSGp4cDNUaXluZ3J2QTdV?=
 =?utf-8?B?MXozRmgyOGxYYTNrWk1FZGxVTHBqNnRzRkxwVnBMRlc0TWNtVGE5ZHM3bkJn?=
 =?utf-8?B?N1k5TEpjREFmUjhMMUVjWjFqTWoySVJ1RmNCNk80dTN2c3Y4UUZGYmNHcldQ?=
 =?utf-8?B?aVlsdFpjdFRGTDZxaUdiYjJEZWM5QUNBMHRYb0xxMHNnT2NGRFU3aXQ1UDdV?=
 =?utf-8?B?cHhxOUNtZW9PZFZwaUxhNThHZ2dFU2FGaUtPOXY4VCtqMTFFd3FDZFdmRGJG?=
 =?utf-8?B?UVF6a1pzZVpqeithRzBuVE1KNVN6KzlJbkFaS1lNTzdrVDFvZzdaZ1lnVnNz?=
 =?utf-8?B?RUh3OGNXZGJTUURud0t5dnFwZktRZVVmZFZOT2hETHZpQXdPaWZBOUs5S2Nm?=
 =?utf-8?B?d3lZVjdQSVY4b1Bidkd6WnkzTHJVSHlhOVROcWhHRnFNUW1TelVDbHBkVzMx?=
 =?utf-8?B?VVVnMkNNMUhKeTlZVnQ3MUJ6R3o2c1RuV0ZjM0toeDNsNWF3TGRrTTJhMXZk?=
 =?utf-8?B?anBjUEg4cVJDR1ZMYXpoREdyS09ZWU9Vb1VHYzBQOHpOSkVMNWxQdHRLN250?=
 =?utf-8?B?MmhPcEcvZW5IN1dXbHhlMHQzNEVBVVlaRXFNa24xRzR6YWExd3BzelRBdVNC?=
 =?utf-8?Q?Xl9Fq3J/fYCOqnpm4ZZniQb5VAx8Gdhwx0W38?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7be4e5f-826c-4eb6-8d44-08de7547d692
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:00:54.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6GCFMWUbCe2KUNpw0r0AV6CQlG4wBscfpBnNDOpIoaQ4snoz2m++/IL9tNfmY4qoyvjUjIamzSgAF3dYW2ta9LSCYMl2KWPDtMtx/gl99s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6686

On 2026-02-26 07:04, Heiko Carstens wrote:
> On Tue, Feb 17, 2026 at 11:10:03AM -0500, Mathieu Desnoyers wrote:
>> This series introduces the hierarchical tree counter (hpcc) to increase
>> accuracy of approximated RSS counters exposed through proc interfaces.
>>
>> With a test program hopping across CPUs doing frequent mmap/munmap
>> operations, the upstream implementation approximation reaches a 1GB
>> delta from the precise value after a few minutes, compared to a 80MB
>> delta with the hierarchical counter. The hierarchical counter provides a
>> guaranteed maximum approximation inaccuracy of 192MB on that hardware
>> topology.
>>
>> This series is based on
>> commit 0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu
>>
>> The main changes since v16:
>> - Dropped OOM killer 2-pass task selection algorithm.
>> - Introduce Kunit tests.
>> - Only perform atomic increments of intermediate tree nodes when
>>    bits which are significant for carry propagation are being changed.
> 
> This seems to cause crashes with linux-next on s390, at least I could bisect
> it to the last patch of this series. Reverting the last one, makes the crashes
> go away:
> 
> 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 is the first bad commit
> commit 0acac6604c1cfd7a1762901f0a4abe87cf3a8619 (HEAD)
> Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> AuthorDate: Tue Feb 17 11:10:06 2026 -0500
> Commit:     Andrew Morton <akpm@linux-foundation.org>
> CommitDate: Tue Feb 24 11:15:15 2026 -0800
> 
>      mm: improve RSS counter approximation accuracy for proc interfaces
> 
> Unable to handle kernel pointer dereference in virtual kernel address space
> Failing address: 766d615f72615000 TEID: 766d615f72615803 ESOP-2 FSI
> Fault in home space mode while using kernel ASCE.
> AS:000000025dc04007 R3:0000000000000024
> Oops: 0038 ilc:2 [#1]SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-20260224.rc1.git266.3ef088b0c577.300.fc43.s390x+next #1 PREEMPTLAZY
> Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)
> Krnl PSW : 0704c00180000000 00000216ef164cde (kernfs_name_hash+0x1e/0xb0)
>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 0000000000000000 766d615f72615f65 0000000000000000
>             766d615f72615f65 0000000000000000 0000000000000000 0000000000000000
>             766d615f72615f65 0000000081212440 0000000000000000 0000000000000000
>             0000000080a00000 00000216efcb5390 00000216ef16530c 00000196eeb07ae0
> Krnl Code: 00000216ef164cd2: a7190000            lghi    %r1,0
>             00000216ef164cd6: b9040042            lgr     %r4,%r2
>            *00000216ef164cda: a7090000            lghi    %r0,0
>            >00000216ef164cde: b25e0014            srst    %r1,%r4
>             00000216ef164ce2: a714fffe            brc     1,00000216ef164cde
>             00000216ef164ce6: b9e92051            sgrk    %r5,%r1,%r2
>             00000216ef164cea: ec1200208076        crj     %r1,%r2,8,00000216ef164d2a
>             00000216ef164cf0: b9160005            llgfr   %r0,%r5
> Call Trace:
>   [<00000216ef164cde>] kernfs_name_hash+0x1e/0xb0
>   [<00000216ef167d32>] kernfs_remove_by_name_ns+0x72/0x120
>   [<00000216ef16bbfa>] remove_files+0x4a/0x90
>   [<00000216ef16bf96>] create_files+0x276/0x2b0
>   [<00000216ef16c15a>] internal_create_group+0x18a/0x320
>   [<00000216f09b61c6>] swap_init+0x5e/0xa0
>   [<00000216eec7fb00>] do_one_initcall+0x40/0x270
>   [<00000216f0990a40>] kernel_init_freeable+0x2b0/0x330
>   [<00000216efb5160e>] kernel_init+0x2e/0x180
>   [<00000216eec81ffc>] __ret_from_fork+0x3c/0x240
>   [<00000216efb5e052>] ret_from_fork+0xa/0x30
> Last Breaking-Event-Address:
>   [<00000216ef165306>] kernfs_find_ns+0x76/0x140
> Kernel panic - not syncing: Fatal exception: panic_on_oops

It looks like either an issue with ordering of the bootup sequence, or
an issue with the size of struct mm_struct init_mm. I'll have a look.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

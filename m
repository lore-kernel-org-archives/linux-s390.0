Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021127.outbound.protection.outlook.com [52.101.62.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC93D34A8;
	Thu, 21 May 2026 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385682; cv=fail; b=IAzpDh+VURe4XOdvSsuyGoY/jBJ4VUDXOywh266xCrU/PZ0C/tiRqh8fecOO2XweLs+DJDpozW+GjEHhs2cJRy/q3ORstc0UMsbhVYCmDvivoVeLOr/ORfUqPO/YqTIxH7C3S+4yO6vvvY3BF/Ngs67GVdxgE1Zq+6cruhfBu9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385682; c=relaxed/simple;
	bh=IfxGcsV1tmEJi6Fmryf3wPjJ4/ngIrRHK1MzmcN8cNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCjQiss6mL+tyy5UnFkCL+3i8hitBcds66vyFU6HcgiEQk1IQcvakk+2p4ZDxmiAoErPOTcRjHr9SxR7R4wMjA4az8z8tC2J3mGVRbZZhsTR2/byVjm1VLncLUEz6Qgy9bUkH1zSuUPbnrsOd/6qPYHmdnHCbwcwOVg9KTQnzNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EnBVau9q; arc=fail smtp.client-ip=52.101.62.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EnBVau9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOj/5j9p55CzOCGYell3pEgO2d/tZlFjiRg8IOBDizK+a1Z9KrwDKpZPW/xPA50I0DC9qwpLrPbihhzHFX4hRnBroy693Zk9emQebotHA/MjE8MQQxi2SZ7nXjlVB6vntSDZb9z6YpaMtmL36cPIYhybjkEl0Wus0afyTwM44qhhchs5gW2a0i2r7ImP0P6lXmXdEp8xYm1SqUmA+PMRzs/ZN5QUNcHKvwE4NcRJ2sysPSEMuxSwhQbMbp3nOyy1RXsWscdHk8jJT9DZfuiKok4tZeAQ3GpwgSalbVFNlyvNzYk0GVXKaL6fgaIKmT7ikWhkP5waWWNxlY/TKDHsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYiTW3t7zxx+XBz7q0/z8u13eZgzMzsOmMzZ5aSqses=;
 b=mrXh0Fq4J1qZmfOJLofGs6r9iswXVQ8kiBwOPKDURTzy85p7q/cxgm4y4xuQnv6B9fTg4bxPR9nUbEHa089skHivzkx9VecBUJcSoXNRiLd9xLazmiVW6yJSDgHz/JhrxqOzVFce/NxXgJ3Q9t0lEB8Ob1hNiAMQTnQg6l4FleoTQbvWuePHa4ZNPySSr+Gy6ffoDY21L4ff0k4T9eNX0kEWe4lFhJMBDxQBSYFa216jlvBXmMes2RY/P9iBEmffGQbrmSvxVgwdpjG/AfxWk2GOvijmvg00W2Y9AOuRSmD7YgTeRWS9d+xH4QBSKxoWKu3+/PtiP/zERnPD1dYLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYiTW3t7zxx+XBz7q0/z8u13eZgzMzsOmMzZ5aSqses=;
 b=EnBVau9q/fuT2FmUvAuAzgWCTPXd1CVXICoCRJ7Aig/Qjp1wCwDQUwexm8Rar08q+reBipIi5DvntEHxMdSOAc6nvYIqgJzOmFGNiKjBdikyhnp8f+Q/BFfoQyn3a0p/ukwKgWPmWyuUBhu39bDD6D+cFRZhP56iylDjM20QiU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6538.prod.exchangelabs.com (2603:10b6:510:77::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Thu, 21 May 2026 17:47:53 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 17:47:53 +0000
Message-ID: <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
Date: Thu, 21 May 2026 10:47:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
To: Heiko Carstens <hca@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
 <20260520233409.0683f595@pumpkin>
 <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
 <20260521103742.9603C8c-hca@linux.ibm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260521103742.9603C8c-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR22CA0079.namprd22.prod.outlook.com
 (2603:10b6:930:80::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: a8afc2bf-3318-427b-c89b-08deb761158c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|55112099003|11063799006|3023799007|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NKA0owc+7Quyh9bLcEutaGbHnzm/h9o6jz+2kVtboaamVJDGQTxjMxg4X7vu+9TMSLM1GGF2QCiMQmatK7LsRMYClhzoq6i6MmQFLrJQ5qoYcwmJKGb//VU7J3ZwzJC8HCv94Y9aLS6zNm22d9BCexuWnppoBu4t/DDr609m5PdwvNbqJbyWECGpZ8YNnIVsXlc/xUfr2ANTTc8DsAHSeURhCGAyV/icysCR5X+N61t6OnWvx+8SnCIS1L995qlIK3bhuson2ruXuHKtYkUcm6obE4id2rauHmt65qPbwclRN0Id9iZIJyecnXWdaUSCvOZc5FKbsGvPHX/zpfhFm+5ZyScpij1CUA4oxWR9cM1c8LjUnnKkboIV4JLyKH4ODjJFnk5m8DP0cJF/gOv+ljsvBBJAXV4FFgl2/3WJKi5PFM8oULXNoX6Ma64tQACWLFXQeCtbLJtFhMpQdhiNuyvMI3cVKbx0ugh5ZTLDwVC8Ol/rVXgA19jLpUunmqVJhhe+WYxX1XsM5zvYAQQ7uJV6lr0B4PIgnvVinXbuLeHFdfS2B55ZPSgwQuYkKNHYoH+2ZGKds2ye1eLic6v8KOlyb4UAG7ktjpmdzSkWQ/EHIo1xSqp1sO87eeTfIhPWC4xEISs3lPoh8JpQgkeGybAGHJVR31mbP8NgnP7+ZychmYCO8vvbqNINnNyFO8TT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(55112099003)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3Z3ZGx6R0JkR2lrQ2VmRHJMS05EWTNuMnpSSUQyMkQyMUxHaUgreTJQajc5?=
 =?utf-8?B?NEdJTCtqVVU3YVk1N0ZjYmplRWFMbTBtVmczMlVJdG5NSUdvYmN4dnhZSDEy?=
 =?utf-8?B?Q3cvOUlvZG8yY3NNbVNhZjlPdVMzcEozQnYzZHNkQjV3RDVjakNQMnhyM3FM?=
 =?utf-8?B?MDlBWUpsbTE2Q2R3c2pZUGo1QjY3UXp6TjM2aTFPellTc2RzWDBLTDFTTFV3?=
 =?utf-8?B?UHhvZk84b3BTQXRyZHJDSGZiK0pOUG1iQmRqMWt5Tm1mRWVraElFcXhVSUpz?=
 =?utf-8?B?Z0ZHdzhyY3lwQjJNa3kvdXdIaFp6N3R1S2JLcDlDaUVNV3Q3WkZhMGFGSUxt?=
 =?utf-8?B?dHBZZ0lqSDRUY3FSeHpjTEs2b1FMeTdYM0dZZlhwZzNCdUZIUlYwaThNWU1k?=
 =?utf-8?B?bDNvV3VLVDAyQitQdWlTUHI5eC9YRHk2bnl0Rll3Q3Y5WkxZZW9aN1ZsQWVV?=
 =?utf-8?B?V2Ezb0VFWlVIeExtUXVhcHBoVlA0Q0tQbmt2Q1h6ZGtUT01nTnp0RFZibHBD?=
 =?utf-8?B?SDVIVlZlaEs2YjRqckZOdU9zK0VYczdHS1NWWDRHbHFWUU54MzZRMjZ2QzFU?=
 =?utf-8?B?L0hsNDB1S0s2ZXh3RldFcG9RbzFNQTBxVUlocWFaNjlUWUVJTlcybjIvYkJH?=
 =?utf-8?B?ZzlKVEN0M2VaeHR4eEtpK3Y5cnJldkxDMW9lZHA2OUkrNTZjS0FwYVZNN1Qw?=
 =?utf-8?B?ZUU5ZURxRWIzZGI5RjlMWmx5WG85ZDlER3VWWnU1YUozN2dWeThQdnRGdytq?=
 =?utf-8?B?UDgyU3hDZDYwQXpsSUZ0NStJbHZNYVNLbXozeDdJZ3N3S0JMZHo4cERjcE5K?=
 =?utf-8?B?R2s2WGY0aDlzU3NmbHBUK3R4bDROaFNwN2JzWnMwUXM0ekN0ZG9aZkdad3BF?=
 =?utf-8?B?K3lIbEx1bi9CTWhnY3I3QSt1WHdZdGdEc0kyR3UxeS80T3pwZkJQMjRLMkxM?=
 =?utf-8?B?dmhBOEtpTEhIeHR1TnpkbU9leEhJclVva1BMVnZSa0xPeXJYcEhDWkZma2d5?=
 =?utf-8?B?T01kK0w0ZytEaGNhK3RKTFIxWG5UeEdmZWZYMitxZFpKOEZRRlVZSGxKRVZj?=
 =?utf-8?B?UERSeUszay84YkdUTkNzRmdFWmZZcmwvVDI1KzArOE1EeEdBdEE4TldFcVZF?=
 =?utf-8?B?UTRXa3I4UFBVOTYwTFpnWnEwV2pVQXY4ZFdVajRzSXNUMkJBOGU1UHlZWmhT?=
 =?utf-8?B?Q04vcEpPcFFVVFN3ejdTRHdFTVRiN08yZHJDeDIydXlYaHVZNjRXb3A2eisy?=
 =?utf-8?B?dVZoTjBOMzNmTUI5RENhdkR4MlUvZ0dkSVdRTDlSOU5FejV1Z1ZRbVcyMys1?=
 =?utf-8?B?RkF3dDJGNmM4ZG1rbWovL25JaWdjYUN2VkNJKzdrVVhBT3YwNUxGWWNKbS9N?=
 =?utf-8?B?WVNiRzFUODhWcTBLK2s2KzhnZEZjeHhqcjloYW9sZ3RZbkdmM0Z5UlhEWitW?=
 =?utf-8?B?WDFndHVmQXdhRFBITWJ4NVFIRFFHMEhKL25nc1FpdkVNMjhweHhNeXlwVmFt?=
 =?utf-8?B?V2hXa2xnd1hCTjUvOE5uQzRVTFhaa1dXZ0ZpWjJUeklteHR4YzBPczk0RjRE?=
 =?utf-8?B?UHVLSVR1KzFzSlkxR28rSWluMXNEU0xsWS9nUGJQUUdLa3Zkb2RnOHNvZVVT?=
 =?utf-8?B?L2UxNnh6Z2llU29NVmFGYW1GZy9iaE9RYlI1d0llVTYvTmo2aW1HTzFUWWFu?=
 =?utf-8?B?RjlTbXljT1pHTytOa1RuYUdZck5UV1JYMXl3NUhQd01sNXRzam5xQmE4dEc4?=
 =?utf-8?B?TXh1SjFVL0dERTN3OUNGSTdpSGlpeUYzUlVqUVg0a3p1bG1qbGNuNWJjSHRJ?=
 =?utf-8?B?cnQ1KzE4NXNpcVFPV2dueGUzaXZyV1V2UFkxdG9zNTVBQVdIRUtrRkdTSE9k?=
 =?utf-8?B?ZXl4TFhBbmVXdFZWQUEzMEg3bGg2UFZBRUdDVkhjNkM5K0YwZU5Oa2NtSlFy?=
 =?utf-8?B?bkVZMmtTVDJUMmFKTmVkSHFmTm9tajVBUFFyblA5K2NRVmdBVHNTV0V4QzFm?=
 =?utf-8?B?eGNQYTM2dUpIZXNZQnFUblNYNnBaQTV5eks1Q2hPNzN0VWhsZ3d3a3BNOFNG?=
 =?utf-8?B?SDc0N0FtVjloZW90K1QyMUEwb3p0SW9FajFpOHZPZzJVOXRKbldaeFhhUmlE?=
 =?utf-8?B?Mk5UWHk1Mk1mNEVZZzFTMWxnQzl2RzlkZ2t1T3grZTA2Rnd0aVBWT3pjZVJs?=
 =?utf-8?B?NEJ4L0o0T09peFppTHZnMUd6S085SGdFRFVuN2ZhaEVkWisxaENveWNmcnVp?=
 =?utf-8?B?bEVmZFhwbmhhc3JBZ3E5eEJaWWVPKytHS2RLTDEyYndUSGlMcDBBb0ViMFpV?=
 =?utf-8?B?MFkrUzlTb2cvazBMNE83SFc0d21KT2s4Smptc00zTXYwRG5xcVI5NzRob3hC?=
 =?utf-8?Q?OZ35/SW65pJRzO/Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8afc2bf-3318-427b-c89b-08deb761158c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:47:53.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Dl6f9HzxxMSTVd46BrfzsGYkEl3lKKJIHMzEQz41N4tPSI6lE9XGb589O/PBtCzQyhD9WiqNipH/jk1b2s6kIhlFJEUj9ferjOXgSK+VfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6538



On 5/21/26 3:37 AM, Heiko Carstens wrote:
> On Wed, May 20, 2026 at 05:23:37PM -0700, Yang Shi wrote:
>>>> If I understand correctly, you replaced preempt_disable() and
>>>> preempt_enable() with seq begin and seg end, and seq begin and seq end
>>>> can be optimized by mvyi instruction on S390. So you just need a single
>>>> mvyi instruction for each instead of read-modify-write the seq count.
>>>>
>>>> But you need some extra overhead for context switch (save and restore
>>>> the seq count register) and need to check whether it is still on the
>>>> same cpu once resuming execution. And there is also penalty if it is
>>>> migrated to another CPU (need to rerun this_cpu ops).
>>> Not as I understand it.
>>> What happens is the context switch code 'corrupts' the register being
>>> used to access per-cpu data so that it is correct for the new cpu.
>>> The write of zero after the sequence is there to stop the register
>>> being corrupted outside of this code window.
>> Thanks for elaborating it. I misunderstood some nuance. I read the patch #2
>> commit message, now I think I understand how it works.
> As background: s390 has so called prefix pages; the first two pages of every
> CPU are percpu, via a special prefixing mechanism. Parts of the pages can be
> used by operating systems as percpu data area, which we use to have fast
> access to e.g. the 'current' pointer, the pid, percpu_offset of the current
> cpu, etc.
>
> Helpful is also that for instructions which access memory with a base register
> zero, its contents are assumed to be zero for address generation by the
> hardware, regardless of its real contents. That is, the above
>
>          ag %r4,952
>
> is the short version of
>
>          ag %r4,952(%r0)
>
> The eight bytes at offset 952 of the current CPU's prefix page are added to
> register 4. Real contents of register 0 are irrelevant for such address
> generations; reducing register pressure.

Aha, I see. So the prefix pages are some special memory?

>
>> Borrowed the disassemble from patch #2 commit message:
>>
>>    11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
>>    11a8ec:       b9 04 00 43             lgr     %r4,%r3
>>    11a8f0:       eb 00 43 c0 00 52       mviy    960,4
>>    11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
>>    11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
>>    11a902:       eb 00 03 c0 00 52       mviy    960,0
>>    11a908:       b9 08 00 25             agr     %r2,%r5
>>    11a90c        07 fe                   br      %r14
>>
>> 11a8f0 loads the percpu offset and mark the percpu code section begin, I
>> believe this is needed with percpu page table too because we need load local
>> percpu offset.
> No, 11a8f0 _writes_ the base register number, which contains the percpu
> address used by the percpu atomic op at 11a8fc, to offset 960 of the first
> prefix page. It could also be written like
>
> 	mviy 960(%r0),4
>
> maybe that makes it more obvious what happens. And yes, this marks the
> beginning of a percpu code section. The percpu offset is added to register r4
> at 11a8f6 with the ag instruction. This could also be written like
>
> 	ag %r4,952(%r0)
>
> This reads the eight byte percpu_offset from offset 952 of the first prefix
> page, and adds it to register r4.

Got it.

>
>> 11a920 loads 0 to the register to mark the percpu code section end, this is
>> not needed with percpu page table.
> I guess you meant 11a902. But yes, this marks the end of the percpu code
> section. Just that this is not a register, but a memory location where is
> written to.

So both mviy instructions actually do memory store?

>
>> And you need to save the register at the irq/exception entry, then restore
>> it at exit. But you also need to check whether migration happens or not, if
>> it happens kernel needs to rewrite the register with correct percpu offset
>> and needs to check whether the interrupted instruction is "ag".
> Yes.
>
>> If it is "ag" instruction (11a8f6) , kernel needs to recalculate the percpu
>> address, right?
> No, if it is within the percpu code section and it is _not_ the ag instruction,
> the percpu base register needs to be adjusted (that's by the way a bug in
> patch two, which has this logic inverted - my mistake).

Yeah, I see.

>
>> It sounds a little bit hacky to me TBH and incur some extra overhead for
>> "migration detection" and fixup.
> Sure, it is hacky, and the small overhead part is of course true.
>
> Compared to the percpu page table proposal the two mviy instructions above
> would go away, as well as the extra interrupt/exception overhead. Besides
> that your proposal is way less hacky.

It would be great if we can compare the performance number for the two 
approaches. rseq has been discussed for ARM64, but it seems too 
expensive and just move the overhead to somewhere else.

>
>>>> So it seems have more overhead than the percpu page table approach IIUC.
>>>> We don't need all the steps with percpu page table. And there is no
>>>> penalty for migration.
>>> This code looks like it relies on 'page zero' already being percpu.
>>> So it probably isn't really that different.
>>> Some values like the 'preemption disable count' and 'current' could be
>>> (maybe are?) written into page zero to give fast access.
>> I don't quite get what you mean about 'page zero'.
> Hopefully the above description with prefix pages explains it?

Yes, definitely, thank you so much for elaborating it.

Regards,
Yang



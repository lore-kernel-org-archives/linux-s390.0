Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021095.outbound.protection.outlook.com [52.101.62.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384239D3D4;
	Thu, 21 May 2026 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396395; cv=fail; b=esZenRAwy3IoNEhcsV94FbRxmQerjCDI4cS9/9+0MPnBhmm+cIz/Xw42PuZLMgsm90zwVqzNrBieJxttmUb9+SeygF79w8X0/UG9KvVc4AKfWko74+ivTrIu7H2ttX8wgjFk/NWRCK+r8c4UakYmhykfS1M71ISFpTTPXQSUtyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396395; c=relaxed/simple;
	bh=nGXJbsejP8LEDMBWhXEvFXacuoJbqgBgqabvNzWwAps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SwoRl0WcA99JHFhYyRejCDkCrdQawKqLDnhvfZdM1qqv1mSO5po6OWB76Ew0KystyrNHaIUWCx+Y/NVYiAeG3RqLwDKEAf3O1zKiqhIfYqhMTzdBqrDJ9+uvu5+8xXevEUiJBbAd/f1fVuchOuMvJK8YxpOgERNQBeXakIlspxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PjmcC8H9; arc=fail smtp.client-ip=52.101.62.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PjmcC8H9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3N7Nj1P0tQgCeiDhce9nOXw71jSqvlez4BS5tIBeVhLtFzQTFj6yx48tlXyi+PkM7NZkswVCm2im1VlwLfpoyJycDUNYJqzVV4Q8bVhjvXExY9rhN+KsnzOzPjA0tGnAHZqS2odzeQ+T3Or0/DBoYSoFGEjR+4eTHHWn7QFegY+3KdbWW9pSBPPQrhLJRjht2c4mEr7mykKJcDIOLndV0FC4bNYNgiMGRo0AA0uZ1YAHI0n2onfQoXMOdCBRNtw4ELZRlkS4uJY/Kv3kMXXHNBNENijVBf0XqquNQbuzRbmOtRbiYYVRJ83DRRfBbw19O9EXf4VkSGYYcN2qdj4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06APWbhECOVLODT3yLS9GqWHx+rvaVkVJyfqNO9Nqz0=;
 b=WLJvjczo4qbp3GpdVvYbbdnTzomVZsefFUv/KrTwvmttY/SiD+3sabezXb44EZZr3+d33oaxnEtlVvut7zMfmD7kChZTJYMIsrMqmam9nSfdlhrL4mK0vXVRcVAB8DpOf3GOvPCN5F+Tf3CS+Bn8HCv/DW7OXmhBFCvrjwy8VsKGuU+FUoZJK+ojHVOXKFXbpa01oe4uaCKe36FvPbc63Fc4WgeXx4LUMbYv7qz3XSVRtcoa9ozgoSGbImXpm/0+SicbUmWfpZDtlGp81gUvzOSq/3W3bGVIt4RKvHpNlTQm6XI3ojpzSnIO4rfSCo1NSKZYFSp1wEvpdHFPG8wdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06APWbhECOVLODT3yLS9GqWHx+rvaVkVJyfqNO9Nqz0=;
 b=PjmcC8H9E/5ggLgnC+xK508fSWu0OLEQDlszb1/AS6TBn2cwNvctdMTH+W16sfDeW2Nl5l3t/0Xzs91wCpsrfTQFqM/feOyHotvFuUcih4iy6Wfx+oyGWt6K5+2+hVti3OKqtCorYe0T2pzKAezF/SFUgjpFmbMCvlGHS4W38YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB6520.prod.exchangelabs.com (2603:10b6:303:d6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 20:46:29 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 20:46:28 +0000
Message-ID: <c29b201e-f839-4702-be60-f8c38ef637ee@os.amperecomputing.com>
Date: Thu, 21 May 2026 13:46:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
To: David Laight <david.laight.linux@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
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
 <20260521111744.6e58bfd6@pumpkin>
 <592ea7fb-b836-4c47-a0cb-248a185cbaa8@os.amperecomputing.com>
 <20260521185532.002541c6@pumpkin>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260521185532.002541c6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0040.namprd12.prod.outlook.com
 (2603:10b6:930:49::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d67ba1-61e7-4ff6-46fb-08deb77a0830
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|55112099003|4143699003|3023799007|5023799004|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	uauj0aKv5WQia3fHVfeUtS5qwGYj7ScNKKv7zTuvYN6Res15sKv3JyGQAE/pgapTYTCFqggSCO24EYcgVwtIxTChsfSQGKzLYl12sUs3T36wCNEHqk0Qol7rRhZcZJ3hx598WFHGEjhPLFdoBqVe+S3mHe5Fq1nHFjuqRYqo+QUKKovl4+Hateejq3VD9hJ84PZk+rqhUXVw8cvkIXHUZCj3RCJttA+jM7xev+jZDX3WVV0XVPkuRgpcqFYMo59XCVjA0S47aqeFNfzb10iIHxZnN/RlpHVhvBaivIm7xcEOA8RjpufxCJdEmxZIUHH7cgbIYC7NUhwnkNOkKFvTaUiBc9cafbV/MX4HngKVMWNxg+dH4mOzE3IGa4VfxFiY6XyNKfmw74u3H+mqbLbsUnoCFGU5FCqWoHwU8lA97OdGrU5JGewBqiIfYeo25Pzpve0vTc7D0LS27TDpGI9VBx1WtI57aq3o7RZqKBI2pVWWs+TeP31Y2wDuBbaIZU8aVBVLIJ+V/EUr/RNABNH2MzL8VV4hNq8RHnR5ngAffGVhUxQKbJTOtUQu7tFJYZkIi2WT+Xn1BRSOZMwC6GvHqW/xONbsb/YRh/a9Avl909XpyzIGlhZTNu+zsLBQdAALKcQj/ReihJnhPoXexUPDW/mDoyq95RD2Y0vbkkOye6k1GoWcjWLN8Acp0DkH/3/82/FhJmGtIKW9xBQRl0zR3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(55112099003)(4143699003)(3023799007)(5023799004)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVVQU1YvMDh6a0FmSVFxNE5qTWE4c2tGc1d5bzhHNkRTYmRmeVdLeS9jbW0y?=
 =?utf-8?B?d3FVV01BRVFCUkJWQVdwVW5uVGhDcThnRnhQOEJYZU5PT1g4bVF4cGRHVk1X?=
 =?utf-8?B?c3hUZ0tKcUZNU3crN0c1TGFLQU0zQWFtRkVLTzdKN3dCVVBmYWd1ZStqenRh?=
 =?utf-8?B?K2RpSDdCaEZld2hNN1czNWh1bGFiKytCcG1Fb0wyc0l4TnpRSEVhTjgyb0tp?=
 =?utf-8?B?SEtublFha09NemxHSGxCUFp3ZVdLRUR2MjduSFZGQmZhMmhvblNLdG5LMmxE?=
 =?utf-8?B?dm5uTmF5dlpLSkhuMlNGaThYZ0kvdll0Uzc5VHZ4R0JKTGRTUWdaL0M4elFW?=
 =?utf-8?B?NWVkY2JxeXNjWkxIdE85dW1hQTdUa2JickgxbkVyMDVYUmpNN3R0L1FRTkpo?=
 =?utf-8?B?QmhTTm4zaDMrZmk5dTd3K2FqeEZGWFZkMXNOMUNKTm5iR0YzdXlGdzVkdEx1?=
 =?utf-8?B?V2lscDIzdVUxSml0QWlsTEptVzVTdjJRRjNjc1BHeGV2czVIT0k1bHhLUERT?=
 =?utf-8?B?bXB4cHQ1cHRmdERMZ2lCdC9DcEJFMi9xZHBBQVV0WnBWZUp5SjJ4eitPTG9u?=
 =?utf-8?B?YVh0NjIyRzdGSjNZTVVwZHMzbm1ucklaZkFYWk54TC9wTmVEY01YQ0I2VHA4?=
 =?utf-8?B?U2FWTWk3TDdTSG5GTDZKWjZFWDRLTGNBYW1tNUdSdXI3bzQ4bXRFREVJU2J6?=
 =?utf-8?B?S3FMR2NiMmZjd0VTaytyNXYvc3V0cE5pdm1La0VkSDR1TlpKWU11SjlBRlpU?=
 =?utf-8?B?dG5sWEsyR3J0RlZaYVVOVUVkdzQ4VzhYeks5bU12ZHFoZmtrT2Q0MGszSnBH?=
 =?utf-8?B?QThoZm41eU5VV0JLaG5sZi9IZmpMVWNSLzhzNW5EdWd6UEFjLzhJNmpudmFT?=
 =?utf-8?B?ZjYyVHZyRU55M1VCTDFMcFB5NVBMZzdyVFdFYzRUMUdidWZPVVRReHZJN1Qv?=
 =?utf-8?B?aG5kN25LbU1iMmU1cnlyWGtMSlZyR3IzR3loenB2YlJpdmNDb0ZDcVVxYTh4?=
 =?utf-8?B?MEFMczhRRmc1ekVXTXBKM0JmUW1vZ0NNNUF6R0VEbWI4Z2UzVDlZWHJ5Mnpr?=
 =?utf-8?B?MS8rRUdqQUtqWS83dWpxNTRPdC9wR1l4WSszMjh4ekExWWtoTFRZR1JTUkpL?=
 =?utf-8?B?REFsQ3BPQWtXYVFNVFFnTnJrTXg4ajdMUHhFa1Y5RmlNbWYxU2QvSHlEcnJG?=
 =?utf-8?B?QkxjbnZhN2JaZ3hiby9TVWVaZXZ0MHRzSEw5VURtdlJlTHlOamlFZnBYK0VX?=
 =?utf-8?B?cm1YbTNzNXNxZWxlRkNBcGM5emo4VlFPS3h6WUdJbWVBN0RUa1NnOG9RaXBn?=
 =?utf-8?B?aXQ3eWF2L1kvTTVua1BsSFhGWmlsUXh1eThmMFNua2ZQTWxjZG1oenJGdzN0?=
 =?utf-8?B?bjBRVmpRcTcyZDhtNDVBSlBlUEV0d2Y3RTQzUmkwczR5RXl1VmdXN2ozcEI5?=
 =?utf-8?B?b29mdzhyUjlLbDFSTlRmOE9Qd2U4TU5lZ2Y1azh5NlB3NHBkTjRDUlFrakE4?=
 =?utf-8?B?UGw0N3hCUEloTnZ5SzlYSnFydTBBdTdPQjdkeDhQQk9EQVNPcmNTZC9jc1hn?=
 =?utf-8?B?THJyTlJIdGc0dHYyMjhQay9iZlByeCs0c293bU9ZSHUyQ05NU24ybmhieEpG?=
 =?utf-8?B?OHowcHpubGh1TWM0VHY3SGdMSDdrM0x2NGdHRitRTkZta2RidHhEdU5pMld0?=
 =?utf-8?B?ayt3NjhnTjI0L0c4amV3NnBwbEhJbnNIaWNRdTZVZnlIS2FMRUFPQk45TjJY?=
 =?utf-8?B?VEMwK0xhZjdhK0VpRExlUkdlaHJNemVKV0xPeC9ScUFsSEFsa01weUNyN3Qw?=
 =?utf-8?B?c0s4M05wV2h5T1pMOWRtNHpuR01hdndvMFdFeTcycFA5VUFLMVlPS0k5dG9U?=
 =?utf-8?B?ZGpjRTBFSDhCeHJHTUxtSW9majdaV2FONGxDTnFwL3VQWnJ4YUFsQlZMRVZ6?=
 =?utf-8?B?VWF0Z0MzZWJ5T08vak02a0s5ODlCMCtNK29ZenBnbU1KRDZZNy8wZ0xvaGNP?=
 =?utf-8?B?NHZ0S3hDdHF1QjZXZk9oTTlXTEJNRkluTmpYRVFzMm45Qk1tVVdvSE5jWGdH?=
 =?utf-8?B?VkhpdFJDNnRRR3FLUDM5ajVkRmdFdkRNMXZFa1p4MndvOUwvN2s3dlpuOWlG?=
 =?utf-8?B?bDMrdlQ5MU0rbWRwc3BJNWYwak5GR3I2VXNTM0xlVkY1RGlRaTY1Vk5lL3ZT?=
 =?utf-8?B?K25nZStIbHFjcUk5V1VCWGJYWEFMVE90b0NzQmkwRnJhbVdqN0FpanBqTTJK?=
 =?utf-8?B?eDVSUlRxZFBULzgrMFYyU3VHdW1xcDkrYTBsRkhURFB3Vis2ckdVa1hMLy90?=
 =?utf-8?B?Tk5jTHhwdGNIQUlVR0xtOGp4QnQrNHU0VWplbFZxb0JlWlpYTHh1NzY5RnVL?=
 =?utf-8?Q?pIk+Ozl0loiSCOjU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d67ba1-61e7-4ff6-46fb-08deb77a0830
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:46:28.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8M7avFdJ0E9jhEY9nKMdMY6TC/0tQvAFVp+6rV/BtGIaM9lcja70g5PlueqshMbx3DTbGceJwCMBmYfb141mH2TwdI7i2kgSt84pjBL4XvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6520



On 5/21/26 10:55 AM, David Laight wrote:
> On Thu, 21 May 2026 09:57:37 -0700
> Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> On 5/21/26 3:17 AM, David Laight wrote:
>>> On Wed, 20 May 2026 17:23:37 -0700
>>> Yang Shi <yang@os.amperecomputing.com> wrote:
>>>   
>>>> On 5/20/26 3:34 PM, David Laight wrote:
>>> ...
>>>>> But I'm sure I remember that some cpu don't like having the same
>>>>> physical address at different virtual addresses (and not just those
>>>>> with VIVT caches like some sparc cpu).
>>>> Yeah, VIVT cache doesn't like it due to cache alias. But the mapping is
>>>> really percpu, so the mapping to the physical address belonging to
>>>> another CPU should never pollute the current CPU's cache if I don't miss
>>>> something.
>>>>   
>>>>> I'm sure code can end up accessing the current cpu's percpu data
>>>>> using the same address that other cpu use - there are definitely
>>>>> places where it needs that address.
>>>> No, it is not. In the percpu page table approach, we use different
>>>> address for this_cpu_*() and per_cpu_ptr() which is mainly used to
>>>> initialize percpu data for all CPUs.
>>> You missed something.
>>>
>>> Look, for example, at kernel/locking/osq_lock.c
>>> The code uses this_cpu_ptr() and then both dereferences the pointer
>>> and writes it to places that other cpu will use.
>>> It also uses per_cpu_ptr() to get an address it can use for the per-cpu
>>> data of another cpu.
>>> (That code all assumes preemption is disabled.)
>> this_cpu_ptr() uses different addresses for different CPUs. It is a
>> special case, it is not due to VIVT, but because it may confuse list
>> API. Because list API determines list is empty by comparing pointers
>> (head->next == head). this_cpu_read/write/add/sub, etc, are fine.
> But you could quite easily get code that manages to mix accesses through
> this_cpu_ptr() with direct accesses to per-cpu variables in the same
> cache line.

I can see potential cache alias issue with VIVT cache with the below 
pattern:

for_each_cpu(cpu)
     per_cpu_ptr(cpu) <-- Initialize per cpu data

this_cpu_inc(current_cpu) <-- Inc the current cpu copy

this_cpu_inc() may see stale copy (uninitialized) if there is no cache 
flush after initialization.

> I'm sure some arm cpu really don't like you doing that.
> (But it is a foggy memory from somewhere.)

ARMv8 requires PIPT if I remember correctly. Some old 32 bit arm 
machines may have VIVT cache, but 32 bit arm is not the target user TBH. 
I can see some potential issues with VIVT cache, I don't think they are 
the target users and VIVT cache is rare now.

>
> You can use per-cpu page tables, but it really only helps for a
> few items.
> Anything that is RMW (eg add on pretty much everything except x86)
> either has to disable preemption or use a compare and exchange loop.

It only helps this_cpu ops because they use atomic instructions (at 
least on ARM64). __this_cpu ops still require preemption disabled. But 
the performance improvement is still impressive even though it just can 
help this_cpu ops.

> Variables like 'current' can be written into the per-cpu page table
> data area by the process switch code (as I believe s390 does).

That may be a useful usecase.

>
> The 'trick' here will work for reading/writing values if you don't
> care that the value read is stale (or might have been written to
> the memory for a different cpu).

If you don't care the stale value, you can just call __this_cpu_read().

Thanks,
Yang

> It might work for updating the preemption disable count - because
> you can only be preempted while it is zero.
>
> -- David
>
>> And per_cpu_ptr() also uses different addresses for different CPUs.
>>
>> The lwn article explained it.
>> https://lwn.net/SubscriberLink/1073395/12c08f128e515809/
>>
>> Thanks,
>> Yang
>>
>>> -- David
>>>   
>>>> Thanks,
>>>> Yang


Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020114.outbound.protection.outlook.com [52.101.61.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDA254AFF;
	Wed, 27 May 2026 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925479; cv=fail; b=LYR1Ub7a4stt4uIAheI3c+CFUP421+GF5jICaY0df/K+gSVcxZE2koOLNhuD3VmgSDxAGl5hkt0+eHHElhYzPh38gv2vJSg7UcbXaCHxx+pzijcs7xPoeZMR74KTTU9L6nbpx0nOj/chjRfn/a0qwaxHADAMgR94LdwoeqCAx+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925479; c=relaxed/simple;
	bh=q43iCPqtCUUo1JNh8RHTXaAHthmH0TbrHU5UX4FgHfw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BIZmxHn6s3jMeP7AmcutvhooeAO09iVVAy5sePPPB2IPTkR797FkcGoi84sRfRDLDsm7/Zbv8v9bbtz/+m1zncrt0VTb+NNPNt5PVM6eT+KOFOBmhZufPf36jNUCQD/13v6CtGheuF3CYBjYwCAj91DiUhnhhJG8N3Jq77x67qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MEd58msb; arc=fail smtp.client-ip=52.101.61.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MEd58msb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9sDtvnbSFyZVtTAXvG9amvm8CG0yNlj8i9w6OsxSRJndsdxHeWa5CYZ8id7pg5haBi1MXx7QRLyDsJDxYtZ/4LruTnL60iXC6tBty3z45cGZMZfAOp02efXTI/idiUS0RYM1AL3tJOdWFYQKkE9JRTFKFPPXJB6X9lu1psgqRWjpBrPojWyJ+TYXKQiTGH3hoooOELpHdHT/8WyGfkYlKNK5LDHKb+YthzI1KSHiWDk4kDLC/ToAHIUFG3V1W2kAvilU/O1gsjaHHD4+EIpz7KB4SOtj+vglGGDEFs5f+NUfu9PfzodbulzZoiNmkzlkD24nEKGRAO7XU4DCnctfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHe2llS2wJ7nGAZoJXraJW2loRg75Lcnp2zgd7YTccI=;
 b=ozeXw0HmNpOfK0YoXtFhWUhrs+/G5ZnKaz4nZR/a0QpqSOvoOK9V9h7cGBUvBu+5J9SBc2hSJO/SH/CBEp7XHeM4NgkMm+geSAIdSMaWzsmQwOja2Tn40mo/acDA+OXVasaaj8cGdnu4Lm8tqrsScF+pciku649ge3lUXkB1Iyy5DWGeiVl5IYvFHjFscRu/zgmg0k/jccNEt20BSJYbEIbZDs3JgtQcx0toxZhA4lIsy6OUCpZy2DgLYh/5VO2+w3JvcesD+rFZmQCfiGIHqtf8Z3G5HqT7R8b5OSUMbkcqVzb0mxg/kw1wv1AkHPN8ki6YDSlaBlaIYJ3/Z8YUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHe2llS2wJ7nGAZoJXraJW2loRg75Lcnp2zgd7YTccI=;
 b=MEd58msb65rsf12Hu1QEctAuV9MwVExHTx0yTG4D+tOU//TlmbKS+81ra3OZgwVP+PSSe/8vjBLwPp44LiyOxPjtglWya9AOeD9yv8qDjg0XbBGv3Ti++rcWgH52JnVy2R69U4WKjDIgAihlvYLDJ0VIETDe+VMg4faRciX1w7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS2PR01MB9439.prod.exchangelabs.com (2603:10b6:8:2be::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Wed, 27 May 2026 23:44:34 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 23:44:34 +0000
Message-ID: <cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
Date: Wed, 27 May 2026 16:44:31 -0700
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
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
 <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
 <20260522091805.18098A5c-hca@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260522091805.18098A5c-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS2PR01MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: bec450ac-3609-43fd-5685-08debc49e7b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|55112099003|22082099003|18002099003|3023799007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ofe96Sc13kHr1pFFC5H2fTv1+nlFvraVY4Kk19jGoCgNOYL+iwoQUNMuznlb8lX5Fgr3Yr/vflkycohLM1Ui3/d1eQB8vuVFUOdqj4OYvpVUt/mhXs/27cyYMR6VK2iSaen63WgqSOQtDPQMVxY2gDfhmeYw4ZwKo34/oa9kXVTURidR/6DXgnN1SesCsEKzSrQ0l27rcTea3Zn4Mvu5+O20FllovIL/Jog24M9oUk3wmtUydl/x0Kmtym968j5LkTc9NRQre7eN5V4g1auFyKuQQk06cjxzmeHhvgfOhfXoo/GvZ+5tr9xHT+ILvaK9WuliWPXA0sPnPH9trvs++mg+R/I8lREtRESq87Xpwn/WqKUtMaUdpAGaXOx2LR6YwjGX8znov+uC65Cas/OsfOySMCObcxWsYvrrTtBsWGbBIi0xtQpDbBz52eCTqOubvb0GchQN8d1+bq5iLcNhQ5zzF12Bby3v0IAnNJwVwf2fewl255rLl0nUCK4FJal8fuZWA1D/jIJeA5s6Ig6uiBbUcm9nv9mBkXDUpkBhgd6BQyyiXn48DUXnrrpOYC2Z9riIj8myd8HmXPL/5E5s0S6AbS7E3Z2aoi4MIM2TuUcdEEhnL1BhLe2PhimLkuOcmDyuy58VGP6tXYty0xZJ0nqN//OT83f5aP2T64pPGmPr+tXFFsdBE/mOifKdvMMe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(55112099003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCtXSWlLV0FsV0pYUFVUWDF2ZS9JTEM1WVpLUmNDL0NiOGJLVjdLSjg3SWdW?=
 =?utf-8?B?cTkzQzB6WXM0bVRlbmR3Q1M1UGNpOWVUOC9QVDJVK2xGOTluaXVxUkwzZGY3?=
 =?utf-8?B?QlJzcitNdUNCZkFGOHYyNmlSN1lndUwxUmhvT2IxSXVTd1Y4MlRMQzEvUUho?=
 =?utf-8?B?bEp2UG0vS0FJTWRTajkvc0NJOHA1a0doUitYbkpYK2VodjkzMTVxNTgveEdJ?=
 =?utf-8?B?VmJmOXFFRHV5RzlkWjkwYnE1QTRJdDlhNjl2WVkvL3VKZE9BUVV5Y2FVVjdi?=
 =?utf-8?B?Z2xPaFFuenBaSFUzWnNJTGorQjdoMFZMdzNCY21LUXMrNUJIdWhFeEJZM2FX?=
 =?utf-8?B?KzZiNHJKZHBlSENjc1BiRFp5YW1TeW93WEtjdTJzeTBGQTBsbFAwOThwdUtx?=
 =?utf-8?B?bzIvelZXR05WU2lGbGRYMDY5M09CaWFBR2c3aVhCa1IxdGs5RTZVY0t2N3VJ?=
 =?utf-8?B?OWVPYzN3NlZZdlBCMk43QktubmpKenJYRjVybWVObDBWMTYwR3VJQTM2WHZP?=
 =?utf-8?B?Y29lTUVuZkRqRmVnV3FmQlZxVEZVUkovZURuWElFZlFSYWdKY3h6ZERBN2s1?=
 =?utf-8?B?cytranhsZ0dwVUs3VkRYb2lVaEVadlBxazZydlJwbTA2N2Ivb1BDMTNxc3A3?=
 =?utf-8?B?MnRNcUlOS0Y0WE0wcStWZEhkVXVLVVh1RE1razcxbjUxRmdteWVDL2dlL3BU?=
 =?utf-8?B?cjZod1BkZTdpdGlHQXJydlhQSzdQWG04VENXWU1hTUV4RzBNZ2Ezdzd4RUor?=
 =?utf-8?B?VkkwTUgvZ1ZYYkMyOG5yclFMSzFxQzhUK2hmclpVQnk3ZEVRdGV4TDV6WW4w?=
 =?utf-8?B?eVVPVGRja0VHR09lVkY1SVVyV1NMVU5ZdnB2ZmVUbkdYWXpHMzdxZUFLM1BS?=
 =?utf-8?B?eEo5bUtKUWdLSURtTXp3K2JNaUVxNGhnRFp0TlFQUzlpWVpYV1NOSnFoVmxj?=
 =?utf-8?B?Qk5wdHh1SjUvYU9GS2FmQzdkZVJzWXJrUng2Mno3czBpYzJLZjYwTGNhbVV3?=
 =?utf-8?B?TTJna1JrWFJneXdnaDZ4Yk5hSjlRT05UcXNjYkNBb3hJMjBCWmpGUzZ2YTM4?=
 =?utf-8?B?S0JGazZUSCtuVEdzNU9kWng0YlBJeFJGL1VNaW93MFUvY2w3TkYvanordTRO?=
 =?utf-8?B?anhIajBZQ0RmWHBWQllPczEyUm12Y0phbTF3ZnBrMzNWeGdZTXNIeDB5VFBx?=
 =?utf-8?B?Ukw3RFZSclBLMFN5NDQ3RytrQ1FzUEltR1drUmhtMmY4YTFPMzRSNGE1b1Fn?=
 =?utf-8?B?VWpURTNmVGY4eVI5SjZQNDRYV1Vaeit5R0lGa0pWUmVPTUEzd1dLQXFOM2FF?=
 =?utf-8?B?bEVmckF0M3NHMk4yWi9ITkJkOTNqTldwZFFRUlh6aHFlcys3R2h4Vm02MUxD?=
 =?utf-8?B?NUxWUG42WDZ4elZqbWMwdWh6QVRZWnVid1ZPaFlZemFLWklaaC83MUs0TXJ0?=
 =?utf-8?B?dk9YbCswRERmbTltdk13N1BmODRWalgxVXpvdWdrcWRuK014UUYrNjd3QkF1?=
 =?utf-8?B?OEY3RXFteFZXbmpUZHB6bXM5QkRFclpNR1BLMnVQNFlZaXVweUVoWE5MSUl3?=
 =?utf-8?B?b1RYTXoxcFRvNFFDWE8zWjNPSDVZNmpXdzRTS2VmUERtaXQ5eWdJcTZ4NjNF?=
 =?utf-8?B?QWdVcko3VTA5TUJOOFFxbEJPRVZseks2UFB0dmJyNzBSUzhXV2M2dWR4Vlli?=
 =?utf-8?B?QzdxbE5BMDFpckQxdzBBaDgvaW9lNlJmWVhveTZTQm02UG1FcFNWZkNpN2tN?=
 =?utf-8?B?ekdvUUJZcjJORjJLdGtwRG9jOGZDV3pQa2JBd2VPM0k3N3h6cDVoZWVCL21t?=
 =?utf-8?B?eXU1RWFNVkFlUFIzcDg1cnA0ZG85TEU5TjdVcWtDd3JpeWF6V0M3VUJSMy9V?=
 =?utf-8?B?QnpKeDZWNWFYWTh4WTRaaTgrdHBEUCtYcEVwRUpFLzZzaTZ1bmdENGV2RzQ4?=
 =?utf-8?B?eGlJcVlCWHZCS0prejJPTmg0TEJWOExRY2xteHQ0R1IyTVN1MmVsSkRWd3V5?=
 =?utf-8?B?Y2dMVEZXQm9TOTZtclJjbEJMa0Q0Zy9jOGNEZUk0T1NVTG5TT09hU2U0K3Ru?=
 =?utf-8?B?Q1E1SXUySjZmOTk3RFhKaVdqUjExQlZJbGd0T1VWeVBkbk9mQ0xRWnV6ZnJh?=
 =?utf-8?B?bHoyV1BzSFQ5VlNucmp0djZDS05mNjVXL1ozSXR6VWVaZVYvZWI5V1pOUnMy?=
 =?utf-8?B?aVhFRE4rekl4N2E0WEpaM3NQdUJTdllQUk5rb21EYldJQSs0c0xlVUVLYkNa?=
 =?utf-8?B?Z3cwS3lXSUpMK1VwZG5DaE11aENlaklmNmNEVFg5L2J4ZWFpZmFCeEpIMkFx?=
 =?utf-8?B?b2ZTbzBhV1NGcG1UalV6dU5yTkxNVTNmVDYyZ0dKaFRjRk9DWUlGR0JVTWZh?=
 =?utf-8?Q?LUtFQiI6cRHEWs50=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec450ac-3609-43fd-5685-08debc49e7b4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:44:34.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8ifgSc2i6F3FF487z0OLd9PSxCLFpwSOh+wu5jWcJFMXgi5FgDlUkPO3TqNADAXyIED+ky1LFfeTf60unKpX2Do9J5+insXF2PyyQneQG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9439



On 5/22/26 2:18 AM, Heiko Carstens wrote:
> On Thu, May 21, 2026 at 10:47:49AM -0700, Yang Shi wrote:
>>> As background: s390 has so called prefix pages; the first two pages of every
>>> CPU are percpu, via a special prefixing mechanism. Parts of the pages can be
>>> used by operating systems as percpu data area, which we use to have fast
>>> access to e.g. the 'current' pointer, the pid, percpu_offset of the current
>>> cpu, etc.
>>>
>>> Helpful is also that for instructions which access memory with a base register
>>> zero, its contents are assumed to be zero for address generation by the
>>> hardware, regardless of its real contents. That is, the above
>>>
>>>           ag %r4,952
>>>
>>> is the short version of
>>>
>>>           ag %r4,952(%r0)
>>>
>>> The eight bytes at offset 952 of the current CPU's prefix page are added to
>>> register 4. Real contents of register 0 are irrelevant for such address
>>> generations; reducing register pressure.
>> Aha, I see. So the prefix pages are some special memory?
> No, it is regular memory. The CPU has a special "prefix register". If
> that is set to an address not equal to zero all memory accesses to the
> first two pages will be transparently redirected to the 8k memory area
> specified with that register.
>
> E.g. the prefix register contains the value 0x10000. If then a memory
> access to address 0x400 happens the CPU will transparently turn that
> into a memory access to address 0x10400. Or in other words, that is a
> small per cpu memory area mechanism provided by the architecture.

Got it.

>>>>     11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
>>>>     11a8ec:       b9 04 00 43             lgr     %r4,%r3
>>>>     11a8f0:       eb 00 43 c0 00 52       mviy    960,4
>>>>     11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
>>>>     11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
>>>>     11a902:       eb 00 03 c0 00 52       mviy    960,0
>>>>     11a908:       b9 08 00 25             agr     %r2,%r5
>>>>     11a90c        07 fe                   br      %r14
> ...
>
>>>> 11a920 loads 0 to the register to mark the percpu code section end, this is
>>>> not needed with percpu page table.
>>> I guess you meant 11a902. But yes, this marks the end of the percpu code
>>> section. Just that this is not a register, but a memory location where is
>>> written to.
>> So both mviy instructions actually do memory store?
> Yes.
>
>>>> It sounds a little bit hacky to me TBH and incur some extra overhead for
>>>> "migration detection" and fixup.
>>> Sure, it is hacky, and the small overhead part is of course true.
>>>
>>> Compared to the percpu page table proposal the two mviy instructions above
>>> would go away, as well as the extra interrupt/exception overhead. Besides
>>> that your proposal is way less hacky.
>> It would be great if we can compare the performance number for the two
>> approaches. rseq has been discussed for ARM64, but it seems too expensive
>> and just move the overhead to somewhere else.
> I tried to implement the proposed rseq/kseq, but the required inline
> assemblies resulted in code which was larger than what we have now for
> s390.
>
> Also with the current proposal I only did some quick micro benchmarks,
> which resulted in 0-1% improvement, which is in the expected range.
>
> It is amazing to see the performance improvements you see on arm64, however
> I believe that is mainly because of the large amount of code which is
> generated by the arm64 implementations of the preempt primitives
> __preempt_count_add() and __preempt_count_dec_and_test().

Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one 
instruction is used to load current pointer, the other 3 instructions 
are used to RMW preempt_count). So I can remove 8 instructions in total 
for a single this_cpu ops. That's a lot. Given this_cpu ops are heavily 
used in kernel, we end up running fewer instructions and having better 
icache hit rate, the better icache hit rate also helps reduce cross node 
traffic for 2-socket system.

> That's a big difference to s390: for both primitives the result is a single
> instruction.

Yeah, I see. S390 should have the similar benefits theoretically, but 
may not have that significant gains.

Thanks,
Yang




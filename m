Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020082.outbound.protection.outlook.com [52.101.201.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3E1E4AF;
	Thu, 21 May 2026 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323033; cv=fail; b=mHUTPe4Tm+V5wFQI+EhX2ib3FM3LmBetx7W9sUXARSb3QvICp+vH+P2Mu1BfivbEspP/SRuCEv83bxIJuska0g9xshDLjeibJ+b1z3hZ1tSSHrS5Cx/LLCSfGClcQk91OKMfT80SQpr+g7Ze9a9oTUGdvciIdl9pBq9jApVAPbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323033; c=relaxed/simple;
	bh=J77Hmu/v1QOg05MXs+TAUYN/zV37l2eU2HlSXT9g8Zc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b/HjT+C1WVVTZWXXsHktFJA3tqT2idsZaHZ3JcjOCH8zHR9vXl2av4N0yFtdtJuYQ1QDvSbf17jb/XmZi+5IsnOlvre/xJ+2BRWFJO1vIVsRB20rh5+h6oe+gUXueh2bCaquY3Xg77kXjLoSyuMtCCEW9xe8Xm4OrTowHaDY5k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rYxEk8sn; arc=fail smtp.client-ip=52.101.201.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rYxEk8sn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHwrVt59ff//qIq6YJiIinZHF9c1Po1c5x0f8sfAJ4rI2ZtcoltFus9Uqe7exSgsfuTPc++IJ0F+aRdoxdgEG4r8edsXT19hgtUTdzCLMu8r2lWD0z/JfFqYoReA/OgBNOk+akmA6mfnnLOUYM93bQMZLVghjwgGu+bEaHNJ0yhpR/hTs7Ad4GzOzyHu+j6PJLuOZNLPCvBu3JP3A0O+H7hl38yqxJztqxZ8XnwinXgYf3QBmLpQRxfaFOUlf1gFWbUBi7kEOEc7ZeKKBDgsqGjcJcAZpFZIEZesKJRYtWNSsVynEbjWn3i3bkPfJ7pevVnpLkVW8BIanJ8DM4alCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIXiq6FqX5sjLZ2hKry2u97x7nv0z7o64swNJKesYbY=;
 b=e5NY+5LNTjnec2dwf1OLS80DnV9wth4GdqizPWzwByABS8GMbybaP+phcNwOoSe+PDWYO57tSN3GLhrE03E2AX/yyvWMfdaY2jC/xRwsaWMh37S2lLXxtjPitrnxBYKP/nAC7P/NsnLMI7NudRxGNeS/jlntx1I982ATMH43LvU6vo0tJjm9wKFPxTmzl2u2IBekFPMPg121RtjQl1OXsQdttJ0rGDmVMsUmBq7XpM928XSo5W749mPKa9pN+l1COFfx2sDhemDFplZ27DiGeQW53o6BWCFZR6PGK2ldNwYeSZEYRo2Vap7ZCJmfGBfW3pLyxaB8XS0Ugxa/dbWJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIXiq6FqX5sjLZ2hKry2u97x7nv0z7o64swNJKesYbY=;
 b=rYxEk8snberCL1Xz1YNuPwq9Q/GTavGH0IJVP6n/6mNweI7cgpuWMgnGaskpIATIA5xXygAj2v3Qndx1ADPaljOLlRyI+1eqOMM+41qggLErDrGnDOjYVnOWR7d83X3YmLXQLe357e9i8ESFsYMWK6f7LlMFNb4FwFIfWwo93pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB8177.prod.exchangelabs.com (2603:10b6:806:332::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Thu, 21 May 2026 00:23:41 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 00:23:41 +0000
Message-ID: <d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
Date: Wed, 20 May 2026 17:23:37 -0700
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
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260520233409.0683f595@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0077.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:9::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: be1f5508-f92c-426d-414f-08deb6cf35e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|55112099003|4143699003|5023799004|11063799006|3023799007|6133799003|22082099003|18002099003|56012099003|11146099003;
X-Microsoft-Antispam-Message-Info:
	fMTjyvEefCj9mpQiNTuFNWkN+zkcSf55sX681p1ZRVjZlnvNVTfPTkcA6/Ur7m2WNUreoLpzTxiJgB4CycUsXBn3JvGTugKMKIpY6EXyGJi26A8YswCJk7/lCjcg3F/Zv0Hlik1XQ810svN1EeXqDPAQMJ/IvT+Sb6kg3E2fRa24X8sx/cPRK9UBKTxXvzW8VhhTwi+auSAaqkHtO99PQ4cVxwet3ROqEqMB5dr+vxYMdwqDmANMyClBP21SP03JLgMVSdobsfYhzAzqLHqEa+Mm5qDacWD2jjQgT3fWoDfhez+J2dKQGqYYj5hGbS1f1v7SQnZqCSg7vLMp5Z6qE4u7Ws3Nxf2kuTH0AiJgpCqcxwi50CzffBhcujDAcFneZd12c5QPmxOw1O7Csdq7dN8Js31Yw5ue1DrOrAiGhIlBqUFjgTql+Z2804EgkhKLB00s16gWeZx22dhzTGbsuUB8Fkp64749i/bxSUgNABUnrr9ytSnkzVYnAP4wGZR3j6cRIeQn3s9h5gj9Dn+0eWGhLXL4ZlcX2XMr1NAGD/eF9rLYhyFElhwfKMKScqeB/u6Avz9rhflNoxmOcGHKh+S6ndTxH7F7LKoz+8rGX+3pdvYyxGohIIaQUdyucDWVwlYBHG15mp3AW+I2x0NcnQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(4143699003)(5023799004)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003)(56012099003)(11146099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1NCUjh4Z0kxNjRNaDBIYUNZQ3dvZGFmUjdibmxWMy9zdEZhRU81SzJablFD?=
 =?utf-8?B?bmw4dTZpQnFoKzN1RkREaFl6b2d4M09WL2VpdHRaSlI0ZU1qV3Z1d0xNQnJ0?=
 =?utf-8?B?QklnTnljQnBCTTArMXNXRnh1Q2Y1WWtSQTFydWlUdlEwdVQrMXBnK0lneUh2?=
 =?utf-8?B?S1VkU1dFT0lNaWhwbFFjTW9xbXRuMGlhNGtnYkRDek1sVGtkdW9JRVVFQU5J?=
 =?utf-8?B?bHRGZGgrTjdMUVFUbHFtRWdoUHM4NWxIZ0RuU0EzWXJEVFh6ZjEwWTJMekpj?=
 =?utf-8?B?UUdNdVdUTnBjbWc3a2JrSzhZNktOR2NmNDMzN1B3dTRhMXpYd1M3QVdvaEJG?=
 =?utf-8?B?M0ZWcmlTZXora3QzUy9PU0thbW4wQ09iaXJuVlMwOGVPRXRLRzFZeVQwQ2Nn?=
 =?utf-8?B?Y3dJN3U2b0F3cjEwYTRZUnpkaDUzNFB2YUNuMElCRk1jSWE0U2tnc2dnNWRa?=
 =?utf-8?B?NVN3cHpUUUIrU20zYk4xR3o2RFlQK1IydVFqNDRleHRROVNCT3BFTTYvVGUw?=
 =?utf-8?B?dUZsOXAzL05BdFU4YVVsdGhXKzUyTE55WU5vWjFVTUs0Wm1mOTlWWDR4YnZz?=
 =?utf-8?B?UW9PYi9UUENXU2p2enZlNkJZNVNBN1ltemxQU1lVU2oyZC9ER1VlYU1jMERG?=
 =?utf-8?B?TjR6b2loNVNCTExSeUs0cW1qMGVXemEzWi9WNkREOVZoa3p3KzlFTVhLUFhw?=
 =?utf-8?B?UVhTclBkNnBsWW9pejRTUDMwdm55dGpRclNkbUVDbHZwSlViTnNpSTB3RmNC?=
 =?utf-8?B?dFRwbGwzT1BzMnBVRklneTZVZmV4bWpyL1RtSUV6M0NKaXVJRlhjaENRajBN?=
 =?utf-8?B?RnVFRXlOMzY3OVZDOG1QR3QrWC8vUWtZOHluZkRZdHFYeXRLeUxZbFFNM1J1?=
 =?utf-8?B?blJ5QkxxYlNZSmxrcTNkcE4vd3NnV1BlcEVIeGl4L1UvZUVuVUFvV1pSNU5J?=
 =?utf-8?B?M3lLS3M3bWdaM0NqVURBRWc2ZVZUREUzRjF2TW5oa0N1UGpqYnBXU1FFSGQ4?=
 =?utf-8?B?WEVwZ3VKTkVGNmNQaWswSUNoSTdQN1lqZ0QvMmdMbjBOZGZaTkM2ejlLN1JW?=
 =?utf-8?B?SVdEeFR1USs5NjhLRTk3NjNnWTN1MndlcDg2Q2RvczNUZy8vQnhoRUk4MjRL?=
 =?utf-8?B?RmxNN05uZU1xZWtyNDhPbGNTZVNGcjU4WWJlWnluZURxVkgwY3ZkUzFBS2Zy?=
 =?utf-8?B?ejhFUWVTRjFBUUJHZGdMOTNNMjAvVFJ3U2laZk5NdXFOT1VVQnQ5akRRdnE2?=
 =?utf-8?B?TitUUWhJMTM2bnhxUjF2Q3Nzc0NkQXVpbVFJeUtiVnVuQ0szMWcveGV1eVYr?=
 =?utf-8?B?WXNRWnVjaEQyamMrY0x1aC9PZG9XQjc0N2w3MHFLWGQxTHNYN2Fob0laL1E2?=
 =?utf-8?B?bGhLb0lBUm5jUUNUa0VBYWFxZ1VKQ3BqYTUvTlFXajJHU2c1Zjhibm0rcUI0?=
 =?utf-8?B?OVBNN0FNWHhyWk1USk9rcWkyYlFIUzZoTmtIQ1Bsdkt0d0MxZVRoT3JNY3hh?=
 =?utf-8?B?WVFWZWIvbmdRekR5Y0VsWS9IT3Nvc2NwU1Y4VEp6bTNuR1FPdUhmcmJSb2hh?=
 =?utf-8?B?WEY1YkZyK1pGaG0vZXRVRGdvNzNVSENlZmVCWHdZL0UxeUp2SW1hbjYvMU1i?=
 =?utf-8?B?ZjBGdlZZZk84Q1ViTXJxeGZMTVZxbmpVdGhDYVJOTktkTlpUbUtyV0hoUXYv?=
 =?utf-8?B?anVTcDFsenZ3RWg0amVSb0xUWnc4UFJ4eXFvTUpaMWJZUWtJaXhzbkdHVnZM?=
 =?utf-8?B?bkF3SERlbnhHRXpCVnVFMmZ0c3BBUUdUdVdTMG9iZHR0V1pxZXFjNmcyUTFu?=
 =?utf-8?B?RndpVWExN0FXeTlOTGhHNytsZDAxQzBaWWh1KytDZ0Z5Vk5WWEhIV0liMlh5?=
 =?utf-8?B?bk4wYjNWT2VMQlI2ZGFsdjJrMTVrc0loYzZZYUZPMHB4WkQyVWFycGNGM0po?=
 =?utf-8?B?bFo3cElEa21CNjdkbGs2VGJOM0pvdnorMXE1OEVsKzdwYWxlTEZFaXhmdUdm?=
 =?utf-8?B?emJIWlZXVWRsbEZjOGVtekpmLzgyYno0VUtabkVabVBWWWpvUW0yWWtJdlNE?=
 =?utf-8?B?clZ4Ti9wa0xpR1R6OUpIR1ZPNjAydjN2MWZSOUg0dWtoRWFGVkxudGZOQUF6?=
 =?utf-8?B?bWhaMk10bDZZU3dNRGVtNTFCbXU4UVlmWVppZXV2bmxNQm1oNzB0SDgrUXNZ?=
 =?utf-8?B?ckpWd3daWWhIMHBPTldWN3UyOGhCcUlrUmNjeUxiandkNG0zU0pSdmJrcXMv?=
 =?utf-8?B?ckJBVW5UOXliYUZkb281Ti9rYmJKOGVLMlNEckJqNy80aWNyZWluVUtuYUF0?=
 =?utf-8?B?dDhLMjJpc2hWZU45QWZ5enpoVVc4S04vWWVPR1RpMFlUK2s3UmFXKzN6RDBo?=
 =?utf-8?Q?HgLnI2CWsgOtcRR8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1f5508-f92c-426d-414f-08deb6cf35e5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 00:23:41.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hQxHr/5yLgYWmjQ1ceJt5Efx/Rh0p3Mkp0P91ZQ+f9OloghGQJcfYD15xqZv+k8szD0397Lz7wiOeVizwjvwAvt0YTspnseuYUFm5vLrCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8177



On 5/20/26 3:34 PM, David Laight wrote:
> On Wed, 20 May 2026 11:42:36 -0700
> Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> Hi Heiko,
>>
>> Thanks for cc'ing me the patchset. Please see the below inline comments.
>>
>>
>> On 5/20/26 2:22 AM, Heiko Carstens wrote:
>>> v3:
>>> - Fix various typos [Juergen Christ]
>>>
>>> - Add missing kprobe detection / handling [Sashiko [3]]
>>>     [FWIW, this made me also aware of that the current general s390 kprobes
>>>      code seems to be racy against concurrent removal of a kprobe while a
>>>      probe hit on a different CPU. But that is a different story.]
>>>
>>> - Fix various minor findings [Sashiko [3]]
>>>
>>> - All of this might be dropped / exchanged in future in favor of the percpu
>>>     page table approach proposed by Yang Shi [4].
>> Thanks for mentioning my approach. I will do some comparison with rseq
>> in the following design details section of the cover letter.
>>
>>> [3] https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca@linux.ibm.com
>>> [4] https://lore.kernel.org/all/20260429170758.3018959-1-yang@os.amperecomputing.com/
>>>
>>> v2:
>>>
>>> - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
>>>     warnings
>>>
>>> - Add missing __packed attribute to insn structure [Sashiko [2]]
>>>
>>> - Fix inverted if condition [Sashiko [2]]
>>>
>>> - Add missing user_mode() check [Sashiko [2]]
>>>
>>> - Move percpu_entry() call in front of irqentry_enter() call in all
>>>     entry paths to avoid that potential this_cpu() operations overwrite
>>>     the not-yet saved percpu code section indicator  [Sashiko [2]]
>>>
>>> [2] https://sashiko.dev/#/patchset/20260317195436.2276810-1-hca%40linux.ibm.com
>>>
>>> v1:
>>>
>>> This is a follow-up to Peter Zijlstra's in-kernel rseq RFC [1].
>>>
>>> With the intended removal of PREEMPT_NONE this_cpu operations based on
>>> atomic instructions, guarded with preempt_disable()/preempt_enable() pairs,
>>> become more expensive: the preempt_disable() / preempt_enable() pairs are
>>> not optimized away anymore during compile time.
>>>
>>> In particular the conditional call to preempt_schedule_notrace() after
>>> preempt_enable() adds additional code and register pressure.
>>>
>>> To avoid this Peter suggested an in-kernel rseq approach. While this would
>>> certainly work, this series tries to come up with a solution which uses
>>> less instructions and doesn't require to repeat instruction sequences.
>>>
>>> The idea is that this_cpu operations based on atomic instructions are
>>> guarded with mvyi instructions:
>>>
>>> - The first mvyi instruction writes the register number, which contains
>>>     the percpu address variable to lowcore. This also indicates that a
>>>     percpu code section is executed.
>>>
>>> - The first instruction following the mvyi instruction must be the ag
>>>     instruction which adds the percpu offset to the percpu address register.
>>>
>>> - Afterwards the atomic percpu operation follows.
>>>
>>> - Then a second mvyi instruction writes a zero to lowcore, which indicates
>>>     the end of the percpu code section.
>>>
>>> - In case of an interrupt/exception/nmi the register number which was
>>>     written to lowcore is copied to the exception frame (pt_regs), and a zero
>>>     is written to lowcore.
>>>
>>> - On return to the previous context it is checked if a percpu code section
>>>     was executed (saved register number not zero), and if the process was
>>>     migrated to a different cpu. If the percpu offset was already added to
>>>     the percpu address register (instruction address does _not_ point to the
>>>     ag instruction) the content of the percpu address register is adjusted so
>>>     it points to percpu variable of the new cpu.
>> If I understand correctly, you replaced preempt_disable() and
>> preempt_enable() with seq begin and seg end, and seq begin and seq end
>> can be optimized by mvyi instruction on S390. So you just need a single
>> mvyi instruction for each instead of read-modify-write the seq count.
>>
>> But you need some extra overhead for context switch (save and restore
>> the seq count register) and need to check whether it is still on the
>> same cpu once resuming execution. And there is also penalty if it is
>> migrated to another CPU (need to rerun this_cpu ops).
> Not as I understand it.
> What happens is the context switch code 'corrupts' the register being
> used to access per-cpu data so that it is correct for the new cpu.
> The write of zero after the sequence is there to stop the register
> being corrupted outside of this code window.

Thanks for elaborating it. I misunderstood some nuance. I read the patch 
#2 commit message, now I think I understand how it works.

Borrowed the disassemble from patch #2 commit message:

   11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
   11a8ec:       b9 04 00 43             lgr     %r4,%r3
   11a8f0:       eb 00 43 c0 00 52       mviy    960,4
   11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
   11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
   11a902:       eb 00 03 c0 00 52       mviy    960,0
   11a908:       b9 08 00 25             agr     %r2,%r5
   11a90c        07 fe                   br      %r14

11a8f0 loads the percpu offset and mark the percpu code section begin, I 
believe this is needed with percpu page table too because we need load 
local percpu offset.
11a920 loads 0 to the register to mark the percpu code section end, this 
is not needed with percpu page table.

And you need to save the register at the irq/exception entry, then 
restore it at exit. But you also need to check whether migration happens 
or not, if it happens kernel needs to rewrite the register with correct 
percpu offset and needs to check whether the interrupted instruction is 
"ag". If it is "ag" instruction (11a8f6) , kernel needs to recalculate 
the percpu address, right?

It sounds a little bit hacky to me TBH and incur some extra overhead for 
"migration detection" and fixup.

>
> This really just means that you can (mostly) only do single accesses,
> since nothing stops pre-emption between the RW or an RMW sequence.
> Although you can probably do an increment of the preempt disable count
> because if you are preempted the value read will be zero.
>
>> So it seems have more overhead than the percpu page table approach IIUC.
>> We don't need all the steps with percpu page table. And there is no
>> penalty for migration.
> This code looks like it relies on 'page zero' already being percpu.
> So it probably isn't really that different.
> Some values like the 'preemption disable count' and 'current' could be
> (maybe are?) written into page zero to give fast access.

I don't quite get what you mean about 'page zero'.

>
> But I'm sure I remember that some cpu don't like having the same
> physical address at different virtual addresses (and not just those
> with VIVT caches like some sparc cpu).

Yeah, VIVT cache doesn't like it due to cache alias. But the mapping is 
really percpu, so the mapping to the physical address belonging to 
another CPU should never pollute the current CPU's cache if I don't miss 
something.

> I'm sure code can end up accessing the current cpu's percpu data
> using the same address that other cpu use - there are definitely
> places where it needs that address.

No, it is not. In the percpu page table approach, we use different 
address for this_cpu_*() and per_cpu_ptr() which is mainly used to 
initialize percpu data for all CPUs.

Thanks,
Yang

> On x86-64 that means it reading the address from the array rather
> than just offsetting from %gs.
>
> -- David
>
>>> All of this seems to work, but of course it could still be broken since I
>>> missed some detail.
>>>
>>> In total this series results in a kernel text size reduction of ~106kb. The
>>> number of preempt_schedule_notrace() call sites is reduced from 7089 to
>>> 1577.
>> Yeah, both approaches can reduce the number of
>> preempt_schedule_notrace() call sites. And both approaches can reduce
>> the number of non-preemptible critical sections.
>>
>>> Note: this comes without any huge performance analysis, however all
>>> microbenchmarks confirmed that the new code is at least as fast as the
>>> old code, like expected.
>> I'm really interested in the benchmark number. I'm supposed percpu page
>> table approach should have better performance per my above analysis.
>>
>> Christopher Lameter is also interested in it, cc'ed him too.
>>
>> Thanks,
>> Yang
>>
>>> [1] 20260223163843.GR1282955@noisy.programming.kicks-ass.net
>>>
>>> Heiko Carstens (9):
>>>     s390/alternatives: Add new ALT_TYPE_PERCPU type
>>>     s390/percpu: Infrastructure for more efficient this_cpu operations
>>>     s390/percpu: Add missing do { } while (0) constructs
>>>     s390/percpu: Use new percpu code section for arch_this_cpu_add()
>>>     s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
>>>     s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
>>>     s390/percpu: Provide arch_this_cpu_read() implementation
>>>     s390/percpu: Provide arch_this_cpu_write() implementation
>>>     s390/percpu: Remove one and two byte this_cpu operation implementation
>>>
>>>    arch/s390/boot/alternative.c         |   7 +
>>>    arch/s390/include/asm/alternative.h  |   5 +
>>>    arch/s390/include/asm/entry-percpu.h |  76 ++++++++
>>>    arch/s390/include/asm/lowcore.h      |   3 +-
>>>    arch/s390/include/asm/percpu.h       | 249 +++++++++++++++++++++------
>>>    arch/s390/include/asm/ptrace.h       |   2 +
>>>    arch/s390/kernel/alternative.c       |  25 ++-
>>>    arch/s390/kernel/irq.c               |  26 ++-
>>>    arch/s390/kernel/nmi.c               |   6 +
>>>    arch/s390/kernel/traps.c             |   6 +
>>>    10 files changed, 344 insertions(+), 61 deletions(-)
>>>    create mode 100644 arch/s390/include/asm/entry-percpu.h
>>>
>>> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
>>


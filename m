Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023120.outbound.protection.outlook.com [40.107.201.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1334107F;
	Thu, 28 May 2026 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995994; cv=fail; b=twKL4XB8GSWyLi3/Gxqzd78WoZbz+Vzp+krWbZL+HZ0VVqS6HdDLmSpxgMppvbkbrvbn6tb3lQcKMKhXCY6uosOFg/ctBvlMHnIdzR56ZhWm5X0JwI7YNbIXi52aVjRZl937trdHPjK8P5NjlEwSayels1NmRbrlFM26/BG7LcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995994; c=relaxed/simple;
	bh=b4Q8V57wm9y+ksAH3ccmfy/DRScChYqgFVAFI5r4kUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qN2OVWHJPv1IlE3G/T+VEe/OA4leLbfax8pdYQWJpu4oFcPzpCHPORlPR+4NipFmYF/sN6Nk50RtB4kpQ2cJdgKCDBkwMK6JLwfGZ5EyIhsdlJYn0J4U1bxhNHu3IskojbtpHTsSQqKlyfQeNJBA0+H1ENwSfLQad00qhbLPkx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fBKHAU0T; arc=fail smtp.client-ip=40.107.201.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fBKHAU0T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GajFym4od84y0u+rTw9XUAeWsruuWD4FbDHOWu8AZorA7uYqcfME5YpIf7/mxPx0nVGl0vmnDTQvq+bMkPMmYY5SRKA5CeY1QBoPFkSi9622BY8ssd3iWE82wOLT/eplDpN2oOHr+gu7BbOTS2lt1ZRLHeWw5yczCHNuKk1WZLmi3Fki4jCR542yLEtOBhRd1QMb+HYiz/H0JwFKlpyyohmH+LW3R+PKowIymzBSAqyjyq1Yr46X8zTcBKNJwN8HGgvI/S4gIYZYSrz7uDxKkg9Y6aeUXcDdPFxqcYjC+wccNG4H6c27bZiW3K7XMItfmeorYF/NHt1isLz4qoEa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JItZiqMtEUCgdE8I9Mmwhiz8m02VK1HMlaxpPdNqn6o=;
 b=nbA3VqvJ7wVkSpr/wSJBSLPtrjnyTzejyTmteVxmWD/zwz//kqtEckHv4nB8IQa5LA1ldIg7ihuCvGZa02AqtmUt7sdExFdYlsUVQHayC1Z1PV2GlVslfMPlM+2R66/0P20MUt1pvmsKVOzbeDOspMv9XAYp4WA7Y5xBVqmJH1BOqMe09Q5BMhvnRKNQf8VedlcJzfuoF51mcDc/5Snnnegg9GQIyaKCAmpB80+Pd73Gg7tRKY6XjegZWy7rAJbUvm4Gu15mmLsVRtEOkn/CHqLC8sVSGvpSRZ92Zc4qorimQ3dzQiSQ0wo8o7oQELP2dKD1bLhXnn6XEkHg9QEYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JItZiqMtEUCgdE8I9Mmwhiz8m02VK1HMlaxpPdNqn6o=;
 b=fBKHAU0Tvbp9b5RP58GrVJ+JLVdbQsuxHQoY8btm6hjsO2vbz22g19OlKtA3e4H5szNxTrb3X+66gAVo1QDBYrwvtpb6WvW6vEU8/a90mjJr4YuKMN8+ncCb9KYm/mop+9xRG4Ze6qITIb1wJTBOp5SlBj+qAYzJcH6plCXJYT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM8PR01MB7029.prod.exchangelabs.com (2603:10b6:8:17::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Thu, 28 May 2026 19:19:49 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 19:19:47 +0000
Message-ID: <37aa12be-f3ee-4b6d-8fcc-33ccdec2725b@os.amperecomputing.com>
Date: Thu, 28 May 2026 12:19:43 -0700
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
 <20260521103742.9603C8c-hca@linux.ibm.com>
 <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
 <20260522091805.18098A5c-hca@linux.ibm.com>
 <cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
 <20260528100346.1e790a53@pumpkin>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260528100346.1e790a53@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM8PR01MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c1f451-5ea4-49cd-f85a-08debcee14d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|55112099003|56012099006|3023799007|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cZfLWcTxwPS7wSTHAwkCe/dldGX0cjx8i5x2Q3E3c8NXq7ECogwGnkBHfJoDW4q55vV1pK2Az48bE82g4CdqljkSOucxnGPC3AcFdFwzEbfIF38VgmPu7FXqXiUddS/EjUR4PDH8LDli4MqnMgIjkO8Sqgtp699O0QLRXaoPU7qwJjpDxQ4m5I+nnTKxjYUDT8UDduwlWa43txceZSSz+rmGvv3gk6oAFdwRji6fR2ubF+MEH/Jz2zgjDTNyJj/X/ZAkNKIapWmnnme8bFBk6yqXNMDMySKMP4uGzj5z4AuqZwAzvZg8U6TDOjnty79yBIW+pnl4me4Yaiun6qrv+yjHB/f8ZaPtE5haSfBcLGl1t0p6InQCGRWK4ljlaKI8F7JKZv6Y331HfrYMKuFt1VceSX8oMghyWrkyCEvk1t4rfqSLRl6itNO8GuPlK6mCdluP3FpOfhGKb2HdD8Jc+p4JdaObDLk3X56o5UkJbMlpg5I+y21cy2WFosFiTkU4DTMtzIxwJlRqxcb/HZ+mRQ+fogBfjT6jHqXMRASok0nQQPgIdKag+HiS4Htf4/CIGTaUNoJPG9HDCE7/DFd68p6goeowTTWRBRTPo3QZ9rvWZGgByn5Ok4OjhSXzkLIvDsBZEE2ouXFhCkSXwQk6qNhHDLwwI9bJnHxOuop3y6ZXsbpjpI6mlnTccZuZk13GnNuaweHRk0IEKCzkWpR8EQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(55112099003)(56012099006)(3023799007)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek94UXI2cjNHc2lKUFpBc1ZYNjljU2djUGtMdE5Pc0p0QTExbGc1TDIyUGZK?=
 =?utf-8?B?Ui91S253RWc4RW9rN3dOUnByVmRiUVEzWHJEcndhUko4VkNiV05MLzVjSHpW?=
 =?utf-8?B?LytPZm5pY3plTEhpRG9JNkVrcWtYTWVsWGRaVmQ5RGhqMVFYd1dYczN3bTFu?=
 =?utf-8?B?QktOS2ZySkpiUU12TFJ2VExNMGVldVVzdkphQ3pZelBNYVZOdVpjWE1DcVlP?=
 =?utf-8?B?d1NWdG5WWW13MjM4VUNuVjJrZmRZQlNONFNjT0VmZXZJTjFrUDc1M0Zyc1p2?=
 =?utf-8?B?Sk5lNFJzK0N3am9qRS91YnFDem9mOWZhVk1ZZDdza2xTbHFTWWlKdHFkUlRM?=
 =?utf-8?B?SUdpeEQyL2FUZnhONnk2K0FpU2dXUU9NZmFsdWJ6OVBMVWlRL0ptYUxnaGdn?=
 =?utf-8?B?eXdBbTB5RTNQdVRzS0xDUmlRcDZCUXR4M2xPbUc3b05ORkl2SWYrK1RTTCts?=
 =?utf-8?B?Uk1RZnEzdXEwK1prMUtRaGVmUENpM0k5WGZCdE13V01BR1BpK1hkT3kwaU5F?=
 =?utf-8?B?SDJySnZKTExUV3lvcUwrMGdIb0o4UWl2OGh5cUY2b2RnZWk0cEpiMWF5MWZH?=
 =?utf-8?B?a0RMc1RTdmZCbCtsUzduRnpjdHM3cmxTSlZPNjdjTGZ6blpvdG1JNkpGU1RC?=
 =?utf-8?B?OUZ3Y25Ec2djdm9jbElIOUVrc3hPQzQ5UGQybXIrUEdoSk10MUFKeHJtSmIx?=
 =?utf-8?B?R05oZjByVjExR2Exc3J4NW8vTFp5R3ZuTGtwWDR4WFk4RlJXVjQxSTlOOUZ6?=
 =?utf-8?B?Um45M3VLMkFQSUpjVm9jTjh6bEhUTkY2YWJvVTl6MjFwcGRVQUhKRXJWSVpM?=
 =?utf-8?B?MEF6QU1JSEpKejJsbXBiRW1KUk93cmFLRHllSm14djQ3OTJTa0VwTmtUOUlW?=
 =?utf-8?B?VGVIMnpmR0hJZTVtak1jMVo2aFNVckxsVUlnYk5WY1hvbU82YnBLMDBoSlhB?=
 =?utf-8?B?SzhQZkNmNmgwT3pISnlFMTdWT0hpK0EzZ1Y4L0M2eG9FTFJRTkxpRWpLVTNT?=
 =?utf-8?B?WUdEMTFZeVlEUndld0pneWIxMktKUkZiUUVQbFpoMXNINmtRaExVN243d1pV?=
 =?utf-8?B?VTRMVFprTExuc0k1NVRvZTErR2JyZHZzcERaNHBzK0JTbmlmK0dkNlJVbDN2?=
 =?utf-8?B?YVNLL2FiMjRmc1l4MEZUN0o0blR2R2NQN01WMnV1QklWRTB2Zk5tclVCUDdQ?=
 =?utf-8?B?c2pwOEVyOGFYYk1Qek4vRVptVGhtZytUVWtXZXBpc1M5Q2hIb1IvamxJT2hX?=
 =?utf-8?B?NXhVQ3dOOGR1OFZJZS9jYVNOaWFQZ0ZWM3dGUHNxQUUySTdFeEtVK2JaSXl6?=
 =?utf-8?B?ekUwT1hpRXd0Q2dsREo4bTdLZURjZTZmVHhUbWpUY1hFRGJyRzZEWmFSTWR6?=
 =?utf-8?B?T2VKOEVnOUNwcVdESVZack8yeHEzVFdPU3N1UFV2VGtscE8yM1dRKzJ4S2ww?=
 =?utf-8?B?Qm5Wc29BSllWZSthcWZERHpUYmRFQUkxdk82UFNYWDBFZ3JhMy9OdkJpeWo5?=
 =?utf-8?B?dnRoWjR1blZjQkw1OUNaOWRBYW44eHJEK1RXeTdWYzVuYnZCRy9nYXBTMFQ5?=
 =?utf-8?B?TnhIenhBR29zMStKaW9mcWFnNC92Q092WVFpUUphQVU4dExNWk1WNVNWekVJ?=
 =?utf-8?B?VkZOdHlkSWhFZmtqbk1WL0ZIYU9JUSsvV0xkUkUzY2JSSXBYWjZMTU1wc2sv?=
 =?utf-8?B?Uy9vc2lwQkIxMXM0akNsaUdoaXpHOW1aNjVscmg2bm1MSjlWQXFHbXN5WUZy?=
 =?utf-8?B?c1YxQVl6MmEzdW9IajNTa3k2RU1qS05XemtzRHFtODJNVzhZbC9xSUxQOVdY?=
 =?utf-8?B?RVAvYVNtbU8ydkxJOFZlcjhHZFpjOFJDRklmLzkxcFRnemtCZDJOdDV4T2FQ?=
 =?utf-8?B?cWpRRnJ2bWdhTUNFUVdnTDc3ZWxmYW9NWlYyaVA0cW9aT2JuRkRJd0F5aGxs?=
 =?utf-8?B?NmxkSUdrM0hqSmhyUThzZkJIR093QnhucExhaDlGSHBLcS96ZEEvS0hEbHNT?=
 =?utf-8?B?bFVjK0w1am44Z21aSUFpR3RZL3ZvYUFtWVNDRjMxbk1maDIzYzJ3S2hCanYv?=
 =?utf-8?B?STJ2NkdpT2ExeVBKbEVlalNjd3dPRUI4dVlweWZLaSs0K05wZUUvaVdwYWds?=
 =?utf-8?B?U3lNeE0wZzFGcHpDdDE1cmV3NFVia3JqRDRxTlpZRU1POFAxWmVWRVZOQjJL?=
 =?utf-8?B?Q2lsZUtnNjgybkl4b3Fob2ZwajlPeU5wbVdWVGxxekJCR2x3ek5BREwwb1Nv?=
 =?utf-8?B?cEE5ayt1MWdLYnRhdUpKUDZ1TElnYW81WFJWdkszYk1uL0RVREZISmsvY0RP?=
 =?utf-8?B?em5xZ3crTjluK2RWZXJ1bktzaVVKUDRlSE4vYkMwV2lyQVZScHZBRTlnVGQx?=
 =?utf-8?Q?K/6c165I53FMFcyc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c1f451-5ea4-49cd-f85a-08debcee14d5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:19:47.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wlSX+cW51JTHb0BXOzpsHRGiVLV9J31bdJtQZJkzqa0UvF0R1Jk1KAAsTGXCOPOt2lr2TckX2MWcHZPJe68Pjbu8XYtK6HWMR27R+IVruU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7029



On 5/28/26 2:03 AM, David Laight wrote:
> On Wed, 27 May 2026 16:44:31 -0700
> Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> On 5/22/26 2:18 AM, Heiko Carstens wrote:
> ...
>>> It is amazing to see the performance improvements you see on arm64, however
>>> I believe that is mainly because of the large amount of code which is
>>> generated by the arm64 implementations of the preempt primitives
>>> __preempt_count_add() and __preempt_count_dec_and_test().
>> Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one
>> instruction is used to load current pointer, the other 3 instructions
>> are used to RMW preempt_count). So I can remove 8 instructions in total
>> for a single this_cpu ops. That's a lot. Given this_cpu ops are heavily
>> used in kernel, we end up running fewer instructions and having better
>> icache hit rate, the better icache hit rate also helps reduce cross node
>> traffic for 2-socket system.
> Is 'current' kept in a cpu hardware register?

Yes, sp_el0. But it is a special register, we need move it to a general 
register before any ARM64 instructions can access it.

> With the process switch code updating current->per_cpu_data.
>
> That might mean that you can access per-cpu data without disabling
> preemption (for single ops) using the same technique as s390.
> So something like:
> 	mov %ra, current
> 	movb per_cpu_reg(%ra), $b
> 	mov %rb, per_cpu_data(%ra)
> 	// per-cpu access using %rb, process switch code will update %rb
> 	movb per_cpu_reg(%ra), $255
>
> An add will need to use a cmpxchg loop.
> For simplicity use a fixed register for %rb.

TBH, I can't say I fully understand what you proposed. But it sounds 
like this one 
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=84ee5f23f93d4a650e828f831da9ed29c54623c5

Thanks,
Yang

>
> -- David


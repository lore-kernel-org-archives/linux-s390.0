Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021111.outbound.protection.outlook.com [52.101.57.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68F3F8EB7;
	Thu, 28 May 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993576; cv=fail; b=OIXE4QT/eqBJ0uJ/vgMAjYW7olBousZQkI5teCJvmeZKvS7O+WPrRslwNTnLU7Eh7SmgQw/cYlcX/L7AAQunaOhkgjRxirrv0aYEtvIYiARLNCqlLlsHa0JNuUuI5QEc3wlu117bhwr3TR6JqfQU1z+6sJDeRBb6aDzgEQWOvqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993576; c=relaxed/simple;
	bh=EuAcgTC0S7bWFc30pXqQbh2XYyAtldxizyBwMW/OKpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mYxpEKwLITTYTPOWdVll6vJKu18eB6e/B7XjDeyvLiLnBOY2eJGu1hkSe0dCAjLdZ2nx7arxH8Sw+7fRJYcBb+lUOSdMjV6FspWQywtAsUT1DJDXtAFvoI+4HfQZ6c/iSA9aRsrKyyLBPJUwEYq4NkWJYfBdsxuW32UV5UlO0NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IcN5mkAl; arc=fail smtp.client-ip=52.101.57.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IcN5mkAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgeKMPTp1muk4kJUvJ0a814HrouywO7le4u+GUHJBitPCtNOHW2kPGOCz9YpWEtvvLc1a2FFdSAuXzg2JnTzddYP7DpSAEZ9qLJxRL3mJPURKnhVSOS7a3xGC4j/S59708OLp7UJOJEzPmOBA2oHN3Gn00fPIgoPKb5khKO9c2JfutlPOlmWPHop3G6fXJ8xyPxZk7S8fT7OLGuOxWWxVMM0EH5BbAznPMfCX/+y2gUgaKAk6tkV+hAc2fJT+8QuLqDddB1TdZjHk0yWnMmJxe17pdS3PYL0HRi5WM4l1kNrVkISlpxXH6uaY8VgWD/2MtLC507wJi29bR/EFCSCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SedgnG38PAcNNGOfjQ0MnlmqxG7fjKEHxOq60ZNOf/Q=;
 b=hZC1Em9n5gOB9YQbLjyCf9CZ2UkJidTXgV5Zeb3MFXY8RrMlAMQJt0ciybFsQeTlY7gMW1G8v7OAyX9UNBl78lGR7NFpCOua306dPjuqFTieZgthDIi1wzHPL2vDji7MWa5OmmzVfRJ6kP/tvZY2trMqOi5Us4ferJZOlT8oXdBkws3219FtWYCUzyFNDLqlU21GMcvJhR0p/CtMXX0ZQuQ6m0AP2imjpFvE5wx9Mdk+TDUqqknqOty32I9JK+4VClLbuf3AeAWNxwcoG/oRZqNWOPG7+/IS6VENoQtDLiNEudUMwBG3oqveGMrR2QRCadDYhlg5kZJhj0w2kcLpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SedgnG38PAcNNGOfjQ0MnlmqxG7fjKEHxOq60ZNOf/Q=;
 b=IcN5mkAloSE/C17OxVUqr4cFyUtcU3sYfiKlMgcjEw77Nz7WI4AgiNJuPBP/v6hyDXFEjA2dkhRZS+XWuH9aoqHdckkbT4wdmLVF2mQJVkQmajNOHAkDD5kyXR5/ui1VovLfTTGhYFS7icZ0YmZ3Beerf5Dx59PeYQX0cD7S9uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA0PR01MB6332.prod.exchangelabs.com (2603:10b6:806:d8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 18:39:31 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 18:39:31 +0000
Message-ID: <a6340a92-b4f0-4f7c-9e37-bc736b520cca@os.amperecomputing.com>
Date: Thu, 28 May 2026 11:39:27 -0700
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
 <5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
 <20260522091805.18098A5c-hca@linux.ibm.com>
 <cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
 <20260528141441.15387D07-hca@linux.ibm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260528141441.15387D07-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:930:8b::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA0PR01MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc96413-8d3a-46d0-6a5b-08debce8748d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3023799007|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	OP5UEIKADa6KGC6B53VzSVEP0zsvZyktOPzBC3U4MyuvB2RtWAVT4+RBL84g3yGgzXdo22c2dDSu2WXpBKBT/3OGBQP3hyRNVymDUlEi9iV49pbIwBYn+xX8sGH4jQNLtFmoPnBTftuDl7vHK1DburuwN6DwzJfMozbA0KwkymWtTRePk+vwq2Ake4H9Kvuwl4HyiZjwqhluco7ePzjdLjlAcMO1J7CFTyLG0jkoFsr/FUcuuqNMpQsFaFp5PTGTN2ogOsouA5qsaifS0aRUyXDmn3EG3gi/2HV7eVGd2ppCRExha/ej54qK662k0ONFDN2GWZxEQnsr/BZYgsdgAub/nmzlJ4hCjZCFR/krG7sFOCTXjAZF9QOKuekJ1xbxnyfiZ5RWLu+jGVGi7e07x51hLaj+OMfs0eaIydP8nWD5UJDpN8DeHkbOrEocqr+FWHcjUBpwag5+jr6l+bDttluqSbl0BOriWziZK9B3/at418JZvRaL0hxg5aKB639pNZ9VMYs2+bZEZUo0hIPGbpupLoP/MQGKTkueD6pzfk4gLhS5aOneX89EFVuoENR2eUtCsfmGq58LQBLRfq4jVxuVrpDIXL0VHuvC4I4mnDx14vrFRPy4kVVE+RBU/tzwhMLKmU9f4LEY8Q4xQA7US7CwcuXjkjtswnaKz1OsdJUgBByC5CsTviWGFkLEwis+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3023799007)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDcrbjFPR3h1TkdzN1NqV1Erd1VmMDFvcnRhdU0zNUNIYWgybG1ERUhjcXN6?=
 =?utf-8?B?SFZiK2M2YkQ3ejRGeTZEK045cTg4QVBOYU1weEVKWWJVTGlIMXZnQ2Y3L3oz?=
 =?utf-8?B?TWd5RWxhVVhwMGFVOGpqTUdCd0p0RG1BQmpsa2ErelhhREF1VTQ0aGt2WG5M?=
 =?utf-8?B?TnZGK29TdXIyczA2SnNYbXVId2s5SFhtVC8yQzl4OGV1TENyM2Z4ZFhPQzUr?=
 =?utf-8?B?eHNGNU5UbHkwZnF4bDhucCtZeDRNSjRSS2pyRThIWVFTU0Ntc1M5djI4OHBU?=
 =?utf-8?B?VC9UcVZkUkNmUGJ4Z3NOMzBub2RrTUM2T2o0dkFCRll4Wlk0VzMwUms4Tk85?=
 =?utf-8?B?OUNuRGo0TTdIcHVqWFVBRHZMSHZYc1NYd0dJdEVPKzF2ZXRFemVnK2RSK3Zy?=
 =?utf-8?B?SUJjdWJqamF3SXVJNUVGaThpVE91bXJRZXBtV1ordmNFOHU2NzJ0VVl3ZHJU?=
 =?utf-8?B?M2xuL0dvSi9aNGxwWkxENVA3c0lPOXpseVptMC91QkgyK01rQkJsdEFCL1ZE?=
 =?utf-8?B?VmxCMmp3MTVlNGxpUk4xaTY0RDZyN2dPQUdWZnlXK005NlhzT2ZMOVYzZnJn?=
 =?utf-8?B?Lzlkemo2blFCbWh6ZWY5bk1BY25uYis4WnRkSkd2OEtuRm9BQTBxNnIvdllQ?=
 =?utf-8?B?TTBjM2VqbDRhdzhJdEMwR053bjI3V2pxanppeGxZMU9DTjlDR2xyWXF6THBE?=
 =?utf-8?B?Y1R5ZVk0eTM5dHJ0am5vaHFoanZCSENCSjNScTRZRk9TSktaMGN2Z3ZVQ2pC?=
 =?utf-8?B?bnhNRU5OVTJqbUwrcFc5emFJdVo5Vk9MbkgrenNXRFRDc1NJanhjaW55Sllu?=
 =?utf-8?B?M24zY2duQk1kbGpQZjh3dFJ5NitVYm5WS3BIbndpcjNHRVYyRWNSVG1xMW5D?=
 =?utf-8?B?cUlZaEpRejFzRGJxTzZ1WlR2bVgzbzFxc3Jkc2hUQnE1QlJiQVNIa3VLNVV2?=
 =?utf-8?B?Vk5FTHpma1VMbE9aQmdoR2FvbWUyM3MrUHhDNnE1TlJOQzVUQUd1WFJtOEFC?=
 =?utf-8?B?OTBvQWE0ejZCTnhEQnJ3S05OZ3dwUkFRS0o5NUxVUjRNM0hQUEs5eVlkbVpx?=
 =?utf-8?B?d1RhQkkyMXJhTmRmOXVVU2VWWGFPQWlVWW9JVW9rL1g3YmFaNEpKenYxdi9S?=
 =?utf-8?B?KzJEczZ4VVNJV0NWc0dkTnRsVndrY0lMMmU2ZkFob2dDUno5eDNqRzl1aGRW?=
 =?utf-8?B?YUd5TXEwTFYxeTNkdHJDZXB4K01oaHAwdFNtQXNVTVY5WmlmYjduQkVjcXUx?=
 =?utf-8?B?aEtvWGNMZzRwWUZ6WEFoRzVBN1p6QU9hb0diVHlXNXNjT0dBRDJBY1lzVjd0?=
 =?utf-8?B?NmFaQm1JTFdmNHRkcSswbkZVYkNCUHp1cE5NUzVHM0Q4Und4T0ZmRy8rQ29t?=
 =?utf-8?B?UEdDWUdIT2RlY3FhSEJOTFlBT0FoZ0N3MVg2SWV4aE9FNzMxMnQ5MW9iVUk4?=
 =?utf-8?B?WmFZRHVZcmFCZ05ZdGRBMzdBVEw2elJraVBkSlRVelB5QVRJNzMvWkV3QmtU?=
 =?utf-8?B?NnJBT0U4YWdVQjBNejN3bmF1WVQ4YjNLUmw1ZDlLUlU2MEJFZ1QyMHUvSkxM?=
 =?utf-8?B?MmM2S0x6WFpsZndoSkZiWm1lcE5tMlFyNU1IM2xISWxndGthazVIb21ZYTRV?=
 =?utf-8?B?aWk5VEYwWDV6S3ZkeDJ3UEFTZndhbTY1YWhRNGVFdWpCZW9rYWRod0dIZ0cw?=
 =?utf-8?B?eWl6elhOdUNtVkJOaUdEbmlHY2Z3T3ZxZUlBb2hWWTlFekZLTGZneXo0T0lU?=
 =?utf-8?B?bFlxUURma2V1Q0ZoWFc4bk9qNml0dVlQbHZRWmVMQUhkc1BHTUlIY2NyUmtO?=
 =?utf-8?B?ME5JeFlGT0FxNjcvek8zaFhDcldNMWtJa09OSERVMmg4T3JTb2VIZGNHVUFK?=
 =?utf-8?B?MkNYRHJVM1p1M3FlcEZtZ2ZDbm82czdtSDg0MGVxQ3lXTW1ZNVUwT3loTUw2?=
 =?utf-8?B?NldkdnM1MVRjdUNKNDk0c0hyTWJEUSsyejhWSCs0M3dyWlVWSUxwZFlmUjRB?=
 =?utf-8?B?WTBUNjBPWU12V21DU0FvSWpmYVRGZmhzTXQzQUVBTmxPUWUyUHR0UjlzbUxn?=
 =?utf-8?B?dGFIUlc4alYxa1hKSnFIRUt6ZEFiVndUaDhNbHF4R0dvUUJWYWdGS1ROU3lo?=
 =?utf-8?B?MTJPQ29uSnhEOEUvSHBuZEViSDdLTHlIMjVOWHVpeVViN05mV0RBOVFsY2Vj?=
 =?utf-8?B?YzJoTkRIRWZyemVIVkVYSW1uTzdGM2tFSXJuOEJDdk00TkhoT21FSWE4UkZ0?=
 =?utf-8?B?RmJ0UHIrOXd6cnpvTGxOTm4wdEpyemdWMXVzZSsvUEc5ZVExRjZKSjFQc2hL?=
 =?utf-8?B?YzBpckM5SEVXUVlaSUpYOUVwUUtKbjdQdi9xTWo0bjBqWnE0SFkrNXJnaUx0?=
 =?utf-8?Q?/v6h+u7gUyvwZ8Wg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc96413-8d3a-46d0-6a5b-08debce8748d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:39:31.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynfZKuw3ztcluBCzqhDY3RiOWfG5eoXN+rb7oNIDUcX2T2l/aUgXKHVeI9tgWE0n9hVtTKh3sa0FZsyfKxVjZmPOrNcobrqMIO6b7yRyVNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6332



On 5/28/26 7:14 AM, Heiko Carstens wrote:
> On Wed, May 27, 2026 at 04:44:31PM -0700, Yang Shi wrote:
>> On 5/22/26 2:18 AM, Heiko Carstens wrote:
>>> It is amazing to see the performance improvements you see on arm64, however
>>> I believe that is mainly because of the large amount of code which is
>>> generated by the arm64 implementations of the preempt primitives
>>> __preempt_count_add() and __preempt_count_dec_and_test().
>> Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one
>> instruction is used to load current pointer, the other 3 instructions are
>> used to RMW preempt_count). So I can remove 8 instructions in total for a
>> single this_cpu ops. That's a lot. Given this_cpu ops are heavily used in
>> kernel, we end up running fewer instructions and having better icache hit
>> rate, the better icache hit rate also helps reduce cross node traffic for
>> 2-socket system.
> You save more. Look at arm64's __preempt_count_dec_and_test()
> implementation: it is RMW + compare + READ + compare.

Yes

>
> preempt_enable() generates this code, where x1 seems to contain the
> preempt_count pointer:
>
>    80:   f9400420        ldr     x0, [x1, #8]
>    84:   d1000400        sub     x0, x0, #0x1
>    88:   b9000820        str     w0, [x1, #8]
>    8c:   b4000060        cbz     x0, 98 <bar+0x58>
>    90:   f9400420        ldr     x0, [x1, #8]
>    94:   b5000040        cbnz    x0, 9c <bar+0x5c>
>    98:   94000000        bl      0 <preempt_schedule_notrace>
>    9c:   ...
>
> I assume arm64's instruction set does not allow for better code for
> __preempt_count_dec_and_test() if you would fold the need_resched bit into
> preempt_count and use atomic instructions + inline assembly with flag
> output operands when modifying preempt_count.
> As of now only x86 and s390 are doing that.

preempt_count and need_resched share the same 8 bytes. preempt_count is 
the lower 32 bits, need_resched is the upper 32 bits.

Atomic instruction is usually slower than load + add + store on ARM64 if 
the cache line is not contended. We may save one branch + load, but my 
profiling didn't show branch is a major contributing factor. The 
performance gain mainly comes from fewer instructions and icache hit 
rate improvement due to the elimination of preempt_disable/enable.

Thanks,
Yang



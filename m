Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022134.outbound.protection.outlook.com [52.101.48.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E933FC5B1;
	Wed, 20 May 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302565; cv=fail; b=BId+2VltSOu+Qs9xvVvKW2tjLaLwV/NyrujDnJsytQdO4fuXLPT+o7bpCtJSXMzBPt7dN3yeD3wlYL/Viy7K9g2aMg2D+P2DSUA5bXQzmT8qhMugFdl+pf+5fMWGmy2J59OoDdzoyXNpdCBxAkGcNjOfAQ0sCn8JueY8/w5d4Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302565; c=relaxed/simple;
	bh=szOFCurHTkFlHQPmeosMnTRCp6j3y2//Z7hloOiEqpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACbAvlBqaui3q3/A2nzh15H9SIRIzzcf2TmVx1DOY0Zp8NWPPAHDwiohI4y2EZnw934XszWysochMO10g3K7gUrwF/gMv2MqGZ9BJFmCJbldNbspIH9h9U/lgk10h7bzV2Az3idBku4DZqj5GzSsGBH2rBP5czHkn3NQi1ol5XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aXTsO9H2; arc=fail smtp.client-ip=52.101.48.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aXTsO9H2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/h+FKJIXx/qisiURRYvFxW+vL+0hz6Hvoo+TloXq0sbEcJzCKBJXICiqeNn/NI+z2MIiWAK7g+symOcrK2PRaSCjvbLF14H5rcIPuXRRC9afpmb2GxKDW+Xevyd5C/EETkuITAKZ4TbmoTUZxIjKkNNsLEMu3nlafnJLR9fiHWINbGctl2lToTg3Z9LlmfulWuZmWpnkkWsexP5VRUJwiM48IRLESQYVnEeflYjQj7220og7ibo8TbwKztVJ02BovUFzbKZIIFiy8sZZk9IGeHd8Pelg8yVfGV1Z52sfKBUlaHk7Yj71Zu7k6lx2NpPLObhLVoq4gFyO1y/NUWngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EnbpDjLt5c9tEQvlK+GklEE2f1okrzs+QcmR6rw6EQ=;
 b=fmDpETfjNoOn4LNeBlgEifBwGkFZs7nX0sgW9SdPy+537WAgYSyaHzDStXuRZep09c4VrMjlA8FGgMFirzPLNqaHIYHUR2o8Zqa3miwU0sGBqsp0pJOq2vHFGyP6evH7ZIBw2Ov6jAuBmPKgJPMhr7Sodi/fXFTprFacFa+ivvuS/H5oKOLADKYj2k37L8+h26wJWZ1YkWHJGOUGTJzWf5MZcszjNtt8p835aoa+Dtg2juevDxDQAQCvZrLVbuXwEth0vkI6OUck7sVh+IGEHjEcEICNt2ODqaAJmwIVia3Y3mNZtncZdFnaWpGufmWzNqd+Q2SoCLB7AAjGHLQk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EnbpDjLt5c9tEQvlK+GklEE2f1okrzs+QcmR6rw6EQ=;
 b=aXTsO9H2JnkCeP5C+HyCRnHwexn7xzlQFRmeF1yoGqo0FRX46eeZkPzOfZcB7ler5GKvpXKLyLnAJQJZlPjEwPn3VYY6G9PuAJm5e8+zR4kEL/K3pK6zAPN0pUjfuuZzOlWcePebwSrgnyEu4FILQ5D2AOtGMgAcMEUJ5sCjufU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO6PR01MB7465.prod.exchangelabs.com (2603:10b6:303:140::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Wed, 20 May 2026 18:42:39 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 18:42:39 +0000
Message-ID: <9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
Date: Wed, 20 May 2026 11:42:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
To: Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20260520092243.264847-1-hca@linux.ibm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260520092243.264847-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:510:323::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO6PR01MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: ad84556d-90d3-4a44-e8a8-08deb69f9190
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|55112099003|6133799003|11063799006|3023799007|5023799004|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	v3d24T0BQ5+XBPAeAe4A/04tu2oUEf9f3N9du4I99HTnQ+dCYsGCfCviFmP+1cwe12GYaqcH4deZ/Do3+cc/tTFY5R+YD5CIlUERUZzAsLaICsznvad9uvyI1eH6gtZqgDMXVvXDs4T9lrmpv05MeoqpY09r7y10SVi2uRPusyrBd9z0joiScXhZBH5KUTkrhO9Mgvh2b3/YD/DtzJF+9GDNz2oESVpzBHAOwj1NQcg7hglv6fwSgEmb4rcxdhkBCOpj11+EQ1gCXcHiwVsVcSQJlNfLwoQntlJRPULI1yRlR66Yh8u+FzjIfRN2v/F3gFY2nr2aVOpw8HmQXOfEGHmPfWuGJORjqqk0Uz9/lUg/DGHBgocWjkDz2LEG4fvOSJeLxDaelI8qywnz8cw+8oq9JXHk02doOnNX4bYE6qBW3QdEYCLazgRA9ujG62VUfj8jCL7IXW+qepkJp7ykvNSMCLwE2JyHKYHY7CW2UP2MkoOOsQ9PG+tcuhg65q9qPiUzeWKYG+hnbmXYzLIz53DhUtE+9qiE//IPIPq/rZzTtSUvY7+0NK0TGFdFXev9FEf6XyJ1OMmCJDtt6mpC0JdBRukjWR8y9B8Lodj6Z9JuiNi9111A4exC7TMg59A/Fmkl6WOvJQL8mXdOUdRyFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(55112099003)(6133799003)(11063799006)(3023799007)(5023799004)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFY3V2c2MXdELzMwRllHd1BiZENHeGIrR2dqclRpQllwMnAzenMxdTBqWlVu?=
 =?utf-8?B?NHdobWd2U1NsTDBDT0EwU2VnT082QVJKbnM3RVNqTUxGYU9IMXV1V0gzZHl4?=
 =?utf-8?B?YWpxVkEyNDVDYllKRkRJWFljaExCWXByYnV1Q095MDcxM0I4RnhDYzhMWUpw?=
 =?utf-8?B?WHVSRDZNbVVVRHFIZTNmWVRsNDljUjZtRzVDVTVZc0RXaSs2VFlQbGlScVlB?=
 =?utf-8?B?Wm9uRHd6eHlBb3FSNEQ3a2RPTUtrTDkyTDFOQkJYTHpiZnN6T2IwdXFUQVpZ?=
 =?utf-8?B?ck92S045Rm9LZElraVlyWW1ac0pSb0cwN1FPYUFLZFdGY0x0SzM2VUk0VVY0?=
 =?utf-8?B?TDdvaUJCOE1SMWV3L1lFSHhqZVNYeE5aVEdxMmgvcEtVa1BNWnpmOGRmSkw1?=
 =?utf-8?B?b2RDV1FvbE1aWm1UcFN5UGRiNDA2QVkvRmtNU1RQUFBmWldZaG82NHlMYThy?=
 =?utf-8?B?a0lZb2xPTzRIbnVFcXRhUVJ5QmFKcUlGd2Fya0lUbDI0QkNOYkFrMitoLzFX?=
 =?utf-8?B?Um9YMm9KVEJYcGFUZVRTWENKaU95VEJsSlpTeE5RbnFzcnVhTFMySXNOdjJy?=
 =?utf-8?B?LzI0Ukk1SlhhbjB6SHVOYmJ3N1Q4bjJacHVRYnNRY1l3NCsxK2s1ZDgxSEtm?=
 =?utf-8?B?N2JnQTBZY3QxSTNJY2EvbVdKM0lLRFlrZzlaNmN4b1FSV2hzOWYvMWNZYy9o?=
 =?utf-8?B?eURhc2c4aFRkemZwQituV20vMUV3ZzhoeENqcE0zUzhLUjYwZ3ZnTmpuNUdm?=
 =?utf-8?B?YitqU2k2dllrRWVYeEpTMkQ3czFLUlNYYU10L25DMjdkQ1hNVFE0R2tJL25o?=
 =?utf-8?B?Szdaeml3a0sxYmJsMDZtSDJwK29lMlJIUFBEcmVldGYwMDhxUkhEUnpBcER6?=
 =?utf-8?B?bU1EQkhaM0ViTEFsaEFDWTYwa3RyOUhSeTFoKy9SK25wcUI1ek1JdDJ5QmNU?=
 =?utf-8?B?ZWdubzdFUzBPS1NEYVc5UEdPdXNFL0pTdDhlTjJRR1BocWt0NGRUanhpMklJ?=
 =?utf-8?B?RWFQaE1OOE1lR2IwRnh0TkFTSjJhNk5UV2ZsNkN4djhvNndNV2Y0anpJMGRI?=
 =?utf-8?B?QnVydFdQNHpOQ3V3UGVBWmsrT1lSaGhBNTZGOEVKbldYVXB4dllJODEvVWw4?=
 =?utf-8?B?aVR6bUZaU0k0Y0QrM251Y2c3UENFaTRnY2tVUi9VdDFLQm1meTFFaC8yQXRQ?=
 =?utf-8?B?L2RmOWlnYWY0V1NQdDV6YWpVZTM0NHVDWGtPREZvQnFqMWFIelhhcVdQZnIy?=
 =?utf-8?B?bWtOUFFSeHhYUVQrTkZNMTJSL251VFpvQ1lCSFNjYTdmWkZMNVE2cXA1V3Ry?=
 =?utf-8?B?alNSV0w3VTJ3cXJIZ0NMcmM3MkNqNkViWkZBclJmOTJvTjc3aCtMS0h6LzZB?=
 =?utf-8?B?TVZPRGcwWERjZjJSd3BvZ2Y0aGREdm5PLzM3dlVxS0JBeHc0RmY5TzVlZm1w?=
 =?utf-8?B?emZXNGxVOTY1azBoZjcyQ1lsZ0N4dDJFNkQ3aTdRUFI3b1M2SGZ6RHFzK3By?=
 =?utf-8?B?alRldUhadExEcEo3REpuSzJnZk9EcEJLNGxUd0tPSU1JS25oNlZpR2lrdkRQ?=
 =?utf-8?B?RG9ENUtNQ3hUNU8zYVo1N0MxKzBJQStvdVJMeGdqRDM3VzNMMEJ3ZExHRVRt?=
 =?utf-8?B?VnA5Rlp1UzlYbG9pZHZYenpWeFlpYnBIcERBK3N6Z1lJMjl2L1hmRFRxZkVI?=
 =?utf-8?B?L0V4dkxtRE1MWVl5VDFVMWxrOElqOG1HQ1JQZTVXRTFnZERlbjZxMXFGTXlI?=
 =?utf-8?B?bWhFdm80VC9QekJtZDVSZFF3aGJVb1NUOExEL2VJV0pPK1F1WUlaWTJNU0JB?=
 =?utf-8?B?VzFPVnNONmFHdjl5N1RaKzJrNEdWRVUrdGxDR1A1SHZEV3I4bnlsZGM5NzUz?=
 =?utf-8?B?Y2tPLyt2THdxRWMxK0FDckZZaVhZOFZBcEl3QUpRNHJadFdDa3puc2lLQlpv?=
 =?utf-8?B?c3hBS09EREJ4UTJjdVVMYXd2TDQ5eVJrVEx3a0lObC9heWI0MVRNUUg3SnJk?=
 =?utf-8?B?N2dRZXE4Wi85TUp4OGR3RllkYk1SejduemlRQW0yS1lWKzBKeVQxUU9tVlhY?=
 =?utf-8?B?QlBjZlVoZ0JJbDFkSmZlaUlPTElSd2tuSmNaRG9jLytLTWNVdjdmM3hZSFdY?=
 =?utf-8?B?SytKZWdkd2QzOVpYMTg2OUVrY2EyY2Q0SHVsOGlqQ3Q2Q1NYRkE2eEdhRWNK?=
 =?utf-8?B?ZWJ4VDJxSmJraDYxTjlFR2puQVpwd0NRUlJEM0FOQ1hDTG5KSTdCMFBRcVho?=
 =?utf-8?B?T3lYVGc2U1puVXh0TEs5SDJYMkZabTA5UVRZNUI3OEYvKzlXREowRlowZGxo?=
 =?utf-8?B?d0ZSNjFrbHhaMisxUno2Z3k0ZkhKMmlGYUZpajVjRllTZGc3UXlIRzlYckpH?=
 =?utf-8?Q?5L9rcjAzulanAXiM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad84556d-90d3-4a44-e8a8-08deb69f9190
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 18:42:39.3446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/v9In1jwaDGEkXzCH+TNb+HIq5HpoUZM8fs5ymw+TLcpJgamQJnbfru5fNZIwc0bDjNAAjl8YtkIoBcBE/jJ/pWsgXSzwN+ioDrFROZmHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7465

Hi Heiko,

Thanks for cc'ing me the patchset. Please see the below inline comments.


On 5/20/26 2:22 AM, Heiko Carstens wrote:
> v3:
> - Fix various typos [Juergen Christ]
>
> - Add missing kprobe detection / handling [Sashiko [3]]
>    [FWIW, this made me also aware of that the current general s390 kprobes
>     code seems to be racy against concurrent removal of a kprobe while a
>     probe hit on a different CPU. But that is a different story.]
>
> - Fix various minor findings [Sashiko [3]]
>
> - All of this might be dropped / exchanged in future in favor of the percpu
>    page table approach proposed by Yang Shi [4].

Thanks for mentioning my approach. I will do some comparison with rseq 
in the following design details section of the cover letter.

>
> [3] https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca@linux.ibm.com
> [4] https://lore.kernel.org/all/20260429170758.3018959-1-yang@os.amperecomputing.com/
>
> v2:
>
> - Add proper PERCPU_PTR cast to most patches to avoid tons of sparse
>    warnings
>
> - Add missing __packed attribute to insn structure [Sashiko [2]]
>
> - Fix inverted if condition [Sashiko [2]]
>
> - Add missing user_mode() check [Sashiko [2]]
>
> - Move percpu_entry() call in front of irqentry_enter() call in all
>    entry paths to avoid that potential this_cpu() operations overwrite
>    the not-yet saved percpu code section indicator  [Sashiko [2]]
>
> [2] https://sashiko.dev/#/patchset/20260317195436.2276810-1-hca%40linux.ibm.com
>
> v1:
>
> This is a follow-up to Peter Zijlstra's in-kernel rseq RFC [1].
>
> With the intended removal of PREEMPT_NONE this_cpu operations based on
> atomic instructions, guarded with preempt_disable()/preempt_enable() pairs,
> become more expensive: the preempt_disable() / preempt_enable() pairs are
> not optimized away anymore during compile time.
>
> In particular the conditional call to preempt_schedule_notrace() after
> preempt_enable() adds additional code and register pressure.
>
> To avoid this Peter suggested an in-kernel rseq approach. While this would
> certainly work, this series tries to come up with a solution which uses
> less instructions and doesn't require to repeat instruction sequences.
>
> The idea is that this_cpu operations based on atomic instructions are
> guarded with mvyi instructions:
>
> - The first mvyi instruction writes the register number, which contains
>    the percpu address variable to lowcore. This also indicates that a
>    percpu code section is executed.
>
> - The first instruction following the mvyi instruction must be the ag
>    instruction which adds the percpu offset to the percpu address register.
>
> - Afterwards the atomic percpu operation follows.
>
> - Then a second mvyi instruction writes a zero to lowcore, which indicates
>    the end of the percpu code section.
>
> - In case of an interrupt/exception/nmi the register number which was
>    written to lowcore is copied to the exception frame (pt_regs), and a zero
>    is written to lowcore.
>
> - On return to the previous context it is checked if a percpu code section
>    was executed (saved register number not zero), and if the process was
>    migrated to a different cpu. If the percpu offset was already added to
>    the percpu address register (instruction address does _not_ point to the
>    ag instruction) the content of the percpu address register is adjusted so
>    it points to percpu variable of the new cpu.

If I understand correctly, you replaced preempt_disable() and 
preempt_enable() with seq begin and seg end, and seq begin and seq end 
can be optimized by mvyi instruction on S390. So you just need a single 
mvyi instruction for each instead of read-modify-write the seq count.

But you need some extra overhead for context switch (save and restore 
the seq count register) and need to check whether it is still on the 
same cpu once resuming execution. And there is also penalty if it is 
migrated to another CPU (need to rerun this_cpu ops).

So it seems have more overhead than the percpu page table approach IIUC. 
We don't need all the steps with percpu page table. And there is no 
penalty for migration.

>
> All of this seems to work, but of course it could still be broken since I
> missed some detail.
>
> In total this series results in a kernel text size reduction of ~106kb. The
> number of preempt_schedule_notrace() call sites is reduced from 7089 to
> 1577.

Yeah, both approaches can reduce the number of 
preempt_schedule_notrace() call sites. And both approaches can reduce 
the number of non-preemptible critical sections.

>
> Note: this comes without any huge performance analysis, however all
> microbenchmarks confirmed that the new code is at least as fast as the
> old code, like expected.

I'm really interested in the benchmark number. I'm supposed percpu page 
table approach should have better performance per my above analysis.

Christopher Lameter is also interested in it, cc'ed him too.

Thanks,
Yang

>
> [1] 20260223163843.GR1282955@noisy.programming.kicks-ass.net
>
> Heiko Carstens (9):
>    s390/alternatives: Add new ALT_TYPE_PERCPU type
>    s390/percpu: Infrastructure for more efficient this_cpu operations
>    s390/percpu: Add missing do { } while (0) constructs
>    s390/percpu: Use new percpu code section for arch_this_cpu_add()
>    s390/percpu: Use new percpu code section for arch_this_cpu_add_return()
>    s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
>    s390/percpu: Provide arch_this_cpu_read() implementation
>    s390/percpu: Provide arch_this_cpu_write() implementation
>    s390/percpu: Remove one and two byte this_cpu operation implementation
>
>   arch/s390/boot/alternative.c         |   7 +
>   arch/s390/include/asm/alternative.h  |   5 +
>   arch/s390/include/asm/entry-percpu.h |  76 ++++++++
>   arch/s390/include/asm/lowcore.h      |   3 +-
>   arch/s390/include/asm/percpu.h       | 249 +++++++++++++++++++++------
>   arch/s390/include/asm/ptrace.h       |   2 +
>   arch/s390/kernel/alternative.c       |  25 ++-
>   arch/s390/kernel/irq.c               |  26 ++-
>   arch/s390/kernel/nmi.c               |   6 +
>   arch/s390/kernel/traps.c             |   6 +
>   10 files changed, 344 insertions(+), 61 deletions(-)
>   create mode 100644 arch/s390/include/asm/entry-percpu.h
>
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8


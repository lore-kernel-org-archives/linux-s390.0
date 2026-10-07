Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021105.outbound.protection.outlook.com [52.101.76.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FC4AB1C5;
	Wed,  7 Oct 2026 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377682; cv=fail; b=PV9Qob8RiyRzdQgQ7LWhBd6hmycvqPlaZBhMO0WoqnUzpkl+OO1i9iQl7qVU208kWkmCWMlXwa+McRdLm5oujK6xftIZzXzh0+/jBkrNMucNI1DPSCM9T7DnFpnfhUMGuQKer+qh9+uItUwpBTxNI95wROCU+I3rybivkgDevig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377682; c=relaxed/simple;
	bh=SlSnvZyNg3vZ3banbkttHyGc9Cx6gHvac+JT/e8d8mE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F7PG5wsREulzISjVZBFO1JA8FNvYUbcX7QK4Bs/lomQdTDcbXpKnrK1i/kWBxp6+mcnJOM4w/KW7ByEygC6AJMkaPIw4ApvB75D8NpkT8FJBNuOkgwWTlliTpqfVgWfYSfL242H2r85EjMFbjKnFMjTo0xP3sNRKEr5yo5m0K3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ChONQHe5; arc=fail smtp.client-ip=52.101.76.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ChONQHe5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOAnBfMMvHkdhBgbEfknHsyfia9xn8395k1Syl6E3FstmrHO6fFICkcJlHQPiyAc7AXWjCEhH8yJw9BpVt7ZH1W1GOTbZPp3L/jiQMZmWqQsdLNRSfHcCaq+x9nKARobh8OZPd4/k6AWtxq8MkII2xFy1Qi5djYaxLlAd3U/g1CQgGnqLRB7s4LbmYH5SGitQavHryA1zDsBgM1+k/FdDPD/RuqNcg82wmRYWCaYS1MKB6pSo3q3Qg8w/SBrq/TUvjPYrN9s58Q8kwH9atVcowHIeDg31MeFnqGiPc5s7jyUIEOArmFfiQzsyG12hob4AGC0gr0KS+txtxzULISR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5rqg/Z/sA3BXP0HwUpbcUC9lAlrYJIja7QKmwutfaM=;
 b=A2rXmpZ4G//yP/n2yjx8d35IRdCKaKK8PnhWvaWYJX0YluFdPw2A9+N9OrciBfb+3fSUNQ4x5jJQ6YhTf/ne4UIk2syi4JyN8ZWTwDYTaTKpZRbtR+sUoT5CS2XrWaJwDCULEy7osqedsY7ZkaVP1QQKJ+TtAg5pnpLdCwmkWE66jDzUDYw4TDxXixYDE2aluJFAVoZTRc7SPY3oos+CnVSpD3Vz0/d39Gp5uVKPzIuLma9zQsp6kTlFe89PH+3B8aG7Bch3cf3dmGwaAyCBOAcA674HAP/H7LqIQnwVQUexOr3gfRRu3ugtuzaGYFOTMhG7BpEr0OsnsxSgD1sZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5rqg/Z/sA3BXP0HwUpbcUC9lAlrYJIja7QKmwutfaM=;
 b=ChONQHe51AyrgpnSBrvVFer0CVUQ1QXiOwGq8ZaO3GAITL3aZPnnH6FKl++X2+mhGNx/ZpChHmS1v8oWZYb0Zi0DcmOlhW4ain0JBY8RQguogcsS7XL1W3MlckVrvdxqWCg9o8WjcZgCmLK7EPbY9qRPvmZ6apXZ7J21Td+QvBW4bLbCnc3SQbtJDHvfFytYmhkKd+jh2OrffMg3Guu1VDRNqMX2tpTf8hGIfRt1sC/4JfYlrYq8w07cul35ROLrC++a4BmP4SpSPOjcNIlUZwAxLPRsEWou/bFYhMnLeFeRccqnRbuu8/Ck5jjmTirtUzB6KrFQe9RaFx/tI8puRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB0422.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:11::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 12:54:25 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 12:54:25 +0000
Message-ID: <52b4a6fd-173e-4596-ac1b-0b1d80fd5ace@gaisler.com>
Date: Wed, 7 Oct 2026 14:54:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Introduce arch_do_panic
To: Andrew Morton <akpm@linux-foundation.org>,
 Mete Durlu <meted@linux.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Bradley Morgan <include@grrlz.net>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
 <20260831171906.7520833ab8ac40d0369b0228@linux-foundation.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260831171906.7520833ab8ac40d0369b0228@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::17) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB0422:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb7cae9-ec57-4828-b8f5-08df24721d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	TZC1QM9otH+W0KWTmiHgeRup5fXGqYvk69Sw0nY2nshmwKiKc2ElDmH+OG1WCdLKtUkO0vNPx4JX0pxt/VDZlo8+uH7qD+UKcm5vQzRVtcGvdMdtyb8xpV0VkCu2tuC/J2J+idRxd61I54+Jv56OtlM4C6cBPhsCXOKLVCrhz1NPUI6ODAuRIWrQsSZiOHvToyRy88GMMFI2RO9Fx08G2OpNacDtlL3ZU5yc3rBCHfCZxh1E8nEtygt0VleD3hMmxa8ZvvzAvuQzwUOVDnkvUhSKrgIIthGPDqX1kR4ZquZ6kCZqgYOLW3e6yOakLV1qnwg/Ka6wN7CzvGBYt+x9tT/WlGpOtjFwh/yJavSblYFHBXz5Ej5R9ybL0RmFB1fCZ/KbyUFH2U3vdIIwMR96K4rttSl8zk2sxoJhveTs4SzcrO67NNsF//n3QJ2gooGUUH6YXrj2wnweO7gnk40ULrmPSjuq/XM8DezAzGa10tv+V0liA22zksmMpY53C/YpKX+WOol7X56YvBU77pnotjfTTSlChmVkyWnewtNErCaR5Gl2cBS+Zf48mhLfBGsymjmSO0n9RvpQ+u6Tv350vd6PunTfE0FzpmhW/levyBBPxqWCfA3LcS9Aj4R16I413NfZv7PB+SFJWhx+wo4mLdba54fC08OCV1+ciIm84+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZHT3lHYzY0SU00RWtjZExvVXQ1dmE1WlhzVTkreFp3UC9WenRYaVM0WHBB?=
 =?utf-8?B?ckZzTTQ4dURJbTFEQnlOc3JiREJmSWcxa3VHSGViSHI4Y1ZhQk1YdzVWVE9q?=
 =?utf-8?B?aFg1ZFI4R096anl0a0JPUDlEM3ZuN0txUHJmdHo4NlFvNFZNV01hZ3pvQ1Jo?=
 =?utf-8?B?aHdoaE5ZdVVsUXBuT0VyRll0VVdHL1ovdUxwdWlJdDBIcWE0ZklTTlJIdzBi?=
 =?utf-8?B?bGNHTnh0d0t0KzZKQ0U5U2Q2NFdnV0pMZFZYVElVY2ZNUkl2NEphZ2hEQVBv?=
 =?utf-8?B?Tmh0R1duT2JGaFdadlhJS0Q2STB2S2ZkSUt2N2dwK2k5L1lHNVFzdm5vVmNX?=
 =?utf-8?B?Q2hyWUE0NFBJQ3dGSDRpUjlyQWR4NmZxQ0o0SnlqdCtXYSt1bGlSaHUwWWdG?=
 =?utf-8?B?NWhBVEFqRHptSTFvVUhxN0NuM0JtazdoK1pXOUs1VEdNNGlnYjEzVlhtY29K?=
 =?utf-8?B?aVJGOVkwemNlcDZJNzV6R2NYek85WEp4eFl0Y05oSkVKOE1Ya2JObGZFWHRX?=
 =?utf-8?B?OXM2bFdSSFhqUFpVdjdhYmpKMGNMaVF6S3AzNnU0VXBIQnpuSjh1bm9oeGZO?=
 =?utf-8?B?czZBcFdOMGVELzhTK3BaUEtlMjNncUI2K0JwV2N0QXN0dGFuNHkxSEZ1U0JF?=
 =?utf-8?B?bTMvV0g4OE5Bd3RGWHpUMisvTDdyOGpQN3pPQ0NaVmdhOEZ4aGMwUmxiT1pq?=
 =?utf-8?B?OUQzREdNK2NmL0RLeTJSLzdVMVl3TVdadjEzU3NNWHRDRklUWkZNdkhrNUZI?=
 =?utf-8?B?dVZxZG1VQ3hFM1B2MDArNEJjL25FK200MzFXS2dUdmlwc3A4WTN5VUJhTEl4?=
 =?utf-8?B?WGYxZlRPTWhjaEt3T2o0RWdDbjJET1grY1ZMUGdLSjY2OGpZOVFPU2xtSVp6?=
 =?utf-8?B?OG5sNkt3VjI0Q3duL3RoNC9yNnZROG1XREdLWHJVb0thb0IvRCtxWnliRk4y?=
 =?utf-8?B?WDhxMndjWjZrd0xGTHFITXVKY21WZTh6eFlaeXhkUmxvdVNDck5zakJQVDE4?=
 =?utf-8?B?ZkxNdjUyNElVb2dkdFJiajVoVGJqUFJYeGwxdzRVWUhjTVZHMllvU3k2Szhn?=
 =?utf-8?B?aENvUU9UMDNXbzF0ZHI4MjRlckxZUjhkVVVPd3drZU13cVdBdVNYVXBlQmZs?=
 =?utf-8?B?WHlDNzlnZWVDOFZpMUJZUGRxcE9qT01MbFlRV0ViUHM5L241OXU1Tk5YeGR4?=
 =?utf-8?B?TlQ2RlVIay9aWXZtMFEwYUcrZmhHQ3VFRU53Q1ZjTFZBRTFVSUtHNFR2Qmtp?=
 =?utf-8?B?NnJrdFE4cXgreXhCMGFnKzlQUVV3c2xNRnFaeWhCeHZXdUNQYTlma011VEpP?=
 =?utf-8?B?T3UxQmhTWHhwdmE5SmhrWlgxakxWNHdxNy96QW51b1V2WHJBR21DQ1R5N0pX?=
 =?utf-8?B?cHE0RUFxdi83UEVaS0Y0QUhZYjBRSUo3WTZCR0M1dWZpemxnNFBRcHVqbTk0?=
 =?utf-8?B?dDlZbGF2cEZmOWNHS1FJeUdCcXVvcURGbnlXTFhLU1JFajBvbXZvQ1d0cFNP?=
 =?utf-8?B?VUFoQnVadnJ3ay9nbTBrTEpPbEZNRlcxWWlUczU5dklzeTYxNnFXWEVrblI3?=
 =?utf-8?B?a1h1cGFldG9RYzBWMFdwd0M0OHNZQjZSejFoR1dwOTFlVEtJMnJCeWoxMWRG?=
 =?utf-8?B?UHNaMjhwbnprUkg3OTJPYTJIN05sMmtmS05nK0dQWmdPaVI1ZTRNdUpCRjhG?=
 =?utf-8?B?VHkxeUoyempSMFVnZCtCZXdDdUJ4aUNPS0JQV05SSWZQN3pjQXFXeldseFE0?=
 =?utf-8?B?Rk5Mc09wMnNCNFNWN0QrNThNbDBEcHZDemQ4cWtEK2E1SmZNUzdLVFBmRjVa?=
 =?utf-8?B?emRoUWRub1lZbHdnamkzSHNRTDNqTnpRb2R0VDBLTkJxeGhrK1RXYjlqQzU2?=
 =?utf-8?B?TElWdzgyV0U2dURaRzd1TGpaWEtKb3VlYXNjTEhnSG9hVlhvL3ZlZ2UvYWRp?=
 =?utf-8?B?bUhjbTFpTTQ0Ull1dHdpVWptZ25MV3dITWRPSHFsOHoyWHZKV3N5dUQvZXBz?=
 =?utf-8?B?VW1HbldFMkRhM2NOcjIwQUVJUlVFcWtCWTNidDZ6RTN5d0YrN3MrVkdsaFBT?=
 =?utf-8?B?MzNqRDRET2IyMTdCMEgrRDB2RGZtcUlmS1kxbmJMdlRwMStETmdQZ1Z4dDJG?=
 =?utf-8?B?S3o0UU40UW1TeTZmMlVoOUdRWTBHclBLUUs5azd2a0FFZTVIRjFLbnJsM2RQ?=
 =?utf-8?B?Y1RjeEdRY01WQ0tvYzN2VlFEeGgwcjhsMGlwejJNTGkyKzBmbVVyVVBBMWhy?=
 =?utf-8?B?dDhJUXZoRE00MVJSdnJhalNYaDcxN0w1K1ZYTFhPMjNiOENJbnk0ODRWbm51?=
 =?utf-8?B?NFdZZ2dRZUxYN1ovbWQ0Q2hlb2Z5OWZ1eHNmVENVRG9rNVlkeHN6RGVRRHlv?=
 =?utf-8?Q?ZHKP7pjasU9FQVfY=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb7cae9-ec57-4828-b8f5-08df24721d73
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:54:25.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPA+Rz8HE/3LGyHNF2HOXYeIwXWVi1KvxTC17oL+FkIMtzxTw9lTl/D2qxgjSYdPc8pm9j6VPbLIzUBTQIx4/ET7JpkVFBolYbvO8ZH8plI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0422

On 2026-09-01 02:19, Andrew Morton wrote:
> On Mon, 31 Aug 2026 11:57:14 +0200 Mete Durlu <meted@linux.ibm.com> wrote:
> 
>> Replace architecture-specific ifdef sections in vpanic() with a clean
>> arch_do_panic() hook. Currently s390 and sparc embed their panic
>> handlers directly in vpanic() using preprocessor conditionals, making
>> the common code path harder to maintain.
> 
> Nice little cleanup, thanks.
> 
>>  arch/s390/kernel/traps.c  |  7 +++++++
>>  arch/sparc/kernel/setup.c |  9 +++++++++
>>  include/linux/panic.h     |  2 ++
>>  kernel/panic.c            | 15 +++------------
>>  4 files changed, 21 insertions(+), 12 deletions(-)
> 
> Why do cleanups make the kernel bigger.  It's often that way.
> 
> I'll scoop it up.  An ack from sparc people would be nice, please.

Tested-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>

Cheers,
Andreas


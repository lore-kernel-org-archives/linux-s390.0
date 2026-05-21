Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021086.outbound.protection.outlook.com [40.107.208.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F9383993;
	Thu, 21 May 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382672; cv=fail; b=dzWThumxfSTQ+NnFg9HhHZgjFA4PEYbNjTmvHh7BtLGLU2BmSSVLcfI8D7x7CMTpgzLe9xMUnVJwSIRaeaREX2f/N8Rd7NQAK27uqihiXAi5dJYYZKV/sv8stKROiDFtZYmx+YFytyMwfx0OwR6G9H/GdW3Jy759QSUXaFpemH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382672; c=relaxed/simple;
	bh=TBJSExPj/JfBY2Xokea80u8I2YLNyo/juCaF6RiT2+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KguCzjcb/fhFT7Q1vhuBrll9gW+SBprkOCcvoiUte1XI29aHBMFk7JgkjJ16BY0Gv2O9wW9LfyEFUbz/QGDHvtLKcYrIKBCi6TDirt6opDIpyJFX+KCLVeg+NXAnEjL3xAhT8nqnZF6pvpziwEDMSP7PBIpbJwbBoVDCkWLdUBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rnFJIkLq; arc=fail smtp.client-ip=40.107.208.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rnFJIkLq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E08uBOuH0R5jKwyO18Oc/MLSkwlV1aVfqzrKzsZbufX6jxlwnrWRb1hHcIoblHkehJPk/yzaV3G29UAztM8G+gsdY9Ku5OWZCNBmr9yoEPIrPwUH8Li//F1V1ZEHmeOMZ+mmkdf/0Z9W2nmuKD09oEB0wEsdpSqfoZlsy90vjwUo7v2CDsNXyz9oHy7yPiDFS+A2xcM+sbSIrdpUCo81tohU38/4UKncDWIox8jRQbPa0GzhoQtsmYjoyg2OFNtmH6+6cy2JeB/CkfrosZID7JhyhpomJJIBLBcy+ySi1Z8n3U/MCf2ZVm/9vUGk5srchzNjpkGkuwmt0k1FPMcDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkuEgqD2p4wBY8pB9fcuU1au4gH3NZIwHi2OYwnH+Zk=;
 b=PitCRhcbYzaHuRjiqNbj44gFnj5rOb0h91F2VxBFQf62usEHJ4VoRFYRLrk8CoVJPWPM1lVTpcEVZURoVrLbfkN9Vcz/18W97wJQXIiM05DmIDVjwZqgiWWCXWvei9f7HblAoFzyYoLeKXx09aTuKcS/eBGvZ07wrMuNrqZMN0rZJD3PK4KQetN9OqKaJu56ClHDYVaAdj3Ygzhxu/FVQXZO6v40gx5G7+RPZoMLR3M7gz6NNeXwYlIrTevy3xZI3PnLGE3QRPNF164IWr3z/U46fZbwmEQMZBgayjzyh/YrXW1fWn6BCxfmgsRRJWyhyZuuLFeIeS35p0ullTw9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkuEgqD2p4wBY8pB9fcuU1au4gH3NZIwHi2OYwnH+Zk=;
 b=rnFJIkLqRZ451gE1rdU60X6R34ZiszT6fCFf5WkDeBzzHnj0moj7EcAPEGbNXtRUQ4y+PonO9W+HCP00sY06m/gxuftk5Tsdh7tfUEVEHzuVswaTI6fL5uPg7jsoe+X2XCVy1OyBUwH5+GkWNjiVa4I1QZRITPp3KiEcd35goyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH5PR01MB8885.prod.exchangelabs.com (2603:10b6:610:20e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 16:57:41 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:57:41 +0000
Message-ID: <592ea7fb-b836-4c47-a0cb-248a185cbaa8@os.amperecomputing.com>
Date: Thu, 21 May 2026 09:57:37 -0700
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
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260521111744.6e58bfd6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0121.namprd19.prod.outlook.com
 (2603:10b6:930:64::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH5PR01MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f13e87-047d-4a27-4687-08deb75a11e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|11063799006|22082099003|18002099003|55112099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Vv4ZJdx5hfr9l6HKVQqY34CoT2s25LOk3b1nubO8LLSVwJwbOP5dufe3fl09jea5OgRf9H6S9U+D6gSrrY0CUPlMwM1usf4J2j2DPwHV0igBNG/lE9LrI6UA3lZjjTmyK5nq7u3wDMuyYT8NR5qRXGLIq3wR9Y0QqEFDD0sEfKIwdOQKtdlH6U1ijLA0CVU3ykMsj35jL8eEMY/SBQqOi4wrwcZtsR5/YI12Ior1UVTr6ZlOelgFuEkK7gC99I+LQbKgleis3EkbOjum31C2WEBUzeYFmG9katCN66TDRtThemXGy8Uh+9tlX8h6gLj7kMYcOwCGejhUl66ap9a85v7CSJnSwomSxcVt0a5dPDtlieDFthhuyL27O5umyhG6Um3+J0FkDEIuIIk03YNKdg2FwbXA8iCSNHlv5KafQQZJ+rJCq+MeNvXlhpBk3MZcdDDxnEx6Me6iUzR/1Uclhm8JJlW3PPzP/bfFBKFm5OjKR6LjnRkyQBhTLuM7wFl1jYxjKQbvkQoUIkk6BhefK3QrKS7824YEOwe3LUzRS9WIaAsSGA5zpz4CzlJIKzY6E4e/xgb9XVgi+bCl+Cfz0dgIPbX8xfMr7t4dQAdU2NhvGdfOfE84zAH+LhEAupMKexzIJZLsM/W5FA3gaIcq3eiU/KhW3HZfEUieT6neX7DQWFCu9ltARU9GFbhU6N9VDulC1S5oM4zK5kIWWyKI+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(11063799006)(22082099003)(18002099003)(55112099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmJCY1dsdS9HVlBOMDlPTWsxTU13WUFPMGtHWEdmd1JVa1FvUCtjSFN3a3I2?=
 =?utf-8?B?ckdzNWtLeVF3NTEwUDhoTUhEa0lyOFpONERwMVcxcE04V04zeEZFNWRRR2N5?=
 =?utf-8?B?WVhQVytwZHhrOG9pUnN5TG5pMlQ5SEk4cXFNQkoxZkRleVBmMlhWVEQzVFAw?=
 =?utf-8?B?em1KM3lSUlg0dW5TZ0JWQkJLejRHN1lGK0hZQmRxYnljTkU1Y0V0d1NmVlB0?=
 =?utf-8?B?ZGxDU21HWWZNSGxaU1kzN3hmTDRVMTdVeFRpM3Y1elh2Slo2dTA0SHJma1k4?=
 =?utf-8?B?dGxVWFdsbTJTY2JhNDRsVUMwUThHWi9CblNnSzhIWmxibmh6WnQ3OTMyTDJR?=
 =?utf-8?B?UGNTODFnY0JubVRrWEUyS2dacWZJSzdCVFdHVG1pL0RzTDB5a2U5Mll0S3Jj?=
 =?utf-8?B?d09vNGx5aW9EbG5TRCt6UHdpRTVLcmd6NVNXbVFaMTdKeERGSkJiSlJkRUJw?=
 =?utf-8?B?a2p6WlhWcVd3bVRkWTVPUE5ydXBDQ1VvcVUwTE1odUZiS0d5TDRpNHlUVGN5?=
 =?utf-8?B?Z1RBQzZ6WHBEOWNycTRHTHRkZ29ETkZQV1dPd3FVVWZnTEF0ZUNpOXZmc2dR?=
 =?utf-8?B?dmltQ1hrOEVkb2ZyQmQwY3hDRnZTSnA1MVJwUEZleSs5YUxXS0ZLYzJxbERz?=
 =?utf-8?B?VDJsQ1l5TFlyT0lIZGNYUHpUNFhzekJwUkNLRC94VWhOOXRiamhhSU1kZi8x?=
 =?utf-8?B?Y0dRbnJLejk4VUxSa2ZLRUZYMkdaSzdSMjZiWlRyRGJvcUVOSnd0dWc5Vngz?=
 =?utf-8?B?VEllSGNXT2x4RGVsMGdacll0N0NTZmVNR0FFUC9WZHVUNEFhb2dZM0tCenBh?=
 =?utf-8?B?Ri82WTJ5c3pNK3pzemZIWFBvSlNTY1lUUmNQcWZyek4vZ0lyemdPODErUzVY?=
 =?utf-8?B?WkhrZldQQU41Q00vc2pjMW5MVE44SlhlNTlrNFAyMTc0dUlTTHBzak0zUVlx?=
 =?utf-8?B?Um11Z28wR2IyeXJscXZMVy9Fd0k3MG9kRVFBQThsTTBMSkVGNW5IWEpPemc0?=
 =?utf-8?B?eUNPRjZkcVI2dUtrc2NnRktrUzJwYW0yam5xQnJjc2piZEtvYVFyRkRYNEJY?=
 =?utf-8?B?QTkzM3dDQ0xzL3crU2pxNGdqTmtJSk1RTk9XbVpNZnl6MUtJTVBkc1JRd1FM?=
 =?utf-8?B?K0tBRmRJZ3VmVGVwaHB4eVBXRTd6S0hoUzBIRVIvWHNwSW8vZ2MxV00rSVJZ?=
 =?utf-8?B?Y3NaZnRKWEVFclNyQmdyS000b1dxcEU5VEhnSEpJbVFseFN4d3E1cVJQRUgz?=
 =?utf-8?B?dFZ2M2NOblEzZTBRczAvcVVjUVhKaGZBTUpidUh1aEZLelZqa0k4MkEwRldB?=
 =?utf-8?B?bVM3TnRVd05vcjhYTHNhSEhrUGM2MWE2NnN0OFpjL3dHWE52TitoTWk0S2Yw?=
 =?utf-8?B?d0RySDlPSURaOWlLWkY1T1VRV1RxRFVtTmVzaTB5K3FSeWlGZ2RjL0hqa1R4?=
 =?utf-8?B?ODdRSFZiOFBFbWpFKzNyR1hPdDdMczFtWXUwVE0waVhhT0haOG9KM0xJZ29y?=
 =?utf-8?B?NXhEVHA0dGZJM09YV1gxc24vYVBtd3NLTWMzSys1MktBQXd5ZVNyL3dQd2p6?=
 =?utf-8?B?NGNIVk1NbDRuS2hFdGVIV0NwQnBCMGFTem1TdDgwVE9aNmJtcGJFRjdGTTlr?=
 =?utf-8?B?QXI2MkVNUjRTaHRhSUJuK2lSVnk3c0g4M0pac2t1a21yUFpHbnlGWE52S1R1?=
 =?utf-8?B?VVA0a0EzaHBXNzVQWmdFYzE1U1BZcm9sZk5wWHlxS0ZLT3dQc1NxVXk1TU9l?=
 =?utf-8?B?dlE3WisyVnJnNEJlRVBIUnErMDB2Z0JTd0FjZlpjcTA1N3RhcmVzQWpmUDly?=
 =?utf-8?B?QkhPRXJpZDEwYm5ZcjVuN1hCUDhGWERhV1VCTDNqOG1BUlB0cU5UT0FDK21T?=
 =?utf-8?B?cVpKTGVpYzdhRXlZTG1WSStLV21IZTRvQzIycWZuMzhlcU4wa2UzT01hSHla?=
 =?utf-8?B?KzdpcDdQeEpGaUx1bVNVc0x6ZWpZMVdKN2JNQTlOTExUdlAvajluT2ZxbDVr?=
 =?utf-8?B?MG1nd2dLQ2JCMnFLMHo2SmZqeGZJcmVCTEN5akVVOWY2U1paUEQrQVgwcXQr?=
 =?utf-8?B?Q053SURZL2RNVFRDY0FWN0F2VitvK2lPOXE5ZDlSM1V1Q3hBZ3pHVGNpKzA0?=
 =?utf-8?B?UkwvTlBDd1VSYklva1hneUh0bnVOaUliMmVmT3R5L2tPMjJNbGdnNnBsVU1G?=
 =?utf-8?B?Y25rZ0FIa2o3UUV6TVljVXJRVFZmLzJCNU9aeEUxYW5LOEJZdVA1WDlvU25p?=
 =?utf-8?B?aUNFMkVoRVpieDhsb1c0eXlwQ2RScmZYazRlZkJwajN5S2hQbU1yRkVpaVRX?=
 =?utf-8?B?U3lnREdoNXNVOEwyYklYQ2VieGFSSGJGSVhGSGpVU2NBcFNWaUltNnM1bThU?=
 =?utf-8?Q?uAigxQVERs9hqp6s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f13e87-047d-4a27-4687-08deb75a11e0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:57:40.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+wTw0TeFtZ63D/RoI1IymHWytTCBYbdS/kQrqYUPhAK3/sBEUa9Dd8+v2E+xL6vQUJkm5fT9wVTYPN1FKY796hzGj7Ow73frdXlXpdsHVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8885



On 5/21/26 3:17 AM, David Laight wrote:
> On Wed, 20 May 2026 17:23:37 -0700
> Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> On 5/20/26 3:34 PM, David Laight wrote:
> ...
>>> But I'm sure I remember that some cpu don't like having the same
>>> physical address at different virtual addresses (and not just those
>>> with VIVT caches like some sparc cpu).
>> Yeah, VIVT cache doesn't like it due to cache alias. But the mapping is
>> really percpu, so the mapping to the physical address belonging to
>> another CPU should never pollute the current CPU's cache if I don't miss
>> something.
>>
>>> I'm sure code can end up accessing the current cpu's percpu data
>>> using the same address that other cpu use - there are definitely
>>> places where it needs that address.
>> No, it is not. In the percpu page table approach, we use different
>> address for this_cpu_*() and per_cpu_ptr() which is mainly used to
>> initialize percpu data for all CPUs.
> You missed something.
>
> Look, for example, at kernel/locking/osq_lock.c
> The code uses this_cpu_ptr() and then both dereferences the pointer
> and writes it to places that other cpu will use.
> It also uses per_cpu_ptr() to get an address it can use for the per-cpu
> data of another cpu.
> (That code all assumes preemption is disabled.)

this_cpu_ptr() uses different addresses for different CPUs. It is a 
special case, it is not due to VIVT, but because it may confuse list 
API. Because list API determines list is empty by comparing pointers 
(head->next == head). this_cpu_read/write/add/sub, etc, are fine.

And per_cpu_ptr() also uses different addresses for different CPUs.

The lwn article explained it. 
https://lwn.net/SubscriberLink/1073395/12c08f128e515809/

Thanks,
Yang

>
> -- David
>
>> Thanks,
>> Yang


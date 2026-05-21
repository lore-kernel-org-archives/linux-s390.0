Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020128.outbound.protection.outlook.com [52.101.56.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B715381B0C;
	Thu, 21 May 2026 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406885; cv=fail; b=hrPLdm5HRBDNvOTTFL+unVl6/RWYZnKdUyjDHcS/eQXpF0R51adzxeEEWGqeqcC5H7DXiCwnHuUQCX4621S+rzO+A+RovG6HT6c+0NoZ18/v/12IaLF1mBFjtQk89eSGndkcG77pAQ88fHZTk9FM0k9KoPjgWIW3SDkVFLuK5G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406885; c=relaxed/simple;
	bh=FWc7bF92SEH0ps/oKpv/g/zD6Nfu0WvRdfB+2KPfa1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwIoCry74jXAYnEpwo9+UN5Fd1XDxKY141JwKtBpo81IDK8E7LRdHiR4KO4sQ+1TTUbroxfWCMnziu+KgsT4zXzCPskkrHEz7IeVKJh70nfvAFjfjxAIl9fVJQrTI9ytaNJ1AnId4XYp42PhXvTXQlls6Cpn1ohnH0Vq2+7rHOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DeSgApoc; arc=fail smtp.client-ip=52.101.56.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DeSgApoc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYUD6R3D7bhzkx5S4oJu6dYE8DjgxoP41z877lV5NBzPHiRi2wZ6UkG8y0SfVCS00y7FUdbNeFNDnfV4AKz4cv8kjvYg+J7eaU8dSHtXNHDr6WOygjWXpr/komd5uN0A8K6PNJsm2b/E4UDNW2OG4NnGk1b1p3MeEVbuDh+NikO+KLmadjWhdoPY8FC/PKzlUZN4DJT3sTlFW18pafcoqApHe/5g2rgv/83vuSza/Pw2M0HQAq1j8cSurWja2YKxs9GEEfhovNHuD0uU2ZW6Jg4Woc/mXpvmLmxHEbl31O87omXNzqGaolPVh8N6zj2sm8kMfMV1rFdpMoQxa/6cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73P64W+ND2vSKhXzHH55uXv63l6vvUUk3JVLQI0EPYc=;
 b=ScceB3jg5nyB4uVZJoK2IPyrZhMwDxfaMpHFQ5Q0+mt7zvwd74IirQRberp9pq8fmtUtysSvMbt9YmSVHJDXZ4h9gBgw5H6us6buHnD4xQuKuwP9z7szDTnckA5dkNcqVUSVc2NA5xErlPdUvkdNKXYf4MqjWrTENscCeto/uVQjUG4hnewyu+FopXgZIFBW6Y4JOvEH6T6LYDS8s7W0EUGHWP+dhKGMZH9BtvbY83OreC47TPtKel1Vgl2R5nPYvJhuGaxxpebfdXNz/suKEXM06R4P4TJOvB10GOzbEnHjJouIib6G0tD2KLbixlFAQ299xnfpmmSIVxswzeJTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73P64W+ND2vSKhXzHH55uXv63l6vvUUk3JVLQI0EPYc=;
 b=DeSgApoclr5vkNjUHRCXh+S/awzGm9Ygiz3/xVqs8e+Qkas4/KpqIGkM2KtESFWzhiXh20G38IVNGrhKKch8lJSsAxyimNQqPMrGIfE6ccDktOwIS1Zusfgy1zZE/LlQYqf8ED1NrK2IeG54J2RqpCoJfQKYEGiiVTXXMJ5QYtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8292.prod.exchangelabs.com (2603:10b6:930:c2::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 23:41:13 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 23:41:13 +0000
Message-ID: <dbaa5fff-66f4-4dc4-97e3-93cd1bad746f@os.amperecomputing.com>
Date: Thu, 21 May 2026 16:41:09 -0700
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
 <c29b201e-f839-4702-be60-f8c38ef637ee@os.amperecomputing.com>
 <20260521231335.2fd3f7e3@pumpkin>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260521231335.2fd3f7e3@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:930:89::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 90398ae5-93eb-4d22-c070-08deb792715a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|55112099003|4143699003|5023799004|18002099003|22082099003|56012099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	5PC1nXcVoBbVhd8ywQTzEPrB4g+4M1Tzo8RoSFlVU+4tLEiSBqkfd3xIxDVF54jmq7Bc5K5LIsLctLPUa1nGNJdeiMvIpJF/VbM5wyl99W5er3zynvrYIiqPjz/A1IT7bmBnk4eyVgByEe5U/MSF1wgd9XPGT7rzzcG9SgmEDU00bU5lokHk3XRHb+oRA+uF05w3D8Idh51hDwNr2ov+0+cY+kmkkHORp7p8c6YMxts1g4f9GbYv7Li4GA7pHzrNJwRN+Q4Zx2VIcpPlvw9Rw9QBn44iY5ui8tTomtIC5OR2G6FxJPMHM2aV0/3ZOv1+3+gsN6wOpfsFeDd74tOvpmi1u4ORJstKf1GRAe7V26RAlyYt4e0V0q32QGmyXEFMkTtWexQEwZjfgDI6uq68V1dVjBBfrDojT9/GBKq5Vg4NJRxA+1qq60orMwwOAukYSt6OTBEIqYnxCDq5bV8K63YgmJt064z1VoXGS4yw/sbcW7XnJze20ahCbIRUa4GKnKptCd0fzzeNSaHjQZsH0s0GEdXpUBDcIrCtmMOM7zBWFy5Xt+xCW1ba6Ud7LOH023hU9pDV4RXTxrJ3Di4nQp8hRiDsja7Gx83MhJr/9Zmq+js9qelg65doOrpjtKfjcgoGC74Ox9atI9FzvuntKCdsBb/jWJ0pO3E9kRl/8iAlW14VYrbXC2+ZQu4bf591
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(4143699003)(5023799004)(18002099003)(22082099003)(56012099003)(11063799006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TURqZFl2dndRbDhrUWc3ZkplUmlkQmxIb2VYMHJQRFlIVkgweUd5Q3kwek9T?=
 =?utf-8?B?NG9kK3M0ZTV1MmZXVGdHRDJQOEsydVU5WVRPNms5TnBhK1dKeWw3amJOdXh1?=
 =?utf-8?B?OUkvY0F2NnBzdEpyVXRrem11Z3NEVnBKMXE2eUlhUk81b2NVNENQeXU5bXZT?=
 =?utf-8?B?U09jeXJFUmtyTUwxQ3VMUVVmVDJhV1lsVk9QRDRQRzA1LzBsbEV0aHJ4aURX?=
 =?utf-8?B?TnJUcCtxbnUzSVRvb0JWeEMrcG1id21jZ0JZTkl0cDc1K0RmTzN0NlJoQVdR?=
 =?utf-8?B?dlQyL005SUVUT0NSa0FoZUowb3M4QjVNbnM1YlB2RTJoQ044YVZzWHI1T0xU?=
 =?utf-8?B?K2RRK1dKWDByekxyVW5nZ0Zjdzk1aDkvQ3JiQ2ZuWklueUlHR3VaKzljOU91?=
 =?utf-8?B?QjhiUlExK0ZyL09HSmU4UXBXZ3BFSDVQNzM3cHh1TTRXMXAyaHJaQlliMW9L?=
 =?utf-8?B?clFsRzVLRzB0cCtOa2M0U3Y0Q0wwNUZYUVROd0U4VHp3bUp2OXRIMGMvUFR4?=
 =?utf-8?B?aUVLZnkwK1RKR0Z4SlZIU09Rdzc4eklBQUF3R1Z3cmMyQ2pvNkFnMDYyWHlp?=
 =?utf-8?B?U3RoM2FTektGdjhnc3UxVmVIbGNGV0V0WHhqTWdqVTNxOUZadlFKQ0twLy9w?=
 =?utf-8?B?RlluTTQvd2lIVUJvTGJlek50MUNLNHlqYkNlVzBqbndWK09JNnBWVHZXd0Jw?=
 =?utf-8?B?Ui9ZYnZpdmgxZXVPRWxIYVc5YWxUeXB5Y3dQb09tYmZTTzRpLzFSOEtBUFV3?=
 =?utf-8?B?SEFXcjNYRGNoWDNuRlBCVDY4RmFULzdpdHRKZllDcEphS0x5TW83c3BlMVpi?=
 =?utf-8?B?QUpGMUhGYkJ0c2RwZDFUZGI2eS9oQzNleVI2NkFBV2w0ZldjeHJaLzdROXg2?=
 =?utf-8?B?VVZ0SXhnRjNmL20vaXhTTWFIZUFON0ZPMTR2bmF3R0p6dkZHbTlEY2FlUmRk?=
 =?utf-8?B?L1FuVGROeCt2VWJNRGFvb2tSaHlTYWZXTEJoUTArcm50L3hMbldxVGxKQ1Vv?=
 =?utf-8?B?TUpKTkpyaXJyQXd0b1Ara08xcU13VGNvMEpHSUsrdmEyQklTbEJkNjlCbEE5?=
 =?utf-8?B?eXNxTjIrOVJveWlxZmtObVNiYW9jRjZTOGdBVlgwclprM0FzZW1HVFBDNFBK?=
 =?utf-8?B?aGJNN1dJVzFOQWNKL3Y3RVYyNEFnSzUwWi9VT2hCaThpcnJOcWNuR3ZZMVkv?=
 =?utf-8?B?YitvWStJcVA2bnU4RmVXekFYS0NVZUZTZy9uem55dUZTVXFpSWIwZ3JmcFpr?=
 =?utf-8?B?TGJBeVBBb2M0dDVlUVVPR0VPUWczTEFyNCtuanlWZ0llUU9DSmM3Q3k1SjNP?=
 =?utf-8?B?UjdkRURwU29Fb0txR3JnZ05DSDk0L0kxM1dqYWNuWUo2U1kwaFFTSTJBb0pv?=
 =?utf-8?B?a2JYZGYrM0xxKzd1Vk5mYU1RcjhtTDRhT3Yzbi9XQjBhd3Z3Z3FCMklQVVB5?=
 =?utf-8?B?K2wrLzNTY2g4bVAyTnJGMGJucjlHd2Urb0hIUnlGTUJocU9jb3hzcDVpb3ZU?=
 =?utf-8?B?SmJjZFZVOWhSVjB0SXVNNk90Yk5HUUNNY0hMckpUV2tra2pUSWxrZFJnRmNm?=
 =?utf-8?B?TWk4TDgzMFhzS3JaN0VJaXR4Qmw5RHdFN0NIbCtzQU5SWkJ6eTZkdWdEMTND?=
 =?utf-8?B?Q2FOV1ZyT0JpZm1BSE9RclRxNTdCNm1MRXM2ZWJqUVVZWTFUVkdPa0pHbFd6?=
 =?utf-8?B?S1JUMmcxWS9nR2VzMHZXWnAyVTBhUXA1cWkvZWUxSTRmYkZhNG0yRis4d01O?=
 =?utf-8?B?RXprb3pERjR6Y2xXa1grRWpQRjhHVndZak1vdFc3K1dtd3lEbEhvODc3ZzNy?=
 =?utf-8?B?MVI1UHA3MjBQbWtTQVU4bWhtMEFRNDR5cDhoVHNJSFBjRkdmT1JVNTFUcitB?=
 =?utf-8?B?NERqNEpGczMzSGxLcGhzYTNUV0oxL2hLdW8vYTVMdFhwTXFhVU5oZjVYeXdy?=
 =?utf-8?B?Y1NoTzVCdnJ2ZUkwejVQelFjTnA4cDRlTGJCdWN6bHh3MHE5UytFMVNGNEEr?=
 =?utf-8?B?enE2cjBuWkFyUFBZN3k3cVlRNm9zdVlQSWVBZ3hMRW1YTW4wTzhPTFR6dy91?=
 =?utf-8?B?MFBTc0dXaklBTkxJUDRhRjNIUk45eVQxakpIL3JMYXFsSE5WOG9ZVURKNWlC?=
 =?utf-8?B?MnFDTWZDYW1FZ2JLZHhpKy9MVGZVV2RSSHgwNVpVTXBVRmRhZURybDU4YlFn?=
 =?utf-8?B?RjVOemVsa3RTYWcwUldRMmdRblBkYnhaY0s0a3pEL05VbkNXK1R4R3pvZkpP?=
 =?utf-8?B?Y2FpeTJzK0hrSSt4WWpDTFFZaENMbnQ4bHN1OG50dTZWbFgzWWVvV0did3Y0?=
 =?utf-8?B?K1AwanVrN2c4ZUlUTm12dG03MjFQQm5HSlY3N3hBRERDWDIvcVovQnFtVllr?=
 =?utf-8?Q?hRx/kyzpGM4xOvPY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90398ae5-93eb-4d22-c070-08deb792715a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:41:12.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYDrJjk7Fln281DOpQXPz5iAsof/hdeTJjMJUW5k/DdmxAwzMeCLCv/Jfj2KMH01k1om3mDHyzVt+c1Mfdnss6EqgMFLp88ZMGaPMNfajq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8292



On 5/21/26 3:13 PM, David Laight wrote:
> On Thu, 21 May 2026 13:46:25 -0700
> Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> On 5/21/26 10:55 AM, David Laight wrote:
> ...
>>> The 'trick' here will work for reading/writing values if you don't
>>> care that the value read is stale (or might have been written to
>>> the memory for a different cpu).
>> If you don't care the stale value, you can just call __this_cpu_read().
> You can get an impossible value.
> The generated code might be like this:
> 	this_cpu_data = xxx;
> 	preempt_disable_count = this_cpu_data->preempt_disable_count;
> If the count was non-zero at the start you'll read the value from
> the current cpu and all is fine.
> But if the count is zero you can get preempted between the instructions,
> the process now running on your 'old' cpu can increment the value
> and you then read the new non-zero value.
> That won't be good at all.

TBH, I don't think this counts for "don't care the stale value".

>
> You can only use __this_cpu_read() for things that don't change.
>
> The big problem with using per-cpu page tables is there will be absolutely
> nothing stopping code taking the wrong address of a per-cpu variable and
> saving it somewhere.

Err... I'm lost. If you mean RW or RMW, atomic instructions are required 
for this_cpu ops. This is how this_cpu ops is implemented for ARM64 even 
though without percpu page table. If the operation is interrupted in the 
middle, the exclusion monitor will be cleared, the hardware will reload 
the value.

If you mean this_cpu_read() some value then this_cpu_write() to the same 
cpu, I don't think it can work as expected without disabling preemption 
for the whole code section even though we don't have percpu page table.

Thanks,
Yang

> At the moment you have to use the helper so always get the global address.
>
> -- David
> 	
>> Thanks,
>> Yang


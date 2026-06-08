Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020092.outbound.protection.outlook.com [52.101.196.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FD246781;
	Mon,  8 Jun 2026 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933732; cv=fail; b=Zr/9oU+lrXmVcg60yzPoqXlCUDYhufQtQl6TEgZqrBe8E8T+Phcwcwwxg1DLYAZRIThyx+/UpHaVws6oOjSNm4dv6YMFuMclCpf4aTBUvQqwvoiymH2lnIi7MK2hyHKofuvLivWs+oxxb6R44nuhOCCYyTISFKHxY2aM3sNE9wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933732; c=relaxed/simple;
	bh=NS6VKPzmpkotXRq/m7y+Lq3TW+aKIu0d7O5X2uUHtGw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=EwAwVI75qckJXMwx8W78PahJ/adlqn6w9Llw/PaLeiR/B0P+dQomdEeXkFcGnB9ot768/1DfmK8sRoRaQZzE3M2U6b+9lcYq8c0mS+CGM215jSHlt8Iu/qR1/oRh04ldJ0LQNP+/te1SXfN2p0/X5pFWqYCUrJDPAKbBfwu5qhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TscPS6Y1; arc=fail smtp.client-ip=52.101.196.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TscPS6Y1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDLzBSRbx2F0yLIYMgGvunoesri/QNbn8e4EBuSVMjWpy+g3wBjpU58ncw2awqcUZrLYj4TVEA/NvKl9qVKfLk+R/C9em7ebGM27mEF9N/MpXKnkFpqv0e8SQ1r+2mT9tBTIMCgnL1Z+bL6dhjDewj4ao7gxQoC2FNsmdgHyNGGPIyaqJKS7J6egL7clyz9lxovUvbFjuC86/HC6IJQ6iglAZC9cSaz3/N3iWTgIc/RFV/gfDTxlTQzWVeXB2OM4xWnsiST+VdlprMTHRIyZU6drRl4Pl+GG9oYIWO4UYU38ato3qqslI1KOmSFaCndlR7aZ72HxucZOp5vsClUOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJMLGAeGh7zYaEBCJ+xxZmSUh2SghSYT2vyukyeb/SI=;
 b=JGJKbZfSLc5xGkScS/oTQyWQQFuEA2kEItO/2Gh04mdZbGy4mHYMqGCCR0r1QGXC8cLtcE8Ib/Gec4FL6v5ztS4baWfsPIAAo3n6oXYCghN+sEeHhwUwuL+6dR+UUaw6X9YrDLZQ5NO027XJO9U6G7qV7LCCXo512RxS861FAPaXkNhDgWuNSQFdd0vidxeyl02+XrveLRIXn7YmcnrdmaA1ZIdyrWjOe9oFtIACdWQTxeHu4vvI8yGdBVdEhgKlaN0Nro6xEj9lMmssM44I6Wardu5HwFL2MYy+LmRmHFaRissDMarLoihkd0y7HnUfcCUljekweavIw4rNk1s5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJMLGAeGh7zYaEBCJ+xxZmSUh2SghSYT2vyukyeb/SI=;
 b=TscPS6Y1CS1Nu8K2vxd+0GpYE/RNoA9fLV87sgP6SeCUykgYPw92mu6YNuA6Yszno1qEj9zMNeOVolkUkjYBPms6NakFUGBFpR6XWMpdO8WbqvScYzv5KgWXHLa7kJDRno4TTG5/yyjSYBOGoPnxgPNMEb/kZ13f/K+o3HlUL0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8768.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 15:48:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:48:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 16:48:45 +0100
Message-Id: <DJ3SBEPW21J5.2GMLCYBAKF7PW@garyguo.net>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens"
 <hca@linux.ibm.com>
Cc: "Jan Polensky" <japo@linux.ibm.com>, <gor@linux.ibm.com>,
 <ojeda@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <borntraeger@linux.ibm.com>,
 <svens@linux.ibm.com>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] s390: Enable Rust support and add required arch
 glue
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260601174625.2910233-1-japo@linux.ibm.com>
 <20260608142122.34400J00-hca@linux.ibm.com>
 <8f3c0ffc-adc3-493f-8347-9e7579f3cf99-agordeev@linux.ibm.com>
In-Reply-To: <8f3c0ffc-adc3-493f-8347-9e7579f3cf99-agordeev@linux.ibm.com>
X-ClientProxiedBy: LO3P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 9833940a-bc5c-4950-9c98-08dec5756cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oOKSZdI2fe6UWsGPt0XlRYPMz5ZxMZnp8hzTh3OsMFh1e0RS7ZDckZrEmlT5MF5GDa44C8evprD7mKg+AlSQXFq6onPX50d/KL0HoWf4T+Pn2jWbZkdj2T6yRD3GG4MpxTUFqXbnJsWddz0gPMb1UL0FARD5s/9uA68aKFzVo2x999SzEvkqdi/MofGUgCZryY+M3BpBQ7mWsZZk0VoiW3ZJ0d8EI1HffmosYDeowTlA3xnj38c4qFmdxeWsKpg/cT6adT9M3CG5928Z5zIEIurghHZp2+3dWGMRcLjJb0rfUhtPoR2PScq2H2Ps0YRQglTf20LK8sY/NPAW0JeIpPB/F7CgKevqBlsO3tPAzKytZNz1XYVZ/OmJDxcjclekaxqO2IeYsoFvScxdTv/+m1lzHnlZNqdkmdgRefELTvVgT44PGhm4mDE+WdkfHm34DinTxpB3mfLkjnRQcngefPMUXOCJ+XnJo5uGL7hNzo3CLRg3o5E4PscyV4WaUBShNaELTwmwrmLBGyY7PumSN/0WHzCX1C+GhJT8AG2WuhCo6Vk4+FSC3Zy6DJR/HYpRx4RAsBNuAcm5XjjEJsvjDxmwMg9tqEsLVdrJwitXhFxAyWmOEzgI9v3jSbk1HC4WOxBCxQbB9HXM30OsB3a4ZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RklZNE1IWjZsWkUrNC9UTmMrQ0o3b0U4SW9JdkhCc1VuZ25GTGFJQWs2T1pX?=
 =?utf-8?B?Q1JWMk14OXBmSThiKzRFcTBBN0FsNEY2YzNzMEJJOENwQk4xTzQ5cDR5eTZ3?=
 =?utf-8?B?SjkyZ05sbzdvL1Y2RW9RVmhoSjZDbTNJaU51c1V0cVFMdVlwSThLd0YrVzhV?=
 =?utf-8?B?VWxNVUt6OUZ4VHJsRTd5eE5yOTdWVitPSGxDQjhlWDA3dk1ITCs1Mk5UMld2?=
 =?utf-8?B?a1BUSHdJeGVxS1lKQTJNdlFWbktxZE5sdXhoVlhQcG9SUWdmT2hhVm1CeUZE?=
 =?utf-8?B?UDhGbjhaUm1zVDZ1UHczbU9vYlM5TDQrNDdqekQrR2E2S2x2T2xzNEZQdmZj?=
 =?utf-8?B?UHJieXh6NURsNE8wYURzSVlZc0dyWHFmblIvejFQcjJocHk2ZEp5enprU3Qw?=
 =?utf-8?B?Z0JvR1dFa0o4M0ZqWldvVlc3Y1hQSjJhRXpXRTBuY1p4RC91MER1bUl5YmlN?=
 =?utf-8?B?NUxNS1NubWZ6SWV5RFI3NkVWYzdhdjVGUWN6Y2lMa1lvckVCb3VXQ1JpQmRI?=
 =?utf-8?B?Ly9TN2hzTmVXNHBUemtiQnFkRlRrY2FBNENCblpoR0hydW1sWXc2YjBNVURq?=
 =?utf-8?B?VzBTN2YrcDhqa1BiZStpS0FUQ1ByQjZlUm9xZXlKaFlyNnFkZWEwNWFWVFJq?=
 =?utf-8?B?T3JBNGhrL294Z1pMSnkwcHFoRjZEWnRJcmh0Zys4WWo3UzkvTEUyUWFuUWp5?=
 =?utf-8?B?ejc1SlVJZWlxMm1VR2o1d3VaaXhGeCs4SXpnLzVJM1I1eFZqTkYvaFFkMC9B?=
 =?utf-8?B?NzBaU0x3aUY1bUFzdDNGM0xPQW9uTi9keHJqMnNXMndUL0NzQnl3YUZpa08z?=
 =?utf-8?B?cjJISmpXbWhuRDdLUFpiaUpzejR3YlhVa1FmSzJDSnBJbSsvaUtMMmdVNHh4?=
 =?utf-8?B?ZDdieTE5ZFkvOXBLbThUcmttMUViN1pMRTZEVGZ6ZDE1RTdjZmpaMmdJMmtw?=
 =?utf-8?B?RXNCYXJmbTMrNytTbjVaZVdNSWhRZXM3TXFXaWdDQnlwVFdlYmZBTFE3aFJo?=
 =?utf-8?B?dnVRSS94MnQrWDFMZGI5Q3AwdEhYTDNFbzBMeXRTUy9RM3NMVDlVazR4VUsy?=
 =?utf-8?B?bmJjVFNmaEE4akl6aGZVOVlJajFoYndzblZFdmZRemtUUVQ4dzVBblBlSzJn?=
 =?utf-8?B?NGJkWmcxQnJsdXlkTFdJZ2NVWDdDZ3JGMWtqZkdnb2phOHplRzlVQ0NkdzlJ?=
 =?utf-8?B?SmNzTFEwZCtUN25RUVFvdmVXbTAvY09kTnJBZW5rVHFTZ3BFUENkWVpGMzVj?=
 =?utf-8?B?K3hDWXdGTytndyt5VGpLMmM4dkJOdlEzaDJPY0h4R042cGhITGFWbUR3MkNz?=
 =?utf-8?B?aTJEaTF2NFRNaDMxWGJhYVpuMUVSNHE0OHdybWpyYnA0dWtSVFJBSGJyY3Jm?=
 =?utf-8?B?d29tQnVKKzNic0EvSVE3M0JEZm95UDdJdUtnRjFCSWVwdnIwM3Q1SlRucTMv?=
 =?utf-8?B?alVsL0ZhMVB4RHdlWlhEbG9ya1BzZDJUSS81M2hzaFhiSVcxVFZteGoyS2Vr?=
 =?utf-8?B?Mi9EK2pLdHdJRCtoQWQrZ2JVQk9sdzF2YjZmczlaWFlGYXRDSTFUbjJYekNk?=
 =?utf-8?B?bU01dnl4RVRFZnBQY3pKUDFvOVQzQ2tCM0dwWk9yYi82bUdZZlJQVUhHdm42?=
 =?utf-8?B?Ymk4Z2hPZkQ3WFBzZlQxOVRxU1c3YjNzaHdUZ0NjSERlSGM5MHU2MXZnSFk1?=
 =?utf-8?B?SDdZaU1oN29rZGJZL25jT3BVbDhMeitKcDUzeWN6OFBiTytSbTR4RXpRNFh5?=
 =?utf-8?B?RnlSaUY4SzJYbHY0eU4veS9kY3dqNXZETWZYNVF0YlhnVjh3ek5ZQjc1TXhv?=
 =?utf-8?B?enVDY0xtK3dXUnBOaktWWlVGM2RCcmxjNUJIWm94K1NpUlNaeVg5MmxndXZn?=
 =?utf-8?B?OGR6ZVY3N2Znei9QVTAwbmhGaUxGMENtUVpJc0p6eVdxb09QRFVnK3hLU3Ns?=
 =?utf-8?B?MTJSTFN2endGems1bEhXeUR6cURRL3VQaDcyNUgwQWluRHZwTzdOQXpUTXZB?=
 =?utf-8?B?QXFaQWdmdUxZWFRRSk1wQ3BIQjkzbWFFTU9zNFV6K1ZmUmVUK2tRMFhkTE1m?=
 =?utf-8?B?U0xtYUI0T2FiL0VFNWcvMThkem9YaXBMWWFVQkdHWVVDS2RtbS9lSzJlOUhK?=
 =?utf-8?B?Ukh3WEwvTHJISURWcjRzenQ2cjFST0RobFlTWUhHbzdKenVLZEgxdi9kRno4?=
 =?utf-8?B?S3pPZzBFOHIzcGlobmpyUWo2M2hqSmRvMXNzWFB2NURCcTNBY2JvMnBQMm5p?=
 =?utf-8?B?Ykg2blA4NHlpOFcyNkc3QjJvYjJwNW9Db2VXL0IzSDl4UUJEMnQ4L3NrSnNS?=
 =?utf-8?B?YnN4TEFxOWVxQlJDQmNMdEVmejVyQ0gyUzN1TnRQZi82M29sTWtEUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9833940a-bc5c-4950-9c98-08dec5756cb2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 15:48:46.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ/wP4dzHWrD79+UVRHFRHZZL4Fno1hVGJAY3BgKp48U8kXM5oMC5Cf0Q7uQpZg8imYqJI0nfH6iWsXwe0ipqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8768

On Mon Jun 8, 2026 at 3:36 PM BST, Alexander Gordeev wrote:
> On Mon, Jun 08, 2026 at 04:21:22PM +0200, Heiko Carstens wrote:
>> I guess Alexander will pick this up and route this via s390.
>
> Yes, I applied and scheduled it for -rc7.
>
> Two new files fall under the Rust maintainers scope:
>
>  rust/helpers/helpers.c | 1 +
>  rust/helpers/string.c  | 8 ++++++++
>
> Please, let me know if someone is against it.
> Otherwise, an ack would be ideal ;)

Thes string.c is missing __rust_helper and it is also missing a trailing
newline.

Sashiko's report is accurate here:
https://sashiko.dev/#/patchset/20260601174625.2910233-1-japo%40linux.ibm.co=
m?part=3D4

Best,
Gary

>
> Thanks!



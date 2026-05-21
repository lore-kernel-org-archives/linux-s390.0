Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020136.outbound.protection.outlook.com [52.101.201.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BA2E974D;
	Thu, 21 May 2026 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385731; cv=fail; b=Gahk5h2bkYFTVw77SuhWnCR72xUQSD1ze/yqYzmlBp/YsoAvsC9vAopKMSCqpUifjtyHjQ/pyE5yWnR7XN4lNbCry6vQfThhhoycI6tpazqUqepzD118xoTCslo09Rvl67MPSnw3/a50rO6OPNm0dF4iyZHVti7G+YAGk3G9YyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385731; c=relaxed/simple;
	bh=LDQ32v7Hvb/NvECTw17KCebRWTIoJHO8/0HxGTc1mZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJKG8KcMYLUPg4imn88E02r/azvHM9KNZS07d9+41Cm3nryZJJH7lKXhT/gkG4a1JoJC/Vf1qblRuDo7cLBqpGkWhxrl/AtCotcAlK6OK7NHojX01aReo0ji2ela5/dq7cHaVh/ZO0KnerP0sgNUb91GAmxwpvUz4u2+bD4m6sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nyXCAY/H; arc=fail smtp.client-ip=52.101.201.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nyXCAY/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5Ee+LWkZanbxKXFQby0dpwR1NDleFlzDql22y3tmrIZ2LcLRKDE7XD/d1CoHfy0KNJnjErhXDJVky8AB5I3YUEt6rhcUG7tm0AlIGoVD4icZBhzZdkDSOCXQFSK4S4+u+86rPSrYtBgMYaWHfaWWlewmt6mXXIVnmPMmjHgtbwqJ8CJ1p9w8mqdywDlb39FXEn2cxES3tpb1XAPRfZIetcDrge0aM8lluSCNlrSmLz8YUmJLM4N7IAxIOWbr0lK0kayLlND74Y2AzU2VXCD7BXwKUKtRpyurRZahyxse7Kzn5Jgk87aqWaZgCIks5108f4mQg62/279UeLCy753HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDQ32v7Hvb/NvECTw17KCebRWTIoJHO8/0HxGTc1mZM=;
 b=V1tsZaVPpxhXbMYdESIMOw0ex7a+zk6IkjWZbJaTVliJCW62mU4jE3cV73Om76kdcrrhs4bzWqRY0a/aXwYEhgGnXZHvI++5MuoEhPslPHBH8nSRx5CXwB5ZIkddASdQNSEx399gi4nH0dIqUGCCwvCy+yJy6KGKtRmesfbe7m5v58Jx5VmRle5yC7ovo2v36Fru+mHcFuKjwBkJNfU9pBog0sjYlxempyo9lvmFadebj47aPR6QPYO7Y8T0D3DL1jNZK9IOi5NnSuELinBc/YlwVxOUSZxFj/k08kD1ngc+T4LmrP5bYhCNQmXqK+EDkzyoOohriq/toLFvlgEeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDQ32v7Hvb/NvECTw17KCebRWTIoJHO8/0HxGTc1mZM=;
 b=nyXCAY/HWDQ1Wzf8ExZ7H5vnfuNwOxAIXCqLtO4hCsA+nt2fnAKbgBBse4z42T8OjyXrpdhrnMRWqkR7y+J3TABwLtKgJbZQ5R+gijaqTDfe3ovY59mfPQkfL3dRVdMhP5dZ+5pRcC8jVmK0Ml5Uk3cuDV/hR0pEzVvQpSeIxGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6538.prod.exchangelabs.com (2603:10b6:510:77::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Thu, 21 May 2026 17:48:47 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 17:48:47 +0000
Message-ID: <dbc80803-6a3e-4e2b-8690-dda6dc0267c4@os.amperecomputing.com>
Date: Thu, 21 May 2026 10:48:42 -0700
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
 <20260521112325.230959c9@pumpkin>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260521112325.230959c9@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR22CA0064.namprd22.prod.outlook.com
 (2603:10b6:930:80::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: d577af6a-6674-471e-119f-08deb76135aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|55112099003|11063799006|3023799007|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9fDdtIDroDCDaaiIpUzL8ZjLxwg9zWOECoLN6MV6CoAYdDqoSQG63UIJMoNMggiisR4pcjwhcBtEklXAWZutVsJ9JepZclrCqVCcvtG8Hg9rq4SBLHE9agIaq79aqPhZ1A3vD0uslS/xDg5KiQIsxCfXNsu4958AMVGr/MIRV1itpIMLKfw6mDwsj7j4nBOSn4gqYwk/GNhiG5hqHdgWEWlSCRH17IrsRB6hF7Rua0iivL2rnXQFsfh+LiYI0RThLHbdaD6GYdf8cpc6tRK7bWkn+Aj+h1PqdFAZ8Pt/5iH4peKsmaP/5iMJc4p25fR4z1W4cVGUbpa1SOg55xrNYdcaE2gvbnRtlsrCLNXrm0XRVcqwXjStKgFT7plWi4DRptlyRUM37hu++7I/rbwDiAHauQ+xRuxkVSpo/EdxgavCAdl8mxgwONxh0vWD3jwOYEVJtQyCmu46hTvJYFPRY/mU17ygwmBQJ2CKsIyTgQEzPexEeDmyHnBmbW9Ag4BZ5IjNtjEOsNONOW3d8dFsIP0Ktl80jj1Y/Z+Uz6vN8fPP+jNYKxm0TqxBj7QK2D4y6ArRvWANo44HZjic1FAK4wedd4IJHD6R16nGnVJZ4TBwBuIX4ShO6hCm0qUdFKSguL46ilw/7pvOdm4jri6LDROKdx9ikOEpb8JSrfW57FHZBKxP+PGGssnNa/X8wiZy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(55112099003)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFNqNERwVGFmRkg5eGNCUEJob1Y1R3ROUFNsaEZCR3liVEZ0d2o2dVZpalpS?=
 =?utf-8?B?YWVOb3krNnBVY2xGK2ZrNVlGOW1ldEN4dFBKbEsvUzVyYnl2djlJZFZGclBh?=
 =?utf-8?B?VkhpWjFBVnJrODI4WXJNZk4rdGlVOGJOUDYwdWpJVHBwWlQ4cEM3TU1SZnVO?=
 =?utf-8?B?T3k0RzdDSG1hQTlsS2laUWZrcWVHMW1SN2FJT01XSUVNKy9PR3NZOUdrcDUx?=
 =?utf-8?B?Nm96SWJJNUFmd0NKZU4rRWliNlZHaXlGdjBGMTc2OFdISlJpVzhhUUh2ekp3?=
 =?utf-8?B?VmlnTGdjWWs0WTF1ZENlQUlKajV4VmdkWEc0ZDAwYlhEVFhTR01FRC9SNnAx?=
 =?utf-8?B?Zy9ZNFZaS2M3ZTlueEh5cEhPVDRlTVdQV2Q4SDh4SGRYcFJhQ2t1V0d2dlF0?=
 =?utf-8?B?ZHNKRHg4VlpPSDZ5cVM5ZE13UE5sQmdUSnRhYmExUXNDYW5reGxRTXI2eXZn?=
 =?utf-8?B?aHYzOHdXTmhuYkNCVEllZm12TjVGaDJzYUJKRHVueEhjaktraVhQTnh6bWVG?=
 =?utf-8?B?Z2c5dmoxM29ybWw4Tit0Vk93QkVHVUd0RUhHTjg5VW5QM2VGWE0xTGFUTk5q?=
 =?utf-8?B?RnpnSWxncjhHTzkwdEFtM0JlWUQxWldWcWYwMTlrMnQ3K05XMUxUVUVhWmdG?=
 =?utf-8?B?bHZKMDIzamkwWjM4eVNlaEh0M1UvTkNpQ1QrS1hiaDRvM0JtMllPa0RPdXdP?=
 =?utf-8?B?ekgxaXpFYXBVamZWUTY4eHFmVFRCUVRzQU1wMFRRZmQzMlRZMGZYMG1HYjZx?=
 =?utf-8?B?bGQxYkY3NkpsdjN3Sk5ZM1QwVWN4UEl5TkhyMEVNUXZGQ1hmQzhsS3dxNjlV?=
 =?utf-8?B?dmhaTUF2K3Z4TU9Qdnl4cUhqYlB0OElIVlNRMUtCMkkvRDZMRnRVZ0loVHYr?=
 =?utf-8?B?cEQrWVhLT1g4VFMyUnBiUFJjalQvalN0eTBibGs2Y2hkMlNzSE8waitBdlFh?=
 =?utf-8?B?Zy9rdlp5RDhRSm5Xd0xOaG1kb0xicy9mc2dSaVY0WWFZTlUvTS9WNjlhZGpK?=
 =?utf-8?B?cFVQbG9wUmdxY0ladmNrcTE2WXFPSVBHUEVsMzdsS0xtU0lSSjdFTUJReHRs?=
 =?utf-8?B?QW1DQkQ3WG1IV0tUaHhuemdYTDlSNmgrWlJlc3JJb0kzUm9VZEIxVFJTeWV3?=
 =?utf-8?B?UDR6MmVEMWdsUHBkZitMS2FHeXdZSThkbWU3OFhrSUpJcjhqY1JLb29FMkhI?=
 =?utf-8?B?eE1QZDZhNW1kMHpWYUxvaWVYS0ZJaVYxditBeTV4aEMzZjFUbzFKQzVaUEpz?=
 =?utf-8?B?bURSbVRSa2kwVkhCVlJNamdqNlZyRFpPc0VZRzZnb1NTOThmWktJenF0VEZz?=
 =?utf-8?B?dDZyK00rT1lkTEZpWkVoUys2S1VYWC84WmdHTjROQjJjZm9STXh0NEJBbXFr?=
 =?utf-8?B?NXh3MzVKUzI2YW5IRkMrdWZaMlhRbTVtWHhSNjRGREU3MFdLWXB2ejRsZlhi?=
 =?utf-8?B?M2U4MTNNcWdDeUJzb0hHREdxU3cyc1R4aWZSWG1NVWhrVlNjb2pjT2V4azBu?=
 =?utf-8?B?akdUbXhCT1pZVVA2OGF0NmhOSmV5U0dzTk51ZVhXODZuQlhEd0xQMUc0T1Fv?=
 =?utf-8?B?bHVIMU5SQndWcWJ0MEpueXM2ZnFMN1VRekpDMnVhak9xY0RHUS9oN3FYRjZl?=
 =?utf-8?B?Z2s5cFNLb0RoNmVEbEloYjN6Q0lyVnI2NzNGRGxNalNpQ2E2QVkwWC9FT2NE?=
 =?utf-8?B?QWJ3ZGRoRFpPc0p5dEJLVUNuWlk5V1JUZ3V1WElmL2RkdENYTk5kaW5DWjk1?=
 =?utf-8?B?NVNDZXYzc0kva2poaTJtU01xQW9uYStVb2tmVkUyZUJldTdCYmlHV3YxVGk0?=
 =?utf-8?B?LzUzM2RJclVMN3RuOEpQOS9DYThMRERQeDMySGQ0REsvNE5CVGNoc1BkNWtl?=
 =?utf-8?B?SXZScDhEb0RZemNPK2lLeFZDMEl5YUZhODFlNU5DczJZUUl1d2FvbndmWlF6?=
 =?utf-8?B?eFcvZUcyWGpYM211d3E1Qi92MHVramtOTGhta0FlbzlCS1BTOGZDeHJkN1FB?=
 =?utf-8?B?OEpqZ2dNZUR0bjRsYXdRQ2xPNkxxSEg2bUxic3ZXRWsvN0tJYy9vUXpzeStO?=
 =?utf-8?B?QzB5TFZhTXl0YTM2OUYzdlJMc3hrTVhnd1JwcTBGTUlsT3UrTmJ2Y3pHUjZh?=
 =?utf-8?B?TXJ3Zit4RkdNQ3pna04yTDk5d0FFNUpiOXYzR0x6dG9XWCtoOEZ0c2NZcTNX?=
 =?utf-8?B?UVk4V3k1dFg3RnZXSXBOcHp3Z0FuWTF3bkM0dEQ0dS9NWWlKYWxBdW8vRnRo?=
 =?utf-8?B?K3NaVlcrZ0g1NHpoMHdldWc1R3RRaUN3L0kwSVBFc29XandHNE1TWXo5dnA1?=
 =?utf-8?B?RnJKbkN4MFhOM0FYZmY5ZWhocjFHVmJTT05mK2g3dTk1NDFVdVJPQkY3ZnZt?=
 =?utf-8?Q?SDdZGEtu6VCIOFoU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d577af6a-6674-471e-119f-08deb76135aa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:48:47.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP5PIe0z1eP2s+35S70GB3v/PCEILpiBd3b1sOsjz5xcSmCWCEeJ9itYegi9IB8MOKiZ5jJbS8yR2Y2RTRLMpqZwvyyjz3+iXxcsNREmrnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6538



On 5/21/26 3:23 AM, David Laight wrote:
> On Wed, 20 May 2026 17:23:37 -0700
> Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> On 5/20/26 3:34 PM, David Laight wrote:
> ..
>>>> So it seems have more overhead than the percpu page table approach IIUC.
>>>> We don't need all the steps with percpu page table. And there is no
>>>> penalty for migration.
>>> This code looks like it relies on 'page zero' already being percpu.
>>> So it probably isn't really that different.
>>> Some values like the 'preemption disable count' and 'current' could be
>>> (maybe are?) written into page zero to give fast access.
>> I don't quite get what you mean about 'page zero'.
> 'page zero' is (at least for some cpu) the memory that can be accessed
> using a small offset embedded in the instruction.
> This is equivalent to using offsets from an 'always zero' %r0.
>
> The code relies on the accesses to 960(%r0) being per-cpu.

Thank you. Heiko also elaborated it.

Yang

>
> -- David


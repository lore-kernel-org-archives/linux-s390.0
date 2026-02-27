Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020092.outbound.protection.outlook.com [52.101.189.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85639525E;
	Fri, 27 Feb 2026 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199604; cv=fail; b=Uy+QT7r9DKg8FcveFizp5ql657JNZv8zyUz1R8dsZc75xApNFMFC39F63KXfHxAezeK5VCbJxz37IRurHN6bldCLerqA1Tlf486ERucrDP/TYugqqKixzKTYynmx/CCjUAVqviKSIp5P9byp+IFzkMHekJz1oHcrGMj3eBUk6Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199604; c=relaxed/simple;
	bh=KMoidLxEI73V80KRilJlv/BQhkTZZz5o6i7CJUPpuco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qtv867bQB/VG/Bv1iNnkdoN1MmI1sPnubL/ntBAK4BYjvlye5gQc1w8ZTsZQEdVPDZ7jSfvMXk03CJR0vvlUltIFp+5EJQJwetfyxITVHAwoeVjntezhJ41rA5UuK+zyl4dVyxHGOEEilWAbLR1rXKRItE3wzzpMlR2kE/kiGqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iPSsmoXP; arc=fail smtp.client-ip=52.101.189.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iPSsmoXP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWb15ub4xQk6rgatEzMQJ81IPRrJtl7Fn69EF90jObMeNAC+YweZ2F+Ud7d6A9W9FSYsa1MU8C2O3zekZ4PYHCKIXebQcd9Ghpc1af0AHuR8KpKLZFmVbJsGJ3DRw3FpLPm0F/nKsET16GX4PSOelE92Fg37yKcTIoxSynHdDRH4e4PL20/ICK9mIr5TXF4DhxWfnnOdvj+x9F+it7be9UuX8jF9hR5PMxkyR29zCZn2yIyBAjl2vF9vdVImQdYjU0UQW7QHNycb07WT6zyC2ui1EoRNUXiXUGhGTvT+NIMmNsAyVg/DIbcWKDe/9lh+kPoEmvY4OonK+SpTiL/XBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX/8ahxcoA74Y5u0bBh5Wvjfe2K+5R+F1bzTaUOdXEk=;
 b=gM0T7g/2m98gHO40DCAkgIYypMh14sLyL4Xgk/+U6xULw64R0VqPaujNhsGyqF3sPBE2TVsnLVVYfDU1cDahdBsxddl8jUGtX2PTTleMxNMHlGwvo4yxb8JDQVkhDJnV0ZlXde4/KV6MQqU4OmHXhqPdX3nLeYBtXHM53ViwkLl/9o6uQysRFVZ1ZImhGBIJ2e7y19p8RO/V6w45eSUaPfCtZDylvIhfGAfC9/KkIvifSe6khraLGghRo6Sc6IzEi6OjLefAB4WIWHXMel0sJJJJQ3sxkdsbKTyLoShYpOXG9SI5dt+C78RjcTzskM14UHOBEtHPXYiI4EUlhY1lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX/8ahxcoA74Y5u0bBh5Wvjfe2K+5R+F1bzTaUOdXEk=;
 b=iPSsmoXPqqgpuWMwXMb0zIa6G4kCScWQAPvdhbFCe7k5I1c9NCSIx9IOYX3PXTXo5McSlRinA6dou9VmhG1YY7BUqotnDTssz+yDKQ5ck+skiextx36J8GTVYuGDZuCpEPOVO4sDHvIlyLBgcggga3hGgyMfX+fSjkGeni+I26y/JEQKEr9A1D1nAHtgKxHyTQXPXbOIeli6w5jbvHDhSEO1Fhg8k7zlfWMHm2Qh0cznObUbwxbSmo3sgoZGa33ascSnYpS33kPe73sePaoNb4/m+w8fKsrA6iXPdCMfWyvbwk6sGMzyyVWF3A9tz6/yrjz7cT3FIwpLBn4mwYMHKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9367.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:39:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:39:59 +0000
Message-ID: <ba28201b-980d-409b-91ac-502a8e381709@efficios.com>
Date: Fri, 27 Feb 2026 08:39:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/3] Improve proc RSS accuracy
To: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
 Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260217161006.1105611-1-mathieu.desnoyers@efficios.com>
 <20260226120422.8101Cc2-hca@linux.ibm.com>
 <59b28cb4-4fff-4888-b562-7b7236e29d27@efficios.com>
 <e0af317a-d6ad-4de4-8bb1-215d5dce7351@efficios.com>
 <73e6fea9-caf2-4404-b511-11646013f8db@efficios.com>
 <20260227011201.GA1577380@ax162>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260227011201.GA1577380@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: d17285c1-3c1a-4fcc-ea38-08de7605b366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	cWH2j4CRQfcWLBYpHXB7XYhx/JMz460fQj6xEsdG/GXimghSYDWsUzMUDvEArI7VcFkZ4uCz+gTCJjsc6c7Dq2fuUFFcgUZRg/BTi1OiGEWfidnN76S0aJhwzhZie0/QM6hkZ6O0IKqij+fzfYUoV95XaxSyVLIX12B5JBXT7noWBWAheyIbN6/TruPLy8HcjzrgfqExVAcDvztGjlOOREXqf64ifGojQn+XH5YgrlHZYCvXfP87a5dvQLcDr+nefBrfDH9DCzxBxmmu29sLdP/m7NVJp5aLGVKZzfubmKWXCz5SdXw6e9j1C4vTnGuM8IoRnfg7HZAjJERI0zcl8FMfNA+xq16RS08o5jYaMitvSKeV2ZMvcFqfMAwfN3TUrpyHQncacUblC+HHNSyEtQfAZ6yaZICUnZGgN1BSrFfq2yaP+wRbTLdoaD3zUIOHDQulZMS4BlaeDcYkyN63+CX0O+Z8f9DB9KqY6YcIMKRtDq9O/6xZlBZeHTio7eR80Hded60Bscq4x39I4MC9nTWvXExj8BpD/pr/QZc2PqvBnoAj8K+uMeSn5Ctja1auFXRIVpjF2eYXv5DdF5ycJuk4d1huA/0EBTlZH0iBUmeL2Te59f+9y4NaL/c4xbaXo4DcOMcyJ1UKMIdDj950sTy2nk8DLAeLsgOt7oWmNNS8ROZhkUob1KxCcYR6Euhr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFZZdDVDWURVODdYVUQzaHFQR0htbnhVZEM2TEpWNDEvKy95QmtlU21ON1lJ?=
 =?utf-8?B?ZEwwMDdkTVkwSnQ4SWlPQmViZ21qU0pPaGNIdjByWkJwV29hY0FDcitYNG1q?=
 =?utf-8?B?V0tDRXRXZlM1QU8vVSt1a1luMDFyMjNIUjFiN1p3MGRqbkZySC9wbnhtS3Vk?=
 =?utf-8?B?MzZzdVI4b0NpaCszSzVKM0t1K2pnYm9ScXhKUVloUmQrczZaWXBHaFd2N29z?=
 =?utf-8?B?a3BkSGpMTGpQZW5CVTdXdW9STUtIdlYybHQxYkNob29tUnVqYjVnYUY3RTNQ?=
 =?utf-8?B?eDN5enpoS0FDa2o5SkZRVzAwMDUxd0NBZThVTVpZLy9odlhPSUhzUGJHVUtt?=
 =?utf-8?B?MHdBdG5JRlBEZC9BMG92THVmWTNHV2w0OGRMc2R3N01oQU8wN2VQVUI1Qmhj?=
 =?utf-8?B?aXYwK21YS1RTMUJ5cTNiR2dEUUtkenVOa1gxRFhCV3Q3ejA4OGlmWkVvQlhr?=
 =?utf-8?B?a2hNK2tvQ0ZZQlRUY0sycWdVSkY0UUw1L2MwSjZtRVlsZVdTWFZYTzQxL29r?=
 =?utf-8?B?cWEySVJIMVN0TS9ZMzBSUmxnOEdLRmUxaUx3OHNJVmwwcDliMXpwdHYzWnFK?=
 =?utf-8?B?UGh6MDV6WkpiaVhyVzBoaXVCd09rMnF4cXVFQ0h4Q2RPcE1PZ1JaRU40L0Yr?=
 =?utf-8?B?RjhJMUZjWnZ2czNJd1ZIN2gremU3dm5DYTVtU3dUSGlWdHR3c1pYb2JmT2xP?=
 =?utf-8?B?ZFhmVG9WL3paT29FMERrV0l3UzhJcjhCdXdMdlFkZE1jV3FVZC9ZUEF1WFJa?=
 =?utf-8?B?WFFBdlhWWGZxa0NoQ2NjVWFZNkFFRUhQemQwaUZnZFVvVDBHeExPQmFvSEJi?=
 =?utf-8?B?Um1SZ1BHWXJmcFJHL2RVY1VhcDNMb08yNDJ4NHlyRXVaSDM2RitHVkdJZEdi?=
 =?utf-8?B?ajVqeUVPSmNheTNpSFgrZVAxWFFDUlExRHhCdE5oakd5R2NaVDZGNG94YTRi?=
 =?utf-8?B?WG1ZK1dFdGtPa1pSUXNQeHZFMUhmOGhiZGtrNWNJM0RGS21lQUVGVExwS3gz?=
 =?utf-8?B?d0ZaVmNEeTc1U3Z3YmhORW5GTkR5cklONnZpaHBuVnN2RitGOENsdkFoaGlQ?=
 =?utf-8?B?U3UxNHJMZ3hIK3JNMW8zamVXaEJvOFRMaDI4NEJvdWk4aGhpUDdaR0VaYzN0?=
 =?utf-8?B?VFQ0S3J3V2kvMWhtZGwvaUhtTGVHSVc0UXFjV3VrY2JxV0d0MFlmRVRRY0lv?=
 =?utf-8?B?azYyRnI4Tkh4UWhtVHhvYVZDWVgzZkFlV1JYdDBDbC9ITXltRGNYTUVxbkRO?=
 =?utf-8?B?enQ0RERWMm4zY2JXTUlMOTQveGphRmRydEZUSTJGOVVxTnc1dm9Zc3A0QW93?=
 =?utf-8?B?NDdZbjNJMjBtOFd3V2JaZE1xRDFzWHk4WjRZMFZZQlhQY2dsNHFVc2xia0Mv?=
 =?utf-8?B?cFdFclUzSUVMdms3amdKWG0vcm11TXZGbi9pcnJPRXpjWXBhWXN6N2g2eWF5?=
 =?utf-8?B?OXFlcktZelYwc2hyVEt3eUlFUHozMmNsYUh4WHNHQUZCQlF5MGxQbzNTc0dV?=
 =?utf-8?B?MDd0ZHZtTEZsaVlxWklnTGNDdDBJNWRyUlhYRFVVcHNaZWpRL1NBMlFFaVVl?=
 =?utf-8?B?bXZ4WXFMN2NPbThycU53ZTRwaDR5aWVJZW1sTXVka1prUVpaOUQ3TnJUZitL?=
 =?utf-8?B?bkJtVTJCT1NWZEc5QnZVaGd5Umo2RmV1c3dYaVJ6aWFXekEvZ3o2R0gwT203?=
 =?utf-8?B?ckVKZU8wS1ZTdW0wSWNnSTNlZjBqczg5aWMvanVOakRmRFVjNzNzUmtmZ0VV?=
 =?utf-8?B?dVg2bTI4Y1B6NlNFK1A3N3BydGR0RkNKWnB5VnV6N3RyajdPZnZCQmNPUUdC?=
 =?utf-8?B?dTFYNUVtdXlmZEZtd2lyWTUyb0l0ZHZma1Jldld0U0YybjVXUDRudnd4cmdS?=
 =?utf-8?B?aU4xZTc2M0hCV1BHUHNHeTZuMG9kMlpubGZORnM4L0tRVGNwM1ZpVlpkTEVC?=
 =?utf-8?B?aVVycHB1Qml2ZmVKNXNMOXZIcWFzdktuNm1aZlVVc1planBjR0JNd0RiRDc0?=
 =?utf-8?B?ZWZYRHUrVHdHMTBrQ3BsSzRzR2tkZWkvcFE4NExvaW9sWkdHY2F3ZkpSSkxi?=
 =?utf-8?B?L1ZuSytNRmxNTFh2Tm1MaUlONXFRTEF2VmJsSlpYekY2VlVteU5nZTZwTjdW?=
 =?utf-8?B?cjlidnE5Ynd6ZVRSczVLNFExeHZoYStUaHEzUENsQzB1bFFDTTBlc1ZGcE85?=
 =?utf-8?B?elhaTEJZbjBjQjIreERmU1c3MW9Hc1htMVFNbEtEcjhkRHNIUjM2ZEphVlFv?=
 =?utf-8?B?c1NoelhqVXhFVFVLYytyaktDQ3h6NnYrSlFQb0hwV015b3pPb2xybmdlbDN4?=
 =?utf-8?B?cTFjeXJXY1NVUWhTYmNOVlJBUmRKRm5aTU13VTNka2Nna1pGL200MXFuS2lT?=
 =?utf-8?Q?enTPGCGj3ImIWcEy4lgoyh0LApTdoEdflj5T1?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17285c1-3c1a-4fcc-ea38-08de7605b366
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:39:59.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn4v97aBb15SNgbNffJXy224axgNMak2d0JNC/aqqNd0DFeHd7tRIkzLw/cCaYiJX9G4/eFVa0knXYzsLO5egCmGIgxzPpUq+oa1dAzT/90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9367

On 2026-02-26 20:12, Nathan Chancellor wrote:
> 
> FWIW, the ClangBuiltLinux CI sees a boot failure with sparc64_defconfig,
> which does not appear to be clang specific. I can reproduce it here
> with:

I found the issue with the info provided by Heiko. Thanks for the
reproducer!

> This series is not bisectable to see which specific patch causes this,
> as I get
> 
>    In file included from mm/init-mm.c:2:
>    include/linux/mm_types.h:1419:57: error: 'PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE' undeclared here (not in a function)
>     1419 |         [0 ... sizeof(cpumask_t) + MM_CID_STATIC_SIZE + PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE. - 1] = 0  \
>          |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    mm/init-mm.c:50:27: note: in expansion of macro 'MM_STRUCT_FLEXIBLE_ARRAY_INIT'
>       50 |         .flexible_array = MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm_types.h:1419:10: error: array index in initializer not of integer type
>     1419 |         [0 ... sizeof(cpumask_t) + MM_CID_STATIC_SIZE + PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE - 1] = 0  \
>          |          ^
>    mm/init-mm.c:50:27: note: in expansion of macro 'MM_STRUCT_FLEXIBLE_ARRAY_INIT'
>       50 |         .flexible_array = MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm_types.h:1419:10: note: (near initialization for 'init_mm.flexible_array')
>     1419 |         [0 ... sizeof(cpumask_t) + MM_CID_STATIC_SIZE + PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE - 1] = 0  \
>          |          ^
>    mm/init-mm.c:50:27: note: in expansion of macro 'MM_STRUCT_FLEXIBLE_ARRAY_INIT'
>       50 |         .flexible_array = MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> prior to this change that removes PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE.

Good catch. I will fix this as well for v18.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

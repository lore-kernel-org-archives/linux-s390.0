Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020116.outbound.protection.outlook.com [52.101.191.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51800242D7B;
	Fri, 27 Feb 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198755; cv=fail; b=surh4gCc2h/5S6Bo0XA4CokHOjWkMGDUhZQ02WZiW2rE34dAe4lsM5R5IDgsPltGLKGwb2DUhfnJgekp6TUqjjK26ew1F1Jdu1VNmHifAzaQMpZY6XIZpzhTCsJVXpDXq56SXKv1YzJcE699Q1fok9vdMJPo3vNyYBsAk4MK3A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198755; c=relaxed/simple;
	bh=pJNrShqsr6H/6IKYFsWErn7TcUY8DCuAYFukqKH9NV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oh3WQAgftInbf6qAq369mlXAycXOJWGQNYc+gLzjM2VTX1PhFwS3mpu0SjqBNU8/TaBzNjIC60LjWqpmZ9wy9IsvVjZxqWV8J63dP6Dqs6kW4azITBzgjhUqy3iXk+O6I99iiCxC3/OahLdwHuM7AfctL6vu+RWbi9rtssLZk0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Lts9i245; arc=fail smtp.client-ip=52.101.191.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lts9i245"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCJpnbhcRH1GS94sOV0PcIgeSMElZBgBeO6k0bkNijhv1Rngp1FT1BNXN15qxGBAiibx2lNfoaJwLTrg/RGNdLoPItn3zs8bs1gJo98xQZnlouG0N/58jcT199++tZnM6NjERW4cOh1a8WRyJ420Nn92+DAv4XcKbnnJzy9ByJiacgur3yeFIDEqSBkN3yjBFGkSSGLQmNNq+njoDEdKAFPq2RLpeolvU3FCTchDqSb3UtFzml7EJtEkpl3oWn9rbTJ6zZUodCOLVjk5t47G6ItArzeWHf/UFYc4qJtBsbpkSggF8J/yo2vajH08vOeFfgQBRATzBf1/E2NKf3RpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dju7i6PdZpTIpt/qgRK7r9fndbFvfPpgx13L451XVY=;
 b=kUn4wS9qsQkZHowAbsZRKmbT2PzIWcevELVDJ1SUkeU6d7kLxC03z4Xa5muJXhUKO/lvElsB55Xz4oqPI62D0E0iAY+DHbCChO/qlKClpjfTeA19EvZn6huPJJH/Pn5FRtZa9zYoDE6dy5FTnaZLM3RZf8J66MH8Um/+w3w5yqOfjhc9tIVB3z5EQZmOFSRpzmS4MdSS5MWpTs5Qu/pAodS6vlgPB0sywaXjKF1ffYnel9/TBAOEYgTzR8nbdVPoBWKSG+x5dMd2TzlHLaiSVo7oQtNQmbe/5wbSJrw8MxRISh9RO4Xm3/K54837N9WZUZV5qyICANzizyVGOkDPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dju7i6PdZpTIpt/qgRK7r9fndbFvfPpgx13L451XVY=;
 b=Lts9i245p6QA9ZXmL27mXGQ/PuxCF7Blw4dbx6rOBeaD4qCzvhWK994oynv4/h7wWbaYxRnLP8P3GkXFWQ4Pm8D7XJzhHAmi5ZA4hBv/RMMJxzsduibgfkuyAzFqZ/2QyvvWVRWTkTySs9HeJuL/UyDnGVB70FnphwCQRjEVb8a1QPOuR3jFl4P6nXYfvdPw6puPxc4h0B5pFNVz//xWeS0yzqtJgjCJpw4vhHmgJkG2jlmbLc3uQPXshZ3hyUE4oUBkxcqv3m/a/XVUqLohiy3JPAZvxg1CX95jL1zLOK8UShNWX5aQUMXt5EVRAhzhqL1M/w1j/LLiWgpeMBwEUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8351.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 13:25:49 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:25:49 +0000
Message-ID: <b3447e37-89a0-4482-886b-dde87733fb86@efficios.com>
Date: Fri, 27 Feb 2026 08:25:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/3] Improve proc RSS accuracy
To: Heiko Carstens <hca@linux.ibm.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
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
 <20260227011201.GA1577380@ax162> <20260227131128.10882B8b-hca@linux.ibm.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260227131128.10882B8b-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e21ef41-5972-43e6-b077-08de7603b8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	zQhqrm4vzTzmTMXHuvsnE5cGJSQ82fY+NsDVpp30FVlBhTtXKF/WsbhsEQruNqNBI9hV8YmeLFl/LDpVuUfQsZv/JgjmHLZbi7DW5OHV9uK+cCYpM7Ayvkj7s87Uh58BHi83mb6WBmEMMOI/I3FGJUq4jw4T4RWf9P83a5+knCZpRILYj3HCE5bI+h+g44YHqmZgwU6F8HPl32y+LoXU2hEWCLNH0L+yt7BFUuVMYWA4rlKsModGtyt8PH7weH8AvAKGuqpnP1gg5su4m6uAagY4fIjO5XzmnZUdJDHtdvZeiyDhFRt4rZ/IWLrZk5CsAE3Ks81R2g+2whM6Psa/PmEt672Ayxr80WloNbLiuhfS+UHOcOQzXoFsOifJdsdl/mbBQLncUl6YGmE3IgDFXgUdHxDCJLAHvooRUOhTqZ3MERN9l9TBXzf/pKhwqG7ZX5K0e0hg9GKO1DFeQn8eagJDkhq66iE25OgKEz/ZAx0fK0Z6qC4+UMMjP6g0NHwFTkX0sKAdu9iT492DL8W7VNUVLTe2LDCqquOyR/ZIWLuxkN8txuLzomtX12SkdWzjkmbEk6y1B9vS7oBoX4sLRj8rDhJGfOhpGkoI9gaUkxK0Sr0lipamQcg6gQP3f2RsPjVinmsaNeiS2ETYxI8bAjVhn9kIqIyokh8Rv2nS18xd/PKN9uSdV6pNMbO4zgZu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXh6bFBRWEJGOG5TZVdGeE92a09tV09vZXRCcHlMV3FsKytjdWFnaExFZ0dw?=
 =?utf-8?B?QUU2SUlveE1BVXRwSFVxWnFOUG11M3krcVAveGxYdUxrN1ZkbkUzRVVQek94?=
 =?utf-8?B?czBudS9DaDNvd3FheTVXRk9kMUJ4dFVNeTBPL2ptZHVHNDBvblFlOW9SQzAv?=
 =?utf-8?B?Q2NPZGw1WGpnejFzK0ZyS1RnNkxBSWIyUXlJQjFGdDRsVk8yR3E5VUFBRlNw?=
 =?utf-8?B?bUN0U056YXhMSWFDY1I5YmduTDduS2tWaS9hZGluTDQ3bWoxc1RPdnhxaDJ6?=
 =?utf-8?B?ZktLei9nUlhVSTFRRm9LYW9JZ2Zud2QrdnNpdWh1akpMTEJGRk55L0ZDVlpH?=
 =?utf-8?B?dGF3YzZNc21jcWtDbW9GTDFiR1lhVHJKY3BYWm1KYVI2ZUtkcFJhclpkTVJt?=
 =?utf-8?B?Wm9KRUM0ejhOVFdQcWU1ZTZhaUVFT1kySGhPNTZ0U0c3WC9Yb1RodDBjOW5H?=
 =?utf-8?B?c0FaeVJsM3E3SGVtdmZaWlB5TithVmJVNllML3FIT3J2dXl6cTVlMkVrT0Z5?=
 =?utf-8?B?d2hjYXNPeitCOFlUeXlyeHRxUklHVzRKUW16WDJLQVAxTXk1eTJFaHZIWThM?=
 =?utf-8?B?SVB0L0pWZlVJckJocjYxYjVhZ0pCeFhUaTluOUdINGg1L3hSODd0S1lWcE5D?=
 =?utf-8?B?bEpmTlFHaTl6NVVSVlA3YVFieUtoQXhNUnNXbk1QMDBvSm1BZXJrUWt5UUIy?=
 =?utf-8?B?T1ZnQmRHcDgzRGZzZ1ZUYU5YVGs5VmxZSndzSHNWTEtTc2FRazVZaUNITGtv?=
 =?utf-8?B?dFVoYldVQkhMdkw5clMycEU2ajFYMmRFSEc2ekM3b01SVTRNZ1kxUWlHdHNV?=
 =?utf-8?B?aGx0ZndEN2dsV3dvMEJhaUMzRThtV0VTTWVuWE5jWFkvNXcyRkRlZ1VsS2lH?=
 =?utf-8?B?UVdoNFFwQmJQS3lXZ0xsZThXcHpsR1U3SDhKMWNyenlLRlRpK1Z6ekJDaG96?=
 =?utf-8?B?UnlValQwVlkza3RmU0RlTzFHZm16MHExVlpQNDFIYXRuUFdKNWh5Tk96OTQ3?=
 =?utf-8?B?Y1ZyeVQrR08yWTlHVXNKTFVEOW8zYTZlSWVWWFVveTBYd1pOWlMyREZkUjZJ?=
 =?utf-8?B?R3RoYm40dXlRK2RQVExtUXFqV2VSYUdIRURKZGpaT1lSRktYUWROYnhLTzJM?=
 =?utf-8?B?emNnMmM3VTlhdFlrSDl5cG45RGMyMloxdENRZVAwc3RPdFI2UnJjS055L1No?=
 =?utf-8?B?VWd5TE0xZnY2S1AraVJaT1ZBSVJKR3BEZzlvWUdaMkc1RzVjQWFzRHpXRTVp?=
 =?utf-8?B?RFFnS0RlSlZ3V1ZuMDJuaGRTQkpNS3FOK2ZCaVp2bFRxVlNIVGtHOWNqV1dw?=
 =?utf-8?B?SHJEQTlkb3Z5djFYclEzSmJDL0FJbGkrNnEvR0dCaHhMZzB2VmhsdHlvVWNH?=
 =?utf-8?B?cmdob21ydUIvZEJXcmtMa201Sk5RN0hLTGhJVXh1TVpENWU4UUZQNHd0S1JK?=
 =?utf-8?B?d01JODk0T0xDdzNPeWF4c1ZpOG9JWHFQYS81Y05UbUF5dUtWQVZnTXRHTjla?=
 =?utf-8?B?ZDUvTXBqSjRtbFVrK3ZtbUxRTkRoS1R6TlVLT3VSVSs1MlJTOEh1U2dURGtU?=
 =?utf-8?B?bEZrU0tXNFU2WE1VdEt6TWVmUEFxL2x6Z0JRZTZhSDhhZHYzSEt2cDFsMlE3?=
 =?utf-8?B?d1NUemNqZUN0d0s2amFHZ3FBbFF6d2NzZG5ra3BJTHRyUlBaZUhiUnYrMnU2?=
 =?utf-8?B?KzNKdVNsWWxWYm1WMHo4NHpnRi9pWisva1Ewa0NuZG5JMldXZHJFSTJ0TzY0?=
 =?utf-8?B?d1FmUTFmaHFvSHc4cFNHbDQzb1lXUHd1K01UUXc2amdnaEFsVzREbFRWdUhx?=
 =?utf-8?B?TlcxQlJjT0J5TURBS0dJWUxoKzVCYTVwZmc1RW00VTBrVmtRTWQ2YXJIT0ly?=
 =?utf-8?B?cStvek13SGdxNmhwZG93VWUrc1lmU0NMdWNNa2p1STh6R1VIalFVTWI2V0FV?=
 =?utf-8?B?SmZWMFlGZ2JMdkZlcGhWbjVRYjdHWkJFWlpxS0tmSitLM25NTWJQb2NORTFE?=
 =?utf-8?B?MmsybXBua0xOR2hwK2JXQ0VhUmNXNERDNGpwUzZSTElwSjJuRHlnc08rS3l3?=
 =?utf-8?B?NjRtR0UrSy95eWl1SFVkVVVaYnRZZjZYdlJ5elhaaEJIRmFnVGJKamM5OXZM?=
 =?utf-8?B?WGlSZWtnR3lCNURBWUxtNEZ0UUdMY2xDNGdpNmlrSkp1UGxpRU01UnJ6d0lH?=
 =?utf-8?B?ZUF6YUdjUHdpYitSV0s0WDVMV1YwVURSVlo0dUJhVDNkaTdjUVRRVlRGbUFh?=
 =?utf-8?B?V1VQaGFTTDhBeStIbjJQOEk4eWh4ek5vZG14NGxxb2xKVTF2cXIxT0ZtNWdL?=
 =?utf-8?B?aE9jOW5vZDdnM3AzSjY5cEJqaHhNUGgxWUxNL0F5VFltdHQ5eVdIYjhTc2NT?=
 =?utf-8?Q?ZkVGcv5Ai2mVGOzqoTl0e8jFkmfskO7Z5qBQK?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e21ef41-5972-43e6-b077-08de7603b8e4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:25:49.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTEQ4mDm0+YG01sAku5syVtAM7XNBMYUXUcKWSwN55yiwbWniP+rpfb0wcWcMBhS1wcwqZHDlizw/iDXs3+UYlLp4vyVrAfp4QWeFi4O52w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8351

On 2026-02-27 08:11, Heiko Carstens wrote:
> On Thu, Feb 26, 2026 at 06:12:01PM -0700, Nathan Chancellor wrote:
>> Hi Mathieu,
>>
>> On Thu, Feb 26, 2026 at 02:38:04PM -0500, Mathieu Desnoyers wrote:
>>> I've successfully booted a defconfig s390x next-20260226 kernel in qemu
>>> with 1 and 4 CPUs, and within a nested s390x VM on 2 cpus.
>>>
>>> I guess I'll really need more info about your specific .config and
>>> command line args to help further.
> 
> On s390 cpumask_set_cpu(0, mm_cpumask(&init_mm)); in arch_mm_preinit() writes
> out-of-bounds into swap_attrs[] overwriting the terminating NULL.
> 
> This seems to happen because the return value of get_rss_stat_items_size() is
> larger than PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE:
> 
> PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE: 18688
> get_rss_stat_items_size(): 21504
> 
> Here I stopped looking further into this. I guess you will figure out
> immediately what's wrong :)

Indeed!

So in get_rss_stat_items_size() we have:

static inline size_t get_rss_stat_items_size(void)
{
         return percpu_counter_tree_items_size() * NR_MM_COUNTERS;
}

And just above:

#define MM_STRUCT_FLEXIBLE_ARRAY_INIT                                                                   \
{                                                                                                       \
         [0 ... PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE + sizeof(cpumask_t) + MM_CID_STATIC_SIZE - 1] = 0  \
}

Which fails to account for NR_MM_COUNTERS. Does the following fix your issue ?

#define MM_STRUCT_FLEXIBLE_ARRAY_INIT                                                                   \
{                                                                                                       \
         [0 ... (PERCPU_COUNTER_TREE_ITEMS_STATIC_SIZE * NR_MM_COUNTERS) + sizeof(cpumask_t) + MM_CID_STATIC_SIZE - 1] = 0  \
}

It would only cause issues when nr_cpu_ids grows closer to NR_CPUS, which explains
why I could not reproduce it locally.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

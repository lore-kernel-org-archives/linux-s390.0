Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909834BA33;
	Tue, 12 May 2026 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613772; cv=fail; b=EIb/OMcSjacNncYoqZDdt8R99mG7m4pdxjmlfP1kfBnjUVybK1TBB/WR2xNIeiOvJPMLvKlHLXY53lWwozNrOH/fyueIldJB7wR0n16u9nONCSX8zZ1T4jXvF2cN6q5xwiWpsRztGPyP1/0SsI/Rp5/nIC6Vjmo7Ns7KNu7Fhn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613772; c=relaxed/simple;
	bh=Dhn+LomCmSGGmoSCMpZA2LfWjV0TSgjNpUl1LX5BJi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHuEZ3nTKIZvpIxOzsx8sIyDaEBIO9hxv9uZf0enu7iayd1Dxq9e/r3VUXJEoEyF7U0sHHD7Lxrn2t89IGCe0021jDKlowRlpXoAWNJ7wLzRC24A/3o9k56AJ79FfHKzW0CpGWbSL8Fg29Cl05puyFaOKYTG4Wu2xd1uc9Ayess=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WfVXdrCL; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WfVXdrCL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5/SBiLkLxF8fS2c3rCyADTeRqb4VCqoGfFlOJT916AVkwh1Q7cUizsBtMMCGS/FJEsUXZX9SqpjG0OIN+bHAxtuvdnQQll+KjAJlkPByuobjqYdf5pHerYNG7nYngF4HeuH4Zpz8RHAB/PEl/URYxsNMpuqcWJYW8zEWQ0bVMR85PPhnk4EzMlndF0qkvv8iP3vfB2yLt8wbOiOuLXIJ8JiZyPC5JaFTtopehSL9uvtiJiuN6yWVjCXLkRo0op8P4AeF8+SPmZH2gwxkLZCSLlOZ0BRsTJvKVztCe4AhWqGUnlspHK6iwF2UfBVTzQ4aL7Cw8UwAA3avro+9fN51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vQ0ixR4if2+lEsSXRTU/8xEIHDeJO4BaRStpJz4+Qs=;
 b=V/bCFHnKg1mx1vUmLFwrwOfi07RSq+PG7N0CC6ElowkHNPAmy8PYLJHRFE7kARApM1e/EXmA7JlMgylNOaCVqTZpl8UDtWjO9KCkEL2wbl0rJs6EZpkGJjoDabgA36u8PzqdQwORELmstyb5C3PNplFmtVLShYzEdRbNQV3ZDtf9KoWmnrbUX6w4IuSE6zFzg4iNIrDVV7dmyivbhSz1ExpWhcWPJ8ySS/wqCmbwHHoE2lS3K5a5f5aUkVEcbDdCNkzI0RDkMkkmPtDpYZWQ+YTAJCtaWiDYjoGqhb1FilIol7+Ghle3ZJNlcppiPPFTjUT92D5+vnEafgUCmOWAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vQ0ixR4if2+lEsSXRTU/8xEIHDeJO4BaRStpJz4+Qs=;
 b=WfVXdrCLbF1GB4dDmxq7IH076hvEKEUKn18FWVkSFi9pww8H6TVlN8dVHhZyVzyU4QtWG6R9sesCbFvAuEYSkYqQ+D5n1MWsb7PZcEOaSyGxC2l1g7B+9TpDU3kADIs3x76c0c7NEXA0CqcyxI+1xq/QOLoh/tL8J5vmzLiOznyOedKPQxG9AEXVr7yw/lcSM5J+UkUG+N+F0OCFykEqimLA95iTY/3bsYWJkB5E6Xy28vt08Lza0vKZS0Cy4cFfrIpp/Ox3eWGxUKGGfYbLkyuehz8kjayMrra4M93eDtzLl2DxaovP53nTxdG7R+og6naOGqM5GHennJUQo5Yk+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Tue, 12 May 2026 19:22:43 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 19:22:43 +0000
Message-ID: <6b2a38fb-1828-43bf-8059-fca8f703e179@nvidia.com>
Date: Tue, 12 May 2026 15:22:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] preempt: Track NMI nesting to separate per-CPU
 counter
To: Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Waiman Long <longman@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>, Lyude Paul <lyude@redhat.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sean Christopherson <seanjc@google.com>,
 Nikunj A Dadhania <nikunj@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, Yury Norov <ynorov@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joelaf@google.com>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260508042111.24358-3-boqun@kernel.org>
 <20260512123048.6666343f@gandalf.local.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260512123048.6666343f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b2b129-0068-48ea-4dbe-08deb05bd707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	hJ57J3FP78xyVzzyQmIp4FpRtAP5dy+8R20PJTlhIYvfQjeKPGbme+9ZazbWMXywq1T1kDAuD0hHGDAYJU7CE/C1fhAt7kmteKL31SllNW1lD4BTV6lLVNNZa0DNCo4PP1VI95U5im+T0iUQauK0ODNeDov3rpLUaDKSYt4iOReFUYtpUeCaVX55L0omTzhHLjeMAUiDmlBCzeXx70SLb6wkpWA9NeRUyVhK03zOpfoInyzc/6iK3MWYezQMZcMXnBVqQ5ta2y3zMEqUqKNsSkcPKsqHTYmSWrbS7dUXhD8Q7Mecd+kk2+CuNzPaolLQqjYWUpHACfUeyZ6OCbCRngZM/Up73CZzja3CUY0AQyFxmuY4YMEbVyy5rY0HCB4RiHRYl0Ex9Al7AkROfqLEocP2E+ZlHREhKC0f0ghRyDswY6fxsLqO3LY1MB4i0iRrVKaIduobjGEBii4h8GR80t/sgtdjaXBXXpu1LuMiqT3foZPWp54nV+/Sxmpyd5xNJNo/iqowhj+kjmMns7tZwxsmJUGOFArK0MtspPXCJr86xpPEwtB3jkYPElEEgao7b04PReJy3DZJZ2wVtjwQdsWBVqt7sUl5i7dwqP7tEOaOPMk2Wk2K09E233qsTbnA/kMziNxXOsmfcFFXoUduPWZJEjULiHVsRebsspzJBf+98wSTItL3yEkrFg7Ul6r6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXNRQk9HUWwwNUd5K2dFYlRpcjhVV2hNemMyejNhbURFVnBVT25ITXZRaEl2?=
 =?utf-8?B?ckVFK2hKYzJ0bk5ldVZYTHd4bzVCSXBNbzJQSnYwYXdRejBVOERxdHBWQ1Jt?=
 =?utf-8?B?MVUwSFlYN0NsRFZ6YlVEdGVoOGlkV0NtTXNsTzFBZkp1Q1JQN2RBR0R2d0hs?=
 =?utf-8?B?REV3cjNCTVFwam55Y1FzUjJqbUtiY1U4U1V4REVVUGY5a3pibzNlbVppMVl1?=
 =?utf-8?B?alVyZWRJYS9TSXF0Q0RDa0xPRktMWlBKdWtpTS9VMXBGa0lkYjg5a1lVMFJs?=
 =?utf-8?B?b255VWJLWTFKUGRkaUdQQ0NpZlhCZi9PWWY0R05xWFFPWnlGanFnTkR1WXhn?=
 =?utf-8?B?L2J5MjdXYm9rYmZWL0IrYnNTSkFiYnZCdGI2OWhJR21pSEt0anJJUWVjdUl4?=
 =?utf-8?B?M3Y2SnF3ZkI5VkNTV2JlaTc3SFZZT2xPMUxvcjJTc3dxeTRDM3hqZzFEZzBP?=
 =?utf-8?B?dE9BZW1RT0FEVDRQN1FraGwyOUFEREhxRmthcHB6MHFpc3RaZGhjS3hvSWw3?=
 =?utf-8?B?SnA2R0FxSVFrTFBwcmplOXBkTDcwdTB5WmdPZ05OQTduczI2QWUyMHJHMFlV?=
 =?utf-8?B?aFVqbWN6TkhnQ3M4emhCeUUwS1hNejV5TjZseUQ5L3ZLL3owUURHR0Q2TWtK?=
 =?utf-8?B?L2VPTkwxTDcxUENTK3lXQ3Q2Y0ZQS3hFdnlFb0xIb1lFWm1PMGVUL3ZyNW9J?=
 =?utf-8?B?UE0zY0tIU0tuWWpjM24vZi9vOG05ZnFOR3BidnFGS0NodVBvK202WU82SzBi?=
 =?utf-8?B?anRIcWErMUpDVjU2UzBVblpEbzZNTFovL2ZsVkIzbXZRNU5UbUo3WjVydEJ6?=
 =?utf-8?B?R0NwdU1GNUNmam00SGlRb3cwWEZ4aGZDSTBka3pncXhkUjh3U1lRMG9KbHJ1?=
 =?utf-8?B?ditkaEx4Sm5QT1IvQ3gzK3hiQVZnVlFTRFBMdGVNbjl2dFdDcDEvOUtRSEl0?=
 =?utf-8?B?QmJSNFJCVFV0cWdUT2JsMkpTcXU1anF3OVRZUW9hRDF6STdvUThsNXYxRHBQ?=
 =?utf-8?B?NFY3Y0JhZ0FqWG9YOVB5QmtQMStKQndWSjR0MjJxNmdnRHNZNWxtNWp0aXNR?=
 =?utf-8?B?eHhNQkZBVHBKYWJxcFFlR3lIS0t1SHBRU0Jvc0lIam1UcXJ1Nk9pektXSkJH?=
 =?utf-8?B?NS9YWVJmRmtTWlQ0cVpDamhxa2tNK0Vrb2p2cmY3eHVDZDJ4QXZQWTAyckxx?=
 =?utf-8?B?ZDhvc1ZXSkUrU081WUxmb0xNaVJnNmJqS3B3NlZJZmVpei9BVmFFUUdsb01w?=
 =?utf-8?B?VkZhM2szQm9qc21QUjFjRU5yaVRsdjFkV2JFOXpTNUpjQnhFdUVMTytzck4z?=
 =?utf-8?B?RVRxc0tuZ2xmRDdMTXdhM3lYTWhyTE1ZTEtYcWFDREdLWktaaWcwK05nME1m?=
 =?utf-8?B?S0JiNEp3eURDR0JOYjlMMndxQVoyOWhrZXkrenMwSXg5bm1vektUUzZxYTVH?=
 =?utf-8?B?Vy8xcG5YZlRocXFTL0RucXhBOUF3bGh2QXlQTHpSNllWb0hncUhyVERTTzhn?=
 =?utf-8?B?dElObE1Zbzl2OEJCMFRnQnlzQlFpZU4yMWUyUnNXbzlLRVBlRG92c3QvNXAv?=
 =?utf-8?B?NXF1Y1FaUE1waUdqUXBGRVU3K1VMNUY4eWVZMGQ1S2dvK0xEMFRvNTFsN29u?=
 =?utf-8?B?NEhRWGhnMkRRMzV5SGUxTWlZQm9Sd1owR1BER0pNOFZEbGpmandWU0JocFFK?=
 =?utf-8?B?YlRaV1BNUERXSVhGLzBDOHJ0bVE1QXcyUVcxUndtZDZUazlUMzgybjNxWTlj?=
 =?utf-8?B?MzZ5MHhKQy9zR0FSWFIrK0RRSzFJTzhiT1hoOXphQlVUOURINjhEWUxDL0cv?=
 =?utf-8?B?ellxWVdIZUp5VjBqanB6bDdxVGdaaWZHNG9sb215OTQvYkd6S01sT2psZXJB?=
 =?utf-8?B?bW82ZCtsWVR3L1g4bHQ0WUgzSUhNMEpIbitheEZ5cE55aUpRU05rMFQ1SXEw?=
 =?utf-8?B?cUVHOEJvTll0SFdYV1NLTk1UNWhHWVROQWRnSHg1MG1MQ0RzN28wWDZaOWFT?=
 =?utf-8?B?bkNCVi9zdjJjSWppaEUrNm9uM3ZCYnZTdzZEK2cwU3lzTFZ6cUNEQzliT1VE?=
 =?utf-8?B?bVluUTFiK0laTXVlQkRoVHM2RGg1WjhobWFQZmVyZDQxb1FwR3JLSEJxTkNM?=
 =?utf-8?B?MStvWng0MFNiK2U4aSttT0ZxQmNsRHFIZEYyV0l1d3pLWVdQTDFpbHphZXZq?=
 =?utf-8?B?aXVQSE9YMy9lYUJlTHAvYTJHUU9rcEVBRkZGK2Q3Y1U0ZmVnRVM1SDdSU3Ux?=
 =?utf-8?B?OFlsSzQrZnN4ZmFnYlIrVlBqQmVDWWhGdVVVdlhkL1pBUVU1K0F2RnVLbG9F?=
 =?utf-8?B?MVNxRGdGNmY4VUMrbkwvTzBJaDg5Y3lidkZERW8vWS9IYklUQ2Rsdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b2b129-0068-48ea-4dbe-08deb05bd707
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:22:43.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkp1YTmoObM61luPuJunFqxeARfwNMjIv8y/7CgAE+FIe8r00HmlyOuPtCeXVcu8Zct/yPedRK+YxOxJZTOG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218



On 5/12/2026 12:30 PM, Steven Rostedt wrote:
> On Thu,  7 May 2026 21:21:02 -0700
> Boqun Feng <boqun@kernel.org> wrote:
> 
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
>> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
>> allowing those bits to be repurposed for other uses.  This also has the benefit
>> of tracking more than 16-levels deep if there is ever a need.
>>
>> Reduce multiple bits in preempt_count for NMI tracking. Reduce NMI_BITS
>> from 3 to 1, using it only to detect if we're in an NMI.
>>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Boqun Feng <boqun@kernel.org>
>> Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
>> ---
>>  include/linux/hardirq.h | 16 ++++++++++++----
>>  include/linux/preempt.h | 13 +++++++++----
>>  kernel/softirq.c        |  2 ++
>>  3 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
>> index d57cab4d4c06..cc06bda52c3e 100644
>> --- a/include/linux/hardirq.h
>> +++ b/include/linux/hardirq.h
>> @@ -10,6 +10,8 @@
>>  #include <linux/vtime.h>
>>  #include <asm/hardirq.h>
>>  
>> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
>> +
>>  extern void synchronize_irq(unsigned int irq);
>>  extern bool synchronize_hardirq(unsigned int irq);
>>  
>> @@ -102,14 +104,16 @@ void irq_exit_rcu(void);
>>   */
>>  
>>  /*
>> - * nmi_enter() can nest up to 15 times; see NMI_BITS.
>> + * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
>>   */
>>  #define __nmi_enter()						\
>>  	do {							\
>>  		lockdep_off();					\
>>  		arch_nmi_enter();				\
>> -		BUG_ON(in_nmi() == NMI_MASK);			\
>> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
> 
> I think we should keep the max nesting fixed to 15. If this doesn't trigger
> until UINT_MAX, it may take a long time to see that, and there's no reason
> NMIs should nest more than 15 anyway.
> 
> Just because the counter allows it, doesn't me the system should allow it.

That's fine with me. Boqun, do you want to make the one-line change to the patch?

Thanks.


Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54C3DD50D;
	Mon, 10 Aug 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364754; cv=fail; b=EaXOgCX6QtnFoCbC59yUpBWsc6kjHGjlDPct9uoyU40QiWxyhXO97vY5FTdrH+NBMYw0GXCtrkwyVfR46TRGTaJj/CSStbyX7b4jpkdOBOQ4SiF6VuZNQrU5yA83l0X4rY5FgLORrgwkOwkLDYCk+lskg1oOCtC2Z1RA5WutfBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364754; c=relaxed/simple;
	bh=aK29VlhHM+oLCqUtbKTXAuivwl3purBvTZUcg7IJExQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPZEo5HTB5prSxzGAGOHluWXEDbS4c7IvuK6AnfiwgR8Y06Xe5sKPkdt7fATzmbkrnkX7F8GSIfV4MFRu52XUb8ud/n5N5MWhvbyRuXFRmPsboQtpSiSH7FlyUhddvAHqlC9g4SrUMZDUq/KFlW1fKhkB5G/3aH35u0+RCCmyvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ej0jUfMT; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ej0jUfMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX6LJJZvuzmas9yuEFSzCNKOvrfQxgCI+v46kQmrBcAHdE4raUlfobAVC0Np/1qZKIko1zlS94W+9rmFEVuTgYM7OFNxSMJvomYtjw76w36LAgwQjHgGRHtiZhbEjjzgRA4Mj2sqQo7Q1VbVAIhumpKO0Onl4LYVcw2AJJotTlerk9Q1MPZdVpCGS5gA3u+zSnpndSX4lG7KkZnNugex+WdXr5h1woVkq228hmvaYsgqNWAeH7f9i7SGJ4FLnq4MZTSSvrctpQsbu4HDrTMWS6FACfVPLWSztLIFCRJMTl0P3WkzfiRZ/8RwXICorTRQMm5sPlpDh5gTurkAW9p9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgPKZhkjoZuhTLTuO+WqzRIbzYH5KCcDPOZXqaOTOMg=;
 b=krb4NyG3ratYdT+XimY4POFDGt7k9+EZyCpKEW7+sQKQ1Q3d6qD0A6qldE8xEfwlj9kF8s9+kk1A8y5m0qiM0Ipnl58gw5EPBrCgI7RSV2Eo5vSub+83xTi/JW/+MbBu3hkGTIybxL7FDiOOBFMyjV2FhuIRuURJV0IcogrzVGRgZbuTrvZoBxz4QaY92/MVRYkYfte6JTptYZoGHN7zGDy1m5lVZ6JuRdhgcUJY9a+pZ6yDBcfZj6PiAbyqrKugGHzZZX30jwLekt534vfWPI+AjZyVZHWNzfiuRgz7BaWatlGJfBrXBgzdTNFPMwqvhZyJ5MwkRlVmYFTTYdudvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgPKZhkjoZuhTLTuO+WqzRIbzYH5KCcDPOZXqaOTOMg=;
 b=ej0jUfMTyqG3IYgqFdxxfPjzQS2ytD5zmzBqji4pWWzhNMXwGRzvEoMZMp+lA5M22JSoxH3IXZfqYSa/DrZqHRZepnMQl8YoYY6kDSrcHvhi+EmKF71zZK3a9ua6g15qLg/MPhOzqfsJMwC3woyAOjyju2MNMKjKgPI3M9xBrL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:25:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:25:45 +0000
Message-ID: <94a06ddf-a969-4499-93cb-1c8808fc7609@amd.com>
Date: Mon, 10 Aug 2026 14:25:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] dma-buf: heaps: Add debugfs support
To: Thierry Reding <thierry.reding@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-6-5510d16af89e@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260807-tegra-vpr-v4-6-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:208:23d::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: d05167ea-cd58-4c2e-5268-08def6da803d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|921020|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uJ0YlBUrLHAd5fjCJPvn9wMDKYHfbYNA1n5wTwS+x26DBHLsgXqHW6dUseMz8Gn8UeKR8TPFuP9ChwSnCgiz0LSp/9mHbbbXIxc0SCA+A1blWVYQPHGCYgr0NIh77FRWFw/e5Jn82+c0eabCbhJ3JUqDabEzm2YS6nYs7QpArMhd+LoWeoNeRUjLIDagxIGDh5dbc6D7Ua1wrqEV0WUx/pSpRHhyPtPR9cXBHGBbQlzF9xNn9Te0Eq5I2cQatLAjKLuvFGXQtUl1935Fz0W7aRDNmwQYAlgoF9vI0eGAON1l9ZFdaHw36nKv+ZWFGSx8OgjwyFeATRoxxVs8fkUx/pWr8GmvyyEGym8+kP/JPtyolp53FvK2RMjDbKJb8Sv7ir61Rz8ugsI2w9C76ynOTKoLoS+bztaaHav8E4Ne4+O2JWBe2Td60Y1HFqtcZT49/2+w596/h4/OtYLJtv8sfoG+Z0SIIpu7jiqhwOEXQIU4bechhj2ob/hLR2m+6aJN2kVhxXUTNi1bXA+HkciVV464ec21RXvmx5xDy7Vw/2xlDoP7wstUi2w0Ax4JFVIzQ3EeW8AMPu11xixZIt7eXAyHRhYND8FCDRAwhjMzStbx1ycuQpmH9iqtEBCoQ0h/mu1vT3iPt1tHmMySeWTxuKkdWb4nDfJyXb8n8ynXLbABQUb9sWkktNgv/1CcrpD4jGSbiGmShpfVp2K69R+pfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzJmRUhLM3l2NElWQS9IVnA0VHFFUTV1MS9jN0ZSSTZNTzgzRTE0QTM4Sm56?=
 =?utf-8?B?TDRBQmFqaGtrWE5ScmdkN2tRbi9PMnNnL042TWM0THdzRXVNa0ZabkMzUUd1?=
 =?utf-8?B?ZzBUNU84UDl4QkJpcUVGVjh4QU5FY0VMVm9QUVV5V3VUR0VjM2RYOHpseE5Y?=
 =?utf-8?B?UWZMYkROTE9LeW1WZ09wZ3laSmVuck1NejZZRXZzbVJVUXV0T0kra2FTbGNI?=
 =?utf-8?B?UlArdjhXanFpM1FubVBQMXBVUkh1THRUYndxT1phYWRMQzZQcVNQaWNmUC8y?=
 =?utf-8?B?TUNXVlFCQ1VnSTQ5WWdyYS8weGZ4VWhIa0svNGZzdTRQS3hUbFlSZ3FpSEUx?=
 =?utf-8?B?MjdRNGc3TXFzNTdzd2YwSnRKcVJRd29FVnljZkJqNWpHOURyU0w1bmpNanFv?=
 =?utf-8?B?ZDJzVDV1elRjWDhuS3ZtZmtrYytDME1aS3RSc0F0RXRGdUdnSitQQXJCdjk3?=
 =?utf-8?B?REV5N1MxL1krTTNiYUNzcW5PbFg0cThvaXZacU9qWXFBV1JweWVhWWRieWlX?=
 =?utf-8?B?UkxjTEI2SEk5RG5rZmxVd1NPZXZrOXplOWVvOE5QendGTmhaeHkvcitLbnRo?=
 =?utf-8?B?UE1ucUpFRTRiZGR0UWRlR1Z6N2ZLQmpEWTVHbUpMSmxTQUViMmN6STdqZWlQ?=
 =?utf-8?B?c1U5endjZVBDREV5WWYwbHAxcmY0d3hXbE9xTXlWV0RHQlpJQ3lQVUJEU1pS?=
 =?utf-8?B?WHhSZzdVWG41b2ljeENyRVNYRzZma0REWFRNRVRoVTRhdFdMRVZmcnpYSWZJ?=
 =?utf-8?B?OTZHMkJ1dFV0N1paWHVqOFU1aDBUN2dhcitKcjU3YlpOZkRsVnVQcnFVTi9l?=
 =?utf-8?B?dXhyUzdsdDlXL2I0MnFQWGtDMVk3RmlsOVVqb3UyZ3JNbTNlcTFMTU95QkZG?=
 =?utf-8?B?aGd6czc4dnJBSkR2K3hVRC9hWnJXOFdJR01mUHh5VmRINWEzdHVoaHYzL1Yz?=
 =?utf-8?B?SHMySHlFYjV5czBIa0pkVmY5WmhyVUFSQkxmQjNLK3NHZjBsNWprdnBtUkVy?=
 =?utf-8?B?R0tyOHZHTVFKV2sxY001K3JOTDF3Nks1RDdQemoraGtlV0FxY2FBUDFQaFVH?=
 =?utf-8?B?eERJelhIRWlpN2IxckYzZXVoMndlSVpYc3k3WG1Rajd1bWwzSjdWZ2tVQTAr?=
 =?utf-8?B?Q09pdVRkU2U2dEFFS2U5ZEszL0pqNjhIZlRzOG11dXkzWjJrc3BuM0hFRTV2?=
 =?utf-8?B?QVVxN2pZNFdxMDZra0hDUWlnTHhJQ0xaNFBIanBDVzYrT2pSQ1crUitQallG?=
 =?utf-8?B?OTZmckdZcThMMGYrcHBFODZtYVAvMWNMV0pnd0lURWlUM0doTmJGMFNEdGIr?=
 =?utf-8?B?UnVFQS9rY3VwODE2WVBSY0NYSXBmemh3QzBQUUVPWE9OMDJERXU5ck1RSVNJ?=
 =?utf-8?B?akx3M1FJUnhCN2wyc3R6bXdkcUlnMjFxSVBmaDJNdXhkVzZJcm5kNGR6V0Vw?=
 =?utf-8?B?NkNnVGNuQktkb1BJRGZPa05KNlhhZFFLZFNaUncwU3JrOUhPblgxb0ZBQlJM?=
 =?utf-8?B?aEJONDBLb2FDT2VSbGNsSlNELysrYzJLQ2JldklBNldsMVNhd2NXV3ZERTk1?=
 =?utf-8?B?cnVFd2d2THdqSlJSMkpCaFdETDIyYVpBZ2Z0NlVKbkRPUmVRRDZYVTNoM0F0?=
 =?utf-8?B?YmVxRDl4bGdzOXU2TlE0WGVLMEk1V3NSQzFvSUFEMGdHd25jTEZVOVlwR29j?=
 =?utf-8?B?aHk1L1Q0bDVWc1F5ZnhlTnJPb051RUZUeko5RUI3TURzcE1BbjJGMzRidXRY?=
 =?utf-8?B?K3FZdXZqMVlJeE1xMlovelJhQ0dmZmM1NXRYNUZudjI1Ly9ubitSNkUrM1RQ?=
 =?utf-8?B?RmJGMDBzckU3ZTMxSkdaYWJBTGZkc1hEdU42ZUxoUkwxeDZHY2d2dkNxa2wx?=
 =?utf-8?B?TEozenhOREJmL0xzWWlheko1VG9VY0lhZmkrTnZIVy9PQnE3MDU3NU54b0JG?=
 =?utf-8?B?ZkhxVm1iM3doUUxRWUNpbEpCT29Mc0lXUTVUZERUcEpJQzM3NzRsNzB2YUdZ?=
 =?utf-8?B?YXVqaWYrdkR2TEtKdXJlcDJGbElxaUpiclY3ekpCVWNnQTBjdm1ENWFBNXJi?=
 =?utf-8?B?NXpLUHMwanFMblE0dTZsNGZxR24wWloyRUdEWHZsdEhhQy8rU2dOTGdxQ1gy?=
 =?utf-8?B?QmlGbFhZVkF1SVlIaTBSV1lTQlBSdmRzTWNyTGh6SW1BQzVzSVVLc1RRNHFa?=
 =?utf-8?B?ZFRSdWlOQUtmdmFkT0dzbUlKRE1Pa09LLzFYV1hSVHk4V3J3UitETFIxallz?=
 =?utf-8?B?SmQ4ajV0VzZhVmVPTGVQbFFDYVBqUVVnM2c1aFo3bklwR0czR05UK25zbFBi?=
 =?utf-8?Q?sV17zeAytFg+QLG5+M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05167ea-cd58-4c2e-5268-08def6da803d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:25:45.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov0Erh0lz3QOIBKiWHRzi3ak8zMidztRl9illREB0K0RFBjsVhc6kcOlkCvYoWzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

On 8/7/26 17:54, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a callback to struct dma_heap_ops that heap providers can implement
> to show information about the state of the heap in debugfs. A top-level
> directory named "dma_heap" is created in debugfs and individual files
> will be named after the heaps.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-heap.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-heap.h   |  2 ++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3937dd41bb0f..389cddd07c8d 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/cdev.h>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
> @@ -225,6 +226,46 @@ const char *dma_heap_get_name(struct dma_heap *heap)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int dma_heap_debug_show(struct seq_file *s, void *unused)
> +{
> +	struct dma_heap *heap = s->private;
> +	int err = 0;
> +
> +	if (heap->ops && heap->ops->show)
> +		err = heap->ops->show(s, heap);
> +
> +	return err;
> +}
> +DEFINE_SHOW_ATTRIBUTE(dma_heap_debug);
> +
> +static struct dentry *dma_heap_debugfs_dir;
> +
> +static void dma_heap_init_debugfs(void)
> +{
> +	struct dentry *dir;
> +
> +	dir = debugfs_create_dir("dma_heap", NULL);
> +	if (IS_ERR(dir))
> +		return;
> +
> +	dma_heap_debugfs_dir = dir;
> +}
> +
> +static void dma_heap_exit_debugfs(void)
> +{
> +	debugfs_remove_recursive(dma_heap_debugfs_dir);
> +}
> +#else
> +static void dma_heap_init_debugfs(void)
> +{
> +}
> +
> +static void dma_heap_exit_debugfs(void)
> +{
> +}
> +#endif
> +
>  /**
>   * dma_heap_add - adds a heap to dmabuf heaps
>   * @exp_info: information needed to register this heap
> @@ -299,6 +340,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
>  
>  	/* Add heap to the list */
>  	list_add(&heap->list, &heap_list);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (heap->ops && heap->ops->show)
> +		debugfs_create_file(heap->name, 0444, dma_heap_debugfs_dir,
> +				    heap, &dma_heap_debug_fops);
> +#endif
> +
>  	mutex_unlock(&heap_list_lock);
>  
>  	return heap;
> @@ -335,6 +383,14 @@ static int dma_heap_init(void)
>  	}
>  	dma_heap_class->devnode = dma_heap_devnode;
>  
> +	dma_heap_init_debugfs();
> +
>  	return 0;
>  }
>  subsys_initcall(dma_heap_init);
> +
> +static void __exit dma_heap_exit(void)
> +{
> +	dma_heap_exit_debugfs();
> +}
> +__exitcall(dma_heap_exit);
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> index 648328a64b27..1c9bed1f4dde 100644
> --- a/include/linux/dma-heap.h
> +++ b/include/linux/dma-heap.h
> @@ -12,6 +12,7 @@
>  #include <linux/types.h>
>  
>  struct dma_heap;
> +struct seq_file;
>  
>  /**
>   * struct dma_heap_ops - ops to operate on a given heap
> @@ -24,6 +25,7 @@ struct dma_heap_ops {
>  				    unsigned long len,
>  				    u32 fd_flags,
>  				    u64 heap_flags);
> +	int (*show)(struct seq_file *s, struct dma_heap *heap);
>  };
>  
>  /**
> 


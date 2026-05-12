Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925C360EF7;
	Tue, 12 May 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587451; cv=fail; b=hDTZaNWve8chQ8t/Wnh5KLXljHVs6/EuKa9VTroVHxiDBzkY6irP+UB3YPt7/ydwLHp6ZA9TWgzgDZM+TLiHewmnWVZ8e+SaD+Vr0b7mIi46SO9vzaFhLcgYeKO/9ZUNjKzysF7qggd5J/U7tS28jObfjt6Yu3HHU0BTkiwcNTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587451; c=relaxed/simple;
	bh=hC8RRyWPdt8U/+ZL9PAZZGzjeFjdkh711EPclWOk9d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lv04z4mHbB5p7OkadZIoog4Qpun9IdReio363oOCkQt+TqNU/kL1kA0ZOHl/+Zy9EnieBlBJ0dvB65gd3gsaI14Mi1A1cUMPPSb3VawwYy4WZDNfasyCeb6x0slzyNfxTebI1S4hXJv3NsKLm09VEpDLCSMUon+QIk1dCZstDg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E8PRMTLE; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8PRMTLE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFIovmhusbz12gqLjhc/hL++LP6NFK4pjljr+yG4X6kBan5Q5zripYgie2g7oyCfZaksytgpQI/fs42TnM8Vs+UEpAOxKrSH3arSb6mubw6mV+YtJuruaRRaNR6vbkAacIIY215DHDlTReVaGwbzUrZumjJ5CuWRFJYUEeWVffGm7keY24YJKGKDf/avc1FwnNF7ZUZyyJkl6ZbYCk3xKQkpLxGGIjU1ruHxbfZD1lT55DHVxNzjbXKaehHupAy2ZnGG31BFbPgeN/JOb/94qpWNSUsQ/2z9X/tM0QMZTI79hPVIaiDZLx0JhEvlkx3BQCqgcm6ABLR6V+syK70TCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po7QUbVTsST//VXwxpsP6KuwY2R/uvZcYASCzSS70KA=;
 b=qtX0C+BOYKrdnhZ46Ha+CKgtocQ57E8TT8h6wB0DW7SgjAAk8FEWUfZmmWc/O6lNbJqPomLVisYQahatgkuW2CiXXQfjfHQwvmFqYaQdCnYu3UapP02KxHrTxU9HyHe88RrMK98iQ8vBfJ2cwWdyDTrCCAZPXwULdvc/FiHB+2sP8qC2s6A5v0k3jKEJT6hY5oWZkvgb3LlkRV+0YUbLjUez0GcYqkr8PL4WGEiaTtGZ+MjNTWGgDuG2m5QxCloUknxzqeJj+JiSoZNEPhdLwX1DwSDv+hMS+puTc8glD0ADxhdfCXdQ9VL5Wu6Ja/RFuQpCtWROOUHXaLlKKYN71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po7QUbVTsST//VXwxpsP6KuwY2R/uvZcYASCzSS70KA=;
 b=E8PRMTLEy7Fn5N5G7btU8KQ5C1Zjfoj1eperpPp5l+WT9orfIGS661hg/fB9j8h5JRCic0AZkbkgiX9MbRCT7g1+Ldva7QJllnYCkfkIWDMduSU/ey/8WEIveVsKYNbWkER+tuMMzMm5KZGunQxNwNVpM0kus4ZxfPUGpihgtEI0DGBOANsVXOozQMoRIFJpW1gNX0nDcIVhqV+1FS2Y8IJJiOvou4SCgB11QLw8iu7zkkCHT5+QxbtgkzpySeCacD7UOwsABouuUB2USEUOsDEgLqE+76HnOjI9d/zcl1/nqN3f3JGUOzq6TfQ1r6vLavoiUMAacl80TmMNb/u/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 12:03:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 12:03:55 +0000
Date: Tue, 12 May 2026 20:03:46 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, Oscar Salvador <osalvador@suse.de>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Kees Cook <kees@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Donet Tom <donettom@linux.ibm.com>, muchun.song@linux.dev
Subject: Re: [PATCH v2] drivers/base/memory: make memory block get/put
 explicit
Message-ID: <agMVtO5QPGYVb48D@MWDK4CY14F>
References: <20260512072635.3969576-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512072635.3969576-1-songmuchun@bytedance.com>
X-ClientProxiedBy: TP0P295CA0031.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc10bf5-d8f7-4677-c511-08deb01e8a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YdatAwBFh9uTbS7WsPgAE9Rh6jXSAMgWWUaZ2ZCAqLUeX11hLJcQhNIRjh72ZxvHRZiqaHRX4deFAPFT3elyt/ls/0jcb6G7ztOOrQ/1TKDiQl4f5WSRfiQ7OboMm0Ll+fktFT14DfvWqoCCKOJk9mEiOgwUTUUOntobbHzRAasqT2FjWiZUsYsXSNyQJWCt13AVwTG5oCsIDV2ajaCtmKDT2ZZC6X18knBDgAakcpG5wGav0Nspp9dm5TGvSPWOzSALvLljY5hUmVB/+o93G/oXwKxHGHnKLjlV2zotVvkDgkqxa8AOWAHB5LBIHbukk/XxiiLZ3pm73F/otiiHO8kM56rwjqLzD1Th7/RDibZnULqHbSzrVeLWO+tRVO4781yuHznbrqWawU7dhSUeWxj96ryRpWVkG/8KB5xbRZ+gkZvYUDwufBT9SKQggcGiYwOR+nb91jgeSGPfLI/3YTqx3eBW4VpQ1205FNvjsCHf9hb0jbdp48/aZ0+Ux29w+JohWMHUsz/EyMfi/HM5PzNI7PPaaPEfAZw/PPFFGW4vTZPIH99xTaz9gfxTxQ38HYU15m7P3ONvf+DIhpHgSB4mvw+pk+UFCCTif0tOfVqFwDxRQT26VW5k4m5v91qgKQIMj6oand9p98iCtfI33Ho4efVvi0xi34OnzknfNCGGspudD/X8KmarYha/Ny79Lqz1mrMJBSvSnhYrtCAWUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?872l5KLeuHiglcpP3y82QnRSqdDLNgjdh5R8Cu1ri8SdesXACakDLPYw60U0?=
 =?us-ascii?Q?c80ClMsQiR7DY5O4zVtzPmg5JwZZ/QFrp/CqWcC2eIqgjxrmuUkRmLczdd3X?=
 =?us-ascii?Q?tc/eFJ2DerW/6Hwzt+pnjO/e3CP965WjsHwStDUIvJ2r9s8aYLcWHJ9iL+ai?=
 =?us-ascii?Q?2RvhgOzPwlqmecQyK4QIvsd5VCsyCXnWFGJJZF2cENrYHPYW1XZy3RElENFk?=
 =?us-ascii?Q?t9jhfttEcHT+bH6PFu+cy86IJ79Q7yXY3tTu/PIcMX1+MpenigMjVvC0PURw?=
 =?us-ascii?Q?e8jiHfrl6TvyoPwh3s6w9qb+o07sJl0pPCxuqoQoEEs53sdblJZJ1mSYOfFz?=
 =?us-ascii?Q?MGg4cz3UE3590/L2orAZsGVmg3C7psRqrjDeghHecJ7nJMExT+pNQRKpjw+I?=
 =?us-ascii?Q?3kMmiSQrNelL2q4iH34x1uFvOV1NYuAlOWRRqXs2ILlITvlTUFnG58GqMPjV?=
 =?us-ascii?Q?M2m7txuf9XKCliBjMASShuAkZSVtijzd2HtSBkh//pRfIBXFcwB3W8BrYOfw?=
 =?us-ascii?Q?MwdRzDIQoCQsfMVeeC3qRGziqzhb46junL8Ac80Ymsuw+L0AFAbncTdvZTqb?=
 =?us-ascii?Q?Utxt3ABqXiBXQjsIKTYmnRIS+kY0J5DYM0yILuOnQumBonV3GLOQnQmmB3PU?=
 =?us-ascii?Q?8LEtF+Il17Gq9bSlp+dF/aJuNKYOXTrT75ha/ooPI64L4WAd62qjJ18li4c/?=
 =?us-ascii?Q?X7Ky9k6V8WuT2KaRqE3tHR8K6DoktVO0Fgp/0OALrBW7cD2soraZcdK5gthz?=
 =?us-ascii?Q?XnVO6onvgxfGPbFBekpQcvRtkmgAB5RYEM9N24up80/1NN1BXYPX8GbPKnYZ?=
 =?us-ascii?Q?wr7wjgWdGnXwKQRm8DbG3u7E+rAt9DZyfhZDdM/87joxz+BiUzJao2FxWL4A?=
 =?us-ascii?Q?KaUYkL9r8CixpHRSZVyZX9BzMRAAcOaKiOKCIaEA743jmctz1G9/TYxF2LlS?=
 =?us-ascii?Q?veZoKoz9rOPSdHMMH3/Ki+P7tBwJDol2lITq+VfycJ1eMj/jL1TXOvi9CTWN?=
 =?us-ascii?Q?IxuEBwUQDOj8ARzo5U72sFBic0bMyG89C/A0zRUJ8eV74EqBOo9VGbzZR4JM?=
 =?us-ascii?Q?19VkS0Wz9F/zHlWYMLKeTHqUXei9H8FJQ1w0wgjdx8FsFPAlw+FH81HFG+Zv?=
 =?us-ascii?Q?NHVgOAHqjICxj47Rt7Nb3jXrxqw+zNxiktolNdF+DmpiiNncHEmZXeuXeWEP?=
 =?us-ascii?Q?gTTFoPrEeFBmYKnFGWX2FXLrDqLXmlw1rabSxqvEqrV+AFkBn/E6dPwgEbu4?=
 =?us-ascii?Q?fSoh5/ILpze8Z/ZexYI0oFv/vZYAmBC9aAZSwms66DIWKQ34zY2YN+0H7UCN?=
 =?us-ascii?Q?g7IR/XBd1CYcn3YFPRAO/HSmKxuNr4T2SmOvhj4A4X5Szs5GXXBjYBr3vMlE?=
 =?us-ascii?Q?Cr3Oo4EhozaIeXVvO45TDjFO0H33vOCA7dR0dCHV81G+1vUBIoEGWYVdT24Y?=
 =?us-ascii?Q?E6IabuYpnI4u762DkKIRgJBj5ikNxgbKiTNVxu3NKkQlsSSqN+lLwmQ4pU/c?=
 =?us-ascii?Q?M7T3qoVJNB19Kvgn6huD9CYYcbjt3BqgZ2aiGPxFBsrv0e7KtFofZk8bgwrV?=
 =?us-ascii?Q?WuG9FCFXrEnr0YYMxeg+ywblVk3JTqSfi6kdhnBxgtUici0zQi5RtIt44KOg?=
 =?us-ascii?Q?ECFUv7z/PunLmqY5nk6r0qP6TtVNigcy5bC/kI8FshTqfAZ90j6OANsCZwi6?=
 =?us-ascii?Q?i40xA3dIagNQ7K4oHDS89dmWLhKYu8mKKWnTC0geB+M1SfXuacxU/U36fqLf?=
 =?us-ascii?Q?h55G9LY6fA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc10bf5-d8f7-4677-c511-08deb01e8a9a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 12:03:55.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hTCP9qs5vT7n+FcVA8TFtAft1x3O44r+YmVEYNpYMKM+oMNUEp9kIiWIBuq7304hM1ZREnRZzaLNhDY6nsGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

On Tue, May 12, 2026 at 03:26:35PM +0800, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), remove
> find_memory_block(), and use memory_block_get() as the single block-id
> based lookup interface.
> 
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
> 
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
> Changes in v2:
> - mention the removal of find_memory_block() in the commit message
> - drop the redundant extern from the memory_block_get() declaration
> ---
>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>  drivers/base/memory.c                         | 38 +++++++------------
>  drivers/base/node.c                           |  4 +-
>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>  include/linux/memory.h                        |  7 +++-
>  mm/memory_hotplug.c                           |  5 +--
>  6 files changed, 35 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 75f85a5da981..94f3b57054b6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>  
>  static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
>  {
> -	unsigned long section_nr;
> -	struct memory_block *mem_block;
> -
> -	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
> -
> -	mem_block = find_memory_block(section_nr);
> -	return mem_block;
> +	return memory_block_get(phys_to_block_id(lmb->base_addr));
>  }
>  
>  static int get_lmb_range(u32 drc_index, int n_lmbs,
> @@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
>  	else
>  		rc = 0;
>  
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>  
>  	return rc;
>  }
> @@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  
>  	rc = dlpar_offline_lmb(lmb);
>  	if (rc) {
> -		put_device(&mem_block->dev);
> +		memory_block_put(mem_block);
>  		return rc;
>  	}
>  
>  	__remove_memory(lmb->base_addr, memory_block_size);
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>  
>  	/* Update memory regions for memory remove */
>  	memblock_remove(lmb->base_addr, memory_block_size);
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 11d57cfa8d72..5b5d41089e81 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>   *
>   * Called under device_hotplug_lock.
>   */
> -struct memory_block *find_memory_block_by_id(unsigned long block_id)
> +struct memory_block *memory_block_get(unsigned long block_id)
>  {
>  	struct memory_block *mem;
>  
> @@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  	return mem;
>  }
>  
> -/*
> - * Called under device_hotplug_lock.
> - */
> -struct memory_block *find_memory_block(unsigned long section_nr)
> -{
> -	unsigned long block_id = memory_block_id(section_nr);
> -
> -	return find_memory_block_by_id(block_id);
> -}
> -
>  static struct attribute *memory_memblk_attrs[] = {
>  	&dev_attr_phys_index.attr,
>  	&dev_attr_state.attr,
> @@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
>  
>  	ret = device_register(&memory->dev);
>  	if (ret) {
> -		put_device(&memory->dev);
> +		memory_block_put(memory);
>  		return ret;
>  	}
>  	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> @@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
>  	struct memory_block *mem;
>  	int ret = 0;
>  
> -	mem = find_memory_block_by_id(block_id);
> +	mem = memory_block_get(block_id);
>  	if (mem) {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		return -EEXIST;
>  	}
>  	mem = kzalloc_obj(*mem);
> @@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
>  		memory->group = NULL;
>  	}
>  
> -	/* drop the ref. we got via find_memory_block() */
> -	put_device(&memory->dev);
> +	/* drop the ref. we got via memory_block_get() */
> +	memory_block_put(memory);
>  	device_unregister(&memory->dev);
>  }
>  
> @@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  		end_block_id = block_id;
>  		for (block_id = start_block_id; block_id != end_block_id;
>  		     block_id++) {
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>  			if (WARN_ON_ONCE(!mem))
>  				continue;
>  			remove_memory_block(mem);
> @@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  		return;
>  
>  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
>  		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
> @@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
>  		return 0;
>  
>  	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>  		if (!mem)
>  			continue;
>  
>  		ret = func(mem, arg);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		if (ret)
>  			break;
>  	}
> @@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  void memblk_nr_poison_inc(unsigned long pfn)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>  
>  	if (mem) {
>  		atomic_long_inc(&mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  	}
>  }
>  
>  void memblk_nr_poison_sub(unsigned long pfn, long i)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>  
>  	if (mem) {
>  		atomic_long_sub(i, &mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  	}
>  }
>  
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 126f66aa2c3e..b3333ca92090 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
>  		for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
>  			struct memory_block *mem;
>  
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>  			if (!mem)
>  				continue;
>  
>  			memory_block_add_nid_early(mem, nid);
>  			do_register_memory_block_under_node(nid, mem);
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>  		}
>  
>  	}
> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 78c054e26d17..6df1926d4c62 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
> @@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>  	addr = sclp_mem->id * block_size;
>  	/*
>  	 * Hold device_hotplug_lock when adding/removing memory blocks.
> -	 * Additionally, also protect calls to find_memory_block() and
> +	 * Additionally, also protect calls to memory_block_get() and
>  	 * sclp_attach_storage().
>  	 */
>  	rc = lock_device_hotplug_sysfs();
> @@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>  			sclp_mem_change_state(addr, block_size, 0);
>  			goto out_unlock;
>  		}
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> -		put_device(&mem->dev);
> +		mem = memory_block_get(phys_to_block_id(addr));
> +		memory_block_put(mem);
>  		WRITE_ONCE(sclp_mem->config, 1);
>  	} else {
>  		if (!sclp_mem->config)
>  			goto out_unlock;
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> +		mem = memory_block_get(phys_to_block_id(addr));
>  		if (mem->state != MEM_OFFLINE) {
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>  			rc = -EBUSY;
>  			goto out_unlock;
>  		}
> -		/* drop the ref just got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		sclp_mem_change_state(addr, block_size, 0);
>  		__remove_memory(addr, block_size);
>  #ifdef CONFIG_KASAN
> @@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
>  		return rc;
>  	block_size = memory_block_size_bytes();
>  	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
> -	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
> +	mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
>  	if (!mem) {
>  		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
>  	} else {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		rc = -EBUSY;
>  	}
>  	unlock_device_hotplug();
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 5bb5599c6b2b..463dc02f6cff 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern void memory_dev_init(void);
>  extern int memory_notify(enum memory_block_state state, void *v);
> -extern struct memory_block *find_memory_block(unsigned long section_nr);
> +struct memory_block *memory_block_get(unsigned long block_id);
> +static inline void memory_block_put(struct memory_block *mem)
> +{
> +	put_device(&mem->dev);
> +}

Hi Muchun,

Thanks for the work, I have a small suggestion if that fits your thought.

I think we should at least add a comment  above memory_block_put() to remind the caller to check
for the availabitliy of "mem" before calling this function.
We perform the check in memory_block_get() inside the function body, I see different usage pattern
across the caller when they're dealing with "mem == NULL" and avoid to call memory_block_put(), 
I can understand we should leverage the check to caller, not inside memory_block_put().
But just in case the next caller might forgot to do the check or think the behavior might be symmetric
bettween memory_block_get() and memory_block_put(), a comment above the function would be nice.

Best regards,
Richard Cheng.

>  typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>  extern int walk_memory_blocks(unsigned long start, unsigned long size,
>  			      void *arg, walk_memory_blocks_func_t func);
> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
>  typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
>  int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  			       struct memory_group *excluded, void *arg);
> -struct memory_block *find_memory_block_by_id(unsigned long block_id);
>  #define hotplug_memory_notifier(fn, pri) ({		\
>  	static __meminitdata struct notifier_block fn##_mem_nb =\
>  		{ .notifier_call = fn, .priority = pri };\
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 462d8dcd636d..890c6453e887 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>  		struct vmem_altmap *altmap = NULL;
>  		struct memory_block *mem;
>  
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> +		mem = memory_block_get(phys_to_block_id(cur_start));
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
>  
>  		altmap = mem->altmap;
>  		mem->altmap = NULL;
> -		/* drop the ref. we got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  
>  		remove_memory_block_devices(cur_start, memblock_size);
>  
> 
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> -- 
> 2.54.0
> 
> 

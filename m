Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726754AbgDHNom (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 09:44:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038DYupe118084
        for <linux-s390@vger.kernel.org>; Wed, 8 Apr 2020 09:44:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30921053t8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2020 09:44:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 8 Apr 2020 14:44:25 +0100
Subject: Re: [PATCH 28/28] s390: use __vmalloc_node in stack_alloc
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-29-hch@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 8 Apr 2020 15:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200408115926.1467567-29-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6689b12a-4473-af2e-0fa0-69097eb2bb52@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org



On 08.04.20 13:59, Christoph Hellwig wrote:
> stack_alloc can use a slightly higher level vmalloc function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/kernel/setup.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 36445dd40fdb..0f0b140b5558 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -305,12 +305,9 @@ void *restart_stack __section(.data);
>  unsigned long stack_alloc(void)
>  {
>  #ifdef CONFIG_VMAP_STACK
> -	return (unsigned long)
> -		__vmalloc_node_range(THREAD_SIZE, THREAD_SIZE,
> -				     VMALLOC_START, VMALLOC_END,
> -				     THREADINFO_GFP,
> -				     PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				     __builtin_return_address(0));
> +	return (unsigned long)__vmalloc_node(THREAD_SIZE, THREAD_SIZE,
> +			THREADINFO_GFP, NUMA_NO_NODE,
> +			__builtin_return_address(0));

Looks sane.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


>  #else
>  	return __get_free_pages(GFP_KERNEL, THREAD_SIZE_ORDER);
>  #endif
> 

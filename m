Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728620AbgDHNdh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 09:33:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038DX3Fk040624
        for <linux-s390@vger.kernel.org>; Wed, 8 Apr 2020 09:33:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3092044h7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Apr 2020 09:33:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 8 Apr 2020 14:33:07 +0100
Subject: Re: [PATCH 27/28] s390: use __vmalloc_node in alloc_vm_stack
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-28-hch@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 8 Apr 2020 15:33:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200408115926.1467567-28-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <de7703c7-5d0c-51f1-87fa-6ce43ad69f60@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

On 08.04.20 13:59, Christoph Hellwig wrote:
> alloc_vm_stack can use a slightly higher level vmalloc function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kernel/irq.c | 5 ++---

wrong subject (power vs s390)

>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a25ed47087ee..4518fb1d6bf4 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -735,9 +735,8 @@ void do_IRQ(struct pt_regs *regs)
>  
>  static void *__init alloc_vm_stack(void)
>  {
> -	return __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, VMALLOC_START,
> -				    VMALLOC_END, THREADINFO_GFP, PAGE_KERNEL,
> -				     0, NUMA_NO_NODE, (void*)_RET_IP_);
> +	return __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, THREADINFO_GFP,
> +			      NUMA_NO_NODE, (void *)_RET_IP_);
>  }
>  
>  static void __init vmap_irqstack_init(void)
> 

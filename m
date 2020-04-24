Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgDXIS4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 04:18:56 -0400
Subject: Re: [PATCH v1] s390: drop memory notifier for protecting kdump crash
 kernel area
References: <20200424081218.6919-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <548f3adb-7569-93a0-ef79-0f5d65f8ef0d@redhat.com>
Date: Fri, 24 Apr 2020 10:18:45 +0200
MIME-Version: 1.0
In-Reply-To: <20200424081218.6919-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Michal Hocko <mhocko@kernel.org>

On 24.04.20 10:12, David Hildenbrand wrote:
> Assume we have a crashkernel area of 256MB reserved:
> 
> root@vm0:~# cat /proc/iomem
> 00000000-6fffffff : System RAM
>   0f258000-0fcfffff : Kernel code
>   0fd00000-101d10e3 : Kernel data
>   105b3000-1068dfff : Kernel bss
> 70000000-7fffffff : Crash kernel
> 
> This exactly corresponds to memory block 7 (memory block size is 256MB).
> Trying to offline that memory block results in:
> 
> root@vm0:~# echo "offline" > /sys/devices/system/memory/memory7/state
> -bash: echo: write error: Device or resource busy
> 
> [  128.458762] page:000003d081c00000 refcount:1 mapcount:0 mapping:00000000d01cecd4 index:0x0
> [  128.458773] flags: 0x1ffff00000001000(reserved)
> [  128.458781] raw: 1ffff00000001000 000003d081c00008 000003d081c00008 0000000000000000
> [  128.458781] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> [  128.458783] page dumped because: unmovable page
> 
> The craskernel area is marked reserved in the bootmem allocator. This
> results in the memmap getting initialized (refcount=1, PG_reserved), but
> the pages are never freed to the page allocator.
> 
> So these pages look like allocated pages that are unmovable (esp.
> PG_reserved), and therefore, memory offlining fails early, when trying to
> isolate the page range.
> 
> We don't need a special memory notifier and can drop it. Repeating the
> above test with this patch results in the same behavior.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/setup.c | 33 ---------------------------------
>  1 file changed, 33 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 0f0b140b5558..95d4fba0d811 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -39,7 +39,6 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/dma-contiguous.h>
>  #include <linux/device.h>
> -#include <linux/notifier.h>
>  #include <linux/pfn.h>
>  #include <linux/ctype.h>
>  #include <linux/reboot.h>
> @@ -591,35 +590,6 @@ static void __init setup_memory_end(void)
>  	pr_notice("The maximum memory size is %luMB\n", memory_end >> 20);
>  }
>  
> -#ifdef CONFIG_CRASH_DUMP
> -
> -/*
> - * When kdump is enabled, we have to ensure that no memory from
> - * the area [0 - crashkernel memory size] and
> - * [crashk_res.start - crashk_res.end] is set offline.
> - */

Re-reading that comment, I missed the [0 - crashkernel memory size]
part (for relocation IIRC). So we might want to keep checking for [0 -
crashkernel memory size] - will double check.


-- 
Thanks,

David / dhildenb

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMlq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 08:41:46 -0400
Subject: Re: [PATCH v2] s390: simplify memory notifier for protecting kdump
 crash kernel area
References: <20200424083904.8587-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <889669d5-5d5f-fe61-e269-1227a181d503@de.ibm.com>
Date: Thu, 14 May 2020 14:41:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200424083904.8587-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Michal Hocko <mhocko@kernel.org>

On 24.04.20 10:39, David Hildenbrand wrote:
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
> We only have to care about the exchange area, make that clear.
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

Thanks applied

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729521AbfI3Gad (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 02:30:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8U6RMcU002109
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 02:30:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbaevbuw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 02:30:31 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 30 Sep 2019 07:30:29 +0100
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
 <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
 <1569619686.5576.242.camel@lca.pw>
 <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Sep 2019 08:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <38b32d77-8ab7-1971-63e4-0bd8c4c1d3da@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org



On 27.09.19 23:59, Andrew Morton wrote:
> On Fri, 27 Sep 2019 17:28:06 -0400 Qian Cai <cai@lca.pw> wrote:
> 
>>>
>>> So I think you've moved the arch_free_page() to be after the final
>>> thing which can access page contents, yes?  If so, we should have a
>>> comment in free_pages_prepare() to attmept to prevent this problem from
>>> reoccurring as the code evolves?
>>
>> Right, something like this above arch_free_page() there?
>>
>> /*
>>  * It needs to be just above kernel_map_pages(), as s390 could mark those
>>  * pages unused and then trigger a fault when accessing.
>>  */
> 
> I did this.
> 
> --- a/mm/page_alloc.c~mm-page_alloc-fix-a-crash-in-free_pages_prepare-fix
> +++ a/mm/page_alloc.c
> @@ -1179,7 +1179,13 @@ static __always_inline bool free_pages_p
>  		kernel_init_free_pages(page, 1 << order);
>  
>  	kernel_poison_pages(page, 1 << order, 0);
> +	/*
> +	 * arch_free_page() can make the page's contents inaccessible.  s390
> +	 * does this.  So nothing which can access the page's contents should
> +	 * happen after this.
> +	 */
>  	arch_free_page(page, order);
> +
>  	if (debug_pagealloc_enabled())
>  		kernel_map_pages(page, 1 << order, 0);


With that Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

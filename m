Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A45EC43460
	for <linux-s390@archiver.kernel.org>; Fri, 16 Apr 2021 11:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF126113B
	for <linux-s390@archiver.kernel.org>; Fri, 16 Apr 2021 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhDPLHP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Apr 2021 07:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:56748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPLHP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Apr 2021 07:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C080ADE2;
        Fri, 16 Apr 2021 11:06:50 +0000 (UTC)
To:     lipeifeng@oppo.com, peifengl55@gmail.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210414023803.937-1-lipeifeng@oppo.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
Date:   Fri, 16 Apr 2021 13:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414023803.937-1-lipeifeng@oppo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/14/21 4:38 AM, lipeifeng@oppo.com wrote:
> From: lipeifeng <lipeifeng@oppo.com>
> 
> This patch would "sort" the free-pages in buddy by pages-PFN to concentrate
> low-order-pages allocation in the front area of memory and high-order-pages
> allcation on the contrary so that few memory-pollution in the back area of
> memory and the probablity of high-order-pages allocation would be increased
> significantly.
> -----------------------------------------------------------------------
> 
>   1) Divide memory into several segments by pages-PFN
>      "Multi_freearea" would divide memory into FREE_AREA_COUNTS segments
>      by pages-PFN,each memory-segment corresponds to a free_area.
> 
>      Example: machine(4G of physical memery) and FREE_AREA_COUNTS(4):
>         page-PFN:0x0     0x40000(1G)   0x80000(2G)  0xc0000(3G) 0xFFFFF(4G)
>                  |------------|--------------|--------------|-------------|
>         free_area:  [0][]           [1][]           [2][]        [3][]
> 
>      NOTE: Selecting the corresponding freearea when pages are freed back
> 	       to buddy:
>         - pages-PFN[0, free_area_segment[0].max_pfn] -> free_area[0][]
>         - pages-PFN[free_area_segment[flc - 1].max_pfn,
> 	            free_area_segment[flc].max_pfn] -> free_area[flc][]
>                    (flc > 0)
> 
>      By this way, all pages in the same segment/free_area is within a
>      certain range of pages-PFN.
> 
>   2) Select the corresponding freearea to alloc-pages
>      "Multi_freearea" would select the corresponding free_area by the
>      allocation-order when alloc-pages.
>         - order <  HIGH_ORDER_TO_FLC:
> 	        free_area[0] -> ... -> free_area[FREE_AREA_COUNTS - 1]
>         - order >= HIGH_ORDER_TO_FLC:
> 	        free_area[FREE_AREA_COUNTS - 1] -> ... -> free_area[0]
> 
>      Example:
>         The machine(4G of physical memery) and FREE_AREA_COUNTS(4)
>         and HIGH_ORDER_TO_FLC(3).
> 	If user allocs page(order = 0),it would take page from
> 	free_area[0][] first, if that fails,try free_area[1][] and so on.
> 	If user allocs page(order = 4),it would take page from
> 	free_area[3][] first, if that fails,try free_area[2][] and so on.
> 
>      By this way,low-order pages will be concentrated in the front area
>      of memory.Because of few memory-pollution in the back area of memory,
>      the sussessful probablity of high-order allocation would be improved.
> 
>   3) Adjust the location of free-pages in the free_list
>      "Multi_freearea" would place free-pages in the head of free_list if
>      pages-PFN is smaller than free_area_segment[flc]->median_pfn and in
>      the tail of free_list on the contrary.
> 
>      Example:
>         page-PFN:        free_area_segment[flc]->median_pfn
>                                         |
>         free_list: page->page->page->...|...page->page->page
>         pages-PFN:|   < median_pfn      |  >= median_pfn    |
> 
>      Because it would take pages from the head of the freelist first in
>      buddy system,the free-pages in the tail are more likely to keep in the
>      buddy system.The closer the PFN of pages kept in buddy system, the
>      greater the probablity of merging that into high-order pages.

I think this part 3) would be worth to be tried separately first, as it's not a
big change compared to the other ones.

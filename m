Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB3AC433B4
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 15:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E23160FF3
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 15:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbhEQPMt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 May 2021 11:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241479AbhEQPKp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 May 2021 11:10:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B470AEBB;
        Mon, 17 May 2021 15:09:27 +0000 (UTC)
Date:   Mon, 17 May 2021 16:09:22 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, ziy@nvidia.com, mhocko@suse.com,
        ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/7] mm: memory: add orig_pmd to struct vm_fault
Message-ID: <20210517150922.GU3672@suse.de>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210413212416.3273-2-shy828301@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 13, 2021 at 02:24:10PM -0700, Yang Shi wrote:
> Add orig_pmd to struct vm_fault so the "orig_pmd" parameter used by huge page
> fault could be removed, just like its PTE counterpart does.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> <SNIP>
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 25b9041f9925..9c5856f8cc81 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -547,6 +547,9 @@ struct vm_fault {
>  					 * the 'address'
>  					 */
>  	pte_t orig_pte;			/* Value of PTE at the time of fault */
> +	pmd_t orig_pmd;			/* Value of PMD at the time of fault,
> +					 * used by PMD fault only.
> +					 */
>  
>  	struct page *cow_page;		/* Page handler may use for COW fault */
>  	struct page *page;		/* ->fault handlers should return a

Could this be a union?

-- 
Mel Gorman
SUSE Labs

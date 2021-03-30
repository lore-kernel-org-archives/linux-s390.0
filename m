Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D6C433E0
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 00:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EAF61996
	for <linux-s390@archiver.kernel.org>; Tue, 30 Mar 2021 00:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC3AV7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:21:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:39274 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhC3AVa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Mar 2021 20:21:30 -0400
IronPort-SDR: 9mPvooaT9C45CatCby5UIdz+nzCMA51HaR2EcTq98X4zqwp7cDAFwK5Wq9U6/j4roEUBqUT5SU
 Ibl/a1Vl65UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="255647126"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="255647126"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:21:28 -0700
IronPort-SDR: i1TLOkluRkhSAVidGcNy0qg3WvjCOXr4+YtdP+Xrfvr2vBu6l5+gk/Uc+352erOpvIvup8gtEm
 +pdrdP9Z7b2Q==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417911010"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:21:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, hughd@google.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: migrate: teach migrate_misplaced_page() about THP
References: <20210329183312.178266-1-shy828301@gmail.com>
        <20210329183312.178266-4-shy828301@gmail.com>
Date:   Tue, 30 Mar 2021 08:21:23 +0800
In-Reply-To: <20210329183312.178266-4-shy828301@gmail.com> (Yang Shi's message
        of "Mon, 29 Mar 2021 11:33:09 -0700")
Message-ID: <87ft0dbif0.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> In the following patch the migrate_misplaced_page() will be used to migrate THP
> for NUMA faul too.  Prepare to deal with THP.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/migrate.h | 6 ++++--
>  mm/memory.c             | 2 +-
>  mm/migrate.c            | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3a389633b68f..6abd34986cc5 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -102,14 +102,16 @@ static inline void __ClearPageMovable(struct page *page)
>  #ifdef CONFIG_NUMA_BALANCING
>  extern bool pmd_trans_migrating(pmd_t pmd);
>  extern int migrate_misplaced_page(struct page *page,
> -				  struct vm_area_struct *vma, int node);
> +				  struct vm_area_struct *vma, int node,
> +				  bool compound);
>  #else
>  static inline bool pmd_trans_migrating(pmd_t pmd)
>  {
>  	return false;
>  }
>  static inline int migrate_misplaced_page(struct page *page,
> -					 struct vm_area_struct *vma, int node)
> +					 struct vm_area_struct *vma, int node,
> +					 bool compound)
>  {
>  	return -EAGAIN; /* can't migrate now */
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 003bbf3187d4..7fed578bdc31 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4169,7 +4169,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	}
>  
>  	/* Migrate to the requested node */
> -	migrated = migrate_misplaced_page(page, vma, target_nid);
> +	migrated = migrate_misplaced_page(page, vma, target_nid, false);
>  	if (migrated) {
>  		page_nid = target_nid;
>  		flags |= TNF_MIGRATED;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 62b81d5257aa..9c4ae5132919 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2127,7 +2127,7 @@ static inline bool is_shared_exec_page(struct vm_area_struct *vma,
>   * the page that will be dropped by this function before returning.
>   */
>  int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
> -			   int node)
> +			   int node, bool compound)

Can we just use PageCompound(page) instead?

Best Regards,
Huang, Ying

>  {
>  	pg_data_t *pgdat = NODE_DATA(node);
>  	int isolated;

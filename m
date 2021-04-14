Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F54C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 03:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E610610C8
	for <linux-s390@archiver.kernel.org>; Wed, 14 Apr 2021 03:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbhDNDBT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Apr 2021 23:01:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:8507 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242332AbhDNDBR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Apr 2021 23:01:17 -0400
IronPort-SDR: osedgeyVcgYWZD8n9ZMWFGyk7DMIN/8IFuQSbuGFL5E8v0HZ3jHimUw4fVN7L9J2Aa2Bud3Pzg
 1cyjm0sqoGKA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194664623"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194664623"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 20:00:56 -0700
IronPort-SDR: fXScKB/ywknplN1St0lrxW+tlSh+sIleiY23QVpHHBfz31pU69vzx4yWcWZ6l9uhlTt9co7XZK
 9Z4nIFT/1yuA==
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="418118465"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 20:00:52 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        mhocko@suse.com, hughd@google.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 6/7] mm: migrate: check mapcount for THP instead of
 ref count
References: <20210413212416.3273-1-shy828301@gmail.com>
        <20210413212416.3273-7-shy828301@gmail.com>
Date:   Wed, 14 Apr 2021 11:00:50 +0800
In-Reply-To: <20210413212416.3273-7-shy828301@gmail.com> (Yang Shi's message
        of "Tue, 13 Apr 2021 14:24:15 -0700")
Message-ID: <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> The generic migration path will check refcount, so no need check refcount here.
> But the old code actually prevents from migrating shared THP (mapped by multiple
> processes), so bail out early if mapcount is > 1 to keep the behavior.

What prevents us from migrating shared THP?  If no, why not just remove
the old refcount checking?

Best Regards,
Huang, Ying

> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/migrate.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a72994c68ec6..dc7cc7f3a124 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2067,6 +2067,10 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  
>  	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
>  
> +	/* Do not migrate THP mapped by multiple processes */
> +	if (PageTransHuge(page) && page_mapcount(page) > 1)
> +		return 0;
> +
>  	/* Avoid migrating to a node that is nearly full */
>  	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
>  		return 0;
> @@ -2074,18 +2078,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	if (isolate_lru_page(page))
>  		return 0;
>  
> -	/*
> -	 * migrate_misplaced_transhuge_page() skips page migration's usual
> -	 * check on page_count(), so we must do it here, now that the page
> -	 * has been isolated: a GUP pin, or any other pin, prevents migration.
> -	 * The expected page count is 3: 1 for page's mapcount and 1 for the
> -	 * caller's pin and 1 for the reference taken by isolate_lru_page().
> -	 */
> -	if (PageTransHuge(page) && page_count(page) != 3) {
> -		putback_lru_page(page);
> -		return 0;
> -	}
> -
>  	page_lru = page_is_file_lru(page);
>  	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
>  				thp_nr_pages(page));

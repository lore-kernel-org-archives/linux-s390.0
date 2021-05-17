Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87D7C433ED
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDBB6101B
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 15:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhEQPeE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 May 2021 11:34:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243299AbhEQPcE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 May 2021 11:32:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4636DB23C;
        Mon, 17 May 2021 15:30:46 +0000 (UTC)
Date:   Mon, 17 May 2021 16:30:44 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, ziy@nvidia.com, mhocko@suse.com,
        ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 7/7] mm: thp: skip make PMD PROT_NONE if THP migration
 is not supported
Message-ID: <20210517153044.GZ3672@suse.de>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-8-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210413212416.3273-8-shy828301@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 13, 2021 at 02:24:16PM -0700, Yang Shi wrote:
> A quick grep shows x86_64, PowerPC (book3s), ARM64 and S390 support both
> NUMA balancing and THP.  But S390 doesn't support THP migration so NUMA
> balancing actually can't migrate any misplaced pages.
> 
> Skip make PMD PROT_NONE for such case otherwise CPU cycles may be wasted
> by pointless NUMA hinting faults on S390.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs

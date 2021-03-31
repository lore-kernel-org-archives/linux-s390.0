Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A5C43460
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 13:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B906196C
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 13:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhCaNVS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:21:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235314AbhCaNU4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Mar 2021 09:20:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93AA6B21D;
        Wed, 31 Mar 2021 13:20:55 +0000 (UTC)
Date:   Wed, 31 Mar 2021 14:20:53 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        ziy@nvidia.com, mhocko@suse.com, ying.huang@intel.com,
        hughd@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
Message-ID: <20210331132053.GW15768@suse.de>
References: <20210329183312.178266-1-shy828301@gmail.com>
 <20210330164200.01a4b78f@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210330164200.01a4b78f@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 30, 2021 at 04:42:00PM +0200, Gerald Schaefer wrote:
> Could there be a work-around by splitting THP pages instead of marking them
> as migrate pmds (via pte swap entries), at least when THP migration is not
> supported? I guess it could also be acceptable if THP pages were simply not
> migrated for NUMA balancing on s390, but then we might need some extra config
> option to make that behavior explicit.
> 

The split is not done on other architectures simply because the loss
from splitting exceeded the gain of improved locality in too many cases.
However, it might be ok as an s390-specific workaround.

(Note, I haven't read the rest of the series due to lack of time but this
query caught my eye).

-- 
Mel Gorman
SUSE Labs

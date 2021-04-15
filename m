Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED23C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562B261139
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 06:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhDOGq2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 02:46:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:21856 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhDOGq2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 02:46:28 -0400
IronPort-SDR: qXA0Cy5Sxat0HlfJSXHh9gid2sfZE9wDO326BmQtwTQB+2Q+8CbzsinEgj5BrSrTPUQg8OT5b6
 N9jAMKFK1F9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191609700"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="191609700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 23:46:02 -0700
IronPort-SDR: 1pfPbXhjlYYReGkPxq6HfP4+S3mzqWZg9G55ESeGOM9vhqkGCJ7BYRc35RiXXmWynnugSAJ6uM
 atnC5MlIfazg==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="425061751"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 23:45:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Zi Yan" <ziy@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, <mgorman@suse.de>,
        <kirill.shutemov@linux.intel.com>, <mhocko@suse.com>,
        <hughd@google.com>, <gerald.schaefer@linux.ibm.com>,
        <hca@linux.ibm.com>, <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 6/7] mm: migrate: check mapcount for THP instead of
 ref count
References: <20210413212416.3273-1-shy828301@gmail.com>
        <20210413212416.3273-7-shy828301@gmail.com>
        <87k0p5sh7h.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <6297AD92-8D0E-4BEC-8E1F-5C5AC32FA128@nvidia.com>
Date:   Thu, 15 Apr 2021 14:45:54 +0800
In-Reply-To: <6297AD92-8D0E-4BEC-8E1F-5C5AC32FA128@nvidia.com> (Zi Yan's
        message of "Wed, 14 Apr 2021 11:02:58 -0400")
Message-ID: <87fszsoxjx.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

"Zi Yan" <ziy@nvidia.com> writes:

> On 13 Apr 2021, at 23:00, Huang, Ying wrote:
>
>> Yang Shi <shy828301@gmail.com> writes:
>>
>>> The generic migration path will check refcount, so no need check refcount here.
>>> But the old code actually prevents from migrating shared THP (mapped by multiple
>>> processes), so bail out early if mapcount is > 1 to keep the behavior.
>>
>> What prevents us from migrating shared THP?  If no, why not just remove
>> the old refcount checking?
>
> If two or more processes are in different NUMA nodes, a THP shared by them can be
> migrated back and forth between NUMA nodes, which is quite costly. Unless we have
> a better way of figuring out a good location for such pages to reduce the number
> of migration, it might be better not to move them, right?
>

Some mechanism has been provided in should_numa_migrate_memory() to
identify the shared pages from the private pages.  Do you find it
doesn't work well in some situations?

The multiple threads in one process which run on different NUMA nodes
may share pages too.  So it isn't a good solution to exclude pages
shared by multiple processes.

Best Regards,
Huang, Ying

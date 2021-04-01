Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EEDC433B4
	for <linux-s390@archiver.kernel.org>; Thu,  1 Apr 2021 20:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A77610D1
	for <linux-s390@archiver.kernel.org>; Thu,  1 Apr 2021 20:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhDAUMl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhDAUMl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Apr 2021 16:12:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58914C0613E6;
        Thu,  1 Apr 2021 13:12:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hq27so4631736ejc.9;
        Thu, 01 Apr 2021 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RELdyoJ3mdxBRdi3zE7PaTML6+VOkh57f4y7o9oQPs=;
        b=BRMEjnbiNfMVhUbUPe/Za+3fa+t9pCHc1P29MuyXNMwWOzN+wZBnSiAUdll2YDL8GG
         XpZ05cRnYgDf+lO6Dbi3aZD81Yz4L/ZwlkTEW6nlpENXvUO+/4N30VVs8PMyjzJ4gSZp
         IjDH9sPPe6Lw/5mP570ADeoiwRvDkUTMLu2jQVT2+G/5EOhWKJADcv5JS4EoDcyYtRte
         YQqpmkJ8zRi8yJmrwLsiXHblu4b8SFAIJJupI08spxpjJNHooIdaa/gsc1SP1qVf5KuP
         30Gfn+z7PfZrG+En6KfDSbIimc2GKlZV3TJVCgelE9FRhjCwWzyuiEOjGVViySoBlDNJ
         ZuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RELdyoJ3mdxBRdi3zE7PaTML6+VOkh57f4y7o9oQPs=;
        b=T/gxNIHstAFg3HKJr/+FCP18Wv/7mR84tck8uxMT01+cnPZti3pFsKdUhEZTEUOBQr
         Yd1/ViHhyZ8JvkN7YHCrWBt+sJRGB1ipXppkp0krV3q1J3RKHUl9MWirLVuhh+pzQyKz
         Znbe6+gUaXMjMXRhRRtHmVSCXhDCOYICfXbmrKtBkLzAYFtLs38N8xqhReXYcl2JMPEi
         hmLu+dPFKdmYlnxkYg6boism80nGb9k3ciGCFt5rNZQXgmh1gBxcpPZk6y0RfDldFLLI
         GJVy1y33JAMDgVgpsUJdiY0tNp2pF34qN9SMKZk7z8A7AIzx0zjlzS2GeAFd7jtJMOPc
         zNMQ==
X-Gm-Message-State: AOAM530gUOVjtgwY/ToEaI8AR+tf6H9bIOI/QZP+5rwkoqwA7t1NM8sO
        wz0rClb+r5wA0TG0xYjRzCBDVkAyOCHI+dBIrMA=
X-Google-Smtp-Source: ABdhPJy8ZU45eCiR5zibHk9azCrqAIUfIh6snXCOXNIXWgzPQn9kWt7iw4FUdAxqMZ3lvaK560nWW8o6XxPXJBiFi5o=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr10810124ejb.238.1617307960129;
 Thu, 01 Apr 2021 13:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183312.178266-1-shy828301@gmail.com> <20210330164200.01a4b78f@thinkpad>
 <20210331132053.GW15768@suse.de>
In-Reply-To: <20210331132053.GW15768@suse.de>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Apr 2021 13:12:28 -0700
Message-ID: <CAHbLzkob_G=nNScD42-xUWJWBpOCDTTqU7F-Eg_az_MTbcgMOA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm: thp: use generic THP migration for NUMA
 hinting fault
To:     Mel Gorman <mgorman@suse.de>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 31, 2021 at 6:20 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Mar 30, 2021 at 04:42:00PM +0200, Gerald Schaefer wrote:
> > Could there be a work-around by splitting THP pages instead of marking them
> > as migrate pmds (via pte swap entries), at least when THP migration is not
> > supported? I guess it could also be acceptable if THP pages were simply not
> > migrated for NUMA balancing on s390, but then we might need some extra config
> > option to make that behavior explicit.
> >
>
> The split is not done on other architectures simply because the loss
> from splitting exceeded the gain of improved locality in too many cases.
> However, it might be ok as an s390-specific workaround.
>
> (Note, I haven't read the rest of the series due to lack of time but this
> query caught my eye).

Will wait for your comments before I post v2. Thanks.

>
> --
> Mel Gorman
> SUSE Labs

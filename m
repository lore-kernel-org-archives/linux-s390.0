Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2946C433B4
	for <linux-s390@archiver.kernel.org>; Fri,  9 Apr 2021 19:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6C6610F9
	for <linux-s390@archiver.kernel.org>; Fri,  9 Apr 2021 19:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhDITlq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhDITlq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Apr 2021 15:41:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA22BC061762
        for <linux-s390@vger.kernel.org>; Fri,  9 Apr 2021 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=wO/sC5No3kUj5SjPijizwqvcx+tKlq7DkfM462oHc/U=; b=nRZ+I2nTvnQQqZVH6T9L2qGCpG
        EA5pqzswHMrFVnongAK29CFZIs22UpPUjkefiA7zhbk4mo4NPWOAe536HZ7b9LqjpygbF2hyKUog0
        G02pT4AVPG/1Y8btkx32MFjcKQ0cy2JGTY/ukJ/XMyXXRk46wV1BPL+YqN6Q5dK+QWZerSHmMHSZ9
        lp98q85Mk+H8mRC/4ALTZXqieWGEMcU6CztgxzYUg/i9sFZx2pUjfoB+r5094TKfvXSjXiBKt/hOi
        aOEjq4Mu2z591PVo3c8SspxXsl/5oRi5MEFeydBJZuF1wAI5dh+Z+e/TFHrN2wIuRidOfE5WekVzD
        /XizPSSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwzz-000qar-Us; Fri, 09 Apr 2021 19:41:09 +0000
Date:   Fri, 9 Apr 2021 20:40:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Inaccessible pages & folios
Message-ID: <20210409194059.GW2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Claudio,

I'm working on making the page cache manage memory in larger chunks than
PAGE_SIZE [1] [2].  In doing so, I came across this call that you added:

@@ -2807,6 +2807,13 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
                inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
        }
        unlock_page_memcg(page);
+       access_ret = arch_make_page_accessible(page);

I'm going to change __test_set_page_writeback() to take a folio [3] and
now I'm wondering what interface you'd like to use.  My preference would
be to rename arch_make_page_accessible() to arch_make_folio_accessible()
and pass a folio, at which time you would make the entire folio (however
many pages might be in it) accessible.  If you would rather, we can
leave the interface as arch_make_page_accessible(), in which case we'll
just call it N times in __test_set_page_writeback() (and I won't need
to touch gup.c).

Let me know what you want.

[1] https://lwn.net/Articles/849538/
[2] https://lore.kernel.org/linux-mm/20210409185105.188284-1-willy@infradead.org/
[3] https://git.infradead.org/users/willy/pagecache.git/commitdiff/85297eb08f1b034b9652ea63dd053e3be4d7de7f

PS: The prototype is in gfp.h.  That's not really appropriate; gfp.h
is about allocating memory, and this call really has nothing to do with
memory allocation.  I think mm.h is a better place for it, if you can't
find a better header file than that.

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBUN6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 16:13:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E70C061245
        for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2020 13:13:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w186so1005316qkd.1
        for <linux-s390@vger.kernel.org>; Wed, 02 Sep 2020 13:13:57 -0700 (PDT)
Date: Wed, 2 Sep 2020 17:13:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200902201355.GJ24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
 <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
 <20200901194020.418da486@thinkpad>
 <91988792-069c-31a6-7840-0122357538c7@nvidia.com>
 <20200902142437.5f39b4bb@thinkpad>
 <20200902170958.09be0c3e@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902170958.09be0c3e@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Wed, Sep 02, 2020 at 05:09:58PM +0200, Gerald Schaefer wrote:
> I guess we *could* assume that all the extra pXd_offset() calls and
> also the de-referencing would be optimized out by the compiler for other
> archs, but it is one example where my gut tells me that this might not
> be so trivial and w/o unwanted effects after all.

Assigning to a variable that is never read should be eliminated.. If
things are very complex then the pXX_offset function might need to be
marked with attribute pure, but I think this should be reliable?

Jason

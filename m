Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgH1OVj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Aug 2020 10:21:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A0C061264
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 07:21:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so440902qvo.13
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 07:21:39 -0700 (PDT)
Date: Fri, 28 Aug 2020 11:21:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828142137.GX24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, Aug 28, 2020 at 04:03:12PM +0200, Gerald Schaefer wrote:
> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> code") introduced a subtle but severe bug on s390 with gup_fast, due to
> dynamic page table folding.

I think the page walk code in mm/pagewalk.c has similar issues to
GUP. I've been noodling on some patches to add the missing stack
copies to pagewalk.c as they are clearly missing..

It would be good if this could be less GUP specific?

Generically this is about walking the page table without holding the
page table spinlocks using READ_ONCE.

Jason

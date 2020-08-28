Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgH1PUJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Aug 2020 11:20:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350CC061264
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so1247613qkd.9
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
Date: Fri, 28 Aug 2020 12:20:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828152006.GY24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <20200828142137.GX24045@ziepe.ca>
 <20200828170103.6d954d95@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828170103.6d954d95@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, Aug 28, 2020 at 05:01:03PM +0200, Gerald Schaefer wrote:

> Just to make sure, you are referring to some future / planned
> changes to mm/pagewalk.c, and not some currently existing
> pagetable walkers already using the READ_ONCE logic w/o
> spinlocks? 

Yes no current code, just something I've been looking at slowly.

Jason

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgIJRUA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 13:20:00 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25699C061786
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2020 10:20:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so5478731qtd.2
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2020 10:20:00 -0700 (PDT)
Date: Thu, 10 Sep 2020 14:19:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910171956.GM87483@ziepe.ca>
References: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <20200910130233.GK87483@ziepe.ca>
 <20200910152803.1a930afc@thinkpad>
 <20200910151026.GL87483@ziepe.ca>
 <20200910190757.153319d4@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910190757.153319d4@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, Sep 10, 2020 at 07:07:57PM +0200, Gerald Schaefer wrote:

> I might have lost track a bit. Are we still talking about possible
> functional impacts of either our current pagetable walking with s390
> (apart from gup_fast), or the proposed generic change (for s390, or
> others?)?

I'm looking for an more understandable explanation what is wrong with
the S390 implementation.

If the page operations require the invariant I described then it is
quite easy to explain the problem and understand the solution.

Jason

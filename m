Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64761 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgD3WUJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 18:20:09 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
From: Dave Hansen <dave.hansen@intel.com>
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
Message-ID: <561b39e0-4501-a6c3-5aa8-13a68d1c9484@intel.com>
Date: Thu, 30 Apr 2020 15:20:07 -0700
MIME-Version: 1.0
In-Reply-To: <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk
Cc: david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

One other thing...  The gup code will not take references on ref-frozen
pages:

> static inline __must_check bool try_get_page(struct page *page)
> {
>         page = compound_head(page);
>         if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>                 return false;
>         page_ref_inc(page);
>         return true;
> }

*But*, notice that the path that skips taking a ref is also a
WARN_ON_ONCE().  Basically, if you get to try_get_page() on a ref-frozen
page, it's considered buggy.  This makes sense because you fundamentally
can't freeze refs on a page that might have more refs taken on it.

I think all the other users do this by ensuring that any PTE that could
be gup'd is set non-present before the refs are frozen and remote TLBs
are flushed which also ensures no GUPs are running.  I don't know if the
s390 code has some other way of preventing GUPs, but leaving Present=1
PTEs while you freeze refs would be quite troublesome on x86.

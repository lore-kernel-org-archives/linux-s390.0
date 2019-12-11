Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKIht (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 03:37:49 -0500
Date: Wed, 11 Dec 2019 09:37:45 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the
 pgprot_t in arch_add_memory()
Message-ID: <20191211083745.GA14655@dhcp22.suse.cz>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
 <20191210100432.GC10404@dhcp22.suse.cz>
 <6da2b279-6a6d-d89c-a34c-962ed021d91d@redhat.com>
 <20191210103452.GF10404@dhcp22.suse.cz>
 <a9d6cfe8-39fb-accf-acdc-7cce5578bf2f@redhat.com>
 <297b7cc0-c5bc-a4c6-83eb-afc008395234@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297b7cc0-c5bc-a4c6-83eb-afc008395234@deltatee.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Tue 10-12-19 16:52:31, Logan Gunthorpe wrote:
[...]
> In my opinion, having a coder and reviewer see PAGE_KERNEL and ask if
> that makes sense is a benefit. Having it hidden because we don't want
> people to think about it is worse, harder to understand and results in
> bugs that are more difficult to spot.

My experience would disagree here. We have several examples in the MM
where an overly complex and versatile APIs led to suble bugs, a lot of
copy&pasting and cargo cult programing (just look at the page allocator
as a shiny example - e.g. gfp_flags). So I am always trying to be
carefull here.

> Though, we may be overthinking this: arch_add_memory() is a low level
> non-exported API that's currently used in exactly two places.

This is a fair argument. Most users are and should be using
add_memory().

> I don't
> think there's going to be many, if any, valid new use cases coming up
> for it in the future. That's more what memremap_pages() is for.

OK, fair enough. If this is indeed the simplest way forward then I will
not stand in the way.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:32283 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Rzy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 13:55:54 -0400
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <609afef2-43c2-d048-1c01-448a53a54d4e@intel.com>
Date: Wed, 29 Apr 2020 10:55:52 -0700
MIME-Version: 1.0
In-Reply-To: <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com

On 4/29/20 10:31 AM, Christian Borntraeger wrote:
> On 29.04.20 18:07, Dave Hansen wrote:
>> On 4/28/20 3:50 PM, Claudio Imbrenda wrote:
>>> If a page is inaccesible and it is used for things like sendfile, then
>>> the content of the page is not always touched, and can be passed
>>> directly to a driver, causing issues.
>>>
>>> This patch fixes the issue by adding a call to arch_make_page_accessible
>>> in page_cache_pipe_buf_confirm; this fixes the issue.
>> I spent about 5 minutes putting together a patch:
>>
>> 	https://sr71.net/~dave/intel/accessible.patch
>>
>> It adds a page flag ("daccess") which starts out set.  It clears the
>> flag it when the page is added to the page cache or mapped as anonymous.
> And that of course does not work. Pages are not made unaccessible at a random
> point in time. We do check for several page flags and page count before doing
> so and we also do this while with paqe_ref_freeze to avoid several races.
> I guess you just hit one of those.

Actually, that's the problem.  You've gone through all these careful
checks and made the page inaccessible.  *After* that process, how do you
keep the page from being hit by an I/O device before it's made
accessible again?  My patch just assumes that *all* pages have gone
through that process and passed those checks.

I'm pretty sure if I lifted all the checks in
arch/s390/kernel/uv.c::make_secure_pte() and duplicated them at the
sites where I'm doing ClearPageAccessible(), they'd happily pass.

Freezing page refs is a transient thing you do *during* the conversion,
but it doesn't stop future access to the page.  That's what these
incomplete hooks are trying to do.

Anyway, I look forward to seeing the patch for the FOLL_PIN issue I
pointed out, and I hope to see another copy of the fs/splice changes
with a proper changelog and the maintainer on cc.  It's starting to get
late in the rc's.

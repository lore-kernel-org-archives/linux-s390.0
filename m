Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 30 Apr 2020 00:53:10 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
Message-ID: <20200430005310.7b25efab@p-imbrenda>
In-Reply-To: <609afef2-43c2-d048-1c01-448a53a54d4e@intel.com>
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
        <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
        <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
        <609afef2-43c2-d048-1c01-448a53a54d4e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On Wed, 29 Apr 2020 10:55:52 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/29/20 10:31 AM, Christian Borntraeger wrote:
> > On 29.04.20 18:07, Dave Hansen wrote:  
> >> On 4/28/20 3:50 PM, Claudio Imbrenda wrote:  
> >>> If a page is inaccesible and it is used for things like sendfile,
> >>> then the content of the page is not always touched, and can be
> >>> passed directly to a driver, causing issues.
> >>>
> >>> This patch fixes the issue by adding a call to
> >>> arch_make_page_accessible in page_cache_pipe_buf_confirm; this
> >>> fixes the issue.  
> >> I spent about 5 minutes putting together a patch:
> >>
> >> 	https://sr71.net/~dave/intel/accessible.patch
> >>
> >> It adds a page flag ("daccess") which starts out set.  It clears
> >> the flag it when the page is added to the page cache or mapped as
> >> anonymous.  
> > And that of course does not work. Pages are not made unaccessible
> > at a random point in time. We do check for several page flags and
> > page count before doing so and we also do this while with
> > paqe_ref_freeze to avoid several races. I guess you just hit one of
> > those.  
> 
> Actually, that's the problem.  You've gone through all these careful
> checks and made the page inaccessible.  *After* that process, how do
> you keep the page from being hit by an I/O device before it's made
> accessible again?  My patch just assumes that *all* pages have gone
> through that process and passed those checks.

I don't understand what you are saying here.

we start with all pages accessible, we mark pages as inaccessible when
they are imported in the secure guest (we use the PG_arch_1 bit in
struct page). we then try to catch all I/O on inaccessible pages and
make them accessible so that I/O devices are happy. when we need to
make page inaccessible again, we mark the page, make sure the counters
and the flag in struct page look ok, then we actually make it
inaccessible. this way pages that are undergoing I/O will never
actually transition from from accessible to inaccessible, although they
might briefly marked as inaccessible. this means that the flag we use
to mark a page inaccessible is overindicating, but that is fine.

pages need to be accessible in order to be used for I/O, and need to be
inaccessible in order to be used by protected VMs.

> I'm pretty sure if I lifted all the checks in
> arch/s390/kernel/uv.c::make_secure_pte() and duplicated them at the
> sites where I'm doing ClearPageAccessible(), they'd happily pass.
> 
> Freezing page refs is a transient thing you do *during* the
> conversion, but it doesn't stop future access to the page.  That's
> what these incomplete hooks are trying to do.

we use the PG_arch_1 bit to actually stop access to the page, freezing
is used just for a short moment to make sure nobody is touching the
page and avoid races while we are checking.

> Anyway, I look forward to seeing the patch for the FOLL_PIN issue I
> pointed out, and I hope to see another copy of the fs/splice changes
> with a proper changelog and the maintainer on cc.  It's starting to
> get late in the rc's.

either your quick and dirty patch was too dirty (e.g. not accounting
for possible races between make_accessible/make_inaccessible), or some
of the functions in the trace you provided should do pin_user_page
instead of get_user_page (or both)


our first implementation (before FOLL_PIN was introduced) called
make_page_accessible for each FOLL_GET. Once FOLL_PIN was introduced,
we thought it would be the right place. If you think calling
make_accessible for both FOLL_PIN and FOLL_GET is the right thing, then
I can surely patch it that way.

I'll send out an v2 for fs/splice later on today.
